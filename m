Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE37369D65
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 23:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780357432; cv=none; b=VtY2Jfrwo5na7edBoCevunD72AxWKj5gPQGNt8vX8wXS1D/umlBhZ16qlBefgWRw08pKLezwIXcsJB9BfW1CoR5niHj3jxTqnDQT54DsZuqoY8JYktwC+MM5XDQUei/cOTATJhG+1mzuc4mpuiAWGpwMmlFHFUHNPjM6yhjFFXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780357432; c=relaxed/simple;
	bh=wZ2jmUkumkVqluAgklF+Br/xCWiDnMEJPTf4qANnnMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tw/tHpPn/l/3MmO+G6ar6cNKx3S2GN2ApAa8VwsX/xk+eOQa/miLgOZg10/vMNQ6cYHE27Oay2dGsM/vRn9CvoFM9/NbbKo031Ao39bgXXnPzhopRRVw5NcurGIcRSc+lLNSgdzRo5UJ4+Ugx9EL6DZUJJsHsP5mw9KLzaPx20I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GubaYbR1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jzxn0tKN; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GubaYbR1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jzxn0tKN"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8AD487A00C3;
	Mon,  1 Jun 2026 19:43:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 19:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780357430; x=1780443830; bh=Z6oa//91cJ
	gFk+kPyrVfnzYO/KrYGkLYeBa1oN0UByY=; b=GubaYbR19a8nTmIJ+w9uPQnU/k
	xRqPF3proOogVZJ1HeytlsFhNIb1e4LhTORcurQqcn0wvuhusRaM/Fkv+cnNAT4j
	53Qk+yRIVG1qQrcUXWxabWD1cwNWwK9jRzoaovAwUM9AqaA534lGo/FGubOVmWSS
	X2rOR8y4zGM/7MWRyzt42B5ixl40fIY/1qYipbHyDLRLUrnrZzg6zTRXV8w+K042
	3pVaW7joD/+LhPVaXYELg0DBZey6K6+Hx5Go3jr+oLwG7twrz6jJTeHPJZW5oIRP
	QV1N38CelITVv+PM+M+GMgaeoxMTRpeX9LBLYPmdvPl+ZoqjTk2KSIjcjctQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780357430; x=1780443830; bh=Z6oa//91cJgFk+kPyrVfnzYO/KrYGkLYeBa
	1oN0UByY=; b=Jzxn0tKNpmDGk2evpbyEDu8KvceoryrTw4u3hIxG3+Brzv4f1pd
	Wrx4XR63RWXZs0chrP1n+lskfeiyn9oHEXk116ao8dKnFyWccbfPgZvuObT4ELGV
	XbYwAns4Rqn6/x8YSRzFYlSh6g8WHRwC+Un7vT/OglaUTgyaspGOB7lv+mKm1HXS
	n9TdnA6q3Ov92zbMsuPTpqm0GTEiSBHVeF0qamUDDJywlMw93xMlcDMqGBeZdzNB
	OcU/j0rkMLqvz+gxkIN440skygzEHmw6wLS/zIWOv4TL/iytJ+tmg3oYAFQmCg6a
	krWP/BP6NsF0uBZ2VoirBlBzUVEvVXEpo+A==
X-ME-Sender: <xms:Nhkeai50-MDzj2HZSUpPAqTzpWOTDRb5e-awiEs-XuSqA1_6TPhb8g>
    <xme:NhkeajXDZBJeUDtCfKUdPF8CO5tceXeDKxvFU7P95ND_oboQ58LjCFsNwXMeW3Jj9
    uPwSbEqcOaXMbsc8kp_n5LwqB9Qt90Rfl7BXx1nIGSH7syQ4qIHuQ>
