Return-Path: <SRS0=+pXB=2E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F0DC43603
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 21:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F452073D
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 21:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomaszubiri-com.20150623.gappssmtp.com header.i=@tomaszubiri-com.20150623.gappssmtp.com header.b="mJqpPjUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfLNV5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Dec 2019 16:57:09 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:42296 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLNV5J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Dec 2019 16:57:09 -0500
Received: by mail-qk1-f169.google.com with SMTP id z14so2228831qkg.9
        for <git@vger.kernel.org>; Sat, 14 Dec 2019 13:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomaszubiri-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ptIpYj276CHFcRggzULK7pN+FMFoYZzhMwG26aCBVdc=;
        b=mJqpPjUDo2yc72yL9Ra/3vjgy+tTMrMY09VAZbHIqF4rtf/yBJPOfogcnql8amXD2F
         CCtAE8N0GOqFEXoXq4biwjwdFNf8s75kLISDSN7It67sf3fDlcryMtriDS3eHvOrA414
         XuKoLg8rsgwdXQuZIXEI1Twcsv3UgOp65YSKUXw8KPQWZzga0AHFkodXK3ISirX6uzyr
         xvF+ApmlCTxR4lLYGUAtOrdD60NM8da8a8GpChEFfUz8vPxj/DO+a6acJQXvRT8v3VdZ
         TLJfU58Kh7puXpBS3X0K1wACccDAWjahYxA3N1ygVxRd/Ig0ezUVVOS48GWi5wTnruje
         c89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=ptIpYj276CHFcRggzULK7pN+FMFoYZzhMwG26aCBVdc=;
        b=sIFMzXmOd39VrqXa6baS5tmuBe/ksISvsm4xta6inFb0eDz90KO049BTmfBWCEiH88
         UR2rccyFjh4sjsn0MqR12TEoLxT1IFpdkNjrBe5o5zwIq4uJXh5p52693BWtM7ANit1A
         SqIlczRfgPAGHenbj7uO81Zj1I6Z+fHjLE2WWeUIUb8WLvAtiEQ2W1+Mtf2L+ehTERH2
         FrwybUnyhiqyGhs9/TryRLDj/LZ1wPaQmkTsih822FVO9MbQR0AM9e0vo42FNBEQCBnY
         ZTwtaQ8thA/Is2TXT/K44EWx0gIFoy6I3/cC6GAgaH032aTHm12MrnHoLb43++8COelH
         Gp3g==
X-Gm-Message-State: APjAAAWKtjlS2TiDWN1ijhK9ZQLQTxui1/lvjzUGkhDCMAXJF0RI2TId
        rgUreOljJkkfDg2PNvrqzyu1UT2WWNFl1FVJEC2ImbhG
X-Google-Smtp-Source: APXvYqzbdstrOOf1hpv254Z9t6PE0qWzQpLfOswByqqsTpyOwlbcZVeOqN/Oe2fRHNmNNZbVShoXBgy6r2j1HcmBnLs=
X-Received: by 2002:a05:620a:2050:: with SMTP id d16mr14370175qka.473.1576360627546;
 Sat, 14 Dec 2019 13:57:07 -0800 (PST)
MIME-Version: 1.0
References: <CAE3VKEpPye+GyR7Uo9WBa=1i1L=dFq9AHfdNnhiw19K-jWLtBA@mail.gmail.com>
In-Reply-To: <CAE3VKEpPye+GyR7Uo9WBa=1i1L=dFq9AHfdNnhiw19K-jWLtBA@mail.gmail.com>
From:   Tomas Zubiri <me@tomaszubiri.com>
Date:   Sat, 14 Dec 2019 18:56:55 -0300
Message-ID: <CAE3VKEppVv=rocJU7jHKu7i=dLyaHhpauTBmm91udjZ_DOpW+g@mail.gmail.com>
Subject: Re: Head, Branch != Head -> Branch?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After going through the code and thinking about this. I think the
unexpected results came from git branch not checking out the branch I
created.
I know git checkout -b master would have been the result I wanted. If
I were to create another commit with HEAD checked out instead of
master, master would not update, only HEAD would.
I guess the real crime here is that git branch does not checkout the
branch created. I don't think I ever wanted to create a branch without
checking it out, otherwise I would use git tag.

Tomas Zubiri
Software Developer
Cel: +54 911 5891 8239


