Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3986040627B
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 18:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792002111; cv=none; b=V6/reLamDJHoUJXjaPhPzRDree40o2bEtrzc3Xj8zH59+kfrkF7/+qB1BrKT4YqsG91+N6qt7Lh59O9MxRJx6hOAj0PtkxJcTNjFA7Vrr6RWw/WXCytDnSrAQs41IKpLbz9mGn0IdDEQYTX5LFadrLrR52eoJZD5mWKHTWyxx5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792002111; c=relaxed/simple;
	bh=9uGgV7wY+xvtvCH9DupLruAFmpgoBg3Vm6VWoPXN7MA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jiO+IwMgT1JPLVR7fO6ebxxkQoPiu16DgNtsHHkF0apqVLVOwNVMgS18O74COCMJWIWXolwuCtDqGChoG2CZcv6vL7BPSoVjZ3bQKTEHH0UhQ0lfvZ3gXjx4D1GFkpvAyRNwBjR48631GDylbCgAq4Lh1l64RlknV/Hb0VTMYp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bhry2KS9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=btgv4hUq; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bhry2KS9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="btgv4hUq"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 583B8140010B
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 14:21:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 14 Oct 2026 14:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792002109; x=1792088509; bh=tUY7K55j02
	eGFnQb/DiSLbltZI/JdszHTLKFt3Hgd/o=; b=Bhry2KS99WEMUK0kltblRznrDL
	aIpfry1sOssn848KY0kVfhIiZbR/AaAsUu7MM2sLCL0Pz/dbiLenVkyDESTqfekK
	0qdmWP7uFafbFoPXAdGtd/PFrKi8tfUdAnma2XMGlH8JUi5VHiLjc2kGb6U87QX3
	VZeDB+tIe/tC9UVwxH454Q4CMnFaBO73OQ1D34zKIkwYTlQrhr9Fl141brBiDTN6
	6X0KyVf53pJ7uI0BLZ/TTTHdPPRgi2rDgSzJmoHXuGkAMN1K71EFc7mPH8OQOlua
	y5JU2HDJB0rYjDs9AU/tnptmEs0CuVaHnEhi4Di7vVQEwgXw2cKNrz2Nq52g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792002109; x=1792088509; bh=tUY7K55j02eGFnQb/DiSLbltZI/JdszHTLK
	Ft3Hgd/o=; b=btgv4hUqGjEwcDUVs2ua4UyvHwCaYGKeE3jOS0UbidEffc17HJj
	jltvdVtj+2lbUpuw0RHHSRBDm+4IdEL+cLm3uCTM2u9hMKEzVGImn3nCtw2VvsmV
	x80r6X5vFit3xRlcpmHaKrePmYahnktHC1xQh83tQhWSwW4IdYRKv4ZvEuhNWEm0
	PQOwgMMpMft5C79mrnerNkc1rSyQNZ6vVtziw9b7MOfzNZBxHTC/cI1xQgUFXK4B
	FPOLNP6wk5ZDVIb+2Gxzy71MFMbnsLGnL5bNFY1IZ2CYt/ncFG2OjP3kZ+lKGtMi
	kbZ0BcS8jO2MNstmV7KBvpK0HPCok0h08Sg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792002109; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:g8uI1Vg+zsygSDLtLvWi5Ste1fP0cVijrg6P39UZGtjuoK1
	0Gk/p4YHZfy0+HjcXpZcPMi/iEtvWtzTEg0YDwPpHk1SZRN94oHUbUS7+cA8oDlh
	q9jarBFR37SFvM8IW4QJM8wI7Jq2DZjt5+JKPOLwKe4B20/x/72ZljU/DrSYq9P7
	VxCNEs1CidftGbwcNH1fGBJkMS6lv7sxZOWjJDrrfpOT/ot1T6HmswJjuhMZZZMe
	BWN0ACtQMB75C4AB+QbhZTjmTzqpCw3AL1wGKQv3zPbTXXjVgNJNrjCe8b84JGvS
	jehwu9esWaf1nbmNqi+5+0ja2C1jj+9lvVwbqpQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:KKP8kMJzizR5pNwuLmV6QkTVvhrexUn7Dqf2fIBP40U=:9uGgV7wY+xvtvCH9DupLruAFmpgoBg3Vm6VWoPXN7MA=;
X-ME-Sender: <xms:PcjPal2YsT5pq3oQhX5VDaarpBuGR4U1vptmAPW-ZsSa-KygzR56NQ>
    <xme:PcjPajEubL-SIv_A_ObJk6VuAElKy647UTWe57iTd_ZnC4yeJZeqMUKMi8nSrq-kK
    JxpFFK4BoKbj02sdi1r-XV-7SDnNQ1EafFqHYXlU6rgxO06b9YWCg>
