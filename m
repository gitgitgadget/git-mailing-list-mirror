Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55CE30100E
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782320309; cv=none; b=j+6MiKXNQ8yRfKYG7ip0xtoYXbFJCIaPlrUuo6VZauCTTBW8f5HjWeNoJcXydbjtibNSJgYJ8XK0Z36kW7FDh0FcxKzFuVpKyXcSIU6D/0GlvoY1bzq4dwAL6QfBDDi9jHVEwh8ZMhJeplcTrobmkvKR+jKqh8IwjOWkHJb7M/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782320309; c=relaxed/simple;
	bh=/bYjDBDztCIJOaYbfirSakluu0QNtm8ooN2ckA0mJaA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mNmIgKHanqhJfh9+aXI+Dfg4w0PSxuVyQf1wpHCyBT7c1IBT5tfMiRYEwJAakIa6s1Sj2zQlkvqftpB6Y904KlEDMTUQrbopZ/gob6IbVUNfv1tpGgU1BhOn+Neuhej17GbwJ8zoSCJhfyeS4GoAt5UR7+aXrI4WeDgFTB3IZnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=giLB/Mmd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PMjM3D8K; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="giLB/Mmd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PMjM3D8K"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 118AA1400184;
	Wed, 24 Jun 2026 12:58:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 24 Jun 2026 12:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782320307; x=1782406707; bh=YhfYeVQ1vu
	PAahwGXuec/boVQiuFWO70TyPka9fYWnI=; b=giLB/Mmd5VFCSuiqh3k4B/1gdr
	BqgGiTeUVN5uN0Ns95uK40Uqtl/bz8FRn8BtUNdqAA2WJ3efXiXOLjX7iKj4O6gl
	dwim3YnvwLCVyqqIveJj7M0YWwasMI6wxMaXvtX6Kffynhw5TK2VE/MOOQZ+4fQc
	EeP8xqmIoMYjdfUg3tYNdKMwoxNUNxsJYUM4qR6yMgcdx2FP1rffh6IBZVFP98Ge
	61Ifw32OJyltRJb7Gz6t5WzLAkxUKodmylJmk7wpaLxA/uhMidA9Q7NXj+q6xzeJ
	GVdT4IlSO581+3dN4ErsvEORzVru4gavaV1GUJNYvEsb35Ny56aQnL0txxLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782320307; x=1782406707; bh=YhfYeVQ1vuPAahwGXuec/boVQiuFWO70TyP
	ka9fYWnI=; b=PMjM3D8KdcDdqlPy64++FR7Om9EVoR4D6aYKGeefLtMQPmi6IzN
	Loj5y4RnKLzQfoq9wpxmMhE4JDNWI9DBTwjTR4Zm+Kq3ZNwiPECWrNxIWZQLduAc
	G+7gzjMBeWO6+ub70pa9zkGRh61o2l6/QgDOUPjrwTODtOPzGWyVdUEciH6NkyiS
	fZ9OPIAMCVu3DSbKx9yMfQFxkJjfVwHqTSYYdeMFrnVVSwZo+RLoEfLngUaWUESP
	ygJfY4mrVR51aYaPBcdD5tmVMuzxeo13w22LP7b4WTCUQKlrMQ5a+Uwk+EtR3ZNA
	1k7BoeXRqRCS1va0q0XrlPI/0GBkCl7NUDg==
X-ME-Sender: <xms:sgw8anEUK7N_jpt75ePV3N3Bknje7gC1-jedHRelxvlAiotPmKjqcQ>
    <xme:sgw8arwxs4X8u5mk5O0wGCL_ENJJTwsSlTmYdpjdCXzeUdZ3pQRfTvMoVLyQdp3zV
    pcqKr6TtNKWTvqZnY_e4jO323QkSwdasxKCP0dMyg6MlmMHo6e0>
