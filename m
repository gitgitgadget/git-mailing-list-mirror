Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD27F9463
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 00:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780358760; cv=none; b=q+F5OSh6uaipvox95SvXl6WX1cZPlsFTU6k/00LOAJ5JhFrZ2ng/t+zW7VkL7GnrSnXeiPdiASc15PXIZW6xwpSFSVkws4IBtNFMan9m5B4t8hAKpEzhIqFAkUad6AVvXokgMQ0PyY34zSOq1uRVteXdFPYw1ppkuYNSSEEIXBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780358760; c=relaxed/simple;
	bh=kVEO2VjI0/4Ws91E9PhZd7wuvLYXE9sSmvtdSZjdhgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rmaCX+Ba/iQEkJDd/tdIWtPB9MOvhY0XACxSHfdFlQeojvPiSvM25LPDh0i0zerPRNF8+7H8k4AK+rYytacqzDyLcxYqGtsoDVsvZJH83O6kBilZZFv5RaQV5UImKe3iBPezIxrwILY9C+5laDPFD5ZfMDFqLrI3HzuLpV+gLhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FHUs7op6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fly1tT/4; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FHUs7op6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fly1tT/4"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E6FDEEC06A4;
	Mon,  1 Jun 2026 20:05:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 01 Jun 2026 20:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780358758; x=1780445158; bh=18vON0X3jX
	ocfkCHCwd/NMtjwQlQ37zQGCNxgRXOHOE=; b=FHUs7op6SINB8bPZl+lpOJyUzD
	axjEjMAvQoDyb85ibEPh1L9Z2l++Y4IXUOAUfdFLDkWnI8T4HehcXQwF8sZ8ZdLO
	Kenx65izp2JnPQJq4F2SJwnYJkETUmA66depCt7eyMwT2GMooU8cIFRfujT28ueY
	AeOy8EXw+M6UPSHcEyz+q7bKM1dD+aetkxt9WNTz9VLfErr6OPcmWJgMBg+feDdQ
	mgNeV2ZWVoKTL3TfEZxKuD6aah/6ZbV0KlfzJboJlYD/CFgFdiT7TCBuuhMrtyjM
	Lx1Rp7wvG1jRaPyxVB1bnrtSfMUzgOz8plQKvklebZ4bxUEQvOHMjYUpeI6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780358758; x=1780445158; bh=18vON0X3jXocfkCHCwd/NMtjwQlQ37zQGCN
	xgRXOHOE=; b=Fly1tT/4oO2lWKlHQ9upxnxRfvbE4VeChlXQAbZj1imcbH0s0io
	P0ESXjBjS8tXVKTdCvrEM0vHh4xd0ig2a7OMCkCy+SHzlOkC/CdxHZy/BYwS9flI
	JQSevwmwlwsQRx9jqORj8kbQD9qeBb7Wk4n5gw+x0Z38vgSVy18V6q7YBVXFHsrB
	SpFYOLT9ri6MKoIKr3xQ1qwSffczb8CFDkIoiNWj/CDrYsZmN5xRIJVE1BrM24Ok
	eeacW2m1Wn0gS90CA/uFhqbECUaet+ccPO0axEzNvSpawfD9TnNshuHbARMI8OGZ
	DFGcJ83BMacDQVru0bZdOOLxhiBHOD2NQYQ==
X-ME-Sender: <xms:Zh4eah6AhutymD5BGnIkitlYNouCq8wS9Fb_Q0UoTjm1BjSuD-RcbQ>
    <xme:Zh4eat97cM0HUW4ZKFmY15rI1W6tvM7JCIq3JQftQJobFr9J4lGYAI5SU7aw5V9ru
    O7CrOW3KMbtLbWvIpcHP6b2gFiOvofm79eE9bu2onx5n9UfqqoVsg>
