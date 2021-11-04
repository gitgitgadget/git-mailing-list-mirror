Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12855C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 16:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E778E61213
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 16:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhKDQgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 12:36:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:40957 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231586AbhKDQgA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 12:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636043588;
        bh=4HvEyVuxuH1JaRrbGFhq9SzFBeTpEmLU4za0onaF5Dk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YazCRmXXRb6qEzDUyVALE2dx+uZ/cabtVZ2U7JtifMjLbv+lgy95/45uqxJPnU1dA
         SnLAmxa5zmrdl9LN2irE+DClOdIfv1srI76F9HSZCSMzDJ1rI09VZcfjMtsxpUBrwC
         mKnhVFLquFILHzrbzAtjaV3ok8oeQ6mNBGQNpiNA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([89.1.212.10]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKbgE-1n1Qym0ba0-00Kvz8; Thu, 04
 Nov 2021 17:33:08 +0100
Date:   Thu, 4 Nov 2021 17:33:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Carlo Arenas <carenas@gmail.com>
cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, philipoakley@iee.email,
        eschwartz@archlinux.org, Jeff King <peff@peff.net>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2] async_die_is_recursing: work around GCC v11.x issue
 on Fedora
In-Reply-To: <CAPUEspiJW8ee_1zoMg6JzJ0ow-2tmPh8iUZK41kfvt6etzEfjQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111041732290.56@tvgsbejvaqbjf.bet>
References: <pull.1072.git.1635990465854.gitgitgadget@gmail.com> <pull.1072.v2.git.1635998463474.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2111040823270.56@tvgsbejvaqbjf.bet> <CAPUEspiJW8ee_1zoMg6JzJ0ow-2tmPh8iUZK41kfvt6etzEfjQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:S+kak+xNfUy8K8CRc71pu7EgqI4BwdS3668DrcQhiL/yT9GTYHn
 gU6vC2oqod7EPcXufKArRjqL0PXrs55o7YWEiIJI9FomC/hFyOU1bLNDwOJ2GNeyOBIpHlW
 D53NNYs/pmNZXcC2xMhnLr1uDCYLRvMJdEobQNxO1uzVmrahEgvEtFBPGPdXX0HzpEY3cCv
 Ad/XkJMF3DlqSK5PvFkQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t/Wm0qUGDv0=:revCsKIlxeaJIJ81BVXE8x
 lxJq4AD2RkAr4p48U6cmuZGVMMhmZmQjdARH12BrJG3r7p8KvGho3ytYCnfN48nHTvNb0GaBk
 HKplphVs0NyB262pKz4j1Ia4AiTkThiDsjS+bCwCgACVcEFLSupmN8RkojXRmimM5lMPIut7G
 n+3LVEhTIRl0amJZS8b7QjrlyD01s/KFmv+uph9lLzgKn4L0hB0VOu6/4+rDJ6+Y4ml/l3caE
 6qLi7IPt2kkBivK+O7h2zIy6OtrRybXCxwxeQ5D2jNOYlBQnT2/WxToGcc/TH3BYvqrAqdJl9
 A6W2s+LoDi33NIBX0tiQbVsdShkRGEf1o9DvtbedfU6JILo1HBOVBeThwAtwVIKocTmMBG55/
 maFA6laas1b7pdwTNGc2N/P/1ctDBooK7k5sAOBq1r7hQIhNwO0XEhOuewRDPpkLnW+K4pCgg
 PXIs9dCXGW4a146OtT5V5335wdQilWRlglJuU33Xjs72i+FtVn8u4sbEYRSB3eZ80ztk9VGau
 6yntVbUV90f6/awLlsr4FrcwEN1/vYpqZfrZE6ut7x8uWpNiRiDv1Ds0PeEtKU8eMIDSZKaGz
 On36nxOqEahPVt0eqKVm1rLZgaiS6YF1CIygBU7dN226cXWyDZURHd0sMxsRDXclFwzwmsfJP
 ojNDk1GjfQfNM3sV1RsQpIGKqTlEQc1OvY8u9hKSasnd1Y5LJy6yUrc8GQU4444UBrYHiaRoK
 E2zpyUClymF8z1qZ9vH5hSUsZnW76wm24oIJQp0PHUAJMSj4pGROaeG37gpCToJP7SsVs3JwK
 A+X9calX1PEd0LAGsHsqxVi3vIvenLGlh0GbApFpkcAX5HNGzlUHpVmTjhM8zfnQWMb9Xsqwk
 3NRHriYurYKIZW1Rt+Y+g9C4Z1x+rjwjXx9M8bjasl4ivSSerE3KhfBcL+bWEvLUZ05MZWDJr
 +FZ5WYBpKbJWQ3Q6c9wrqeGDUysKYhB9SOT4pM2Db6CD1IlA8T6VXBCRDLL2+WT+jfxGvs5F+
 q0WEa57WOVqzhQ7nS8AeAV1IxjGjl1ikvp6DnTXt4puV52lGGhkP080e0UAGRXv5phW2zhqfR
 UG0gSDix/RvZTA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

On Thu, 4 Nov 2021, Carlo Arenas wrote:

> On Thu, Nov 4, 2021 at 1:43 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > My best guess is that my GCC (which is v11.2.0) and Fedora's GCC (whic=
h is
> > v11.2.1 plus the usual Fedora customization) behave slightly different=
ly
> > with respect to that optional `size-index` argument:
> > `pthread_setspecific()` is essentially declared without a `size-index`=
, so
> > I guess GCC v11.2.1 probably defaults to `size-index =3D 1`.
>
> Got to read the whole explanation that Victoria put together.
>
> for the warning to trigger on that gcc, you got also to have the
> attribute in the header as shown by the link[1] she provided, and
> which I am sure could be a nice thing to send toward those helpful
> folks of the MSYS2 project so it can be added to their WinPthread
> headers, as was done in glibc.

D'oh. Of course we do not have glibc in the Git for Windows SDK! Thanks
for helping me understand this.

Ciao,
Dscho

>
> Carlo
>
> [1] https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommitdiff;h=3Da1561c3=
bbe8
>
