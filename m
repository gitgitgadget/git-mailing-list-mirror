Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7516819C553
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781889287; cv=none; b=I6bXVAMDRMBnV5Z9wtC0Ltkgm41aQk/CTi3dRs+7NuY5MHOC6Ww+VG9v5sPN/6mBw+Llcw7IyTZqXt+WC5vSkCPkmuhpqtByh5RXaaKbmu33ZQXjFnFBWO+rVdICk1SxDG53TRhgYQJjx2iS/03RLIB34WNsyovETTUERjqgIb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781889287; c=relaxed/simple;
	bh=8JsJQY0arCinueszpAZXq+yZXWR21wMCAceVxsLCF/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OD3osXgpvDVAj75WmjsMYmBNgkVF8ZCM0ZopCcRdY9lSoqAJgbnJ1krajXy5cVM7761Du+aHCNKyV9xqOidCAZDr0Oa1SM/V5QXtSAQjTYk9vxnWINr1ac4ZjQgkAJXZItCADrkkgoL6I4yNViSJLeWSdTroqs4+BG4Onl7jBBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cF2iWmzO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cYTcPCjV; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cF2iWmzO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cYTcPCjV"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id AE6C51D0010D;
	Fri, 19 Jun 2026 13:14:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 19 Jun 2026 13:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781889285; x=1781975685; bh=yxDf2OW8tU
	Cgh9lRNwVSeiIqp3sfUyLREv5ljtTh1SQ=; b=cF2iWmzOlBqmXoFiGQ3/WH8aAp
	piOLvpR14+SMdp4YfkqQX0Vwww31NtyIo/tql7e/EC++Hnwd185BfOEQpWr+fZE3
	ZYTxdZ6MYNNPNfCF41l6TnWwebn+J4aNZQFRttzDGHCz2IgAiKbEIhBor8RVkoeg
	HR7SAoCbKYaujgZ/e2G6lKiSMn77EPUsn1UyXu9vUrth2X8xSuODp8mBpJgxm/Ai
	fdxJRGcPwP63ngYhLS2kVy22d21Mn/3maTa3c8KA1pOv26wxUIR2DI3IEqplRXOk
	bUYYrhM6N/hzrl3D45hCjDNo9dC0Mwe1aA+WwKkASmKU3A4gShUJkOsmT+kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781889285; x=1781975685; bh=yxDf2OW8tUCgh9lRNwVSeiIqp3sfUyLREv5
	ljtTh1SQ=; b=cYTcPCjVIzKVHhMuU7CAtrm1+QS4u53GeUc6A7VKuN9DOyk9Wbn
	cqlxV2rh2BW0vW5P3JwwoRO/4t+zr1svIGRVoP6KZtWqH6zMvVS94D/DMaWJR5qB
	P6gBTbzTyZr33WKOtw1NKdfZfSruppYJ/l6brF7Fgl+M0qkuExG5uMt31FXX93Zm
	WkBdXsa2kzad4j681UKp4BF0c6dPtqZ1DIjZU7W0bUr8d7Q7NyG00Yr7dPUx72m3
	RATGrjSZYvjA3kxtqJGCiFXJ64IMLYa/EsuvZEpwDwQC6473mtfHbFL3v1qmV8Uj
	8unSSyodrqplJsbe+LMMApU4xy1eBQcqyzA==
X-ME-Sender: <xms:BXk1ajeMTcnqOnUpev_H-Il3dlLbTScvf_KgPAshOkMSNnfVZm8IHA>
    <xme:BXk1as5eI058PwMT_fM5ooiqKfYSHlvlkTthNJk6JgbQS9Q-LiNR2dFt30xEukNkL
    jC0ZzihjaiF21Aa0TgUdJeMxFFgEe4Fcv8tymlBf4Ab-BU3Q1NM>
