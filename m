From: Leila <muhtasib@gmail.com>
Subject: Re: Help understanding git checkout behavior
Date: Mon, 11 Jun 2012 14:34:01 -0400
Message-ID: <CAA3EhH+iD-sS-3Sg4HJDHgs4Deg2=qbCuJD4UwZWtGQsKbV5aA@mail.gmail.com>
References: <CAMUXYmUFbixgA1bVMA46Zzjed1Dwmjv54kWWXyjsuyu904GpTA@mail.gmail.com>
 <20120611202132.Horde.dPo1XHwdC4BP1jcsTvSBaFA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Cl=E1udio_Louren=E7o?= <pt.smooke@gmail.com>,
	git@vger.kernel.org, Renato Neves <nevrenato@gmail.com>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Mon Jun 11 20:34:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se9Rc-0001LI-Gn
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 20:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600Ab2FKSeX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 14:34:23 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:45779 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab2FKSeW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 14:34:22 -0400
Received: by vbbff1 with SMTP id ff1so2434152vbb.19
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=yb8PUN31p8JseUn++gWwQLesgs6xodPNvW2Zco7Ihhk=;
        b=hX8tr50Z85xcR9dH1uKBRzWKzEB4GuuxcqQkATMiuRfk8a5VWHEeKH+5y5KB4gxBvE
         Gxm9mQ1Pt0M8rs1zdJAhWP+quGRDFcgbbVDRkuLOyKf5LhXzKyLDVue3tpSXiQKIeHjv
         i7clyb2DKYbdTUODr7W5a/AFDzWCbp53u8+d8UZiS5fFerIR2pIa8/Rlu9akF54lSJ3Q
         lH7iNvw4zB04J97WvIKxwyDxWA0WT+R37QF3ssM5QeMX2sbjtE8xs/1U3UnJDngvCAn2
         HQZwqoEfmgX5YERnBAV1PE9ESe1FeLtM6RPKm1OmUCcxATnY438vZUa+pS5h9L4TqO+B
         Q6TQ==
Received: by 10.220.209.75 with SMTP id gf11mr13109930vcb.56.1339439661923;
 Mon, 11 Jun 2012 11:34:21 -0700 (PDT)
Received: by 10.52.37.233 with HTTP; Mon, 11 Jun 2012 11:34:01 -0700 (PDT)
In-Reply-To: <20120611202132.Horde.dPo1XHwdC4BP1jcsTvSBaFA@webmail.minatec.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When you create a branch, it will contain everything committed on the
branch you created it from at that given point. So if you commit more
things on the master branch like you have done (after creating b),
then switch to branch b, they won't appear. This is the correct
behavior. Does that answer your question?


On Mon, Jun 11, 2012 at 2:21 PM,  <konglu@minatec.inpg.fr> wrote:
>
> Cl=E1udio Louren=E7o <pt.smooke@gmail.com> a =E9crit=A0:
>
>
>> The project was going pretty fine, till we start modeling the=A0chec=
kout
>> operation. We are with some problems finding useful information abou=
t
>> the properties that have to be satisfied when the "git=A0checkout" i=
s
>> performed. We have concluded that if everything that is on index is
>> commited then we have no problems making=A0checkout.
>> The problem is when we have something on index that is not updated
>> with the last commit. We cannot find a general property that says wh=
en
>> checkout can be performed. We have even found some files that are
>> lost, like in this case:
>>
>> smooke =A0teste $ git init
>> Initialized empty Git repository in /home/smooke/Dropbox/teste/.git/
>> smooke =A0teste $ touch f
>> smooke =A0teste $ echo a > f
>> smooke =A0teste $ git add f
>> smooke =A0teste $ git commit -m 'first commit'
>> [master (root-commit) dab04b9] first commit
>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>> =A0create mode 100644 f
>> smooke =A0teste $ git branch b
>> smooke =A0teste $ touch something
>> smooke =A0teste $ echo b > something
>> smooke =A0teste $ git add something
>> smooke =A0teste $ git commit -m 'something added'
>> [master 9f2b8ad] something added
>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>> =A0create mode 100644 something
>> smooke =A0teste $ git rm something
>> rm 'something'
>> smooke =A0teste $ mkdir something
>> smooke =A0teste $ cd something/
>> smooke =A0something $ touch f1
>> smooke =A0something $ echo c > f1
>> smooke =A0something $ cd ..
>> smooke =A0teste $ git add something/f1
>> smooke =A0teste $ git checkout b
>> Switched to branch 'b'
>> smooke =A0teste $ ls
>> f
>> smooke =A0teste $ git checkout master
>> Switched to branch 'master'
>> smooke =A0teste $ ls
>> f =A0something
>> smooke =A0teste $ cat something
>> b
>
>
> What do you mean by "lost files" ? Are you talking about "something"
> that doesn't appear on branch 'b' ?
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
