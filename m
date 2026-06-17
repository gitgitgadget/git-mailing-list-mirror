Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC41330B22
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716598; cv=none; b=PtwAOj/xJJSJN/k9KjSnKai1SU5IRYXHwvu0MaluTIkU58rY7Dw3wgerH2K0jhrjlI5p7CSNnVlR0/EN1KB/V+NTxhaBW/RAkUk/UNDwxA+tM1M4ovNuBoxMbkQN6lgagrGr+/ry8gDwljB37SvGZFoRkk+Z/OQ/7Gr2M7qse6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716598; c=relaxed/simple;
	bh=hGa6FYdtFYsD9Qj/TvT0QegPtQEUIkTAGtxtob7aEbg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JiVhYxrECd4OzmTB9ZjeJLAfvZP2TvJ4YMVrHtAH7gcZdFbxZ/I//pnkIwMEsG1AzXw7RIM7NX8pJ6SNy0qykqX4vXfWWm4fSeN2YZBSOogEauEzhLXeHN1kOBEZreK1SSb7YdLR4LFXY31CrwYGvOZpSJY/RCRvhWxQQcpFELI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jO5pJ/Lv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ysh3C3ZJ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jO5pJ/Lv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ysh3C3ZJ"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D554C7A0150;
	Wed, 17 Jun 2026 13:16:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 17 Jun 2026 13:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781716593; x=1781802993; bh=b3oRKkXBa3
	gtmNvpLc7MxaJIbmEWVm+WUre78/ZnONE=; b=jO5pJ/Lv5iMHSvoVz7F2qFG4aT
	GgrRBlzLrBmKzpTpWd82aMUxNMC6REbpe7FAUXNK3yiyi6zphzceyYr72vPjtD35
	JzNEOwC6txVsk0kP3tQaUvEFBrZwTLlT2bIaGbWro312jbBg7454k70RYXYWiHWu
	6zEbZqcpQusJJFShacTkuaj3gBYbbbh1iTk+p2/dFzNfjrRGDtqaOyflWzYsOT0s
	M1/gIAG8Q+S7AA8ojjCsvMVCOYz+GR951Y6GwMmjc20SYraDjghFFGEMIm/sIXDp
	vOoagUDT4jq1zwCTpM38/+sysuCkcbM5pdLIlkMDxKmAe7fVKkQbJbJ5AKtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781716593; x=1781802993; bh=b3oRKkXBa3gtmNvpLc7MxaJIbmEWVm+WUre
	78/ZnONE=; b=Ysh3C3ZJcm9BMpeVqLBrgxsG872yR1r3EzqI2n8ofwdPy0f2uEP
	VraJ2F9L1KUBVVb4CAqIX9yzMFMfBKOnIGw/+U6uIAKQyYgAjLnHZEBmM5Ibo1Mz
	9Ihr2hALH6E08J/jfF8IG+pm5hbqANqagJ3i/xo6c21kHW1zv7nKVT8nHmHxSeNq
	xkPV+R6GDmWZALmSn4GDK469G9Xvv2XyCPKPDzm8iA+4yz3LcKe1wlRHgfJH0KkS
	v1bsf7tbn5Dm7XJD58+64zP0pycmrDrzAD7kKbzDfFPyPtpo6ohx6nuZ0kl+Yks9
	GTu9TjLEMs1rM1k29qi0F3Y8MU4XoeqPP1A==
X-ME-Sender: <xms:cdYyaguHdowfXRO7FG6PPrTN0ONOXKdze5sju4b9mHpKTCkV5APVpQ>
    <xme:cdYyaqBIu8sdhyOMrz7WM28mEu0JiSoZv8D2pMHIj8MVtjBCcFtaG41U2zzXLPnaS
    ZIt2_M_uN91Q3SENPVYhofO2C8qhAQj2AT2pWYpVk2vaIYJGza2hw>
