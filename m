From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: How to reorder all commits include the initial commit
Date: Mon, 19 Mar 2012 04:05:14 +0900
Message-ID: <CAFT+Tg8=dkFLh_=2pMYH6McZTWr2NjxZHztVG7WcxGMEBmdOwA@mail.gmail.com>
References: <CAFT+Tg_DmqxiK1qw1YvNZtY07ZaZ89+JWohdWw2fm8f=6hAwiQ@mail.gmail.com>
	<m3k42jl2wn.fsf@localhost.localdomain>
	<CAFT+Tg9UGdBxj5-DTpxDJRVgvBCnmkmgm6nzVek0KeELgsNneQ@mail.gmail.com>
	<CANYiYbGbJxZPOAN9twBPZoD318eA_CLcsVzcFuoHrc32+e96FQ@mail.gmail.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 20:05:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9LPv-0007zg-Ac
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 20:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137Ab2CRTFQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Mar 2012 15:05:16 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34431 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755024Ab2CRTFP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Mar 2012 15:05:15 -0400
Received: by obbeh20 with SMTP id eh20so610263obb.19
        for <git@vger.kernel.org>; Sun, 18 Mar 2012 12:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=RCNTzfe6vce9Y2uKSEcC4q2n4XSubHY39X/MGzJraIw=;
        b=C8BDoNZWSh8V8NcLJRS81E+5OKmF68w+Cqgp+8/Qn6MPACIpVTjBJ4DWYOeX1JC0dG
         75606Ap3uZBc84JB/GCr6Xb+yQiEnqrwvDvy8z9TgshWjguqHTWbyKtP7PeJTMamUHb3
         FxklFxtQvTVo9ZMTW7MPJrAUrMgwnDsLrAP6cHhEseV35F67MdUnqNErR7BcTfXFtHOY
         IjtCvj3+yZlqF01S+OeIknj1n4OU4oRdRfO3DEdV0gK+8otObuZ4MZAHIkM1nZNcsBXi
         XKxlWrKw6kldwAjqdtTX2SIo3+1vHoTPtdmK+xSj7VmnD2upQ44VlTgniXIkz3wSPXsT
         9tmg==
Received: by 10.182.72.71 with SMTP id b7mr10956990obv.11.1332097514895; Sun,
 18 Mar 2012 12:05:14 -0700 (PDT)
Received: by 10.182.53.98 with HTTP; Sun, 18 Mar 2012 12:05:14 -0700 (PDT)
In-Reply-To: <CANYiYbGbJxZPOAN9twBPZoD318eA_CLcsVzcFuoHrc32+e96FQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193389>

2012=B3=E2 3=BF=F9 18=C0=CF =BF=C0=C0=FC 11:58, Jiang Xin <worldhello.n=
et@gmail.com>=B4=D4=C0=C7 =B8=BB:
>> $ git checkout -b test --orphan
>
> option -b and --orphan can not be used together.
>
>> $ git format-patch <newroot>^..<newroot> | git am
>
> can not apply patch when there is no root commit
>

You are all right. I made several mistakes including what you point out=
=2E

I fixed them as follows:

$ git checkout --orphan test
$ git rm '*' -f
$ git show <newroot> | git apply - --index
$ git commit --reuse-message <newroot>
$ git rebase --onto test --root master
$ git branch -d test
