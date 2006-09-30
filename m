From: Santi <sbejar@gmail.com>
Subject: Re: [PATCH 5/5] fetch: Clean output
Date: Sat, 30 Sep 2006 11:42:33 +0200
Message-ID: <8aa486160609300242i6f52ee90o235e668a5d865fb7@mail.gmail.com>
References: <87r6xu1rci.fsf@gmail.com> <8764f61r74.fsf@gmail.com>
	 <7vpsdehzcs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 30 11:42:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTbMk-00057i-1U
	for gcvg-git@gmane.org; Sat, 30 Sep 2006 11:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWI3Jmf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 30 Sep 2006 05:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWI3Jmf
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 05:42:35 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:9876 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751208AbWI3Jme convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Sep 2006 05:42:34 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1183765wxc
        for <git@vger.kernel.org>; Sat, 30 Sep 2006 02:42:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ULVCfpBTO4TC6riFAGYhJZMJwjZR4hwszCvSeRe3Muwtl8gTDcoldtIh/j6KHtGgmrkmerpKbNIPIjkdW6VC5EF8lAVGZJKYVXo88prCgobEeSrqmRdRkFKUDnwvv6azHHaFm4mopCUa+TtKqSO5QwUy5GNbHCAfKT9Vb1+j3+4=
Received: by 10.70.117.1 with SMTP id p1mr6959673wxc;
        Sat, 30 Sep 2006 02:42:33 -0700 (PDT)
Received: by 10.70.19.6 with HTTP; Sat, 30 Sep 2006 02:42:33 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vpsdehzcs.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28143>

2006/9/30, Junio C Hamano <junkio@cox.net>:
> Santi B=E9jar <sbejar@gmail.com> writes:
>
> > Do not show duplicated remote branch information and reformat the o=
utput as:
> >
> > $ git fetch -v   # the committish lines for the -v.
> > * refs/heads/origin: fast forward to remote branch 'master' of ../g=
it/
> >   1ad7a06..bc1a580
> >   committish: bc1a580
>
> I am not quite sure about this --- it is not obvious what these
> two numbers represent anymore.  Also I think the last line
> outlived its usefulness (99% of the time refs are committish, so
> noting exception is good but otherwise it is not interesting).

I agree in the case of updating a ref, but I would keep it otherwise
(and even in this case only when -v is given).

>
> I know you opted for minimum patch, but it might be a good time
> to polish the wording a bit while we are touching the general
> vicinity of the code.
>
> How about saying something like:
>
>  * refs/heads/origin: fast forward to remote branch 'master' of ../gi=
t/
>    old..new =3D 1ad7a06..bc1a580

I like it.

>
> > * refs/heads/pu: does not fast forward to remote branch 'pu' of ../=
git/;
> >   7c733a8...5faa935
> >   not updating.
> >   forcing update.
> >   committish: 5faa935
>
> This is even more confusing.  Perhaps we would want to have two
> cases, depending on --force (and +).

Sorry, it was from two copy'n'paste. I did it in a new repository
(without the +), then it stoped at this point (I suppose to force the
user to solve the problem). Then I put the + and did the copy'n'paste
again without deleting this extra line.

>
>  * refs/heads/pu: does not fast forward to remote branch 'pu' of ../g=
it/;
>    but forcing update anyway.  old...new =3D 7c733a8...5faa935

With the old...new in a new line?

So at the end, something like this output?

$ git fetch -v   # the committish lines for the -v.
* refs/heads/origin: fast forward to remote branch 'master' of ../git/
 old..new: 1ad7a06..bc1a580
* refs/heads/pu: does not fast forward to remote branch 'pu' of ../git/
 old...new: 7c733a8...5faa935
 forcing update.
* refs/heads/next: same as remote branch 'origin/next' of ../git/
 committish: ce47b9f
=2E..
* refs/tags/v1.4.2-rc4: storing tag 'v1.4.2-rc4' of ../git/
 committish: 8c7a107

$ git fetch -v origin refs/heads/master
* committish: 695dffe
 branch 'master' of ../git/

Santi