El s=C3=A1b., 14 de dic. de 2019 a la(s) 15:00, Tomas Zubiri
(me@tomaszubiri.com) escribi=C3=B3:
>
> Hello, I'm writing because I believe I found a case where git could be
> simplified. I'm posting my terminal log so that you can see exactly
> what I saw. Comments are marked with >> . Important spanish git was
> translated.
>
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git status
> HEAD detached at 54da1ac
> Cambios no rastreados para el commit:
>   (usa "git add <archivo>..." para actualizar lo que ser=C3=A1 confirmado=
)
>   (usa "git checkout -- <archivo>..." para descartar los cambios en el
> directorio de trabajo)
>
> modificado:     cv/en/index.html
> modificado:     cv/index.html
>
> sin cambios agregados al commit (usa "git add" y/o "git commit -a")
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git add cv/en/index.ht=
ml
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git add cv/index.html
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git commit -m
> "Agrego mi celular, por favor no me manden spam"
> [HEAD detached 82b2b55] Agrego mi celular, por favor no me manden spam
>  2 files changed, 3 insertions(+), 1 deletion(-)
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git push
> fatal: Actualmente no est=C3=A1s en una rama.
> Para hacer un push a la historia que lleva al estado actual
> (HEAD detached), use
>
> git push origin HEAD:<nombre-de-rama-remota>
>
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git push origin ^C
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git log
> commit 82b2b55b3f7768a60e3d8bcda97d4d623ff0e044 (HEAD)
> Author: Tomas Zubiri <me@tomaszubiri.com>
> Date:   Fri Dec 13 21:37:30 2019 -0300
>
>     Agrego mi celular, por favor no me manden spam
> >> This is the commit I wanted to push
>
> commit 54da1ac07a5c7c2e7234911a0af76aee042b5b99
> Author: Tomas Zubiri <me@tomaszubiri.com>
> Date:   Fri Dec 13 20:33:11 2019 -0300
>
>     Limpio url para cv en ingl=C3=A9s.
> >> This is an abandoned commit I didn't push.
>
>
>
> commit 81542e725149ba5da36560ad14d4871eb7ea01e6 (origin/master)
> Author: Tomas Zubiri <me@tomaszubiri.com>
> Date:   Fri Oct 18 17:08:50 2019 -0300
>
>     especifico tecnolog=C3=ADas de contribuci=C3=B3n de codigo
> >> This is what's in production
>
>
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git checkout origin/ma=
ster^C
> >> ^C cancels the command, I notice there's an extra commit.
>
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git branch newmaster
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git checkout origin/ma=
ster
> La posici=C3=B3n previa de HEAD era 82b2b55 Agrego mi celular, por favor =
no
> me manden spam
> >> Previous head position was..
>
> HEAD est=C3=A1 ahora en 81542e7 especifico tecnolog=C3=ADas de contribuci=
=C3=B3n de codigo
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git cherry-pick newmas=
ter
> [HEAD desacoplado 912c91a] Agrego mi celular, por favor no me manden spam
>  Date: Fri Dec 13 21:37:30 2019 -0300
>  2 files changed, 3 insertions(+), 1 deletion(-)
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git log
> commit 912c91a92e17de33247e2040d1dd01adbfc218eb (HEAD)
> Author: Tomas Zubiri <me@tomaszubiri.com>
> Date:   Fri Dec 13 21:37:30 2019 -0300
>
>     Agrego mi celular, por favor no me manden spam
>
> commit 81542e725149ba5da36560ad14d4871eb7ea01e6 (origin/master)
> Author: Tomas Zubiri <me@tomaszubiri.com>
> Date:   Fri Oct 18 17:08:50 2019 -0300
>
>     especifico tecnolog=C3=ADas de contribuci=C3=B3n de codigo
> >> Looks good.
>
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git branch master
> fatal: Una rama llamada 'master' ya existe.
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git branch -D master
> Eliminada la rama master (era 679eaf3)..
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git branch master
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git push^C
> >> Gotta double check.
>
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git log
> commit 912c91a92e17de33247e2040d1dd01adbfc218eb (HEAD, master)
> Author: Tomas Zubiri <me@tomaszubiri.com>
> Date:   Fri Dec 13 21:37:30 2019 -0300
>
>     Agrego mi celular, por favor no me manden spam
>
> commit 81542e725149ba5da36560ad14d4871eb7ea01e6 (origin/master)
> Author: Tomas Zubiri <me@tomaszubiri.com>
> Date:   Fri Oct 18 17:08:50 2019 -0300
>
>     especifico tecnolog=C3=ADas de contribuci=C3=B3n de codigo
>
>
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git push
> fatal: Actualmente no est=C3=A1s en una rama.
> >> Fatal: You are not currently on a branch.
>
> Para hacer un push a la historia que lleva al estado actual
> (HEAD desacoplado), use
>
> git push origin HEAD:<nombre-de-rama-remota>
>
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git push origin/master
> fatal: Actualmente no est=C3=A1s en una rama.
> Para hacer un push a la historia que lleva al estado actual
> (HEAD desacoplado), use
>
> git push origin/master HEAD:<nombre-de-rama-remota>
>
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git push ^Cigin/master
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git log
> commit 912c91a92e17de33247e2040d1dd01adbfc218eb (HEAD, master)
> Author: Tomas Zubiri <me@tomaszubiri.com>
> Date:   Fri Dec 13 21:37:30 2019 -0300
>
>     Agrego mi celular, por favor no me manden spam
>
> commit 81542e725149ba5da36560ad14d4871eb7ea01e6 (origin/master)
> Author: Tomas Zubiri <me@tomaszubiri.com>
> Date:   Fri Oct 18 17:08:50 2019 -0300
>
>     especifico tecnolog=C3=ADas de contribuci=C3=B3n de codigo
>
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git push >> So
> confused I repeated a command.
> fatal: Actualmente no est=C3=A1s en una rama.
> Para hacer un push a la historia que lleva al estado actual
> (HEAD desacoplado), use
>
> git push origin HEAD:<nombre-de-rama-remota>
>
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git log
> commit 912c91a92e17de33247e2040d1dd01adbfc218eb (HEAD, master)
> Author: Tomas Zubiri <me@tomaszubiri.com>
> Date:   Fri Dec 13 21:37:30 2019 -0300
>
>     Agrego mi celular, por favor no me manden spam
>
> commit 81542e725149ba5da36560ad14d4871eb7ea01e6 (origin/master)
> Author: Tomas Zubiri <me@tomaszubiri.com>
> Date:   Fri Oct 18 17:08:50 2019 -0300
>
>     especifico tecnolog=C3=ADas de contribuci=C3=B3n de codigo
>
>
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git push
> fatal: Actualmente no est=C3=A1s en una rama.
> >> Fatal: Not currently on a branch
>
> Para hacer un push a la historia que lleva al estado actual
> (HEAD desacoplado), use
>
> git push origin HEAD:<nombre-de-rama-remota>
>
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git checkout master
> Cambiado a rama 'master'
> >> Now on 'master' branch
>
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git push
> fatal: La rama actual master no tiene una rama upstream.
> >> This error message is something I would expect, since I deleted the ma=
ster branch and created a new one. That's ok.
>
> Para realizar un push de la rama actual y configurar el remoto como
> upstream, use
>
> git push --set-upstream origin master
>
> (base) tomas@toms:~/Projects/tomaszubiri.com/site$ git log
> commit 912c91a92e17de33247e2040d1dd01adbfc218eb (HEAD -> master)
> Author: Tomas Zubiri <me@tomaszubiri.com>
> Date:   Fri Dec 13 21:37:30 2019 -0300
>
>     Agrego mi celular, por favor no me manden spam
>
> commit 81542e725149ba5da36560ad14d4871eb7ea01e6 (origin/master)
> Author: Tomas Zubiri <me@tomaszubiri.com>
> Date:   Fri Oct 18 17:08:50 2019 -0300
>
>     especifico tecnolog=C3=ADas de contribuci=C3=B3n de codigo
>
>
> Thank you for stepping in my shoes for a moment here. I understand now
> that Head is a special kind of tag and it must be attached to a
> branch. But I don't yet understand why the distinction between head
> attached to branch and head and branch in the same commit is
> necessary. Couple that to the fact that git forgot (perhaps with good
> cause) what remote master pointed to, it feels like this is a place
> where git could improve in simplicity.
>
> My naive suggestion would be as follows:
>
>  When HEAD is pointing to a commit and another branch is pointing to
> the same commit, consider the head attached to that commit.
> I understand that, if there were multiple branches on the same commit,
> git wouldn't know what remote to push to, so in such case a
> disambiguation would be needed, but the case here would be that we are
> on 2 branches, not none!
>
> What am I missing here? Would this change have catastrophic consequences?
>
> Regards.
