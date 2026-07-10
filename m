Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7485C37CD3C
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 18:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709467; cv=none; b=BWEDqqUcsX5p7L2qbU8IUZcWvLS+nq20Ua+1+YSqUX8mHMjoat2ZBi+1G6AVrnQa76UeyWAa6P5AbULyNSSNV6S1tmoSl3VwdVkC44uYzzqPwfaQ7TEGQyvY7Xmq8TlHM48WepThKL8U+NCLSghyDLWyOWUmcq+kTF8V/uNhnN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709467; c=relaxed/simple;
	bh=LjP9+fU8vHAdNbSQ9m7UEu0d7jURfTad7t/Szn+HyDs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YUBdS4tgGbsKRlZvhjyzTnuD3kfOuSbAmVSjoXXYgaVzObfcTULkOvNr7ITkGpr25j17rr/DLo/Kj+umrR1UD01G/Gfe3xnJ19Ojy+vmMYcbtN3hLyIG0M+BaxKH4OkXBvOpt/D6pEsyICC8wOkfW8yowicsJ6h5Zbl47CKP6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cwVxjazM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DCFbLC3u; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cwVxjazM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DCFbLC3u"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 733CB1400090;
	Fri, 10 Jul 2026 14:51:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 10 Jul 2026 14:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783709464; x=1783795864; bh=//wc+TXmOS
	jauQzImL4gFXIzm0OaKoP/0RCTOgKM6e4=; b=cwVxjazMDi4W5iA4qTVFwCb6qX
	aqYWXqZNn4bk1L62X0HPXTTbrB44wocr4y6rcn0KbQOLBPZYgVq1OeGFuetDKlE7
	VP+ziB0Ncb8qUN3N5bBhslWQhN9rSl+z68L7JxUMGn+yZhgqMjNINFPhmuT7ruU2
	265EBVVjdU+bPX9odWsdwmsRFqTz8PjQf97fZYVa17bvy7B3zCuWYtywNKvXRAup
	RVuG5eOpTEEqVAX5pG1dAW1f8213Z+1UGz/WX5HA2ZlXvUVmJAMauUACksFANxy1
	Bg+mQWhYwem/EvWC/QkGZGpQJeypFODY3nPAA+r+ESn9KB02MtZf27/d9nGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783709464; x=1783795864; bh=//wc+TXmOSjauQzImL4gFXIzm0OaKoP/0RC
	TOgKM6e4=; b=DCFbLC3uF87YIX5rt5x45650ZbkLRhc12GrEoKRWW2ZXd4qU0/F
	f0qBFUOgO3KhWb22KachOmlMoyyQCLxxNnzCSuedJeTX+9lNbPXzlqHegblowdr6
	wyy7Ywd8c5oX5xR+zg1hphr9KvSfsyOiXEuHPxMQesTu0w6Sw/m5aYAD68b/Ch8A
	GA30FGZmSi7JmC1ZxvqTyWNcki2NKVpUudUevaoYHXLUKLJeYHQCeBaC097KGuO2
	gArMIVlLTVoOeitiKL/U9HiuFRbSPeGxpIS+OBdkqtxwN5QSKfkk1QAEJj6IzE6k
	yOB9V2beEOBoeylPdT48UuqCAznO7uB6GiQ==
X-ME-Sender: <xms:GD9RamvJQ8z3iOHDAYgZyx8Ju5fqPh-8F0OoF_I3QMQcRe11viOKog>
    <xme:GD9Rai7cSArT-bYN25BJlWHqh4nutKdRiYN5deSR4PA5qJFYuGe52GxLCYBbP3ZQw
    TnkfYz4TgJKj8lVh4DFsrMIN5ZELIZ0qkFREFWhoxVWh6nVDc8P>
