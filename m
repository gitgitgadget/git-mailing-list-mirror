Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B815CCA0FFB
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 15:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjIEP7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 11:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354342AbjIEKv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 06:51:27 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620A11A8
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1693911075; x=1694515875; i=johannes.schindelin@gmx.de;
 bh=OSdEVHifdYSuWFnsGde1uLigJ/l6yT1dC6YdYY2lf40=;
 h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
 b=BbaRG/hMOMDjeqPPVxIdjlXLpQ7TB6k2TeUXeOaZ05/0Cf1rJ601nvc76AlQhGl9BUCycMC
 GxhV6KKf1ceykWKcB978keUtcRv3u3ZcN1xAsAVxN4rOrnLqhsWJOF0d2TYPS3gEL0shKc8vI
 flhXd5ZRBlDujCncrZIpQG5ocL47C0/NQe5SIcB14mjychHr3zCY+zGUQR3knrKDC8mLgI4qX
 xG8uRXNe3ZFTfqDZqP708DumihoH/A7c5opPoeqTxG/sZ1kUGX0WqHxS2VrBaaDx47Gy070PN
 A0kM7yOZKjpqILYGIXZzMpGmcaIiUyV4L6aWF5+8qRBl6dwLiXMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.152]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRTNF-1qGCAw2POn-00NPc1; Tue, 05
 Sep 2023 12:51:15 +0200
Date:   Tue, 5 Sep 2023 12:51:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] ci: allow branch selection through "vars"
In-Reply-To: <20230905073013.GI199565@coredump.intra.peff.net>
Message-ID: <44a5d2d4-a6f1-7259-504e-269ee389c8ea@gmx.de>
References: <20230830194919.GA1709446@coredump.intra.peff.net> <20230830195113.GA1709824@coredump.intra.peff.net> <d000f469-2b7d-e037-c92e-013034490461@gmx.de> <20230905073013.GI199565@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7HMSQVy5UILgOKphIorEqVkSF4YaCBxJVJyhEe2EYFNcNbrGfkM
 53YfMES1oU+0u9oNiT5ch6DpAnY+SLZtGLv1Kjs4IF1YL7CkXYJugS+XlmZnOHMSWMm4nW/
 7tBlSKpAVPs2HOlOn5zhBLQgpeTGkrmFMGFicDN/irU2pN3fM15NX46qujPkSQ8RSTMl6OA
 nr/4AcY/ldh8lt29HfmmQ==
UI-OutboundReport: notjunk:1;M01:P0:Wqcuvoq7uag=;RLnKVC/hN7NkjgIi6C3VteBa5yE
 JcTwab1ZtzvHz0bpoyDqr2aMqOr6R7IldKh8DPxHCC/nD95gEorTT9YCevLxBf4y3IGNJ+7og
 0RUunU37eWTFoURWQzS09Ims46vm5cmoQugfw2BxZLgjSO1c6CqBVVC7hhSOQYmAM9FbBBMVL
 a4vdRoAQFKxp3+a2u8t28NGXKTjRm10xdJ9vbwNPrMdxkOd5DZlkxGPDoF3K8O4r+9PVGyCcD
 SemmQrkKmOGv/J7+RLgkC8TOxPNtu3olbhGzxRxkrcMAFmBVvRZawkMeFXoosNWnKKgPT6yFe
 mmzIgjsfKiabGbEPf2tIo9ZUN9WKkxkFno1N20AfDor/7DUFlozGu0kJcA7vCnA2FlllfFtnU
 g8UkgT40lhix9XKzlwo+/4ONyj7bKqV1+366KOJ8fUzZj3QG6SWsgJx/MKlDv8IpOPEpRS2UL
 qjLZnDvufsIq83TZYLXlo7iPcTaxkVfcP1EDIqS8Dknx3+fa93yyVQNe5kYjNPRStbF5ytsro
 jT4U69dUkm2SqkcjwhYbmUPY6noC822TJ+1L+ZbxwMNPTJRThbiBo+uZRza2EwP/Yhmegh7zR
 n7woBz3aUeqExUD5299tr53y6JK5dyDmoUXtbtRAGdeJXtwWB8Fx97wld39iufircaST3mIaw
 epJu/pZNkNg9LHE5FpdtexjByNCWeP02MIlj06qyIQEfwh6YvHDkIHlT8b3rmkuQ7DbfLg0zq
 csX52vrIpQKjxOttPEwLYywAmOEvHBEZvUzLBlr4BJrfWqpu1ValTJ+PkbDlQ1DwiZNsKLqsE
 WJ9xzPiA2yow5XVe0Isjk3tSmOCTFWiAMnz7J94qGB5ShAXZMlyoYKmYoVXHBrurMF5uwbLrc
 WXbW+O+RjbQaeIYISKkBVy+16aApwOPF6RkDYcGponuyNW6VUGAXpYzuNobIWKbdTMKDE4Xxh
 7PMPlPIVE+So6nXvmll0M0WBZn0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Tue, 5 Sep 2023, Jeff King wrote:

> [...] coupled with Phillip's use cases in the other part of the thread,
> maybe we should have a JSON-formatted CI_CONFIG variable instead.
>
> That requires the developer to hand-write a bit of JSON, but it's not
> too bad (and again, I really think it's only a couple folks using this).
>
> What do you think?

Thank you for asking my opinion. The `[no ci]` support described in
https://github.blog/changelog/2021-02-08-github-actions-skip-pull-request-=
and-push-workflows-with-skip-ci/
solves the problem adequately and with a lot less complexity than the
current or the `vars.`-based solution. In my opinion.

Ciao,
Johannes
