Return-Path: <SRS0=+MKA=Z6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6206C43603
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 10:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D225206D6
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 10:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="R5kB9TaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfLHKq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Dec 2019 05:46:26 -0500
Received: from mout.gmx.net ([212.227.15.15]:56285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfLHKq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Dec 2019 05:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575801967;
        bh=62IY+LQvpV3QmdAJVQtLu8qQj6TlEdFj5lKHg5L+JRo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R5kB9TaAvHtf9YNJoCJzR+9kLc5VdJuGkIwH/9qR6JUBqQTy+inpv/u988xCbg2M5
         0jdEi8lzNRscA7OkLadXAdz1i1PEchhjqjcGEVAUMm5nAQmnniTwys01gL4gfTabfv
         rfuNaEoTkJz8t4avrrKCPyPIcsURrHpD20CHY8U8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8mV-1i87hK0PTh-00fCzQ; Sun, 08
 Dec 2019 11:46:07 +0100
Date:   Sun, 8 Dec 2019 11:45:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 0/9] Rewrite packfile reuse code
In-Reply-To: <CAP8UFD1fp_uaR5+=Hp24y4zq+rVuwfgiFntDtr8i3B7Bx4k-_w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1912081144110.31080@tvgsbejvaqbjf.bet>
References: <20191115141541.11149-1-chriscool@tuxfamily.org> <20191115180319.113991-1-jonathantanmy@google.com> <xmqqeexwxyc0.fsf@gitster-ct.c.googlers.com> <xmqqa78kxy1i.fsf@gitster-ct.c.googlers.com> <xmqq8snpw2pk.fsf@gitster-ct.c.googlers.com>
 <CAP8UFD20LMxuV7KWAvobybHYZruDiADX-yOFPLyMxsHS7HZN0g@mail.gmail.com> <nycvar.QRO.7.76.6.1912072145290.31080@tvgsbejvaqbjf.bet> <CAP8UFD1rmv7dvWBe5=dnrh8icfsE_PWEukmuUmqB9dWJ9NQTkg@mail.gmail.com> <nycvar.QRO.7.76.6.1912080942360.31080@tvgsbejvaqbjf.bet>
 <CAP8UFD1fp_uaR5+=Hp24y4zq+rVuwfgiFntDtr8i3B7Bx4k-_w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Wp3uzdihIFswi/ElMQ4r7vAOgkU1IZe1yKutv+gTSiVfAWg04/K
 djBxyRg7fnzGyd/PxeMsPMFkPXixmhai5a2VhxzEjIpsuU8JjJlfmycCMgblckjIMA7zbeO
 bHxc6BKX5Ieox7aFPD9aqdcVulU9I+LcXAQ5P4cX3MiOBJeu3m7XMVdtTFF9Zecq0X5snkL
 /QdFxUcWRgo/O5gIDPLjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XvR12KdmBUU=:FJibP20FYXUyrKLw7OPY1G
 lYh1g0135mCaW2PtzOW7oggh+K4vCIOP10orwuxqh1tEpPOWSmHeEcZjpecJyL6/7QUY9Lis1
 iWfWdF3/Y1x7TsFiK4F3uymHrN++tCZLrdcEO8TmR7jE5411lCZYiCGUXTOu73XhBS6lovE6R
 QfbpjYei8Jz+U01XEweJF280jM0xQwTDKHldQGr9W1jak8e96pyIM+Wyp+O2HSDvP+Gj5Ojm/
 qKk2Js8e2E8aoh3wA580H5OUTQ/vktygXckhF3aPlytIpKpLuW8VmqGSOdvqyzijAoiVm0/Nv
 xrDK3ZLt1g7iw5wwNim+ErN7pEWm/P4wrYyv97n+d2OZk3jGTXMwdAb2ZzmKi2UxLuWwOjx9+
 RK/bLkNCa0+Au8jAOGIQ5uEoZTVQJjUTZjpZyp3XtQYf0AJ5rN75peKEVUahgb2RxNPw5aTQu
 OckCXAtFJEElgEBehN7hUxIAHDJo/R1oxRZJlttrNOmHMfOkP/iRcG8D0GSsty8mYy7hw9K26
 E7kyVTbg7y8kupn4/WKtlRPmDb1HtdkwDu9NhtkQhHM6lqOgpvDIDN5QP8NznLLlzzHbVUX5K
 lR85OhZR4u2PqDGJXvfCeYLjuFCNFwSjdPVM6t3YAZL7OR2FqyMXMjBAmz7+VHAcnbzfv4iqv
 ja/VayUq9Vx+xgX7/TeO6v5wjnzWawWsi8JmeKaA8UmD26E5HiQBXgZHUnBw6nTFFDt2fK6s0
 Fs3dmQHivLuTRZYYYWkVQhk9+oTYdS3Qc3KYbdEItMoSIJwpsnF8HUXzbY23FcpjjyrZjXGzU
 k1ZQqK9ahsA1rA6JRIDOkM2x8thwsp24LU1JwDsYQuuQvEep3uHQNzzizcy4vQdxAcqhlRmek
 8+O8efRMVxRheIA0TfRMtgLNPXHkkiihO4slVT7wBrwnmFeR+RMkr625o0gfKKfgr5GQ1IUHS
 2Or77Ro0M8GvRZFQHGm36her+42sH7RbwmWOXvXULogD43/QUR9BjnZ7ey4wkoY8PXuNlRNx0
 oZUhA1dv68FC/c8lwCbygMzCr+xN9G49C2i11li6t1lD2bR7APZMS0Hylmucz2pCjt2PY5kHO
 qqihhTUGMCGrb/UOpy/TSZYoDVgXVKHIlhsteTH0Yw+Wf7lyimgau+n2EtYZ8R/8AerQ/nshX
 OeCRf5fcMORDcZAgzU/ygfgWSU8vXOAbN6QGcewDiAjhBvn+mcTrnu4BAkTaOI02I5tzBR7pO
 gYhlF1OrdagH9LqgfPmFGQJQoaU3nEVCgGN08FbnjCuC0EQOMRtA+S8H34vM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,

On Sun, 8 Dec 2019, Christian Couder wrote:

> I perceive it as unfair to me that you think that I have to do a lot
> of work on this when Peff hasn't even said that he doesn't want to, or
> cannot, answer Jonathan's question.

Well, you have time enough to send lengthy replies on a Sunday morning
(while Peff apparently did not even have time to say that he lacks the
time to work on this).

So there,
Johannes