X-ME-Received: <xmr:Nhkeau3DonsW_ErS3b_48kdX27puYXLMT-ZO8MlRwgSlj4u193uMoVnlMXh-rIvdVFBUTdrGL2rxCb6yKEG6OqROyyXBAT37Q_Tx>
X-ME-Proxy-Cause: dmFkZTFwk/sFl0comeeXUsOLDXynua7yNiQfZyIeH+s43ZwbP5McZoVzIMSlwym0iQ/+HG
    wMpnTlg0C7Wa3vNdsaWlKmvgEWMt+FkZdus6t5BOVdXD9anLT3kxKoRmAJ8e5rVG1dqB2w
    T/fmPuq3CAkNIgQSmw5jYfSiAtLPqRUxB8D4Xn1JIRawYtXZUER7TAhtc0+ornT5awElz0
    yKDnyTpTvlTAr7B9G10MXks37HBARkj6OGz0fpTyizuP7rCKei3sECEzWNBBe3D4QpqB+1
    GcaWq12LuWjrPMirWEukVZOFjI5jrwtO9FDqYaLf09gjCNzV/vB1rtG0N7S3Bdzv/uBxPq
    LBpv09MG5yzJkZpEKP22xPX4vzTU+rKCWs10/+3MQIM2r29kRy0W5KVVlfGodk3/SBw0G7
    LhTejw/ILvYxcKheQ+DcuZHr7TB0XwanpukgQ8OarbydtctQQzD/R/4xaDKsAFNC0uQfyd
    okELXAgt/ptIhQDAq347UwbAZ308OABK2PvZ6x+Hh4fnrvbWpQsfds3p6KIdAQykI5jvY6
    Z1FXK+9GrJ8BrFWYzN/cVixeK/6wESdVKOcHPEEdh7x8ky0L9kIcqusf16CSL1gtUACRYh
    Oiwut5vdO9UlnTLLi7j8Na3c4Y2x7d6NOKlyUrgq556+4Ng4wtibdXLmXDlg
X-ME-Proxy: <xmx:Nhkeao3dmu1onTz_-4DU9afqYmsvjyUnQNmc0RyKuqbVKAK7mZMlow>
    <xmx:Nhkeap9-WjyGj_FwhUttoo1v-Gxf5NkjP_4LMJDKMrJaina4EY3XKQ>
    <xmx:Nhkeat1EcKfHGsfyKcnGHkFTK5DBcj5em4CcPFStlU2zQzy3aPUk8w>
    <xmx:Nhkeau_pOrgkOspZy6FjTa6M3sb0-KLc9oUpIsps3L1uf0-T4_AeeQ>
    <xmx:NhkearfvUlJqzb48J8J05dHs6vr9MRAhdJhWaWPBsoNUadyEcL6wp1wK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 19:43:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] builtin/history: implement "drop" subcommand
In-Reply-To: <20260601-b4-pks-history-drop-v1-2-643e32340d55@pks.im> (Patrick
	Steinhardt's message of "Mon, 01 Jun 2026 17:36:14 +0200")
References: <20260601-b4-pks-history-drop-v1-0-643e32340d55@pks.im>
	<20260601-b4-pks-history-drop-v1-2-643e32340d55@pks.im>
Date: Tue, 02 Jun 2026 08:43:48 +0900
Message-ID: <xmqqbjdt25e3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> A common operation when editing the commit history is to drop a specific
> commit from the history entirely, but this operation is not currently
> covered by git-history(1).
>
> A couple of noteworthy bits:
>
>   - This is the first git-history(1) command that will ultimately result
>     in changes to both the index and the working tree. We thus have to
>     add logic to merge resulting changes into those.
>
>   - It is still not possible to replay merge commits, so this limitation
>     is inherited for the new "drop" command.
>
>   - For now we refuse to drop root commits. While we _can_ indeed drop
>     root commits in the general case, there are edge cases where the
>     resulting history would become completely empty. This is thus left
>     to a subsequent patch series.
>
> Other than that, most of the logic is rather straight-forward as we can
> continue to build on the preexisting logic in git-history(1) for most of
> the part.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> ...
> +static int update_worktree(struct repository *repo,
> +			   const struct commit *old_head,
> +			   const struct commit *new_head,
> +			   bool dry_run)
> +{
> +...
> +
> +out:
> +	clear_unpack_trees_porcelain(&opts);
> +	rollback_lock_file(&lock);
> +	release_index(&index);
> +	free(desc_buf[0]);
> +	free(desc_buf[1]);
> +	return ret;
> +}

The function looks very familiar---anybody who wants to perform
"checkout <other-commit>" needs to do exactly the above.  It is a
bit surprising and disappointing that this topic needs to *invent*
its own helper function and carry it as a file-scope static.

> +	if (head_moves && update_worktree(repo, old_head, new_head, false) < 0) {
> +		ret = error(_("failed to update working tree; "
> +			      "run `git checkout HEAD` to sync"));
> +		goto out;
> +	}

This is minor, but unlike in documentation pages written in AsciiDoc, we do
not do backticks for literals in our error messages, I think.
