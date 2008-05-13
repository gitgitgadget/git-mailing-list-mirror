From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add a test for git-add --ignore-errors
Date: Wed, 14 May 2008 00:28:02 +0200
Message-ID: <20080513222802.GC3981@steel.home>
References: <20080302154238.GD2973@steel.home> <alpine.LSU.1.00.0803021555500.22527@racer.site> <7vtzjpoye6.fsf@gitster.siamese.dyndns.org> <20080512175654.GB3128@steel.home> <20080512175745.GC3128@steel.home> <20080512175810.GD3128@steel.home> <20080512175829.GE3128@steel.home> <20080512175848.GF3128@steel.home> <7v3aomx3sp.fsf@gitster.siamese.dyndns.org> <7vhcd2viwi.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dirk =?iso-8859-15?Q?S=FCsserott?= <newsletter@dirk.my1.cc>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 00:28:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw2zR-0000wL-LR
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 00:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744AbYEMW2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 18:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754124AbYEMW2H
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 18:28:07 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:37640 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbYEMW2G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 18:28:06 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnareO8OVwvA==
Received: from tigra.home (Fafac.f.strato-dslnet.de [195.4.175.172])
	by post.webmailer.de (fruni mo37) (RZmta 16.34)
	with ESMTP id 4001f3k4DIG0Jn ; Wed, 14 May 2008 00:28:02 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C9EB3277BD;
	Wed, 14 May 2008 00:28:02 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 90BA056D28; Wed, 14 May 2008 00:28:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vhcd2viwi.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82049>

Junio C Hamano, Tue, May 13, 2008 08:05:01 +0200:
> Junio C Hamano <junio@pobox.com> writes:
> 
> > Alex Riesen <raa.lkml@gmail.com> writes:
> >
> >> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> >> ---
> >>  t/t3700-add.sh |    9 +++++++++
> >>  1 files changed, 9 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> >> index 287e058..ca3e33d 100755
> >> --- a/t/t3700-add.sh
> >> +++ b/t/t3700-add.sh
> >> @@ -179,4 +179,13 @@ test_expect_success 'git add --refresh' '
> >>  	test -z "`git diff-index HEAD -- foo`"
> >>  '
> >>  
> >> +test_expect_success 'git add --ignore-errors' '
> >> +	git reset --hard &&
> >> +	date >foo1 &&
> >> +	date >foo2 &&
> >> +	chmod 0 foo2 &&
> >> +	git add --verbose --ignore-errors .
> >> +	git ls-files |grep foo1
> >> +'
> >> +
> >>  test_done
> >
> > I like the fact that you added --ignore-errors and made it still error out
> > when it cannot read some files.  Shouldn't we be testing it here with
> > "must-fail"?
> 
> It is human nature to get too enthusiastic demonstrating his own shiny new
> toy and forget to check that it does not kick in when not asked.  There is
> no test for a case to make sure "git add" fails when foo2 is not readable
> and does not add "foo1".

Yes, I missed that. Exactly for the reason :)

> Here is a replacement I've queued.  I have a similar addition to the test
> in the patch after this one that demonstrates the configuration variable.
> I added tests to check the case when the variable is set to false.

Thanks.

> -- >8 --
> Add a test for git-add --ignore-errors
> 
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

Acked-by: Alex Riesen <raa.lkml@gmail.com>
