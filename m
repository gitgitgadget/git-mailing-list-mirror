Return-Path: <SRS0=+pXB=2E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB38C43603
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 18:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A2420724
	for <git@archiver.kernel.org>; Sat, 14 Dec 2019 18:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomaszubiri-com.20150623.gappssmtp.com header.i=@tomaszubiri-com.20150623.gappssmtp.com header.b="pcBMSlKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfLNSAG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Dec 2019 13:00:06 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:39535 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfLNSAG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Dec 2019 13:00:06 -0500
Received: by mail-qk1-f182.google.com with SMTP id c16so1971751qko.6
        for <git@vger.kernel.org>; Sat, 14 Dec 2019 10:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomaszubiri-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1V0Ivg4eg1KY5Ss8TY85/4TFy29537nO+7l6vGDiLEc=;
        b=pcBMSlKN3eOej7fm6hepD5kL3RMGKyUgKmvIC1c8pr9BjsTrrXOPZEB1hICbnMHpbx
         DD+3HUi/FwNBxyhpZcnmLvoT2S6vq/LTlQuyRNfxmGjxUBlykziCREzwq50nMTwbBf7i
         n07fNGPxIfsXh8MMydIkrqKaPkxd/Mmsu2+lR2Gcs/gbxJ9qbx66/5QDqLKJzROMeCqp
         tB62P7nOLMwnIBfBa0sY7ud4Xwn6OZ3naka5VkW/lH6S0IMZvgFdlioqlI5EIRYB/ViG
         AkMGGKqoigD52n6UuMQFJiqcZW96vHuMrOvi3K+o9cd1kgmI0K87TFcy2xx9JwAejnii
         RSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1V0Ivg4eg1KY5Ss8TY85/4TFy29537nO+7l6vGDiLEc=;
        b=AYKuPobJ4oyHIoHONU+rq5ed0dOdmUUCbOxnyBaNYb8fj0QPI2Fx5+5rc2JjkxxIU7
         ///thmq/pirUEdTqt1o3ZlJN0za3AcakOLcR7PPRBPRNH4FxaToRz9lvSaKllvzgY1mu
         qE9JXCSDNLRT2s/gyxmEe/SR8dbmfYj9u4D7tAktKqsgMwr62VMcuiOBtrvU2pnFzAJd
         aceZYGhA3fQWqXxM6jgiKFSHCM+4a7oZXpoka1ni3ImRON16uzjou31IBzLKLq9vpDkv
         v5XpglDgWmiJeHy20SPaW9kLsMmCNVMUCopLW0CG8EVB/lZlVuXqlprd4L6y8MPoDnqV
         RUmg==
X-Gm-Message-State: APjAAAXLKg7qB/mkDywaw4QeHUHLoRz+MciVrdAXuzc8jvANePWENUik
        QUZ9gzL2dMzsXJQF0vjLbN7yiu/+yluEt1/OWYQbAvWUVuo=
X-Google-Smtp-Source: APXvYqzWPHHtwBRbN4AUoz7TYxNlLN5O+aIBK8HRCOELKTrb1Zq1+SJpaOdRyukQtLBjjIr7kpNfN75xV1+glupr0cE=
X-Received: by 2002:a05:620a:2050:: with SMTP id d16mr13460657qka.473.1576346404132;
 Sat, 14 Dec 2019 10:00:04 -0800 (PST)
MIME-Version: 1.0
From:   Tomas Zubiri <me@tomaszubiri.com>
Date:   Sat, 14 Dec 2019 15:00:01 -0300
Message-ID: <CAE3VKEpPye+GyR7Uo9WBa=1i1L=dFq9AHfdNnhiw19K-jWLtBA@mail.gmail.com>
Subject: Head, Branch != Head -> Branch?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, I'm writing because I believe I found a case where git could be
simplified. I'm posting my terminal log so that you can see exactly
what I saw. Comments are marked with >> . Important spanish git was
translated.