X-ME-Received: <xmr:BXk1amXM514gNZTPF_wjVpjduFhCbATBXBjRdDt2zYfJjiG-dSN9QeXkHFFqLjNDoYzZIq9QtV1FgZQs7Kef5ZGCa14ixeRKuu7d>
X-ME-Proxy-Cause: dmFkZTFMGe1BTCzGPQ/X4wOqiYosIJ4PvCdpvHxzVhiAGXF11w1Cqm1TPSO4w4sB0KbFCc
    zzrIYdpkrJ2ooXbHWchq/nsBzMIjH/vqyITw4/rYDuQEJtOZ8vw8bp0zDVV0McrRD4M7CB
    2YT4v/Xu64Yb/ehgkDNdCEQ3OQ8g99UfFELIAoAyHn9y9hRF5M+LDun5L5UyqgJW+QRaNp
    bBZu9Yksvwji/1idth8SRVlcOvtG18a9kegD1K38NlCI8GBWCUAa0DwYthNVUQ+a0OGphI
    kZ2USE2WzcjlD0hWgiqDN9GaiEQw+Ft7OiOtho7Re3S190SRzVvXlH9TfA49PrQHXE5hQW
    O5/5UU4nWkfz1BvCOcdetlAHsM9BnZLOy8IiEJk5DH1/+78T4P0f21o5x3ukdx1w7TGgUc
    GhjAxNQaRm7S8yvuwH1vB5SGV5V4OrOBiWP+3Vc4sNhMWYMhxOnxUqjATRfp7xLQz5oyrl
    ZRgOTJspoLi5w96azkablE4c2SA0WuAq7v4Gmix8RvunQEBKLhuW0tX5i2DFIi1OWINgcf
    6/OxLwZ607SS2GnhrN8lk3DKOmqEVCEhDVDG8Ak1HQZfR4ylR6Irr8oZ1VOC6OlHbxI2RN
    ie0NMXT6ovAw8JlT5n6AA9t/xRFDBdUi80NmtaAiDIRQcP9gYLJaDgOJEmvQ
X-ME-Proxy: <xmx:BXk1ar40XpEi41qz_eE-bbvYenbgP7EfZlwCkKIa60Ci-cLCRq82Vg>
    <xmx:BXk1ahr4HFLZ4-4xNgP4kDn0dQHf-82EO_msoQ3SK280dpxlILT-qw>
    <xmx:BXk1aukdZdBFW_ZstKsbEcQi_wxl7yqWioTnCE8AYSvykxua-9vEZg>
    <xmx:BXk1atOIwULar-zDI0S9seLOpzyhfxpusa6fJzQt-oZq44cGNgd7Hg>
    <xmx:BXk1aoKO9r1UkXYGsImeFFn-ylyUmdO3NuJO-xZMvgj5dUi51a7yvq-b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 13:14:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Ayush Chandekar <ayu.chandekar@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH v4 0/1] environment: move protect_hfs and protect_ntfs
 into repo_config_values
In-Reply-To: <20260619163823.652091-1-cat@malon.dev> (Tian Yuchen's message of
	"Sat, 20 Jun 2026 00:38:22 +0800")
References: <20260619163823.652091-1-cat@malon.dev>
Date: Fri, 19 Jun 2026 10:14:43 -0700
Message-ID: <xmqqo6h6jvuk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> This series continues the ongoing libification effort by moving the
> global filesystem variables, 'protect_hfs' and 'protect_ntfs', into
> 'struct repo_config_values'.
> ...
> Change since V3:
>
>  - In repo_protect_hfs() and repo_protect_ntfs(), change repo->gitdir to
>  using (repo && repo->initialized).

While I think that it is a good change for consistency with other
two topics, the hfs/ntfs topic is already in 'next', so it needs to
be handled differently.  Namely, a topic in 'next' should not be
replaced, but be improved by additional patches on top.

In this particular case case, I think it would be good to have "to
match how we refrain from calling repo_config_values() on an
uninitialized instance of a repository object in other two topics
that deal with X bit and Y bit, check the repo->initialized bit
instead of the repo->gitdir member" or something like that in the
log message to explain why we are making the change, perhaps.

The patch text may look like this.

 environment.c | 4 ++--
 environment.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git c/environment.c w/environment.c
index 683fe1b4d3..f34f6fc750 100644
--- c/environment.c
+++ w/environment.c
@@ -142,14 +142,14 @@ int is_bare_repository(void)
 
 int repo_protect_ntfs(struct repository *repo)
 {
-	return repo->gitdir ?
+	return (repo && repo->initialized) ?
 		repo_config_values(repo)->protect_ntfs :
 		PROTECT_NTFS_DEFAULT;
 }
 
 int repo_protect_hfs(struct repository *repo)
 {
-	return repo->gitdir ?
+	return (repo && repo->initialized) ?
 		repo_config_values(repo)->protect_hfs :
 		PROTECT_HFS_DEFAULT;
 }
diff --git c/environment.h w/environment.h
index fdd9775900..b1ae4a70de 100644
--- c/environment.h
+++ w/environment.h
@@ -127,8 +127,8 @@ int git_default_core_config(const char *var, const char *value,
 
 /*
  * Getters for the `protect_hfs` and `protect_ntfs` fields of `struct repo_config_values`.
- * They check `repo->gitdir` to prevent calling repo_config_values()
- * before the configuration is loaded or in bare environments.
+ * They check `repo->initialized` to prevent calling `repo_config_values()`
+ * before the repository setup is fully complete or in non-git environments.
  */
 int repo_protect_hfs(struct repository *repo);
 int repo_protect_ntfs(struct repository *repo);

