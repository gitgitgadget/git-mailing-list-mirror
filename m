Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E159C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 07:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B6D060F11
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 07:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhIIHxT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 03:53:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:45147 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhIIHxS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 03:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631173923;
        bh=RaCIwm6h6lK/k3zUaU20sNmlj+ca7Mw7GAXP/mkR2DA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=CKdWDFHgCI4DwWPLhWZKu1KZTZQ0NwZ4brofXNNAnLZ9uOW2IDg3y8G3gEojNxdgf
         3i9PEGQ+gGS58YyaKawE0MdpLLzGOs/P4RJsmSqLlyCkhcV7xm/V8OIgaHQ0CTNhNe
         IKk5opYMaKwGY2JLj9PS6jcVgpKXKQmympQ+g9k4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhD2O-1mtR0T0Z4E-00eHik; Thu, 09
 Sep 2021 09:52:03 +0200
Date:   Thu, 9 Sep 2021 09:51:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     "Miriam R." <mirucam@gmail.com>, git <git@vger.kernel.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 5/6] bisect--helper: reimplement `bisect_run` shell
In-Reply-To: <xmqqlf48b5io.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2109090922310.55@tvgsbejvaqbjf.bet>
References: <20210902090421.93113-1-mirucam@gmail.com> <20210902090421.93113-6-mirucam@gmail.com> <xmqqtuj2h7cp.fsf@gitster.g> <nycvar.QRO.7.76.6.2109060923390.55@tvgsbejvaqbjf.bet> <CAN7CjDANWsWwPcAG2cftAiadwaWZNXBtL=Q8MrqH2xVMj7kUOg@mail.gmail.com>
 <xmqqlf48b5io.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:g9rL8DknyHH3BLJpbrJ7FHglOL9h1WbZd+zc0Qq8eV94vivXp4S
 Z0zXSvJzbImM4yflNiDnvyANSDPCN5nBImSqz6oB+KizlzfOglUHAZjfUjKw+6hqxoEs0uX
 n7LVDYh6JhW4N9YCTPneE0mkXjqXeLr/2bhQRGAL5S2ssqo9YyAqH4s168g2fAJ/5BZVpiq
 +zZR4grf+az3BOc8kVMBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/8dWcpHVeE0=:fLbYh2SL3FnCWXX6UMViM2
 X4K/RMulGfXNEMKQrGqh35UEax9xfZC2+ORTKIJ9zHJlMmgEfnNRM7fATXC9tcMHo0CXqE8OS
 GxMSLEBrFWpsVnvXO/W0QFuVl8KsGTSmIXA6iuZ7A/Nq+Wu/KRS63HUhBMSlN7faF9s5XeXgo
 kMfdbGxs77OJ1qsiPSsUN/7MqaQpT1bTAghYIKQX3sYq3zd1B2koFYMneFi3xFj6U7bw3CYzZ
 32b7j/Ra1eclOV573zXayr5KsupwX1H6LfJmoc0rn+ypTBr5UyYCPKPqK9dm7E2BpI9tDQZGK
 9TN7l9nt21SwT7n5hpuQbRGUuZuDVZmjzI3mNw6TgAW3LFH6Y1YEOSTZ8v1NnZMcpkSCcs3zB
 /4pxmfsdaeYimorQpvAwtNzBTl/drd1BPFFRcK6IqlAC8rzLUT8sdxXOiJEvV5EkIvypXVfCU
 /Mp65f+IWBvHl4XuDnIK4G4hGXXfiw+EaKrF80bOC4/RwvF+7g/g51X5HFDh4LfFhstvBjG3q
 8AWxa9hMoYFGffiA0UqUB3mkcs2OkYC0duKyh+A7287a0jRncI0Soo31WdD55NH/GKF2BqgF4
 1W0LpbU+MKAO66ynbJC812DeYiomnIyL2Q4KzT3UhQAzUBJwyoXWSxCdEW2uLt1HXYwvZMiI6
 pWK3laen1lKvQhL1OLypWE6ppuzwmZHgQDloAVtgRv5GETvV73hPCwF8y5lItWOnhFhJ4nNHS
 VzTxgWWo+p0d5WUout8zQIE0p1Y5ufWgMzZD2d8B+/jU0XcBhZ/1pcBHzltjv1j4qdkNKRXWc
 64BzB8IwZaX4/OTvPFpxjFc2pgA0kKWFuCLqUko+1lI2g9DndFbVvH6pzbyLd7OS9dvVoh9AC
 9YDIMwM9Q0A6kXokaO3taOxYg+ucnB6jv7oSErH7U4Jv2v3NXfYV89Fb/Y9eSJfSwPvGQRHdX
 K/9wOLAUeeu8P3fIPEM369PwM1BfQrMkFL2t4aiydHQji/A5Z23tCv8nIKHxZgpK6YlIfwprE
 fZomZah1aTpsYkGjKUSaMjf2IWL1rjHfS55hss38VF4HSckpZtXoCl9ayHnZSGp6C0CZCXUiH
 tKixGkmV53AppY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 7 Sep 2021, Junio C Hamano wrote:

> "Miriam R." <mirucam@gmail.com> writes:
>
> >> However, I still don't like that we play such a `dup2()` game. I gave=
 it a
> >> quick try to avoid it (see the diff below, which corresponds to the c=
ommit
> >> I pushed up as `git-bisect-work-part4-v7` to
> >> https://github.com/dscho/git), which still could benefit from a bit o=
f
> >> polishing (maybe we should rethink the object model and extend/rename
> >> `bisect_terms` to `bisect_state` and accumulate more fields, such as
> >> `out_fd`.
> >>
> >> Obviously this will need to be cleaned up, and while I would _love_ t=
o see
> >> this make it into your next iteration, ultimately it is up to you, Mi=
riam,
> >> to decide whether you want to build on my diff (quite possibly making=
 the
> >> entire object model of the bisect part of Git's code more elegant and=
 more
> >> maintainable), and up to you, Junio, to decide whether you would be
> >> willing to accept the patch series without this refactoring.
>
> If the code paths involved are shallow and narrow enough that not
> too many existing callers need to start passing FILE *stdout down
> (from the looks of your illustration patch, it does not seem to be
> too bad), I do not mind a series that is a bit longer than the
> current 6-patch series that has a preliminary enhancement step that
> allows callers to pass their own "FILE *" for output destination
> before the main part of the topic.

My impression, from the diff that I sent, is that this is too deep and
wide, and indeed needs a follow-up patch series as indicated by Miriam. My
preference would be (as I hinted at) to accumulate relevant data (such as
the terms and, yes, the `FILE *`) into a `struct bisect_state` and pass
that around. Sort of a light-weight object-oriented design, similar to how
we do things in `builtin/am.c` with `struct am_state`.

Thanks,
Dscho

