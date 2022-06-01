Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4822C433EF
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 10:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbiFAKLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 06:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352393AbiFAKKe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 06:10:34 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93348AE250
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 03:09:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id me5so2174557ejb.2
        for <git@vger.kernel.org>; Wed, 01 Jun 2022 03:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gt+jmpmfQ1Z5XQAnL9Zg/u99ThiE2sZgNSSFzgf/kNo=;
        b=TdmNs5I75JROYN4xaIUNR6uo//nrRMK0pD9jjieSGxTN5IGKQr6NmtOUeU0OxVzLj2
         nAUvkqPirSsLiMv9T9Gx2R7p7X4WNkNspVDMQJvbjNPmjV5yspVadDP0nYeIR82MGQg2
         Pyo/19FO2wf5EQV3Obn+Kuy1kV97xHBp9jpWMO94J2kSSjnvHop6c3FTeULHm9kn14Pj
         KroqfmdmUVTPx+g1W0ywQ4GOwtVgSKEfnjFxkQEpbiG8m8fsiNzpg1x86tJp5CcH53VU
         W2etrlqZIWG3Ly2WIeRMrx9q1qX/M9stoGwrfB3i2PNktwdEiliCOruwJNzpR/AUAM0i
         s7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gt+jmpmfQ1Z5XQAnL9Zg/u99ThiE2sZgNSSFzgf/kNo=;
        b=nm/Fvo40FsDNE7OwrPnnRQkGAhuacIjFZht6k59KC7ePZk+Sgaawmi1xRkyPKrmr28
         6hoq4BmibTgOfHztj5DVAqoNdzUOpqdxsOxr8VoTXC8nxUsfrOnViNC8u5ukqizPAN8f
         /k2gFPX/SsPRcOxwlt/9lCTv64YdOzqldzOHss489HQsapBc6NOqlG7OMLDjtK2LgAd9
         DCN9UanEVbZwUmayijzAVHDey71o0anhYi0DQ9uZGV3QEu5aI1n1XVF+CQ3rbWjW+KMY
         z/pevge0RlLdwIQADVOW/maTSUbtkPNt44tucVOOlBCzoYIKHQ6O4Hs8bSTiEQeftjUE
         NC7Q==
X-Gm-Message-State: AOAM531W7BOB+Gl6nc66MqwKns9Z7FswsfTHsF2NWKmiM9FQymYo+ccN
        ur0j/RJh1QETRICgO/nCMERkHOSIgAsgTw==
X-Google-Smtp-Source: ABdhPJzTE5+VGJOGUwIi1qPaDuwSup1l//5XOyctZXnyZ9GawFq6e9W2jOBXgHjuX8b7Z+rWXkdiXA==
X-Received: by 2002:a17:907:2d29:b0:6fe:c413:d9a4 with SMTP id gs41-20020a1709072d2900b006fec413d9a4mr45213290ejc.694.1654078181748;
        Wed, 01 Jun 2022 03:09:41 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id i22-20020a05640200d600b0042dcf600231sm721466edu.41.2022.06.01.03.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 03:09:41 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nwLIK-00172g-Ki;
        Wed, 01 Jun 2022 12:09:40 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/2] merge-ort: fix small memory leak in
 detect_and_process_renames()
Date:   Wed, 01 Jun 2022 12:00:25 +0200
References: <pull.1152.git.1645290601.gitgitgadget@gmail.com>
 <pull.1152.v2.git.1645320591.gitgitgadget@gmail.com>
 <f1f7fc97fe2fe5079365bb91c71fb7033378995d.1645320592.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <f1f7fc97fe2fe5079365bb91c71fb7033378995d.1645320592.git.gitgitgadget@gmail.com>