X-ME-Received: <xmr:sgw8amgdyQGGQXYIQcWw1NbWoIY3ZvsJx_OAxks6wqc37-MF-rud01b-1oNwwJIva0eGEgIVk83OpF2GVY-GyU6Y9oigWhrI296TS5A>
X-ME-Proxy-Cause: dmFkZTEGLentwEXhx2K96tiorO29gEjpCWC2WWvKtxo3E4n/gv3xyldye3e7d0vjul0qBy
    HJxd6D2FC2lvZBVpAxdnS0ro/DVyEp+2TSqhzkGtMKKuuqoHQlaLPpoDUuEWAJJ0CUHqhM
    Zt6zltU3OKykGBS7VUsXD8x4B9D8zhEbU9n5Ij2Vu06aAWdpu8WNwNP2tjdsY/hnGbJ8yL
    Wpt1OlWZP+vh0cKry47BLvcI/tdXV8MuZA9VDJBj3XYgFFsShq2mQa8HBg+yS0Wm3vBb3p
    EKaiS3X/e6qq3HkLJd6OqN0JgBOon00T5Tk/IgATS8tWPsn9BiYyZ34hjrZTHSudDgFVOI
    kZs8kExkipKVfgil4VXF0gD/1nJs4qcwTOTXfh1HAdW/naf4gvnCezC9FqtAX7qiC1Jit3
    zfjuDiPgEyyHRToBwaPQFYVrDFlrEUsnx3UFTWIQhj1hSOTWTk0JhIz2wDoFztHSvJ9oF5
    2O4eGj9EoY6NZSkB8FYqaYvPyryDwypWfKtv9G0ysVr6VtuwaisEYLgjjNKnh5LwDYEtm9
    OGwNg+jTutKAzN8D5VE2lvu5jysG/7tiDFp+p+eO2HEJZ/byIOI0TOl3odzpTXTpT1daiv
    CmYVHXET/V609ITiaw/liW11VOXgHziU+deVkgDc3sJOYHwo0tbDp5Q2fXOQ
X-ME-Proxy: <xmx:sgw8aux4t6eGX93Xez7_3tNnFCAO6H0LMvZzRPZxHjbp-MU1LC9mnQ>
    <xmx:sgw8ahIAtMsx3d3bztVFcyZdIT2eKosEsqiWYy1T4hPUI_hESBMyRw>
    <xmx:sgw8atS03Sr4BIE8ZYOAHPEG5YJ9jpXe6D5pE1vNn86Mko7C8F1AGw>
    <xmx:sgw8ahqAH2rlT-SdNIp4Ppo7_CUOVXzeNDK5wVLzwm2l_hCzVY7a9A>
    <xmx:sww8avze7QUZEFN1GnIdp3lSXe8_7vXBz7sBaa8MCzF22qhoYuE--fgy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 12:58:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Antonio De Stefani <antonio.destefani08@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] gpg-interface: fix strip_cr_before_lf to only remove CR
 before LF
In-Reply-To: <20260624093618.17456-1-antonio.destefani08@gmail.com> (Antonio
	De Stefani's message of "Wed, 24 Jun 2026 11:36:18 +0200")
References: <20260624093618.17456-1-antonio.destefani08@gmail.com>
Date: Wed, 24 Jun 2026 09:58:25 -0700
Message-ID: <xmqqfr2bkh8u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Antonio De Stefani <antonio.destefani08@gmail.com> writes:

> c4adea82 (Convert CR/LF to LF in tag signatures, 2008-07-11)
> introduced CR stripping for GPG output on Windows, but intentionally
> stripped all CR characters unconditionally to "keep the code simpler",
> even though only \r\n sequences (Windows line endings) needed to be
> normalized. 2f47eae2 (Split GPG interface into its own helper library,
> 2011-09-07) moved the code into gpg-interface.c, and 29b31577 (ssh
> signing: add ssh key format and signing code, 2021-09-10) extracted
> it into the remove_cr_after() helper when adding SSH signing support.
>
> The original laziness was safe at the time because lone CR characters
> are not expected in GPG signature output. However, the NEEDSWORK
> comment left by a previous reader correctly identified that only
> \r\n pairs should be stripped, not lone \r characters.
>
> Fix the loop to skip \r only when immediately followed by \n, keeping
> lone trailing CR characters intact. Rename the function to
> strip_cr_before_lf to reflect its corrected behavior, and update
> both call sites and their comments accordingly.
>
> Signed-off-by: Antonio De Stefani <antonio.destefani08@gmail.com>
> ---
>  gpg-interface.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)

Looking good.  Will queue. Thanks.
