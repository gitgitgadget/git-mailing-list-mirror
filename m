From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Always output a trailing space conflicted merge markers.
Date: Tue, 30 Jun 2009 19:01:24 -0700
Message-ID: <7vzlbpxitn.fsf@alter.siamese.dyndns.org>
References: <1246322461-24742-1-git-send-email-nelhage@mit.edu>
	<7v1vp15ppi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nelson Elhage <nelhage@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Jul 01 04:02:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLp9m-0000CR-M5
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 04:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbZGACBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 22:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753084AbZGACBW
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 22:01:22 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:55676 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbZGACBV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 22:01:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090701020124.LWRV17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Tue, 30 Jun 2009 22:01:24 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id AS1Q1c0084aMwMQ04S1QrC; Tue, 30 Jun 2009 22:01:24 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=JfQwyIwb32wA:10 a=ybZZDoGAAAAA:8
 a=Op-QDATyAAAA:8 a=CgGsZj4DQhEtlGWbOjoA:9 a=B6Hxq4jW7K00ZE2VEzoA:7
 a=nE2fmVxWB48bFV7kUp59r2wt0l4A:4 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <7v1vp15ppi.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 30 Jun 2009 15\:20\:09 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122561>

Junio C Hamano <gitster@pobox.com> writes:

> Nelson Elhage <nelhage@MIT.EDU> writes:
>
>> Some tools, such as emacs' smerge-mode, except that diff3-style merge
>> conflict markers always include a trailing space (and optional
>> description) after the marker, and so fail to correctly detect
>> git's (notably the '|||||||' base marker, for which git never outputs a
>> trailing space).
>>
>> (See http://emacsbugs.donarmstrong.com/cgi-bin/bugreport.cgi?bug=3553
>> for the emacs issue)
>>
>> Signed-off-by: Nelson Elhage <nelhage@mit.edu>
>> ---
>>  xdiff/xmerge.c |   11 ++++++++---
>>  1 files changed, 8 insertions(+), 3 deletions(-)
>
> Thanks, but I think you also need to update the test scripts.
>
> Don't you want some new tests to protect this from getting broken
> in the future by other people yourself, too?

I actually changed my mind.  The plain "diff3" (from GNU diffutils 2.8.1)
does not seem to give an trailing space after ||||||| separator.  It
feels very wrong to change the output format to work around a bug in
smerge-mode (which I never use, by the way), if we are not the only
offender.  With this change, we may be breaking something else that relied
on the "diff3" output format that does not have such a trailing space.

I'll drop this patch.
