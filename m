From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 17/18] revert: Introduce --continue to continue the operation
Date: Thu, 4 Aug 2011 06:57:23 +0200
Message-ID: <201108040657.24610.chriscool@tuxfamily.org>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com> <1312222025-28453-18-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 06:57:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qoq03-0003n1-PM
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 06:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102Ab1HDE5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 00:57:35 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:51214 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964Ab1HDE5e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 00:57:34 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 48290A6176;
	Thu,  4 Aug 2011 06:57:26 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <1312222025-28453-18-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178700>

On Monday 01 August 2011 20:07:04 Ramkumar Ramachandra wrote:
>
> +test_expect_success '--continue complains when there are unresolved
> conflicts' '
> +	pristine_detach initial &&
> +	test_must_fail git cherry-pick base..picked &&
> +	test_must_fail git cherry-pick --continue
> +'

When I try to manually run the above test I get:

-----------------------------------

$ pristine_detach initial     
Warning: you are leaving 1 commit behind, not connected to
any of your branches:

  30b20f1 unrelatedpick

HEAD is now at df2a63d... initial
$
$ git cherry-pick base..picked                                                                                          
[detached HEAD 30b20f1] unrelatedpick
 Author: A U Thor <author@example.com>
 1 files changed, 1 insertions(+), 1 deletions(-)
Auto-merging foo
CONFLICT (content): Merge conflict in foo
error: could not apply fdc0b12... picked
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'
$
$ git cherry-pick --continue                                                                                            
fatal: No cherry-pick in progress

-----------------------------------

So it complains because there is no cherry-pick in progress, not because there 
are unresolved conflicts.

Thanks,
Christian.
