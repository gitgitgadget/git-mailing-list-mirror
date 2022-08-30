Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE463ECAAD1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 14:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiH3OTE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 10:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiH3OTD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 10:19:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F5DB5166
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661869140;
        bh=JnTV4moF/pJfb7++O/mydU/dl6HhY+s5h7NegSclpUw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LdmRhNt/hXSpYkw5sJ02iLGg65p8slnQkNtCwnXHh183o4zdHrnQV8WTVQnU9oHtb
         qpTkv3akOL324+gNhHkOdZa0iqlOWwtjo/WYC6Ut3Qnm81l6KBxdLRqTYNcgBI21gk
         lYFgeXvledvBDAT27bp5tkYBzd9UeYQJAeWebqqM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MryT9-1pEky10rWX-00nvjq; Tue, 30
 Aug 2022 16:19:00 +0200
Date:   Tue, 30 Aug 2022 16:19:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org
Subject: validating signed/unsigned comparisons with Coccinelle, was Re:
 [PATCH 0/3] A couple of CI fixes regarding the built-in add --patch
In-Reply-To: <pull.1340.git.1661867664.gitgitgadget@gmail.com>
Message-ID: <p9p431r8-nq64-02sq-3049-n10rrn1o89o7@tzk.qr>
References: <pull.1340.git.1661867664.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QJtByPjKkChZJbQDzv/XE3VM5v3nhg0n7KKIUFH6hIfGcQ5wa7T
 9PuI9WTYeQgKBNonHEjbt7uLzA06vfAGGPbFwD+kp0pKUzWNb+oIVDSZpAT8ypEbE2MbFhA
 Qe5kjv9FxP84iuk959pXP3mck8u0v1lwFpDllfmbsbmhIG8AEqyxWr4wi3jV7agdgDpGBtu
 V3Ues5oQ/rLzqwjj78AtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:va/b1nUsxsM=:MyBwU14ZKnsuEAI/4Fikin
 bxQuOdKhodC5akvqmUR5lGsQsjXTbwRZq95D3e2mR0twos/ny8to+3wKbGY5dhcJ4qQDPgdc4
 Vvk6SwBfAEchSI5vJN74cW7Glz+LiXeiGrnfZLkIellW1GrIOxMmipRoaH5420ziFh+crMYob
 PE91vR4hWeOLmcSmip72G5GuGAVehJGA8WlOUMr01Iqa+VROGeZv2LeVR0AoTiNHyLZbt7Zo/
 hGM1WoUjXLnuAUY3goIYml6UvIKT90B6GgO/rlgoSAhq5p40QMT6wof1w7ObjvrAC1IdXrg4c
 YWPX9j3VfwKHCrVEmjxVurGsq8AoYY3tiGqphMFcQod5DAb9uq39RqDz4zWepQxVBI6qrSIbA
 UjVBBqobehv0ca1JUD9AWIEpD4Wt+a+vDdGq4zlwop16JfIEfYA9awRHPjyHreCe82q8KZhDn
 P4iJqoo/FdoBotmz1ddzrWF1DrSdRupWLGvAwbluEY4gxDFStayylINQL+iEHzOfil3du3kVq
 nQuxCVlzPoi8fE/ugeRwZvUlSyrVoNDXvInhdqH8/P+dh8VK0d7bHbX5Niqn1jQBrDBi/VYrL
 E1kXNSSCOp15/qE9FqVqK0gd/kDbk7ec9K4wpBGqcJqAjmG3h2syIKo+zY8qGRrd0oJfLhjoK
 sxG03uMDYSCslOGocQKAEN+yDw5VkXSIXgKy7UMd7ktMkwD0FObQfNZym0nZhJYiF5eVU5e0x
 K8+6go/YsC5XubPgfJjj6KgzBoHvgPntEluAOaNm6x73Bpi9iXyxdFZjR1PwO+mJD8hdYRYka
 HtNArkYUjlT2ufWYysaLeZEFOUQHxW6os11hrJEXH27h/FMTQY3F8pIsTMSUcePSlZdUNnClS
 qtmF3+1kr7gixh+NIs06sfyv7+8UbeIO2CmYAeJJdFGARIQIH/OUVNIZFUAGkXn++N9ZdJaeN
 xrm5CKayLSGr8CW7U/ljgNU91fU31Q4YtsSrL18cMTjURR5z3mik7fVAjiVClXIbZCz1+uyRm
 OT5ow/QQUCI+yCtvl5kjb2holM/1hHyAl3MpWwa+FvKoJCoCNLtvyVlw58BAywiLinoVvCMps
 HCBBvKFdMNO1b7VW4dKRp/T3eBC2YrRV1E9mAuOJ8OlFXXNyAMgIFdx6A==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 30 Aug 2022, Johannes Schindelin via GitGitGadget wrote:

> Note: This patch series is based on ds/github-actions-use-newer-ubuntu (=
but
> probably applies cleanly even on maint) because I tried to develop a
> semantic patch to fix similar issues in the code base. However, I've sin=
ce
> run into what looks like a bug in Coccinelle
> [https://github.com/coccinelle/coccinelle/issues/284]. My latest version=
 of
> that semantic patch looks like this, but I stopped when running it on Gi=
t's
> source code triggered the bug for 66 of Git's .c files:
>
> @@
> type T =3D { unsigned int };
> T:n b;
> type S !=3D { unsigned int, size_t };
> S s;
> binary operator o !=3D { &&, || };
> @@
> -s o b
> +s o (S)b
>
> @@
> type T =3D { unsigned int };
> T:n b;
> type S !=3D { unsigned int, size_t };
> S s;
> binary operator o !=3D { &&, || };
> @@
> -b o s
> +(S)b o s

The bug in Coccinelle is already fixed (are you impressed? I certainly
am at the incredible speed and at the wonderful conversation I had!), and
I verified with this semantic patch that our code is clean:

=2D- snip --
@@
type T =3D { unsigned int };
T:n b;
type S !=3D { unsigned int, size_t, float, double };
S s;
binary operator o !=3D { &&, || };
@@
 s o
-b
+(S)b

@@
type T =3D { unsigned int };
T:n b;
type S !=3D { unsigned int, size_t, float, double };
S s;
binary operator o !=3D { &&, || };
@@
-b
+(S)b
 o s
=2D- snap --

I do not currently plan on integrating this into `contrib/coccinelle/`,
though, because it will take a while until we can benefit from the fix in
Git's CI/PR runs.

Ciao,
Dscho