X-ME-Received: <xmr:Zh4eaurVT69HEDkkrRc3KxwrjNU1ng2BFivUWbTddFfoomg-wRGLk6H02ukng3jsbowxQ_iU54uQajU2ccij_ZZTYBhPq5ep1KFp>
X-ME-Proxy-Cause: dmFkZTElO2ptS5vm2/tmFhtMYIcdGYcDdsjZTbly2wiBNniGBzLkXMe5JaUETtFDY9FqvA
    jZ8dKxHOlYFdcbnoH5PsZl5hhU9l5DxrcViqWszK6haCAR4xB+uopE4petTWPtg/szsvlc
    +yBVIS9ZpJHsITTNVQ496nXOLGFBiyyzhOvTjl1Qp/fe/ghXZXSX3cNITkFmXNXH/vUqi0
    +A2LFq9ZMZUNnT0inPrzenqDGF//3IYxabq3tFDGknRsHKjFmgqhoj2ADbMhC67/dlLaOT
    umBd0xmh4S2saSSSU/8Kn9Sfjy4GdYtAzyVEBmgX57fY4Lzm9INDlcjNDkPZjnR4NhS/ja
    puVkyNTbkDIwLd2iN/S3WpZ6qN0WO7Mlvx+0Pl3yFuW3n4CuELrX5eQgAxzR4XPgMKzXaO
    XaNT/uEUZr06UQUzYAi7My9r/eAev3b63OArRWlyaI6w2bh4tRue7EpLRSqUn1avww2lKi
    kXy5TESaOX6jz2dGvFQx3AO9mMSQhEOMExCwM3dAPWnNT2UeNwI6kuhXQpAoT0mIMBxf/V
    +EIyS8/VkhActqZkSQHJxXQzy03JJxNodMDcHnkezzYmioXdLQ9FQ7BWBODJuqmGYvjVHm
    FE7wv64qEH5c+byh7qO42nijLilSffCval95MtcNBOjEsaUruckSHjtONEFQ
X-ME-Proxy: <xmx:Zh4eampuz_O7rxZsC3UJ8LCWZZiUN-iyxZIGtMdIhTqGPqWaA31RGQ>
    <xmx:Zh4eap3Newqygvvhy5dpOqxIOUi4ed4DQkLPtMm0BFxO4rR9LLlk7w>
    <xmx:Zh4easGX5UQ-r-JPoMEbyz4RH1BAxbxniwC69GPu27eiLi8i3Shkqg>
    <xmx:Zh4easFTyGL79sElQNy3kSOZIr-dhZ8WwhsKTF6FfeX6nVd42DmRlw>
    <xmx:Zh4earqRNxlJ5CLdIShXTwQmS2kmsAXJXUAZfc60mGx-MC1bA2kJPdpB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 20:05:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  kaartic.sivaraam@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v4 8/8] environment: move
 "warn_on_object_refname_ambiguity" into `struct repo_config_values`
In-Reply-To: <20260601154211.82370-9-belkid98@gmail.com> (Olamide Caleb
	Bello's message of "Mon, 1 Jun 2026 16:42:11 +0100")
References: <20260423160832.114816-1-belkid98@gmail.com>
	<20260601154211.82370-1-belkid98@gmail.com>
	<20260601154211.82370-9-belkid98@gmail.com>
Date: Tue, 02 Jun 2026 09:05:57 +0900
Message-ID: <xmqqtsrlztzu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Olamide Caleb Bello <belkid98@gmail.com> writes:

> @@ -684,11 +684,12 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
>  	int refs_found = 0;
>  	int at, reflog_len, nth_prior = 0;
>  	int fatal = !(flags & GET_OID_QUIETLY);
> +	struct repo_config_values *cfg = repo_config_values(the_repository);

The theme of this topic, however, is to turn the process-wide global
into per-repository setting, so it may appear to be a bit unrelated
change, but the function already takes a repository instance, which
may be different from the_repository.  In the longer run, we
definitely want to see this call pass 'r' instead of
'the_repository', after making sure that repo-config-values for
repository 'r' has already been properly initialized in the program
flow that leads here.

If we want to be conservative, keep the call passing the_repository,
but leave an in-code comment 

	/*
	 * NEEDSWORK: pass 'r' instead of the_repository after
	 * making sure that repo_config_values for 'r' does have
	 * the right value for the repository.
	 */

or something like that nearby.

> diff --git a/submodule.c b/submodule.c
> index b1a0363f9d..f26235bbb7 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -898,12 +898,13 @@ static void collect_changed_submodules(struct repository *r,
>  	struct setup_revision_opt s_r_opt = {
>  		.assume_dashdash = 1,
>  	};
> +	struct repo_config_values *cfg = repo_config_values(the_repository);

Likewise.

There may be other places with the same issue I may have missed.


