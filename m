Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97491C0DF8
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711818373; cv=none; b=OvmjYV0dANj9TWCrWGbSwDNGmiXXl+TLqYEmg9sSh548rOZzbvQCEaAUzusYkXB7ftU2wtW7L1ogKVBssVutwRtrysYKW6PMfHjljUZ5fHs1lvpSbMgbNjigPWjzaqamlD0jxvc4dh0xdVzA6T5KrIPGzQipLFaZ79hZnwciKVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711818373; c=relaxed/simple;
	bh=a/ln5bI1kEJ9bLuHeTqhk35sKxTETpNPoP2bNa4YPXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jwovGVh51iSlMmw1Wrj55C1tzgfbCZkHRjq4F6TKn8+0tSDT1hYwr+agDwzgLRDfqEK5BcXrMrVSE3GdlxC0X6aVjsiKhK4zYqLefquYlnxIec5bLwsSBesTYh5r81FmVaPaetS5UQJBXtHox9M+HmRz0SgcaMXPS8aQHmgdeqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=o5lvGQcx; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o5lvGQcx"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CFE931D4BD8;
	Sat, 30 Mar 2024 13:06:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=a/ln5bI1kEJ9
	bLuHeTqhk35sKxTETpNPoP2bNa4YPXo=; b=o5lvGQcxNNfP5Ke+na4LVdOnYc2m
	qHWBZG9xjpd0pA+8XnF7Ga9Aif0e54H0DgllDtUll7CW4zQcbYSY0CqQwn3zk23f
	OBMDAUombKg55ykEw0BQYO891ZkGZW/upU1xywDvjH5vT/L3d1JD/xNGOgMxBHUZ
	D4mJqeeUB/E1D1g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C62AE1D4BD7;
	Sat, 30 Mar 2024 13:06:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 370AF1D4BD6;
	Sat, 30 Mar 2024 13:06:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Git List
 <git@vger.kernel.org>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] improve interactive-patch
In-Reply-To: <c19f444c-f4ad-497b-a82d-4f6195b44fce@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 29 Mar 2024 20:26:04 +0100")
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
	<6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
	<59f19783-a663-449d-a1ef-3a9ebc43cc59@gmail.com>
	<xmqq5xx9dn6q.fsf@gitster.g>
	<eabf30e0-091e-475a-b59f-16b1091763ed@gmail.com>
	<xmqqcyrgajrp.fsf@gitster.g>
	<c19f444c-f4ad-497b-a82d-4f6195b44fce@gmail.com>
Date: Sat, 30 Mar 2024 10:06:00 -0700
Message-ID: <xmqqsf07lkef.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 C9853C6A-EEB7-11EE-A104-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> I do not plan to address this in this series, but while the topic is
> warm;  Perhaps?:
>
> --- >8 ---
> @@ -1450,7 +1451,7 @@ static int patch_update_file(struct add_p_state *=
s,
>  		if (file_diff->hunk_nr) {
>  			if (rendered_hunk_index !=3D hunk_index) {
>  				render_hunk(s, hunk, 0, colored, &s->buf);
> -				fputs(s->buf.buf, stdout);
> +				fputs_to_pager(s->buf.buf);
>  				rendered_hunk_index =3D hunk_index;
>  			}

For this particular application, such a "I have the whole thing in
core, send it to the pater" API might be sufficient, but it may not
be usable if the existing code sends its output in pieces already.

I was envisioning an API more along the lines of

	/*
	 * pager control data structure
	 */
	struct pager_control;

	/*
	 * Start a pager, from now on, what we write to our fd #0
	 * and stdout are fed to the pager.  The function returns
	 * 0 on success, or -1 on failure.
	 */
	int redirect_fd_to_pager(struct pager_control *);

	/*
	 * We have written everything we want to write to the
	 * pager.  Tell the pager that we are done.  Wait until
	 * the end-user quits the pager and then give us control
	 * back.  The fd #0 and stdout are restored.
	 */
	int wait_for_pager(struct pager_control *);

so that any subpart of existing code can be enclosed inside the two
calls, keep writing to fd#0/stdout as before, and we'd page only
that part of the output from the program without changing anything
else.