(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git status
HEAD detached at 54da1ac
Cambios no rastreados para el commit:
  (usa "git add <archivo>..." para actualizar lo que ser=C3=A1 confirmado)
  (usa "git checkout -- <archivo>..." para descartar los cambios en el
directorio de trabajo)

modificado:     cv/en/index.html
modificado:     cv/index.html

sin cambios agregados al commit (usa "git add" y/o "git commit -a")
(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git add cv/en/index.html
(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git add cv/index.html
(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git commit -m
"Agrego mi celular, por favor no me manden spam"
[HEAD detached 82b2b55] Agrego mi celular, por favor no me manden spam
 2 files changed, 3 insertions(+), 1 deletion(-)
(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git push
fatal: Actualmente no est=C3=A1s en una rama.
Para hacer un push a la historia que lleva al estado actual
(HEAD detached), use

git push origin HEAD:<nombre-de-rama-remota>

(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git push origin ^C
(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git log
commit 82b2b55b3f7768a60e3d8bcda97d4d623ff0e044 (HEAD)
Author: Tomas Zubiri <me@tomaszubiri.com>
Date:   Fri Dec 13 21:37:30 2019 -0300

    Agrego mi celular, por favor no me manden spam
>> This is the commit I wanted to push

commit 54da1ac07a5c7c2e7234911a0af76aee042b5b99
Author: Tomas Zubiri <me@tomaszubiri.com>
Date:   Fri Dec 13 20:33:11 2019 -0300

    Limpio url para cv en ingl=C3=A9s.
>> This is an abandoned commit I didn't push.



commit 81542e725149ba5da36560ad14d4871eb7ea01e6 (origin/master)
Author: Tomas Zubiri <me@tomaszubiri.com>
Date:   Fri Oct 18 17:08:50 2019 -0300

    especifico tecnolog=C3=ADas de contribuci=C3=B3n de codigo
>> This is what's in production


(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git checkout origin/mast=
er^C
>> ^C cancels the command, I notice there's an extra commit.

(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git branch newmaster
(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git checkout origin/mast=
er
La posici=C3=B3n previa de HEAD era 82b2b55 Agrego mi celular, por favor no
me manden spam
>> Previous head position was..

HEAD est=C3=A1 ahora en 81542e7 especifico tecnolog=C3=ADas de contribuci=
=C3=B3n de codigo
(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git cherry-pick newmaste=
r
[HEAD desacoplado 912c91a] Agrego mi celular, por favor no me manden spam
 Date: Fri Dec 13 21:37:30 2019 -0300
 2 files changed, 3 insertions(+), 1 deletion(-)
(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git log
commit 912c91a92e17de33247e2040d1dd01adbfc218eb (HEAD)
Author: Tomas Zubiri <me@tomaszubiri.com>
Date:   Fri Dec 13 21:37:30 2019 -0300

    Agrego mi celular, por favor no me manden spam

commit 81542e725149ba5da36560ad14d4871eb7ea01e6 (origin/master)
Author: Tomas Zubiri <me@tomaszubiri.com>
Date:   Fri Oct 18 17:08:50 2019 -0300

    especifico tecnolog=C3=ADas de contribuci=C3=B3n de codigo
>> Looks good.

(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git branch master
fatal: Una rama llamada 'master' ya existe.
(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git branch -D master
Eliminada la rama master (era 679eaf3)..
(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git branch master
(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git push^C
>> Gotta double check.

(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git log
commit 912c91a92e17de33247e2040d1dd01adbfc218eb (HEAD, master)
Author: Tomas Zubiri <me@tomaszubiri.com>
Date:   Fri Dec 13 21:37:30 2019 -0300

    Agrego mi celular, por favor no me manden spam

commit 81542e725149ba5da36560ad14d4871eb7ea01e6 (origin/master)
Author: Tomas Zubiri <me@tomaszubiri.com>
Date:   Fri Oct 18 17:08:50 2019 -0300

    especifico tecnolog=C3=ADas de contribuci=C3=B3n de codigo


(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git push
fatal: Actualmente no est=C3=A1s en una rama.
>> Fatal: You are not currently on a branch.

Para hacer un push a la historia que lleva al estado actual
(HEAD desacoplado), use

git push origin HEAD:<nombre-de-rama-remota>

(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git push origin/master
fatal: Actualmente no est=C3=A1s en una rama.
Para hacer un push a la historia que lleva al estado actual
(HEAD desacoplado), use

git push origin/master HEAD:<nombre-de-rama-remota>

(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git push ^Cigin/master
(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git log
commit 912c91a92e17de33247e2040d1dd01adbfc218eb (HEAD, master)
Author: Tomas Zubiri <me@tomaszubiri.com>
Date:   Fri Dec 13 21:37:30 2019 -0300

    Agrego mi celular, por favor no me manden spam

commit 81542e725149ba5da36560ad14d4871eb7ea01e6 (origin/master)
Author: Tomas Zubiri <me@tomaszubiri.com>
Date:   Fri Oct 18 17:08:50 2019 -0300

    especifico tecnolog=C3=ADas de contribuci=C3=B3n de codigo

(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git push >> So
confused I repeated a command.
fatal: Actualmente no est=C3=A1s en una rama.
Para hacer un push a la historia que lleva al estado actual
(HEAD desacoplado), use

git push origin HEAD:<nombre-de-rama-remota>

(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git log
commit 912c91a92e17de33247e2040d1dd01adbfc218eb (HEAD, master)
Author: Tomas Zubiri <me@tomaszubiri.com>
Date:   Fri Dec 13 21:37:30 2019 -0300

    Agrego mi celular, por favor no me manden spam

commit 81542e725149ba5da36560ad14d4871eb7ea01e6 (origin/master)
Author: Tomas Zubiri <me@tomaszubiri.com>
Date:   Fri Oct 18 17:08:50 2019 -0300

    especifico tecnolog=C3=ADas de contribuci=C3=B3n de codigo


(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git push
fatal: Actualmente no est=C3=A1s en una rama.
>> Fatal: Not currently on a branch

Para hacer un push a la historia que lleva al estado actual
(HEAD desacoplado), use

git push origin HEAD:<nombre-de-rama-remota>

(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git checkout master
Cambiado a rama 'master'
>> Now on 'master' branch

(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git push
fatal: La rama actual master no tiene una rama upstream.
>> This error message is something I would expect, since I deleted the mast=
er branch and created a new one. That's ok.

Para realizar un push de la rama actual y configurar el remoto como
upstream, use

git push --set-upstream origin master

(base) tomas@toms:~/Projects/tomaszubiri.com/site$ git log
commit 912c91a92e17de33247e2040d1dd01adbfc218eb (HEAD -> master)
Author: Tomas Zubiri <me@tomaszubiri.com>
Date:   Fri Dec 13 21:37:30 2019 -0300

    Agrego mi celular, por favor no me manden spam

commit 81542e725149ba5da36560ad14d4871eb7ea01e6 (origin/master)
Author: Tomas Zubiri <me@tomaszubiri.com>
Date:   Fri Oct 18 17:08:50 2019 -0300

    especifico tecnolog=C3=ADas de contribuci=C3=B3n de codigo


Thank you for stepping in my shoes for a moment here. I understand now
that Head is a special kind of tag and it must be attached to a
branch. But I don't yet understand why the distinction between head
attached to branch and head and branch in the same commit is
necessary. Couple that to the fact that git forgot (perhaps with good
cause) what remote master pointed to, it feels like this is a place
where git could improve in simplicity.

My naive suggestion would be as follows:

 When HEAD is pointing to a commit and another branch is pointing to
the same commit, consider the head attached to that commit.
I understand that, if there were multiple branches on the same commit,
git wouldn't know what remote to push to, so in such case a
disambiguation would be needed, but the case here would be that we are
on 2 branches, not none!

What am I missing here? Would this change have catastrophic consequences?

Regards.
