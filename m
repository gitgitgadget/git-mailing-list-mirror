Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6BD3290DB
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 01:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078109; cv=none; b=CySfkePImx42Q6mAqCi5z7TdeaUKLPAG+QrwC8KvpsyAKhNMNguGDpwsL/W226ttjdB3LEMETwXz5a8qio7mCKeZvbj4M6pyqVIB6xPcy57H5RkEvB+L7ujG+0S6JbNbPTJOl9xmi/RkLqc0bZ7dd10leNUQLwlbyTA1x/rXY0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078109; c=relaxed/simple;
	bh=HDC+tYXxlQnnrA6AvF7TvVvmVmP4ILfKYLT0aZJ1wUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U0z9SdjUIVJYJJigtroDolq/rzrPoC7RnaD1xndOAxanFgXlIJUg/myparN/rFzoUj5TeriZf9As96RYqnkYBslQScRij5QoN8DMevDjDiONXCPkUaTVXAzXA93/S4VBz5zOCct58yf8ASaAsZ5N3IhuSa8ACxVIQUx7zgVUK/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=llRC19aV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z9dKJGVM; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="llRC19aV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z9dKJGVM"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2A8F67A01A5;
	Tue, 14 Jul 2026 21:15:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 14 Jul 2026 21:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784078106; x=1784164506; bh=F2aBniYWd1
	QTOYh+0Vsh5Vhn2N3r855xWFnKfJuUXLI=; b=llRC19aViKjwi/Ltg9SDZND1mv
	TLass1iMc7O9mv03TcMQ7lj2VV6WM6wNIGVNdmc+8ZLW0NeVfTjy/kfs+KQ4ZtHL
	pkyWptTfgUNOa100rbqLhqsw0XZUL/4sC59l8kr29QIdOb4cjN3pOP4PqKHgbnfJ
	nAgO5huXg95Q1F02CMtMi3bvf1l1L/YRAl92PRIn8KEEg81sz1XraUqQtO722p/k
	D1x7ivgRTNK2w060eB+KQbqyzHIp9PJEs1r8ULzolZ2ld7UEmKzGl9qVdchJkO3q
	8wRyC5lSsxxoie/YHyrKY3edudM8MvNRALw7mfcTiQMsdedXsmB7gxNZTOAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784078106; x=1784164506; bh=F2aBniYWd1QTOYh+0Vsh5Vhn2N3r855xWFn
	KfJuUXLI=; b=Z9dKJGVMwL9LW/IshwMcFq/eAuTL4mV4rFwFzHPsRu12fMc2zfB
	73WBzE9T90gIAONMLjt6D8GubtB/nKP8tsCFJDQbhWYW4lem6FawkpdvtM+UHDFo
	ZPqF5y0tX/CL7XKvERcDLGj7CHZ9lX8NjOvXuLgozgZES9Ktp15D/oUSoO8cUpvn
	S+zBquSd7V8VpY9l/+XVYsQTi4jNw3WMgxVSiVOyzVSN4FniF+T289R/j23XN7N3
	dfmKcACA07QAjCg9nTuruH8Tjzx37X+b105NKk8WnfqiRbpmsu9x04QM7hDWVbZl
	uGOLfzKg55bnIfej8sdeRbDeqOG5hRFpHIA==
X-ME-Sender: <xms:Gd9Wah1u7Ce4_hcTNnaFKYS64tYob1BKKLQ1fD-QdYVKKC19IiWOFA>
    <xme:Gd9WavGwg3aQsLfY0w5ql_SJiaGNWyMJmdmzAprjyZfCcEARurLm3DfiOi0Gyh0Ud
    4XOhJdHoT-q8LPhXBHkKg6fOst7ue1cf8Zr0CvVtBxpatvkNJjp7EM>
