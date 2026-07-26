Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E39A345749
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785098533; cv=none; b=XEoPZTvoK1x/jkC/3Wipj53kbgBB61G8o1lSgkTyBHsU4jcRNGG3ucG4geGGSZszpBhwGfEKNu5J+cce2guAwTVxjPHQWoeUzem3oou78+1ioRkF8MRnG0bfvC3Cb8lznDDLTREIKv9uYhCoiULadW1/LGg9NydYEpZ1bq1Sl+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785098533; c=relaxed/simple;
	bh=u2BlG8Lh1VN37+NSXLVcVB+iEOzRHAmjWg4GU5p5plI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wujj7Eh9HEayaqQ3h+WUSwQSlm66IFI9QHyI3Ihl83MRfJbMlXAvubF0vdv148UB5P69cHble9V/Eqa2FrnK/d5bf74ZQIAPhJqA7qXPLQFjKWqpNZ6/M7bqePflbNvWJWt0hxI3kjp0sIT6GPEhkxyOCpuyWPLQEADFtulnsuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fmFwQKIV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lRUJb0YL; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fmFwQKIV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lRUJb0YL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A48314003D0;
	Sun, 26 Jul 2026 16:42:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 26 Jul 2026 16:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785098531; x=1785184931; bh=+WGQNzyUDT
	NzIj84ttb9Ner1kTL39+19tbmg+GUBJjI=; b=fmFwQKIV5AF2y4YkAyoiKikAJe
	H7BVPLq8sheF4kf4G015vlus87TkmoZsXiRXXhc5Cq3EXzzXFkfqUUVG62yxfcnd
	Qb5ExsgRUbjNquvYyvVJ7yzwgdxVylEhISyxhfUD++9sra3ADBb8AzvKwWHBOwCI
	nTzhBtj1ltZyI5Gcxq0o9pJw2RmJ59omKUGbmeU4zamGcJYW8BbG8PyQS2tlLrcp
	gpwVyDp7CghZhFwImNtyw5a01UCE3ZPhu5Uwb1dMZewJ8wc8g0JrhD0VU3Q/mDNH
	f7XvbAJoyDv7X+Ox2VeRKvHHkNPn1OsxUE3utv8Csr2LUvdvxfMPJBrL+G6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785098531; x=1785184931; bh=+WGQNzyUDTNzIj84ttb9Ner1kTL39+19tbm
	g+GUBJjI=; b=lRUJb0YLXi8QPX80v4BV5n9yYkGpf2lNwk4pykyhGApTWeLA5MY
	OJQH4oJOCrfhecu8mObIyxo7fl/NBgv81IOGow933PFuRImea9x3AtgzONyh2MTX
	0heHLKAV/o7f4arh4o7pA/+DSaZYwIr22JiF36eMvYEbkZQHZheTt/oqC9CztO+z
	WWqzYpNxiuTITfPfYb6eTCOP+AI8lboLJt3oEqZV3YnVWw6ibggv+4BHS+WIJGh8
	H8UOqT1Lcq9rGaaMNXa6iVKfIi69qvlyxTeOvaG77ZCUvcO8RO5V1Zq5+JPxLYY8
	7nJ6AOVsgz0HlimLi2MRANAUybWFd4NJAEw==
X-ME-Sender: <xms:I3Fmamk2uSWjZ9Mrxe41vGhe37X2Nsyy7b79OHOvz6eltZIbQhzxcg>
    <xme:I3FmalR4XF-0OzSlABXdVzIxXdVvvP-pWdGLEaBgNxQlUfiRcCQjFro2JRsILUUzE
    xPQ8kjkPC5yczC1QUXYEaDZK3xHTLoAiFwX85jlpj70TzBtlv-Xhg>
