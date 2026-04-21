Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3322BEACD
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 19:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776800046; cv=none; b=XX9HY3qVs2AOGCmLG+cw0W3KUW82w1o04GBGnSCvUZHI9ZzDxR1QxJpOMZx1MM7hT/Lf+ZjNEIjAUDHULokqVxWs7kMjjk52XhQRuCX1Bf0ULYUuaUi06lUxvZHXsHSqL6Sxu4QA5TRqbXWAtKCLkwoFIhVxHQtwivTBnv15wLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776800046; c=relaxed/simple;
	bh=bwAFGfy9DPex0hnb3cD1UNbedqckmsFqp3ALhHo4H1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lF39Q1B64m1GME+Lntqb/qAbVQ4ZqJUVitvMyCEiv+JTV1PNJ2qiLpjOT/ioHpOSd8rxhIIGB1ITJSQ0I1QHDLiRJKaImxLNqmSdPfLNJZKNFddIN09wNPLUztatr4pmroFWLbG3L1ESdLbjJkWPvMQ+944cR0bfbGH/39MdPLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Txc32sSb; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Txc32sSb"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7dbd23bc684so2702410a34.2
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 12:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776800044; x=1777404844; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C9mas+CYpBmi8flUU/vXVFZLmRj+dfw7TTIhLguNrX4=;
        b=Txc32sSbuc7AZp8vAw3oiPb0MfyAOmIiSOcv0J1pvfSbuy63nML299b0biOqO/Hi2Q
         uQzEi+I/P/d26KgBpff9Jm3KHF6+OZ/e1VTVmq5Ij6TPPzPdzacoWb3u8/U8NP/adX6n
         Uh+246kScezKov5add066HDlCulDaxxjC5Xgu4rOyc9+9L/GV7VXAChsLiWT3ja/fx2c
         BD9uhC8xKnF11ZXl4OyR7CwExnsvKupl9ix3T17INM7yX7wEFnNVPbtxyqVYgob+9OqO
         L54s3pTMWONxZR9U8d2sADtc+O9Em3G82UccHgLFNp88iupxOKzV16oSCmMV3jZZlE1v
         voEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776800044; x=1777404844;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C9mas+CYpBmi8flUU/vXVFZLmRj+dfw7TTIhLguNrX4=;
        b=p+1BKzEh3+194ONSLgydbzYxX0XawohNB5a134VuIK/Lt+Zix66Dcdz1w/bZiyLK9A
         8f5uzI5J/MnmpAII/ooP9Txqpup02KDnfId6KMdXylvyw2SO9pnOnlZtnHGWbJsHy9AN
         F96YttjB7D3bXKQ+Zpam6z9u+DfW0nTKN0jZkX4sac08HbV0qbVAvTT8fJjqHnSmKqMJ
         VXv4dkuv3HmlY/jqHVWGNgsHVLX+D4907rbzl5tIM4MvrUDNE9eboIXKGOmfeZiGhF8i
         BhyTOU0WMLnVc7Q+1sunqN7wPZ63Ve5qi8VrlF3G0IcEK61uMp3e9qyBPSXp9q5X4HTS
         N1kw==
X-Gm-Message-State: AOJu0YwVDwKYNRqwUu4kk4YRL/n0tw3XnYKh5tuiCGkjpHNv7cNnX8rW
	1kpKIPy3Ar6fZ/Uo+/BCzJulmnaz6QeyLogQf8YJq6hNLEDHxgnRxj/i0I/Qg8fVEcU=
X-Gm-Gg: AeBDies2gYKGHcpu0rOqsauohDd3FJZiYEO2yxt6ufPxf/Ku6hSI7CpZXcwutY3N+DX
	rO35unJPahb4TlbGc0awYqUtdsRqpZEtviV37uwwEIDRjAri6tDpzq/veccvxPbYeNHrn4D+1LO
	li+fkFo1JH2U8lRd2keH+5U6VDxkUd2EeiMw0sibtO3PKpAFGwxLnU1lpoAJwDnG21AB12+HK0F
	rxlJek+OAYu7zFDZje+DDkqB4ffFWIR4SzWrcIDGhZ/RDMM6lLA9GYkUm8hbk4p/ncCaqfemqyq
	KA6TLY3lBVxFgu9NM4YGOfwhmxWQCfhHZ4vrGLbFSbJKqPKJXnwTj2CC1t++Cj23sEtKKxUSj/Y
	J2F8SoVu4gYiPCYZ30/wGpP+NPGdLdz4LdCejJEoXdv5nbSUyO2IW/K6lNepVsI3/dqWSAPlFpi
	7qx1SbDMVuVWsdJgOv7eyGIGcnUlTENqvbgnhzYpCIW+XBo5WC7YaTmuHFnCBKG4mCsCyp7yiu3
	AQH6p6Q+PGEWyNbjP3lxQBF3bcmK7/Vw8Z6G2xrC+AWDcNt0TOs0NfGjGjQssvpAajStmNmXaZv
	cAUMk8AjY4TSQEpMa+u3kV6+JIwioP2iQCKyzQ==