X-ME-Received: <xmr:Gd9Wam7qIFHb19txiVSfPUfjApQc9cwEoUIOZK6fZBZyauSdQxWTu2iiF-GYaWORT22psoACFxXjh7vd81z7_OAtbCx3KawEUv0aB0Y>
X-ME-Proxy-Cause: dmFkZTETJ3ibN35vHmPeHIb62y3jWF4zS+AoxIlWvKBDbfxyBenJbdqCrrfvil0EbU5Y3Q
    x26kkD3knEpP/RGj3/5BtePKL/e7Tuh5wmICHbIXUq3GWIrAQBKgMNXQBtT/46E9JiE5ak
    Rbw/eJ3ziaZ1sf1XKEracyX8ujYzYSd9kdxjdQJCv/JlpCIIdmDaFGACf8J/sBgFQuGfko
    wsrrCoUWc5fE2h0xU16+CqiaIxvBq9ZC5chHRZAcHLAme3P6zx+MKOe2wxVVlkFknjrXFp
    sS8QDTOPDT6Ypha60rurYC3QBjhuvdwzNZGzKFdijGQqY70a1+Mr0CUD9fPHxGJdRFaNah
    8VKDbPNJTxERThuAGlcoSm+t1K0MDhHFxJen3oXZTvWL0smRjzJr9OFQuLbj+DhNBRzZXX
    QFF3Xy5R4kQsS2QY0pNt3vqCF6AuTzwO/3tE+b6G/AKzYGL0B+Zdd0dq4UVLalaySGdeFp
    khIaGm37YjFUd1HEJVRC/A9+icyUihdvjCVimJGaMlavSTlXGUfeFY35Wq+lzpK8VUKI0g
    HEGzKASQF40ovprl1BvIARPgh5iu+XEkymlx1OGpj0f4nryK6WbV72M7hPDX9nQCpill58
    BAs18V/dsGelce40w28tL7KF3EepZ2c6z7qMUF3oHi3/z4/2aokBBrPPLqSA
X-ME-Proxy: <xmx:Gd9WatuyKngDd-aN7A5xH-I8g4U9aj1z0TSp0DdsAAxpHttltMyjyQ>
    <xmx:Gd9Wav4eBADsHj57j5Tpw1pO8n7MFl4Qc_YeYpTCiqqgdOxyU8b-rA>
    <xmx:Gd9WagW0V9pG_t37PGsJBiupig1yczfCWnaeoDZcWZApmFJL-rsXFQ>
    <xmx:Gd9Wap83m5XTEPu30csSc9tocbO-gFA65MGU6wKr5AOfoen46fpyNQ>
    <xmx:Gt9WakSW0MITL30lqazeWo6bgmsc7_6HTqg0k55fotFXzMi7f-CdUzVx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 21:15:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 05/11] last-modified: handle repo_parse_commit() failures
In-Reply-To: <f728be4dacb0b9781ef6589a0d2c48009aa31e9e.1784069325.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Tue, 14 Jul 2026
	22:48:38 +0000")
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<f728be4dacb0b9781ef6589a0d2c48009aa31e9e.1784069325.git.gitgitgadget@gmail.com>
Date: Tue, 14 Jul 2026 18:15:01 -0700
Message-ID: <xmqqldbdqciy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Skip unparsable commits by checking the return value and
> continuing to the next iteration (or returning early in
> process_parent). This matches the defensive pattern used in other
> revision walkers such as limit_list() and get_revision_internal().
> ...
> @@ -414,12 +415,14 @@ static int last_modified_run(struct last_modified *lm)
>  		 * Otherwise, make sure that 'c' isn't reachable from anything
>  		 * in the '--not' queue.
>  		 */
> -		repo_parse_commit(lm->rev.repo, c);
> +		if (repo_parse_commit(lm->rev.repo, c))
> +			continue;

Shouldn't this be

			goto cleanup;

instead?  'n' pulled out of not_queue may be unparseable and when we
ignore it, don't we still want to clean up the active_paths slab for
commit 'c'?

>  		while ((n = prio_queue_get(&not_queue))) {
>  			struct commit_list *np;
>  
> -			repo_parse_commit(lm->rev.repo, n);
> +			if (repo_parse_commit(lm->rev.repo, n))
> +				continue;
>  
>  			for (np = n->parents; np; np = np->next) {
>  				if (!(np->item->object.flags & PARENT2)) {
