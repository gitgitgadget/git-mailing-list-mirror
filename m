Return-Path: <SRS0=2KbR=CB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7106EC433E1
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 20:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 385332074D
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 20:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="X6jlSFEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHWUa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Aug 2020 16:30:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:59533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgHWUaW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Aug 2020 16:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598214593;
        bh=kmJoEmILemEupdxFUXlb3P8sAVoTj8XHRJGKO/7eCU0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=X6jlSFEnT3tACVNDbIXcl32qFYSOgxx1P/9IiXG1vVelr4/bHYHfk/7oSPdKlyn/Z
         wGvpbxpWfotkNb96sDmrkk8x2liPhQ/zIqp2OkibVuEsXQvZuIbLppsIgJotygOxdY
         DV3QWu63wIavbKvXsRtK/KkpxdhQyAl4qvWzvG9Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.214.173]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzhnH-1kVzcW0AuP-00vidO; Sun, 23
 Aug 2020 22:29:53 +0200
Date:   Sat, 22 Aug 2020 15:29:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jacob Keller <jacob.e.keller@intel.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC v2 1/1] refspec: add support for negative refspecs
In-Reply-To: <20200821215247.758978-2-jacob.e.keller@intel.com>
Message-ID: <nycvar.QRO.7.76.6.2008221528170.56@tvgsbejvaqbjf.bet>
References: <20200821215247.758978-1-jacob.e.keller@intel.com> <20200821215247.758978-2-jacob.e.keller@intel.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZHLiHrqA69imjrMTueHgnXVtv8toh0U90ff1H0h4wy3a34fLfQE
 vr2LqY4asOvGsuKb5YdTR5gQwSirlFh3UbK59te963as54w7Dcb3Iw6jK21jl9jbL7/pHeh
 shWSUKLpnyd+JUYbEhJi7qf8tQ1pK2297uS6h+QOuFQgMQnORTM1ZvRY7pnZv7e87jgRTaf
 SXUwQTM9NKffRAJY+NQNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yJmLPBYpcYU=:+wYDTs7RLOJQcLAZAkalyM
 WmpwzauxqFgUKVf1xiC3IGbYXtnwfBKAGQNWDWaSplVo1JCCLIObsNKSwkBNhff56VLuQ295v
 Bo6uFjpMGJ9DJso791nNlzW7v62adtdcs23sKy96V/Tt4ySajN7ZZXlBHvH3X0UvrYUemCcUl
 MSLD3dyL/B3FwhR+O76eC2WcaLR3Z8qGC72fG8S2SQ6vI4jNeVbMQof9UQJQnng5h6Gkr3N9W
 aJIplpPKzpn5Q4Dz+eVbgHw7GrTm0LC35cYLNIRvnWZWFtsC9J/69lMnMeUB/iV5sWoiw+G2f
 PdAt1xNItALfA5aPLHU2yLUtc302Vl5Mxgk6kbd/QA5URgtJ0oWm8f8QQT7hY4NsIpV+W58Lq
 bTQnlFu6Sr1Vwmd+SQmbLufESD9r0qibvmgy2AdV4iS46CnEKeeCSiVhI9dceOlVYzAoniWhy
 izu4U6ymTbJw88oR2C4c6SLLIfT6bMKY6mwIMwXcgSjZP0OJ+uM/uo7zhqKyAsVWf6BzY4uQq
 RSOK7grUvBMlybmpgR9Rf7A38x/9sSrtDKpkmenKxPzZNuljscSV9YUa0IsTaCMZ6lE9jtgP/
 JdPdIBYuz4VrSLmFTbi/2eKC3zpg5bKJOJRa50NYBj+CIqb4gm+h0saR2WviKOrWP+Iz6x3Nf
 cPdIarxGqsDtywv11zsQ9q+BQXwrzTRT+L7ZgbOnchNHoLI6k1q8bwC0q0DqixExeEcNj1myg
 NNHPIL1DrrzmDkosuro0PuDNGcC1m0WUXIVrf9D3RJY/Dg6/geIec3wc87CWB1/uGPc1SBayI
 wmI5epsP9YJVqX1qYETCvX/6DUS/FB4K9DsxjMhNjKRm1MoxcyT6vbN4lo+ZB61EHirctLcLv
 zuWknCB7TT8P2pbU6jA4c7Px/wFANkd1l7l+LSZ7W2afLWkLBUXuU+cIrES1xDDfNd9w5+tnx
 fEFqu9eaX1VvzvSMdwvW8/jqRh2jE6yo8uGxD5/gOWQO3N47HOiOHpRXi6mwosa0ovNgiD58s
 NboQArnnBXNgw+FOvOvmdLg16qCT8nZFr/ow6rQJCIt4Bf2TqGsyibBerV5N+0qx9IOUafg6+
 /5IVH28NMLDwHoByd2v1oxPObnYP0lVp1zzJuIsRCaolZ9teoUFYwTBD1PZG4mucBqB/2seqM
 AcTpu2DEPBWCofXdT0Cd3bdarX82b1qeB50+Qo1yNreCtpdBzXP93caPPFrop1MsJ0lbMS0pX
 CbYaisVzgAY0aRZJRMwZqXA1ZVQLtxBM0Z0oAYQS/2YFD5qFw0qe7gDFGE7U=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Fri, 21 Aug 2020, Jacob Keller wrote:

>  static void query_refspecs_multiple(struct refspec *rs,
>  				    struct refspec_item *query,
>  				    struct string_list *results)
>  {
> -	int i;
> +	int i, matched_negative =3D 0;
>  	int find_src =3D !query->src;
> +	struct string_list reversed =3D STRING_LIST_INIT_NODUP;
> +	const char *needle =3D find_src ? query->dst : query->src;
> +	char **result =3D find_src ? &query->src : &query->dst;
>
>  	if (find_src && !query->dst)
>  		BUG("query_refspecs_multiple: need either src or dst");
>
> +	/*
> +	 * If a ref matches any of the negative refspecs, then we should treat
> +	 * it as not matching this query. Note that negative refspecs apply to
> +	 * the source but we're checking only the destination. Reverse and
> +	 * capture any pattern refspecs in order to see if the source would
> +	 * have matched a negative refspec.
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

This breaks at least with Visual C. I need this to unbreak the build:

=2D- snipsnap --
Subject: [PATCH] fixup! refspec: add support for negative refspecs

The `?:` operator is not supported e.g. by Visual C. Let's not use it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 remote.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 940622e0ba88..8e081863c06d 100644
=2D-- a/remote.c
+++ b/remote.c
@@ -731,7 +731,7 @@ static void query_refspecs_multiple(struct refspec *rs=
,

 		/* Note the reversal of src and dst */
 		if (refspec->pattern) {
-			const char *key =3D refspec->dst ?: refspec->src;
+			const char *key =3D refspec->dst ? refspec->dst : refspec->src;
 			const char *value =3D refspec->src;

 			if (match_name_with_pattern(key, needle, value, &expn_name))
@@ -795,7 +795,7 @@ int query_refspecs(struct refspec *rs, struct refspec_=
item *query)

 		/* Note the reversal of src and dst */
 		if (refspec->pattern) {
-			const char *key =3D refspec->dst ?: refspec->src;
+			const char *key =3D refspec->dst ? refspec->dst : refspec->src;
 			const char *value =3D refspec->src;

 			if (match_name_with_pattern(key, needle, value, &expn_name))
=2D-
2.28.0.windows.1

