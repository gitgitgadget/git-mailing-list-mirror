From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] Add --first-parent support to interactive rebase.
Date: Wed, 31 Oct 2007 21:10:30 -0700
Message-ID: <7vabpyfvwp.fsf@gitster.siamese.dyndns.org>
References: <1193797309-1161-1-git-send-email-B.Steinbrink@gmx.de>
	<7vodefj2lk.fsf@gitster.siamese.dyndns.org>
	<20071031055303.GB3326@atjola.homenet>
	<20071031134358.GD15182@dpotapov.dyndns.org>
	<20071031140028.GA30207@diana.vm.bytemark.co.uk>
	<20071031143641.GF15182@dpotapov.dyndns.org>
	<20071031180557.GA12211@coredump.intra.peff.net>
	<7v8x5jgdck.fsf@gitster.siamese.dyndns.org>
	<20071031215625.GC14211@coredump.intra.peff.net>
	<7vzlxygblz.fsf@gitster.siamese.dyndns.org>
	<20071101032303.GA14495@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 01 05:11:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InROU-000705-7l
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 05:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbXKAEKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 00:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbXKAEKl
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 00:10:41 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:50069 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbXKAEKl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 00:10:41 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id BC9D52F9;
	Thu,  1 Nov 2007 00:11:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1708D8DBA3;
	Thu,  1 Nov 2007 00:10:55 -0400 (EDT)
In-Reply-To: <20071101032303.GA14495@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 31 Oct 2007 23:23:03 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62911>

Jeff King <peff@peff.net> writes:

> On Wed, Oct 31, 2007 at 03:31:20PM -0700, Junio C Hamano wrote:
>
>> > ... I had one concern that
>> > I was tracking down: is the author name encoding necessarily the same as
>> > the commit text encoding?
>> 
>> The user is screwing himself already if that is the case and
>> uses -s to format-patch, isn't he?
>
> Hrm, they probably _should_ be the same in the output. It's not clear to
> me what encoding we assume the name comes in (utf-8, I guess). Looks
> like we don't touch it at all when putting it in the signoff. I think we
> should just be able to reencode when appending the signoff; patch is
> below.

I think assuming utf-8 and reencoding is actively wrong.
Existing setups of people with names that cannot be expressed in
ASCII would already have the commit encoding specified in the
configuration and user.name stored in that encoding, so passing
things through as we have always done is the right thing to do.