X-Received: by 2002:a05:6820:a01:b0:694:90be:618e with SMTP id 006d021491bc7-69490be699fmr3980337eaf.6.1776800044053;
        Tue, 21 Apr 2026 12:34:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69464fc7237sm8835273eaf.11.2026.04.21.12.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 12:34:03 -0700 (PDT)
Date: Tue, 21 Apr 2026 15:34:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 11/16] repack-geometry: prepare for incremental MIDX
 repacking
Message-ID: <aefRKvNO1XXtIe1K@nand.local>
References: <cover.1774820449.git.me@ttaylorr.com>
 <d2c667e841300c3310e3a23493ac27eb2b08992b.1774820449.git.me@ttaylorr.com>
 <CABPp-BGhXzo7yLQ5z_pPztSNf4vEiPM2x2pMxty99rak_NU-CQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGhXzo7yLQ5z_pPztSNf4vEiPM2x2pMxty99rak_NU-CQ@mail.gmail.com>

On Thu, Apr 16, 2026 at 03:51:32PM -0700, Elijah Newren wrote:
> Hi,
>
> On Sun, Mar 29, 2026 at 2:41 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > ...If the tip layer has fewer packs
> > than the threshold, those packs are excluded entirely; otherwise only
> > packs in that layer participate in the geometric repack.
>
> "fewer packs than the threshold"; I'll come back to this below...
>
> >         repo_for_each_pack(existing->repo, p) {
> > +               if (geometry->midx_layer_threshold_set && m &&
> > +                   p->multi_pack_index) {
> > +                       /*
> > +                        * When writing MIDX layers incrementally,
> > +                        * ignore packs unless they are in the most
> > +                        * recent MIDX layer *and* there are at least
> > +                        * 'midx_layer_threshold' packs in that layer.
> > +                        *
> > +                        * Otherwise 'p' is either in an older layer, or
> > +                        * the youngest layer does not have enough packs
> > +                        * to consider its packs as candidates for
> > +                        * repacking. In either of those cases we want
> > +                        * to ignore the pack.
> > +                        */
> > +                       if (m->num_packs > geometry->midx_layer_threshold &&
> > +                           midx_layer_contains_pack(m, pack_basename(p)))
> > +                               ;
> > +                       else
> > +                               continue;
>
> Should the commit message use "no more packs than" rather than "fewer
> packs than"?  Alternatively, should this be >=  rather than >?  Or am
> I just mis-reading?

I think the goal was to have "fewer packs than" so the commit message is
right here and the implementation is wrong.

> Also, the empty-if looks a bit weird; would it make sense to invert
> the condition to get rid of the empty-if?  In other words, something
> like:
>
>     if (m->num_packs <= geometry->midx_layer_threshold ||
>        !midx_layer_contains_pack(m, pack_basename(p)))
>             continue;

I sometimes will use the empty-if style when the conditional is easier
to explain in the positive than the negative, but reading it out like
this I think that the conditional as written here is still clear. Thanks
for the suggestion!

With the above "no more than" vs "fewer than", I changed this as
follows:

--- 8< ---
diff --git a/repack-geometry.c b/repack-geometry.c
index 5b554da89f1..0469dc6496a 100644
--- a/repack-geometry.c
+++ b/repack-geometry.c
@@ -49,10 +49,8 @@ void pack_geometry_init(struct pack_geometry *geometry,
 			 * repacking. In either of those cases we want
 			 * to ignore the pack.
 			 */
-			if (m->num_packs > geometry->midx_layer_threshold &&
-			    midx_layer_contains_pack(m, pack_basename(p)))
-				;
-			else
+			if (m->num_packs < geometry->midx_layer_threshold ||
+			    !midx_layer_contains_pack(m, pack_basename(p)))
 				continue;
 		}
--- >8 ---

> > @@ -173,6 +196,20 @@ void pack_geometry_split(struct pack_geometry *geometry)
> >         geometry->promisor_split = compute_pack_geometry_split(geometry->promisor_pack,
> >                                                                geometry->promisor_pack_nr,
> >                                                                geometry->split_factor);
> > +       for (uint32_t i = 0; i < geometry->split; i++) {
> > +               struct packed_git *p = geometry->pack[i];
> > +               /*
> > +                * During incremental MIDX/bitmap repacking, any packs
> > +                * included in the rollup are either (a) not MIDX'd, or
> > +                * (b) contained in the tip layer iff it has more than
> > +                * the threshold number of packs.
>
> This wording looks consistent with the previous check, but not the
> commit message.  If the commit message is deemed correct, then you'd
> probably need to update not only the above comparison but this comment
> as well.

Great catch, I would have definitely missed this if you hadn't pointed
it out.

Thanks,
Taylor
