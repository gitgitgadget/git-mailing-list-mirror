Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36F1C4727E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B19562076E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="J/u6Bdfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgI3MgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 08:36:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:49413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728235AbgI3MgM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 08:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601469363;
        bh=Ha91gP3aZi+bdIFWPloiXEtMBXk8JYFWd0u8jFR2mC4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=J/u6Bdfnyd3zcHVJHIlfQV5HwIMKoztz0b5vr60X3TH0MKj8ic5y+qOfuJLd736mn
         H79moqEOpZbzQh9EEOYyf5YZvIZKa2nfrBM7xaflLsD52OPiw22R4tm7cN8Mg54U17
         IS0sHe/OdTps4EQbvVYPloSXupX/HBpagjgACkuI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.113.174] ([213.196.213.65]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9o21-1kIMXW1wDF-005nUg; Wed, 30
 Sep 2020 14:36:03 +0200
Date:   Wed, 30 Sep 2020 14:36:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jacob Keller <jacob.e.keller@intel.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 1/1] refspec: add support for negative refspecs
In-Reply-To: <20200925210740.1939450-2-jacob.e.keller@intel.com>
Message-ID: <nycvar.QRO.7.76.6.2009301428580.50@tvgsbejvaqbjf.bet>
References: <20200925210740.1939450-1-jacob.e.keller@intel.com> <20200925210740.1939450-2-jacob.e.keller@intel.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:F4dVoVNshL2F4a9HdgOmo+KdDV0086x4KNx0kuOBQ8Z4c2Yw2Dw
 rfxaNI+g1yZro1aJ8XtPUljuplgChywJwiLHVgoSs4+D1PjoAzsvaDYO0dcMqU0EurkMqMn
 ObvFLpvuGckizfJN0A5Cm0H24hUqu2MbqfmjzRnu8oJdA/MM/LkNvlCznNs2H7qmkxH8u58
 BynBH7JEnVgjQYqdELpog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SgVDpu8dhqA=:XXYLZntbOa3s3Z3qMG95BG
 HoqRlfz40uxT+qhs72jn4RvsdnfeEwT2I6QIhw78LQbGzPwXL/gtNHqipiYUZHXeXkevRW4GS
 LOcVpRXCxXS/hc2e3l6mfBIyrrYsmHCxhXhf9i/kpdjZpVCzLpAWem/5UZvXqgjwSN9ZwP1YL
 wVxbHkqTLxRCwYZ2MA2NYjPhlDbq/raeD7TkQ6WGJcMVWWWJjHDizKmkBeClPq/svcwfNKNDD
 ZibTkSK8X35dHFO6nAxoKnFxovJBN4HH55pd91X2hnNKv4Hs6jpqGLX7x7rHmNvSdrOnzEbhY
 SR4Fz8DzYK4JqqgnV0Y8qHDSiVA5lwTk6DIUmmWMoK0+gJVgG8iJpRrmAbczm5t9pqTCgdqjo
 l5tmDANoBqScD2xAvWLDFVUKMdCipdSj2FubFbUX9VENEuqCQ7gKGud6dSyKfDrhlJ1Tj01kq
 HfE/zRBhR/wkbqI2SD672mSQl1bLj+fMVaWcHQPgJNuLWFOrXCB6KvfqHIMWafeWMuQ2Kgtdy
 NiugZMgtwbvqxwtwHM8Jt1fAOpoZkTPQpgmHp/MQH0f3AW97EAuQkoMIRnY27QUlzbBP0fzcj
 82xh8arDLPJa+VJf3A10w2tZUNtgcNYQeQCV8DbfXumWwQSkFT7LpU6xGbM+a2xQVS/hkwM+U
 SPR8tzXR6o7Q9L47ZvqWs3W2O8ou7k5kwjdJzRb8iI59SBMoUrgo9JZ8/ppSMQi+WCwY60dxD
 zieV/SAT+9rKjuAhN3KwYIBwhIEduOFHlWZP95VTmE7dYISibepPcYt8Hqm4a6TgzSY41b1l1
 tP+L+B8dev/J13L78F72qs7FzQ5Z3H5nSlrtVJEDIm4vcQ5+jC7S/Kpx6C/Jea38fbpC4OH1U
 g7N9VwvulP1iVkaU8MV+yiS/Kja3RlHRyudLZtrho2mIoGCD8cQ7wVPYFlWLR8oHGuUaLW77i
 QCg2Zez1F9VmJxao8/XoeXI1gg320Wv6Zamk0umtlTFY50UlqHjFpzHuDbZHhor7sqh3iU20M
 +7h6PrCs9kcQtOb23c2dZSF9HQU7bcgDyBe1NG4HMGDhgfz4MdXdvaunwjm06D0OlFR/0XqnM
 ZYAuGHBqBltCaNoRpdvjTrdprHPRbJU8XZzrV3GMJuI/xbUz0M5Rd7P3vdd/7SFooUt7Wlj+p
 BJFwvtSetzqHN9CSfHlXr3CV4C7tB52rb5n+R8zWAXjbPxSZzTpQjUSkOUHeeF1pdZHq+d+MX
 e4Rubx75MsOw5wreGmzskIHT2D5f+ZXhY753FAw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Fri, 25 Sep 2020, Jacob Keller wrote:

