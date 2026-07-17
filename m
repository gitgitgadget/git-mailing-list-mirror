Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD16C348C46
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784304066; cv=none; b=mNNA0T2qALKbhTYEQzxHR2pAgdIcESqM/qTKloIfCRRubq5YSMIEtRDO5jdHJ2pJ3MxtOM6lEUyg9Ij9hHmrpCnT7X5oDkXDsYUO696sZSIdHo3aZ+RAyI+ieI5yLrPA4AQsCo/JV2QHskXfn9pm14tkeLlONoET/QKLd6qY89g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784304066; c=relaxed/simple;
	bh=/zZDXSO5i1wdVgc2EY8+C0x48/SThfdWHL/GjelkTH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EdQFujk6BTsIZP3oxTkw0wQ0QO+I7IGHlmeonO2iRhijqmYcTx9Lm96doKhCsgZa0uRx6HZ4KbgGJkFjQSUuyCktTQ3PHvMxG85O/ypRyfpEaDh3GbcCyzjbm3TrSYHYwUrxGIyHqq4iLo5S5KLgKbhi8UEXyRhpc+eFGw+GzVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R/GV4X7T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lswcd0rY; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R/GV4X7T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lswcd0rY"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E18351400090;
	Fri, 17 Jul 2026 12:01:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Fri, 17 Jul 2026 12:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784304063; x=1784390463; bh=KnNfiPdDni
	kVaiRRYBYO1iHFS7DC7uXCJz/buerhlwk=; b=R/GV4X7TXb9RWpqOwi39CR9xhK
	Jvj98IVECmk5cYoPu8X71OY6ZYSNo79UEtuE07upQf7/Aexq2YltjxNfoMIKXpoA
	hrTq7zzyrBggIYsT6xKq2cnkfv21mEaifK8dTup6x6llo36HO74sASPIBTjwpcw/
	BF+o82jJRMGc8GPAd7h6L9TkDrfCDPx6IOUrCTdgSFpxTdwW5Rsq/qrrRJvnU0xn
	x9eEIdqW/Qjoo1umJWcuRUi0UPlJy75C/psPlxdD1Y2/YAg26ubH8IC7uGc2OsFt
	ot1ULNASSod/vWr8dnzoA7vK5oPMp12YwJmySATOMWphA3Vc0QY1tpwveSUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784304063; x=1784390463; bh=KnNfiPdDnikVaiRRYBYO1iHFS7DC7uXCJz/
	buerhlwk=; b=lswcd0rYSgU40WZRZerG/asWjO3kk+84OnpTUqoFix3vlMBWFCV
	Nden5kYP5CUsiBWSJFComLZ+E6Rt3vf3VjrH9vRD1MtBeCnsN/5ccPegqn0ytz9p
	8UXdLj3CvGdzttwhVFikvZWToqt/KJOmpZqywAcuk0/be8Sr0L1TUeKq+N6Mmp2x
	/ApGZr872PUkWHQyhZekJ2q+seyNsqd0OEULI/iG6f0Xb6cO/XUaphMoVjjZy2he
	uwdkDQoss3RluGdxrMcVRM7Yb/48noplmPqUB6bEUUjH9en14aPbvy551TpbF5eU
	viVwQQ+euhysYWeEkCDjjLB3j/MWqN1AiKw==
X-ME-Sender: <xms:v1FaaspTud4Q5z34gyMaJzf1a1DEPljhWR9JkypOpGq0D0oV7hDMiA>
    <xme:v1Faak4tNr99yNa-S_LuWtNmUn0YkjjpKBhj4zmSgyaLiiphY0hF5wCd_6JmSMX9g
    39my1IrNxe4ceAYUIT0Fp9g9ybjmb2eGUg4SR1WImsbqUsO_4_a64I>
