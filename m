From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit] aborting tg create leafs deleted .top* files in index
Date: Fri, 27 Feb 2009 07:47:15 +0100
Message-ID: <36ca99e90902262247q783f8ce1j20bdc971cfc22948@mail.gmail.com>
References: <36ca99e90902061103u24d4f38eua52d9259cb8d34d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	martin f krafft <madduck@debian.org>,
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Feb 27 07:48:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcwWc-0005zt-KG
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 07:48:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936AbZB0GrT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 01:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752474AbZB0GrT
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 01:47:19 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:5295 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbZB0GrS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 01:47:18 -0500
Received: by nf-out-0910.google.com with SMTP id d21so281110nfb.21
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 22:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ni/w6Tmxa/wu9q2ZLntwc9txVzgWqWZNgIEGbwtTH5g=;
        b=tGFP3RClvo6PUB5isOKOc+1H4IZF8aQYYHv1o3XmXo5aVwb0uXLl+M59DwVMplP16I
         EsHt4FDL5sTE5ISl+7So7Ut15YaYiLlH42BOpvvZB8h7ox90NQxdTAftK+6vjvex9stX
         x1sElN0/4osIlq5WaTBEZsMiA5vqjGGfbQ2ew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Vp5hPicOjQmlWJXJt9UxTwplmNBLa+Fs3bae8BtEi0ccsIhh+OqyZmQTo7aNjbkBM1
         Oan3Vp5LJ/23pf72R+jFUtLAtt/BIEYcq4EpJsKLPDIn9EBDFTlSTheFMJQf0yblzQqD
         dVIvzmZtoKEu64Vt0+0KLzjxS4h7ciMkQbPyo=
Received: by 10.210.88.3 with SMTP id l3mr403508ebb.23.1235717235129; Thu, 26 
	Feb 2009 22:47:15 -0800 (PST)
In-Reply-To: <36ca99e90902061103u24d4f38eua52d9259cb8d34d1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111636>

On Fri, Feb 6, 2009 at 20:03, Bert Wesarg <bert.wesarg@googlemail.com> =
wrote:
> Hi,
>
> after executing the abort commands to remove a just created new topic
> branch, the .top* files from the previous branch are markes as
> deleted.
>
> To reproduce:
>
> $ md g
> $ cd g
> $ git --version
> git version 1.6.1.rc4
> $ git init
> Initialized empty Git repository in /home/bertw/tmp/g/.git/
> $ touch file
> $ git add file
> $ git commit -m init
> [master (root-commit)]: created 2155efd: "init"
> =C2=A00 files changed, 0 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 file
> $ tg create t/test1
> tg: Automatically marking dependency on master
> tg: Creating t/test1 base from master...
> Switched to a new branch "t/test1"
> tg: Topic branch t/test1 set up. Please fill .topmsg now and make
> initial commit.
> tg: To abort: git rm -f .top* && git checkout master && tg delete t/t=
est1
> $ git commit -m "topic test1"
> [t/test1]: created 3cb4fbf: "topic test1"
> =C2=A02 files changed, 7 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 .topdeps
> =C2=A0create mode 100644 .topmsg
> $ tg create t/test2
> tg: Automatically marking dependency on t/test1
> tg: Creating t/test2 base from t/test1...
> Switched to a new branch "t/test2"
> tg: Topic branch t/test2 set up. Please fill .topmsg now and make
> initial commit.
> tg: To abort: git rm -f .top* && git checkout t/test1 && tg delete t/=
test2
> $ git rm -f .top* && git checkout t/test1 && tg delete t/test2
> rm '.topdeps'
> rm '.topmsg'
> D =C2=A0 =C2=A0 =C2=A0 .topdeps
> D =C2=A0 =C2=A0 =C2=A0 .topmsg
> Switched to branch "t/test1"
> $ git status
> # On branch t/test1
> # Changes to be committed:
> # =C2=A0 (use "git reset HEAD <file>..." to unstage)
> #
> # =C2=A0 =C2=A0 =C2=A0 deleted: =C2=A0 =C2=A0.topdeps
> # =C2=A0 =C2=A0 =C2=A0 deleted: =C2=A0 =C2=A0.topmsg
> #
> $
Anyone?

>
>
> Regards,
> Bert Wesarg
>