Message-ID: <220601.86h7541yqj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 20 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> detect_and_process_renames() detects renames on both sides of history
> and then combines these into a single diff_queue_struct.  The combined
> diff_queue_struct needs to be able to hold the renames found on either
> side, and since it knows the (maximum) size it needs, it pre-emptively
> grows the array to the appropriate size:
>
> 	ALLOC_GROW(combined.queue,
> 		   renames->pairs[1].nr + renames->pairs[2].nr,
> 		   combined.alloc);
>
> It then collects the items from each side:
>
> 	collect_renames(opt, &combined, MERGE_SIDE1, ...)
> 	collect_renames(opt, &combined, MERGE_SIDE2, ...)
>
> Note, though, that collect_renames() sometimes determines that some
> pairs are unnecessary and does not include them in the combined array.
> When it is done, detect_and_process_renames() frees this memory:
>
> 	if (combined.nr) {
>                 ...
> 		free(combined.queue);
>         }
>
> The problem is that sometimes even when there are pairs, none of them
> are necessary.  Instead of checking combined.nr, just remove the
> if-check; free() knows to skip NULL pointers.  This change fixes the
> following memory leak, as reported by valgrind:
>
> =3D=3DPID=3D=3D 192 bytes in 1 blocks are definitely lost in loss record =
107 of 134
> =3D=3DPID=3D=3D    at 0xADDRESS: malloc
> =3D=3DPID=3D=3D    by 0xADDRESS: realloc
> =3D=3DPID=3D=3D    by 0xADDRESS: xrealloc (wrapper.c:126)
> =3D=3DPID=3D=3D    by 0xADDRESS: detect_and_process_renames (merge-ort.c:=
3134)
> =3D=3DPID=3D=3D    by 0xADDRESS: merge_ort_nonrecursive_internal (merge-o=
rt.c:4610)
> =3D=3DPID=3D=3D    by 0xADDRESS: merge_ort_internal (merge-ort.c:4709)
> =3D=3DPID=3D=3D    by 0xADDRESS: merge_incore_recursive (merge-ort.c:4760)
> =3D=3DPID=3D=3D    by 0xADDRESS: merge_ort_recursive (merge-ort-wrappers.=
c:57)
> =3D=3DPID=3D=3D    by 0xADDRESS: try_merge_strategy (merge.c:753)
> =3D=3DPID=3D=3D    by 0xADDRESS: cmd_merge (merge.c:1676)
> =3D=3DPID=3D=3D    by 0xADDRESS: run_builtin (git.c:461)
> =3D=3DPID=3D=3D    by 0xADDRESS: handle_builtin (git.c:713)
> =3D=3DPID=3D=3D    by 0xADDRESS: run_argv (git.c:780)
> =3D=3DPID=3D=3D    by 0xADDRESS: cmd_main (git.c:911)
> =3D=3DPID=3D=3D    by 0xADDRESS: main (common-main.c:52)
>
> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index d85b1cd99e9..3d7f9feb6f7 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3086,12 +3086,11 @@ static int detect_and_process_renames(struct merg=
e_options *opt,
>  				      struct tree *side1,
>  				      struct tree *side2)
>  {
> -	struct diff_queue_struct combined;
> +	struct diff_queue_struct combined =3D { 0 };
>  	struct rename_info *renames =3D &opt->priv->renames;
> -	int need_dir_renames, s, clean =3D 1;
> +	int need_dir_renames, s, i, clean =3D 1;
>  	unsigned detection_run =3D 0;
>=20=20
> -	memset(&combined, 0, sizeof(combined));
>  	if (!possible_renames(renames))
>  		goto cleanup;
>=20=20
> @@ -3175,13 +3174,9 @@ simple_cleanup:
>  		free(renames->pairs[s].queue);
>  		DIFF_QUEUE_CLEAR(&renames->pairs[s]);
>  	}
> -	if (combined.nr) {
> -		int i;
> -		for (i =3D 0; i < combined.nr; i++)
> -			pool_diff_free_filepair(&opt->priv->pool,
> -						combined.queue[i]);
> -		free(combined.queue);
> -	}
> +	for (i =3D 0; i < combined.nr; i++)
> +		pool_diff_free_filepair(&opt->priv->pool, combined.queue[i]);
> +	free(combined.queue);
>=20=20
>  	return clean;
>  }

