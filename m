Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456E6C433E0
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 12:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F2A720792
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 12:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Pym8+Ag/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgFLMyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:54:18 -0400
Received: from mout.gmx.net ([212.227.17.21]:42927 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgFLMyR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 08:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591966412;
        bh=cdCS/2MfX00AjjnTNFkLHdQ+LiwjO+f7WckYilcDPQo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Pym8+Ag/dqENCqtOJxn7CvJbWtjB+8IMI96rBXeRsK0WzmQjJ7MUO87wDYX+JaTWl
         2Fx2C388a0zDDNFBPvjEfymYTZK7IQwFlWQhUB5lbmgPOzhQ4X/rjKo8eDsiWWBkLS
         8zuBwdwDy/+3PKGm65vTHGPir70Xa1Gzwbyt7/zI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.214.156]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatRT-1jC23r1xRT-00cSWZ; Fri, 12
 Jun 2020 14:53:32 +0200
Date:   Fri, 12 Jun 2020 14:53:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH 8/9] fast-export: respect the possibly-overridden
 default branch name
In-Reply-To: <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006121451100.56@tvgsbejvaqbjf.bet>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com> <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com> <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com> <20200610233912.GU6569@camp.crustytoothpaste.net>
 <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com> <xmqq3672cgw8.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet> <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:x3WZ9eZ0UwLZ9+QoGmU57qVMSGvlIGwuFv8G4gXtHlk3iO445km
 JTtvykUGh7/ptnSL/PloBNIQTJeV0JFHxBr5JsfYiMydtKIBgyLsuS174aFn9e+Q649sP0m
 hLopRB+Wvw+fjn1qL8nLI37C15aYn3TGk6wV/Cg+U1azskXDjgvA/qyoVEkOap7JOQkBg5p
 geZyuq8roMLU0T1ASqprw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ogQ1YLnaurA=:f1GPjm+VjWHhp/ILeRPrY3
 czxwYq+aa92hZlRlZx34zXqAN3W1M9HwnAPVSV/Ir4o8qu0EMbhD/SrgDslCgf8IObqgnhDHY
 agoC/KNHZDnQo6kOOgnnwbqgl+Wiz+x8wAEAl/OWMhlYMtY+IbgdHVtraFJwn1xxZlSuIeoGd
 OxvOXX5UjQqKie4HNuJmMza2z+tDsJ7ozG6xYDQDEDuHtVDFdAsfM10CQHHEo/WsuawUdj90+
 DsZqGEuy5z1Q3gFHlddBT8LF9riro8xb9PlTR4EfAJo0nehif1kAPOZSfy+Qy3XShT7ZWHqJE
 lsk0dJUlB+Cvhs2EwMJy5rnhsdHojDC+80+ZIz4tGPjLZ1bQvCB9NJcru/+3MjLaa8AYW+sc2
 qs1FqZ89dUC/hB9qEqgBNto8N0603euesysmSNvpP8yBSPXSKOMvVpbR9jmSgnWHyCFGpEs5r
 pKrVKVx1lZbn5JjeD4BDghr2b7q+yK5EdWZ3sdWv4rcDM0jGxcS2cKOX+PGnZ3Mgo6wJg+oL4
 yz4IA+0qw1sVGhnf+PxBhnk6zR0229KaaxgOWSQFcs4DYcvHkkm4UWXH+5QOj0ZHUPOheUhPy
 wXw1n0D3uiXbdkKMH4bg8JeFTe7rgBe5DRqnp69egoxwO8ci0ewrLiPx6Cvq0ntXrchPHg6rU
 uPM1WTPwUI9CUzeRWh8IhBbO6EzinZ3rfMIQT45aYPymomqTM2VlYi3l/YoaYfdvdMTPi2766
 ckuW/7Mds4jxRZwOL71raTfYaRX0WWiWOW6Ltg/8g+TMvGGXYL4kQ5eulW4poFhNA5BQK8mGP
 mQCDCquHBslK2erHqIbx1YtoLUtZtHbMbX92Iw3H09BI0WV6oyxg6hMjawLy8jd+BDYTDO9as
 b4A+lXbyvYaqGxmDY6e98O2Gf8WzNK3cr9xyGnD7Jo4pCG0VRcK1e0h53LSrwi0L44U4A9g3K
 ICm0YN9XvtmtG8pz1oPVNy8yXTRNl621oam0QFCSJ5ZgnJXuxsyu93jxWv/BAw1hb70OOyaBQ
 fXbSHt1sfMtgsXuB7pB9hH6JAznIGpacuNepwqUMmxdvKNz//wIKu00MnS5MBISw1gBLL+Lmi
 wvWXN6LsR/ZzNvBqntdnk+EHbSHsJY9AODFSiigLyNDTdvau3CLM29sMBwdl3+YaQzAM+WLh0
 BfDx1HT/Wj1/+P5H7JB2ZnIU5PAmCs5OuFWlsOxJJCfvXro0H8FYZwk/KRbfxag7bKAQWe2tB
 uq+Gc3gojDrnhixvS
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 11 Jun 2020, Junio C Hamano wrote:

> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 85868162ee..a306a60d25 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -522,7 +522,7 @@ static const char *anonymize_refname(const char *ref=
name)
>  	 * anything interesting.
>  	 */
>  	if (!strcmp(refname, "refs/heads/master"))
> -		return refname;
> +		return "ref0";

I just realized that the comment above reads:

        /*
         * We also leave "master" as a special case, since it does not rev=
eal
         * anything interesting.
         */


Obviously, we need to change that comment here because we do not leave the
name unchanged. How about this?

        /*
         * We special-case the main branch, anonymizing it to `ref0`.
         */

Ciao,
Dscho

>
>  	strbuf_reset(&anon);
>  	for (i =3D 0; i < ARRAY_SIZE(prefixes); i++) {
>
