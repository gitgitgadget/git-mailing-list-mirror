Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E566C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 18:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9D146120D
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 18:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbhFUSfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 14:35:13 -0400
Received: from mout.web.de ([212.227.17.11]:39463 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231757AbhFUSfM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 14:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1624300376;
        bh=qvS96a9jtjUdj8okTu3wlOChz/oycjWjJzVG9O7YBwQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aM3gHVFB/hiTACqanmXwq9RAMa0no7vaekCbQWF4+9VTgTtEIsJctybowjWUPBoI6
         ns9P7yy7WxzZ96hjkQAFihTL6UPdZi9UgUWQYix+5qkWLjlCXFt8JyXqSYxT524egC
         x870mf6aiG14F3w8upXG6aHEChqAu7qTwzevskEw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MWRzK-1lksza2XX8-00XfGY; Mon, 21 Jun 2021 20:32:56 +0200
Subject: Re: [PATCH 6/7] [RFC] entry: don't show "Filtering content: ...
 done." line in case of errors
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210620200303.2328957-7-szeder.dev@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <85ff4cb1-f3e3-4fcb-d9d8-fd294e0df451@web.de>
Date:   Mon, 21 Jun 2021 20:32:56 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210620200303.2328957-7-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eIhrOXnREKaA27+LEUNtexqw0DSUGoFiJm6WiE899b8dJg5EPz4
 a0lCg3auLdMHN1m7tReK3T3qRrsBxWZIWIjBStuL9U/YajnGIIzvxW5r7RC4+h7XPRL+V/F
 +05p1Q9JLSSDcl4x1fbtdhgVoitHoLO2Ajc3t516Xu0pdarHp3ifBsC5Exhoh1ewkZi4vH5
 lECpCxTQY2meRVz/9NiiQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oDzbCgMLb1o=:Ipsj6wKB+8hLbNSt9D/Ekf
 GPYzOIp9u86utmytWUJF7cEMjxYGf99mSFuXuS8lpMSkClTrNbc/VGiLcxhnMytmC+MbivShA
 uDr87ZhLFKFLe998BuSb5YpvQAx6xBhTGwS58PCQkEsHwCEaTuXj9Tl7foBF0tZf0swjO8/5K
 FIWmVdXzDl9bAM9yg8XGTTu0pk1eS/Zk/G0I1LsFs8ebSl4JbHmbA9jlr0Hv+wNX+X8Pn6mWY
 SAMdbx50fX9E6pclvElJpiZQ5qYKmJpPwpahY1N92w3rrbBkxwkldwmIkLP8jhy+x8jthhRM4
 hJ8YJuhCdH8Y6zc+hw4+qSgb6vmIAZG0osA7HzYd6gVuQDXgCqH3mqeT+hQq2giNj1l6y3+P6
 uS8xZLgBHFpWddoHBXtQmI+o6eP7m5C3m7GQy2tGPl4WCiaBJGxj63KyFZWiUKq4ab4E7XpXN
 5YV+mBlQOTXjhS2286LaEK3Te1Vo2DLxmInetmHPRAyLaahuoyJNMPbP2E0xx7O5yTShBpJiz
 5TnoU9kcUhIus3U1XGLdXD8YjAfMgFZ1Gw1YMbh9AEUNGTvWtKfUD+G0n6Xa4MsWLdiVk7xml
 ZnrHoTrC4u+fLb3UdCIDU4w5xhIm84QF5JFi7E17/ydkPnj8oo9GRlfzqjI6TlV0uB4XDVkj0
 8QnFUYw0o4bMpRFXQ3XjdiBwC08YdJBrDYiPlcSdELqnh8Un2YZyG5SZZkPMVhrgeb1EWd8+r
 bA7yrKt+3p/6zf0QeinYplHcSG4ucdMmcyb2muPzS4cu8psi65Qzp8E8MZg+6lSqsoKqGxths
 Zetg5yJMfna1s839Mi8J8olWEmPf0SNGJ4IfwMB6rAANPzmaOqZFAebHcHIAHg0Bc2UxSZ/gZ
 Zd8mvND+nSOBnngJChq7Agi0llgxTJ3XXTbcAoeYWEu/Wx95nnhwXnG7jxeYDW2/SniA+agpb
 CRK5pB+vOvjkRK1u7xIfyGXRKUKKtchW/6FDIRmb77wcFs5AbnKvLCICFT4B6enMwSewHunPK
 oZtHYQnijq4Z7Sb2HqK5L5HBGI7Ogw6wT7rHGqqzR6Njn1gFTcHkWZ079833/Rt0h5cxadEnq
 /5Fwql4WevemPUemD/owklkt5AeqEx/couQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.06.21 um 22:03 schrieb SZEDER G=C3=A1bor:
> RFC!!  Alas, not calling stop_progress() on error has drawbacks:
>
>   - All memory allocated for the progress bar is leaked.
>   - This progress line remains "active", in the sense that if we were
>     to start a new progress later in the same git process, then with
>     GIT_TEST_CHECK_PROGRESS it would trigger the other BUG() catching
>     nested/overlapping progresses.
>
> Do we care?!  TBH I don't :)
> Anyway, if we do, then we might need some sort of an abort_progress()
> function...

I think the abort_progress() idea makes sense; to clean up allocations,
tell the user what happened and avoid the BUG().  Showing just
"aborted" instead of "done" should suffice here -- the explanation is
given a few lines later ("'foo' was not filtered properly").

It could be a cheesy stop_progress_msg() wrapper that temporarily sets
test_check_progress to zero..

Ren=C3=A9