X-ME-Received: <xmr:cdYyagPlIynoz9-A5eyt-yTi2I39IymtAU-_pnVJkXgjDdKOaZ1YPuKiISx0UrSXb9JhBbNZ3AZBL1i3YmFyZ_CSizVlwEGCRRBk>
X-ME-Proxy-Cause: dmFkZTFxdYyrlXtbQYWD2eDVD6+Mx9Ea37/A7SOjQSJhy3DkK9A1LB9+gVSLgCOE/xBJFU
    AU+ZcQ8ckUNgzNtGnvhWT1ndxgrKrBZ3K2lecpv2/P0aq6Io/R6uOlJAx2Ngs5fU7xYzHb
    0P/mz7rJ7b33Kh+c7F1uqWqxqkcpz0GmtSD3UCBPlQ5Ku+PbTam7rskqeLj/ScI0wPrerT
    mkPWq1BnWLKfDcZWPGgiYemByVbXoMdWeiZKPp9PwpOe+eQZA0KIhCTLMCpNUM5aidUKLJ
    L3vnw8GlXgPUWHduKFEpyO1J4AraitcgCqjARllEPOdjm/nWIc+oL1EOw8sWFMAGY5J/O2
    u4LVXYqd5rY7YiA2c5Qj3JSDZl338caRHWrO110idlozK4rfCPtxxy/kn36je/RmUZkQaG
    VX/DgqLN/0nBd120A4FTGS1niKkL8MqXqiSKPTU7IfAX5T6WgLE34IhrEx1Nc/Ko2DS4nr
    YMNq19s0o7qO0pvF47+OaQ9RE8P1ciY9YrToYsb9VcJs/FYcnMyilBl5Tcvpi4Hj1yCl0U
    ei2iDAKUiO2b3ufpjfznugHl+ymOiVAIFxKWUnZzJQKdHQYYLI4fMHOu/kkwn1PgCIsb1c
    HZfOnNELnCaNfagr5XRYKcGqMACyghd4qx0Nn71qlRruWr1tPiH4+Cr3i0Vw
X-ME-Proxy: <xmx:cdYyaqA1Qq2iWKtbsJHmWAopXp4niD3xKMQj9oJlpdfRU1H2-_IG5g>
    <xmx:cdYyah5t_MyBp1GAjDEmTpfaiVNw2cPII8trgnKL2yyP1JPUXjNy4w>
    <xmx:cdYyak7hLYZNQdTtsimMRVO0QTS0C26Cfe2C0ckjSOA71EgdML79Qg>
    <xmx:cdYyajRrnUU_HfIJjUFrlNOTuDExcSNIbUo8t0kiqHZRzPQ-Y7B0TA>
    <xmx:cdYyahu_7ga8w1GFikn67Go0KV4FiuUpN248W6b2GLYcYAHklDxuBzjy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 13:16:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  ps@pks.im,  phillip.wood123@gmail.com,
  johannes.schindelin@gmx.de,  stolee@gmail.com,  Christian Couder
 <christian.couder@gmail.com>,  Ayush Chandekar <ayu.chandekar@gmail.com>,
  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH 1/2] environment: move ignore_case into repo_config_values
In-Reply-To: <20260617154929.564498-2-cat@malon.dev> (Tian Yuchen's message of
	"Wed, 17 Jun 2026 23:49:28 +0800")
References: <20260617154929.564498-1-cat@malon.dev>
	<20260617154929.564498-2-cat@malon.dev>
Date: Wed, 17 Jun 2026 10:16:32 -0700
Message-ID: <xmqqh5n1w0i7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> Note that the newly introduced getter, 'repo_get_ignore_case()',
> intentionally avoids checking 'repo->gitdir'. This could safely
> accommodates early dynamic probing of the filesystem during
> 'git init' or clone operations, where the 'gitdir' might not be fully
> initialized but the filesystem capability must be recorded.

Why "could"?  It either "safely accommodates" or it doesn't.

I do not quite understand the logic behind this part.  Why is it OK
to punt until .gitdir is ready for trust-executable-bit, like it is
done in f951ed98 (environment: move trust_executable_bit into
repo_config_values, 2026-06-13)

diff --git a/environment.c b/environment.c
index fc3ed8bb1c..75069a884d 100644
--- a/environment.c
+++ b/environment.c
@@ -142,6 +141,13 @@ int is_bare_repository(void)
 	return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
 }
 
+int repo_trust_executable_bit(struct repository *repo)
+{
+	return repo->gitdir?
+		repo_config_values(repo)->trust_executable_bit :
+		1;
+}
+

or hfs/ntfs in 71386c21 (environment: move 'protect_hfs' and
'protect_ntfs' into 'repo_config_values', 2026-06-10)

diff --git a/environment.c b/environment.c
index fc3ed8bb1c..683fe1b4d3 100644
--- a/environment.c
+++ b/environment.c
@@ -142,6 +140,20 @@ int is_bare_repository(void)
 	return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
 }
 
+int repo_protect_ntfs(struct repository *repo)
+{
+	return repo->gitdir ?
+		repo_config_values(repo)->protect_ntfs :
+		PROTECT_NTFS_DEFAULT;
+}
+
+int repo_protect_hfs(struct repository *repo)
+{
+	return repo->gitdir ?
+		repo_config_values(repo)->protect_hfs :
+		PROTECT_HFS_DEFAULT;
+}
+
 int have_git_dir(void)
 {
 	return startup_info->have_repository

but not for this bit?

> +int repo_get_ignore_case(struct repository *repo)
> +{
> +	if (repo)
> +		return repo_config_values(repo)->ignore_case;
> +	return 0;
> +}

What makes ignore-case so special?  Doesn't the same logic apply to
the other three bits?

Or use a more direct

	if (repo && repo->initialized)
		...;

for all three, as repo_config_values(repo) barfs when repo is not
initialized?

I dunno.