> diff --git a/remote.c b/remote.c
> index eafc14cbe759..26a127142344 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -682,6 +682,91 @@ static int match_name_with_pattern(const char *key,=
 const char *name,
>  	return ret;
>  }
>
> +static int refspec_match(const struct refspec_item *refspec,
> +			 const char *name)
> +{
> +	if (refspec->pattern)
> +		return match_name_with_pattern(refspec->src, name, NULL, NULL);
> +
> +	return !strcmp(refspec->src, name);
> +}
> +
> +static int omit_name_by_refspec(const char *name, struct refspec *rs)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < rs->nr; i++) {
> +		if (rs->items[i].negative && refspec_match(&rs->items[i], name))
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +struct ref *apply_negative_refspecs(struct ref *ref_map, struct refspec=
 *rs)
> +{
> +	struct ref **tail;
> +
> +	for (tail =3D &ref_map; *tail; ) {
> +		struct ref *ref =3D *tail;
> +
> +		if (omit_name_by_refspec(ref->name, rs)) {
> +			*tail =3D ref->next;
> +			free(ref->peer_ref);
> +			free(ref);
> +		} else
> +			tail =3D &ref->next;
> +	}
> +
> +	return ref_map;
> +}
> +
> +static int query_matches_negative_refspec(struct refspec *rs, struct re=
fspec_item *query)
> +{
> +	int i, matched_negative =3D 0;
> +	int find_src =3D !query->src;
> +	struct string_list reversed =3D STRING_LIST_INIT_NODUP;
> +	const char *needle =3D find_src ? query->dst : query->src;
> +
> +	/*
> +	 * Check whether the queried ref matches any negative refpsec. If so,
> +	 * then we should ultimately treat this as not matching the query at
> +	 * all.
> +	 *
> +	 * Note that negative refspecs always match the source, but the query
> +	 * item uses the destination. To handle this, we apply pattern
> +	 * refspecs in reverse to figure out if the query source matches any
> +	 * of the negative refspecs.
> +	 */
> +	for (i =3D 0; i < rs->nr; i++) {
> +		struct refspec_item *refspec =3D &rs->items[i];
> +		char *expn_name;
> +
> +		if (refspec->negative)
> +			continue;
> +
> +		/* Note the reversal of src and dst */
> +		if (refspec->pattern) {
> +			const char *key =3D refspec->dst ?: refspec->src;

Would you mind fixing this? This keeps getting reverted...

=2D- snipsnap --
=46rom 4aea2a58a9f6bb1cbbc7a03db63a1465f9a801da Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Sun, 23 Aug 2020 22:27:17 +0200
Subject: [PATCH] fixup??? refspec: add support for negative refspecs

The `?:` operator is not supported e.g. by Visual C. Let's not use it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index f7d20c059b3e..1659535c1a8d 100644
=2D-- a/remote.c
+++ b/remote.c
@@ -724,7 +724,7 @@ static int query_matches_negative_refspec(struct refsp=
ec *rs, struct refspec_ite

 		/* Note the reversal of src and dst */
 		if (refspec->pattern) {
-			const char *key =3D refspec->dst ?: refspec->src;
+			const char *key =3D refspec->dst ? refspec->dst : refspec->src;
 			const char *value =3D refspec->src;

 			if (match_name_with_pattern(key, needle, value, &expn_name))
=2D-
2.28.0.windows.1.52.gbcabfe850c5e