X-ME-Received: <xmr:GD9RavIbvelQvu3sDIYredgMro8bdQ5MzHWAqGqQfkEhWRLBrFnrQRvGnYOlDTDsAOeaF0uRzzKvUdi7c1XGKnBR5n31WZViB6BtHjs>
X-ME-Proxy-Cause: dmFkZTGUsftvXTFmwKcLuLdON0RC6/rOVYoNCpYd+GblIlAPLjvTHPHmtldQw3ppMqBWYi
    Yxu8+rzIoEgLtIoqY8xbpVEakvqQzyU9I3xX6VX34mIdywbG/W69XvEBl/DRKmStHjfpiZ
    U2cUHde9WSV5QircNB9dX0MP8z466Y2iebnWEc9Bpkc2kII/3kEHcCkf9gnOAwSvED0KVZ
    8VGwfQy4rCvJehgbLNyIet2HKV39w/5ZfkGZPOhjIIWuslOJ7arc9PV9Mdp34zxD47hwwN
    BQpIxl9PTQ4VJDnlAyJbKEKAVYkZCX4Dov+81vAEkAB+cbIA01oenVSLHtw34bgFV2IgL1
    kRLry90cH9kQftawO9w9MzWKwiokgXgnkzoR6rdWJ0RmKqOcKIJTy8m8o7DbxpF6pGM2wq
    yNgtUnyMQRB8LVCu45qj5gAG/03rwKR4DtaZIMKlhc4mj3b8DGVzZds6PQdQzwYoYVe6VN
    ByUm1y6IRM/Ypu6yWuUxrjojoRFHaw3yOmUJvSb6VH6qILJPAucMIwWF8ryLBspwsiSP76
    hxjrZC7GSnaOMNvDsNXobRzHKPxBslUoIsVahahdvfvcf+pQalkBZlelkKmUTqA0ecP5rx
    ccu/Ra0WclnSBM6XegHVfropaaMo2wwmg65qvcqGXd0siCYoHwTJ10CZ1GAQ
X-ME-Proxy: <xmx:GD9Raq7VgvTcIIEponCyRYuaZRiGHHUV0KVd6jQxMfQa-OfFo53nPA>
    <xmx:GD9RaqzKePJLfX8WFObm-c_5f-NtgsHXeBJhx0wwXq9rqU--8eAPJQ>
    <xmx:GD9RamZUpsyXx5QxGlnvYk6msqlWtSv3mDpz7XfK-ys61WGJW3Kt9A>
    <xmx:GD9RakSdgEL_Ps8y_9gMmqrMICduIsr_Ckr2Qwby1nMxPjR689Hg8g>
    <xmx:GD9Rau5LpCgWu2sJZkyrGW0tUUhBNdse6VdqqWUXFgCS-4XXAwdtpF17>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 14:51:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] builtin/add.c: replace run_command() with direct
 apply_all_patches() call
In-Reply-To: <20260710074105.50737-1-gatlavishweshwarreddy26@gmail.com> (Gatla
	Vishweshwar Reddy's message of "Fri, 10 Jul 2026 13:02:06 +0530")
References: <xmqqmrvzfitd.fsf@gitster.g>
	<20260710074105.50737-1-gatlavishweshwarreddy26@gmail.com>
Date: Fri, 10 Jul 2026 11:51:02 -0700
Message-ID: <xmqqechad6g9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com> writes:

> @@ -187,7 +186,6 @@ static int edit_patch(struct repository *repo,
>  		      const char *prefix)
>  {
>  	char *file = repo_git_path(repo, "ADD_EDIT.patch");
> -	struct child_process child = CHILD_PROCESS_INIT;
>  	struct rev_info rev;
>  	int out;
>  	struct stat st;
> @@ -217,11 +215,17 @@ static int edit_patch(struct repository *repo,
>  	if (!st.st_size)
>  		die(_("empty patch. aborted"));
>
> -	child.git_cmd = 1;
> -	strvec_pushl(&child.args, "apply", "--recount", "--cached", file,
> -		     NULL);
> -	if (run_command(&child))
> +	struct apply_state state;
> +	const char *apply_argv[] = { file, NULL };

These are -Wdeclaration-after-statement violations; we should move
them to the beginning of the function alongside the other variable
declarations.

> +
> +	if (init_apply_state(&state, repo, prefix))
> +		die(_("could not initialize apply state"));
> +	state.cached = 1;
> +	if (check_apply_state(&state, 0))
> +		die(_("could not check apply state"));
> +	if (apply_all_patches(&state, 1, apply_argv, APPLY_OPT_RECOUNT))
>  		die(_("could not apply '%s'"), file);
> +	clear_apply_state(&state);

Does it work properly when run in a subdirectory, such as "cd t &&
git add -e")?  The apply_all_patches() function adjusts the path to
patch files by calling prefix_filename() to prepend state->prefix,
which represents our current directory.

This is not a rhetorical question, as I am unsure what "file"
actually holds at this point after calling repo_git_path().  I don't
know if it is ADD_EDIT.patch relative to a specific directory, an
absolute path to the file, or something else entirely.  It would be
highly beneficial to include a test or two verifying the behavour of
'add -e' from within a subdirectory.

Thanks.