X-ME-Received: <xmr:PcjPaq6-pTMuU0mdROTt8VZEXSg-7bBLFAUt_okst-DyFtuZ98u-bBNFRTabi8dYyXxzzohzYRUaZZDbARIGK9RqBViKYxmWa_mf>
X-ME-Proxy-Cause: dmFkZTE/VjAjJ+9trSPVQdZ+2vlDH6gfE75mNCYLe/4+0jqhTFkQCpHnw6Fa+Df2MK2yFq
    PogSO7FEe5Y8B2OqBKWM07fYYeodBhP1DODXAI+4995TOAAW/Z842oXTBCZK7QVvPRt2Mo
    uCYat70mrRZkZ42OH2S8T7r9E4RAdGZNeENymie3KOcqGapHBoO1m59pXjwvOfey7xbJX/
    LIIIkEzjuS3ZOVYCwVSHd0xUtNZhapL/FOfgwY5w1i2qB6oPjECpQK+kQPVCb0Li9KWrLc
    F+X53RBgYzUm1ofmW20gc4LevcW+G8T+oWXxChm9Dh+sws/n7Xcjq6tmALU6ghhFsoblr0
    UyDFQwGkLP/Q2PFvK2lHN2CZrkj7mpJTLWstoboz00R79VWXx3u1NLffYOjxHyN+hnHSl4
    QRQWJEIGnH/+SQ01rS8GGtmNzxiFWghs6SHMRPOwPDSnB78wBBOcf+Jtcb3KqeGrNJW8P/
    NRYGcWorBgkl1SQtB+rUgk4isYiJya8AD2fOvMrEHCupuv+V3P3Jf6oEMSvOBkpRArWst/
    LSq9CMr6BfjBzu9BD+LbShUiRv052rIq9pQLoVEYwDSNw+9qLb0K2t7FGaB7lOvV8jU7a2
    I8xlZ2DoCyWao7aBD0stCfECYkEd9WkYKRXUMuq5mKYs6afdBk3R9loa8kBQ
X-ME-Proxy: <xmx:PcjPahuSamzaFXI1CLv5dqDneQivMfhro7uVlvD2xdPZwhP3rcaeGA>
    <xmx:PcjPaj6tybDRtkFj8LigznjOUtu5CS2ZWwXVPnjrL2w5r7DyAqtlnQ>
    <xmx:PcjPakXFQj9U_xQvZ9LoVwn16HurosfxIh2UcHMe26VmKrE7Bbdytw>
    <xmx:PcjPat8PMSas3Oqq9HMkduZBU1D4Ld-aCf2hzohVx4WqB-yZ_LGAUg>
    <xmx:PcjPalZ9ADn8ykb98D-ZPax_1P1Uzmd-76Yhs2uKm6h0XL6Pb5pSU_1I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 14:21:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?6YeN55Sw5LiA6IGW?=
 <kazumasa.shigeta@kanamei.com>
Subject: Re: [PATCH v2 6/7] stash create: remove unnecessary index load and
 refresh
In-Reply-To: <768d6bc7e5a8c47e1d727917cbd8818f1906cb17.1791992404.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Wed, 14 Oct 2026 16:40:18 +0100")
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
	<cover.1791992404.git.phillip.wood@dunelm.org.uk>
	<768d6bc7e5a8c47e1d727917cbd8818f1906cb17.1791992404.git.phillip.wood@dunelm.org.uk>
Date: Wed, 14 Oct 2026 11:21:47 -0700
Message-ID: <xmqqmrsgrvlw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> create_index_from_tree() is called either directly or indirectly
> from do_create_stash() after it has loaded and refreshed the index,
> so we do not need to refresh it again here. This saves three lstat()
> calls per changed path.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/stash.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index ddeb5a5d2a..55916259c3 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -384,9 +384,6 @@ static int create_index_from_tree(const struct object_id *tree_id,
>  	struct index_state dst_istate = INDEX_STATE_INIT(the_repository);
>  	struct lock_file lock_file = LOCK_INIT;
>  
> -	repo_read_index_preload(the_repository, NULL, 0);
> -	refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
> -

Oh, it is emrarrasingly stupid follow read_index_preload() with
refresh_index(), since the reason former is not read_index() is
because we want it refreshed.  The original is doubly bad.

>  	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
>  
>  	memset(&opts, 0, sizeof(opts));
