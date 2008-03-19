From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/16] more tr portability test script fixes
Date: Wed, 19 Mar 2008 14:40:57 -0700
Message-ID: <7v8x0e2xzq.fsf@gitster.siamese.dyndns.org>
References: <cover.1205356737.git.peff@peff.net>
 <20080312213106.GD26286@coredump.intra.peff.net>
 <20080318222302.GA3450@steel.home>
 <20080318224436.GA6806@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:42:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc630-00030y-JN
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 22:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937987AbYCSVlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 17:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758722AbYCSVlO
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 17:41:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57390 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760109AbYCSVlN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 17:41:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EA46D3EFD;
	Wed, 19 Mar 2008 17:41:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3A4843EFB; Wed, 19 Mar 2008 17:41:02 -0400 (EDT)
In-Reply-To: <20080318224436.GA6806@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 18 Mar 2008 18:44:37 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77561>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 18, 2008 at 11:23:02PM +0100, Alex Riesen wrote:
>
>> Jeff King, Wed, Mar 12, 2008 22:31:06 +0100:
>> > -    tr '\000' '\012' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
>> > -    tr '\000' '\012' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
>> > +    perl -pe 'y/\000/\012/' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
>> > +    perl -pe 'y/\000/\012/' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
>> 
>> These break in presence of ActiveState Perl on Windows.
>> 
>> I suggest replacing such simple construction with a simplified,
>> in-tree, version of tr.
>
> <sigh> It's sad that it must come to that, but your test-tr patches seem
> like the only sane choice. They seem to work fine on my Solaris box.

I am very tempted to say that it might make more sense to declare
ActiveState unsupported.  How many times have we suffered from it, and
notice it was only from Alex every time, nobody else?  Are there silent
majorities involved here?