X-ME-Received: <xmr:v1Faajc68Wk_QWxs4A7L1mFyReJMBezMDZKjQTYhXA90NgNP2JlSJNrqiuwZUTI7wovbFboiTZ0qrkbJlFMlPqXo_1-BOoNdHR0MrTs>
X-ME-Proxy-Cause: dmFkZTGYTzZSQg0Lhpg4ial6oKOpxAXeb5h83WM7Z2NiHeVB/5Yo78KkvMp3c5lSgcMcf0
    ZuLyiCB9N+Fok9yAmTkmOl33uhsJM/mmDJzQN9E2S50natDz3s7U1PbhyfRABSiAZa6i/N
    KJ6cy6kjBALzA27a2XNCT/Bj+dYjnTccLFr3UYc2awBcPI5QPvM5dCA5U5aeGdUcPQU5ph
    hpo72dWiJuaBPZMRqXYUrd8Edypb4XI3xrUxmQPnKHcqC0UDb1nfUuakZLVILOh0XfdSAy
    Ya0Qi2qcYuQZjmwL2mEvwzpV8cdHW4xaTkK+jJwcycmfjfW8MBHTjZ/D93tE+IrdJQ2GYt
    LWopanTSuuE0WItV49fVrrcvi6I1m0jPSyINuCfMCxzJ4XTq4Jc11XZ12yR2yIjJNHggjH
    7kt8J0V8t9agqijyt/qrb64U0X1zYbqJWkV4AtnV638lS542z7DVY1l751TFceVmy3aiLd
    /VZc4WzDyc9IBstgsntfKpMRFGQuKTL9TlvQpKiOdpT6Gg2VraMTViLBZos7COTnde583m
    DdPSIlejMXu52srjeUunly6lkrk+VAnbqm4yst/Fkt2+YyCGTAD8jbXhHkyQDQwFDoJgBz
    R0WYuxsWRwHk12C8+X8tSFwJbHS7tsDIWE70ibdogjMsF27vt3Gmjs2hZJcA
X-ME-Proxy: <xmx:v1Faap6hZsFSPsbdiDfiOiB6PcbdWfEhLiMiintvySoh21KEn2nTSg>
    <xmx:v1FaaquYQ9eqmsUSy96fa9BHB0SFUhU8Yzj0z3mtiEC3byR1kXe0eg>
    <xmx:v1FaapgC47zhdrrQOcjZUOEQqJF00f-WW2jxWa0-wULjAyLzPFtMmA>
    <xmx:v1FaaloG9wi8ZvHnNuP1ZsR_WQn-80bp8KmkH4o8eVkPMIvktc7g9g>
    <xmx:v1FaatpUs_AZGcshFI593Jm-UGs9RmezsaAxIht38vnpx5B1mfGRHiiO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 12:01:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  ps@pks.im,  Christian Couder
 <christian.couder@gmail.com>,  Ayush Chandekar <ayu.chandekar@gmail.com>,
  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v7 3/4] environment: move trust_executable_bit into
 repo_config_values
In-Reply-To: <20260717063559.1633567-4-cat@malon.dev> (Tian Yuchen's message
	of "Fri, 17 Jul 2026 14:35:58 +0800")
References: <20260716084941.1101918-1-cat@malon.dev>
	<20260717063559.1633567-1-cat@malon.dev>
	<20260717063559.1633567-4-cat@malon.dev>
Date: Fri, 17 Jul 2026 09:01:01 -0700
Message-ID: <xmqq8q7961xe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> diff --git a/environment.c b/environment.c
> index fc3ed8bb1c..75069a884d 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -41,7 +41,6 @@
>  static int pack_compression_seen;
>  static int zlib_compression_seen;
>  
> -int trust_executable_bit = 1;
>  int trust_ctime = 1;
>  int check_stat = 1;
>  int has_symlinks = 1;
> @@ -142,6 +141,13 @@ int is_bare_repository(void)
>  	return is_bare_repository_cfg && !repo_get_work_tree(the_repository);
>  }
>  
> +int repo_trust_executable_bit(struct repository *repo)
> +{
> +	return repo->gitdir?
> +		repo_config_values(repo)->trust_executable_bit :
> +		1;
> +}
> +
>  int have_git_dir(void)
>  {
>  	return startup_info->have_repository

Two comments.

 * Missing SP before '?'.  It may be easier to read if it is written
   like this:

	return repo->gitdir
	       ? repo_config_values(repo)->trust_executable_bit
	       : 1;

   which more clearly highlights the ternary structure.  If you tilt
   your head 90 degrees to the left, you can almost see the parse
   tree of the expression.
  
 * Does it make sense to protect against a NULL 'repo' case, as
   repo_protect_ntfs() and repo_protect_hfs() helpers do?  Or is it
   better to crash loudly with a segfault to let the developer know
   they have a bug to fix?  I lean toward the latter myself, and if
   we go that route, we should probably stop using 'repo &&
   repo->gitdir' elsewhere, rather than sweeping the problem under
   the rug with defensive checks.
