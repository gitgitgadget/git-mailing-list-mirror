From: suvayu ali <fatkasuvayu+linux@gmail.com>
Subject: Re: Qn about git pull and git fetch
Date: Tue, 28 Sep 2010 12:09:10 -0700
Message-ID: <AANLkTin1F+y1LZ8VQse_+NZP1pJuS9bnKHb4=23un29k@mail.gmail.com>
References: <AANLkTi=-UU8X-7h8c4=UENRwNe+G2xGy54YhvWPnnY7y@mail.gmail.com> <9732E43E-124D-4145-A289-2E78F2277ACE@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 21:09:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0fYY-00012a-7E
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 21:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908Ab0I1TJc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 15:09:32 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65434 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab0I1TJc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 15:09:32 -0400
Received: by wwd20 with SMTP id 20so420705wwd.1
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 12:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=TKCOlkKMnXKpjFhDdNMUFJmO6ioFYSX22IZUzrQKfO8=;
        b=bMTc3GXHamLSzsx90qBskyu6reV177LlqYymucd+3CrVeJ0n/4+2MlZxZIzN0a62sg
         IrlvzECfEuHql818DZ3T/qzkobqRHzihbqdoUZHgN26Xc3r5byINFdtOOps1chsc5d/F
         crfc2D4xkeUz+MVfh8wRAm8iSrTGkaFuDFd9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=wrOngJqsnNJjYagNy7eETe5EgeITx2pYxwjpqK34EblEFJ1XRErfBVFgIZwb7IQOT0
         cQGXM0Pym5oCQncYg3H+YeeWxcaMO2qNVIIas+sa8foa+U4nlgxYbrmqPBSUjpOuU/Bf
         ocCFT5l+bzl9zP3tapgEbh1uu1GMOpAVz6kX0=
Received: by 10.216.181.84 with SMTP id k62mr361423wem.76.1285700970496; Tue,
 28 Sep 2010 12:09:30 -0700 (PDT)
Received: by 10.216.86.3 with HTTP; Tue, 28 Sep 2010 12:09:10 -0700 (PDT)
In-Reply-To: <9732E43E-124D-4145-A289-2E78F2277ACE@gernhardtsoftware.com>
X-Google-Sender-Auth: FgAk4CebByGdubbJLw_vars9Abc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157460>

Hi Brian,

On 28 September 2010 10:33, Brian Gernhardt <brian@gernhardtsoftware.co=
m> wrote:
>
> On Sep 28, 2010, at 12:59 PM, suvayu ali wrote:
>
>> If I have a remote tracking repository, and I do a `git pull
>> origin master', the latest changes are merged into my currently
>> checked out branch. But the references to the remote repo are not.
>
>> This is not an inconvenience for me, just a little puzzling since th=
e
>> man page says git pull runs `git fetch' followed by `git mege'. Just
>> out of curiosity, is there any reason for this choice?
>
> `git pull origin master` does the following:
> - `git fetch origin master` will fetch the master branch from remote
> =A0 origin into FETCH_HEAD
> - `git merge` will then merge FETCH_HEAD into HEAD
>
> It sounds like what you want is to get your branch as a tracking bran=
ch.
> If you see the following in `git remote show origin`:
>
> [...]
> =A0Local branch configured for 'git pull':
> =A0 =A0master merges with remote master
> [...]
>
> Then all you have to do is `git pull`. =A0It will update all tracking
> branches for origin, then merge origin/master into master. =A0The com=
mand
> `git pull origin master` is telling git to override whatever defaults=
 it
> has and merge the master branch from remote origin into your current =
HEAD.
>

That explains it! I was overriding the default hence it didn't track
the remote branches as expected. Following the steps you mentioned
above confirmed that. On doing just `git pull' gave me the behaviour I
was expecting in the first place. :)

> Your branches should be set to track automatically but if they didn't=
 for
> some reason and are using v1.7.0 or newer, you can:
>
> $ git branch --set-upstream master origin/next
> Branch master set up to track remote branch next from origin.
> $ git pull
>
> If you're using git prior to v1.7.0, you can instead:
>
> $ git config branch.master.remote origin
> $ git config branch.master.merge refs/heads/master
> $ git pull
>
> (Note: You only have to use `git branch --set-upstream` or the `git
> config ...` lines once, not before every pull.)
>

Thanks a lot for pointing me to these. I am using git v1.7.0.4,
v1.7.2.3 and v1.7.2.2. The above utilities will be very helpful in the
future to configure exactly how I want my repository to behave.

> ~~ Brian
>



--=20
Suvayu

Open source is the future. It sets us free.
