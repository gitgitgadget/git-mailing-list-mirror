From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: Add a missing OPT_END().
Date: Tue, 01 Apr 2008 21:34:05 -0700
Message-ID: <7vk5jgan9e.fsf@gitster.siamese.dyndns.org>
References: <20080402054741.24d95299.chriscool@tuxfamily.org>
 <20080402034430.GA10360@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 02 06:35:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jgugo-00088H-Rf
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 06:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbYDBEeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 00:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbYDBEeZ
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 00:34:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbYDBEeY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 00:34:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 260D72E98;
	Wed,  2 Apr 2008 00:34:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4BE902E97; Wed,  2 Apr 2008 00:34:15 -0400 (EDT)
In-Reply-To: <20080402034430.GA10360@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 1 Apr 2008 23:44:31 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78680>

Jeff King <peff@peff.net> writes:

> On Wed, Apr 02, 2008 at 05:47:41AM +0200, Christian Couder wrote:
>
>> 	Some comments in "parse-options.h" say it is needed,
>> 	though I did not see a crash without it.
>
> There was no particular reason I didn't put it in; I just didn't know
> about it. So ack from me, assuming it is supposed to be there.

parse-options.c::parse_short_opt() and parse_long_opt() has this loop:

	for (; options->type != OPTION_END; options++) {
		...
	}

So whatever happens to come after builtin_help_options[] may be read from
by this loop when you do not have OPTION_END.
