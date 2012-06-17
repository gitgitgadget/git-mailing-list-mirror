From: David Kilzer <ddkilzer@kilzer.net>
Subject: Re: [PATCH] rebase -i -p: use rerere to resolve conflicts if enabled
Date: Sun, 17 Jun 2012 14:30:54 -0700
Message-ID: <B5E2DD4F-4EEB-4440-A149-DD718B0C2EFD@kilzer.net>
References: <1339769855-94161-1-git-send-email-ddkilzer@kilzer.net> <7vwr38bmj5.fsf@alter.siamese.dyndns.org> <B4036488-1ECA-41C9-BD97-B2ABD116D54C@kilzer.net> <7vd34z96lv.fsf@alter.siamese.dyndns.org> <76A6615B-5758-4D67-A556-2EE131FF7B20@kilzer.net> <7vmx427aj0.fsf@alter.siamese.dyndns.org> <1917D067-6FB3-4393-B178-BBE36B4B5D4E@kilzer.net> <4FDE2252.5030802@kdbg.org>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jun 17 23:31:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgN49-0006eg-PB
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jun 2012 23:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758002Ab2FQVa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jun 2012 17:30:57 -0400
Received: from nm9-vm0.bullet.mail.sp2.yahoo.com ([98.139.91.196]:46845 "HELO
	nm9-vm0.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754422Ab2FQVa4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2012 17:30:56 -0400
Received: from [98.139.91.62] by nm9.bullet.mail.sp2.yahoo.com with NNFMP; 17 Jun 2012 21:30:55 -0000
Received: from [98.136.185.40] by tm2.bullet.mail.sp2.yahoo.com with NNFMP; 17 Jun 2012 21:30:55 -0000
Received: from [127.0.0.1] by smtp101.mail.gq1.yahoo.com with NNFMP; 17 Jun 2012 21:30:55 -0000
X-Yahoo-Newman-Id: 729854.60007.bm@smtp101.mail.gq1.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: LJgqNZ0VM1mLAVJIUI72i3bN.nZapIdRDpddMX7MioQGlrA
 d3zBu4QVbpZ4M6aCgJVXkrJatlsH07l7yAkuh7g4XBfvIVEzIEjF38J7FKYd
 36Vy5ZTkc9s5PXoZ6DRtHoCvZUKajpX8DRwWS7BEUVqW7qHrxnWTwDYl5pch
 2ej7d0ZnaiSH.ijuhynBun5E5CDr8L1XwxhEDhtqtAeDV7GGGFAt3KncyWLx
 YOwm1HDI4ZN_2JfohElODhEe5Wc1L7VlCfa_HuZYTKON8Jo38ZeqasB4NeJO
 KUnj7GKLtITxA23FWTsk3akI7wtiuzFUR4B0HxUDFOkF7X0cCjJv9TePpIHe
 C6wBvkqqKO45NGAgx3eBOyAB_wyED5kp7h7za3zcRmusOOY4Drlh.LhKK9oh
 p0O6aF42pcfRD13R8SSguCWrQuTv7uheKit2HKj2IYMk0O3qMm6w5CY6EPPf
 Lx0rN2hUvg8U9NSk0UFNPh2QPQw1iPS44GWFW57OR.YKsC7I-
X-Yahoo-SMTP: 1KOiJh.swBAFCIHbgY4jfyoPcdmG
Received: from kilze0-204.kilzer.net (ddkilzer@98.207.50.178 with plain)
        by smtp101.mail.gq1.yahoo.com with SMTP; 17 Jun 2012 14:30:55 -0700 PDT
In-Reply-To: <4FDE2252.5030802@kdbg.org>
X-Mailer: Apple Mail (2.1278)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200131>

On Jun 17, 2012, at 11:30 AM, Johannes Sixt wrote:

> Am 17.06.2012 15:46, schrieb David Kilzer:
>> If it could be guaranteed that all changes in a merge commit would be
>> preserved when running "git rebase -i -p" with rerere.autoupdate
>> enabled, I think that would be an argument for not returning control
>> to the user during the rebase operation.  However, changes to
>> non-conflicted files in a merge commit are currently lost in this
>> case, so it would be too dangerous to enable this behavior now.
> 
> You can test this patch:
> 
>  git://repo.or.cz/git/mingw/j6t.git preserve-merges-by-cherry-pick
> 
> I think it suits you needs unless you run into the one use-case where
> the patch is a regression (as documented by the new test_expect_failure
> in the test suite).


I'd love to try it, but I'm running into an issue pulling the repository:

$ git clone git://repo.or.cz/git/mingw/j6t.git -b preserve-merges-by-cherry-pick j6t.git
Cloning into 'j6t.git'...
remote: error: Could not read 942cf39b9a36ae27a4377d22093827ef4df25239
remote: fatal: Failed to traverse parents of commit 051ba02462dd65a0ceb3e527a75f24416378880f
remote: aborting due to possible repository corruption on the remote side.
fatal: early EOF
fatal: index-pack failed

$ git --version
git version 1.7.9.6 (Apple Git-31)

Dave