X-ME-Received: <xmr:I3FmaiC8aKhrfBq01OAF_mV3MN7-cpyKWO5wryBUivOlnEdnNXSwWK0XoSNhatD6w2rO6ju-vjPVYAdHLI-v4azRWVHnSvlmYw>
X-ME-Proxy-Cause: dmFkZTFv4oLlmnZ78OifoMaq+W294QPPTQWB2ID63NXcR5KELm2UyS9gcbkkCsFXr+rmNp
    8QLibg2BBT1QL6qr2/2Kr9ChTg8I3jnnRZPq7sfYsRHjmSgfzmDsoAiyOP5o8ijwSj8N7s
    n73rSTUpVkoLlkQdcs47WCJWhKDwDYv3WOkLH8Gajd4qfZxYjRNXSqA+ky78hikN+HhXug
    Nc9Tae9XbVbiVSmz6c7rjGTrO7pLhzTfu96xr6iS6VbWC4QfNx2nfbvUFMGqVDp6CGnvev
    mlB2U+Cppz/tucoTEy+q+dTKXwaP9WvNOK0yp6jtHNDeJZJRj2KmeK3UiBhMdR4DznmHIw
    sdpx8Wu6X2jDAn4WQmKJ4fLrlxt8yJ50vto2hcVRLUPShJPWAdYcA/mGxwQirKUlQ5oQfv
    c8zbkEaQQNSobYFXXyQICkjs1ZPntOm9R4U9Q8oiHcZ0PoTyE2Yuoo+2TuG7YvKrcigrfc
    xkI1IaXc331UITVf8kJq786c4vybQeQHj0q/LsRVtz6AGVOk20XigJzI4qspK2+4SNDWQH
    tv2yawMckV3Cwf6XPj6pTU0wa5CwPkxet/kxr27vTHMG9pf3FPqwLDqVfoTm2Vnpr48mIq
    M6zNixCY8BXRYqnfKUkpjJrxIZnz09+jHk9n3Bf7P6Ts61fTECPGQQpR8SfQ
X-ME-Proxy: <xmx:I3FmakRd5-OZC8z8dXT7i_eIGZV3Q90jOKZuoybolNbrpQ4zvsNQcw>
    <xmx:I3FmaopJX0R79cFtEYv8REbcTGmJr7aVvlVAF0XGFvEvRa-Tp4IYBg>
    <xmx:I3FmauzMbTo4fuUmO8fpoR8Fa0IS6pbNuZjTgxT7_pfnFQZMUB0waQ>
    <xmx:I3FmalJSP4b8L1gEykekFi3sWYsUgnLuXMJmkdMKyIKxFDp7EduYJw>
    <xmx:I3Fmalag_pgQa_fKkqN82R0DsY1ga2otvcrNtACWA7YudGrtyYl9qP81>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Jul 2026 16:42:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] odb: make creation of on-disk structures pluggable
In-Reply-To: <20260724-pks-odb-create-on-disk-v1-5-3b3d265d979b@pks.im>
	(Patrick Steinhardt's message of "Fri, 24 Jul 2026 05:48:44 +0200")
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
	<20260724-pks-odb-create-on-disk-v1-5-3b3d265d979b@pks.im>
Date: Sun, 26 Jul 2026 13:42:09 -0700
Message-ID: <xmqqbjbtv5y6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Note that there is one exception though: the "objects" directory must
> exist in a repository regardless of which backend is in use. If it
> doesn't exist then the repository is not treated as a Git repository at
> all. Consequently, we create this directory regardless of the backend.

Very good thing to leave a note in the log message for.

Perhaps in Git 4.0 ;-)

> @@ -271,6 +289,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
>  
>  	files->base.free = odb_source_files_free;
>  	files->base.close = odb_source_files_close;
> +	files->base.create_on_disk = odb_source_files_create_on_disk;
>  	files->base.prepare = odb_source_files_prepare;
>  	files->base.read_object_info = odb_source_files_read_object_info;
>  	files->base.read_object_stream = odb_source_files_read_object_stream;

If we are going to write a brand new object backing store that does
not use an on-disk filesystem (or a network filesystem, for that
matter) but still requires some sort of "initialization", for
example, an object database in the cloud that needs provisioning
before its first use, would this virtual function be the ideal place
to do so?

I wonder if we can give it a name better suited to its purpose by
moving away from the '_on_disk' suffix.

