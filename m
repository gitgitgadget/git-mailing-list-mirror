Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF713921ED
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 22:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787350860; cv=none; b=MO6sm5XZ7vncaMXSe+9N5nIplQrkjgoWYB5ALG9uaEkxQrVZNRhsCp8XxNKdDymqIBDgzVzNwN9iLePRAR1id4KJtZWAlWoNGEI0gpvB6KDbjbMhNi9f0GBNpCksZoA/6lPO8lKNspteVXa2pmxVPiOj2OHnx8AnHYFFNaiENQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787350860; c=relaxed/simple;
	bh=y+BA/hqdwhQednaRW7R3uWGQXl8cHxmlx4ZONHybUIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t6S9qZW3xFSrPnm7HGSDOVXltbr1+Zj3JPgSEMbzvPIESZCcpsUZ531jCkoRIuW6sJ5b09H/7A0MK1N7/FkiZs5eN92fkGUG9fdGXJ9jS8MqnqFjoBqllKJDvHVDuwV9g8xQaMk7GGEod7CVm/IUgnu1pAJn9U5mY8AG0BY83fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hDodSq84; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZhGsv6RO; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hDodSq84";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZhGsv6RO"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 63B0A1D0011C;
	Fri, 21 Aug 2026 18:20:58 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 21 Aug 2026 18:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787350858; x=1787437258; bh=j9lzL4f6pP
	ZoaW/yOOQfQMQg3iam35iP7eZ3WkwHjis=; b=hDodSq84gJB7YVwGJB3BknjTm/
	umkEYezkNzseLMmX8vEcCOhF8b526d7G7IcgYX3co0O5czNVbA4cjRekTF4cZejU
	WOY4QfIc4i2pOwoCD8BEgGIt+Fc4o7Cibchwc2XwXzrmHeDXXIl7zhgIdopeh9Qu
	rn9inTa3s4pVXCSx7KuK+lUBy8Ilx7ZPPLbhAoOpxKOKTMMxqLWhfYrenpmAwoBa
	plUu7azAdmZnyzuGMuZzqY+16Xhrgr7Q9m6hGlGzCQVT1ccorO3/V1q75WjjwT2K
	YhQ+hglK4ooni7ENLSapX7vSW3b5naK2Lf2pUwty//iqWWGkT9zAm5KCgK7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787350858; x=1787437258; bh=j9lzL4f6pPZoaW/yOOQfQMQg3iam35iP7eZ
	3WkwHjis=; b=ZhGsv6RODtFNNUx8KAdkctI14pZ1ayUiXGE3u0AGFeQLnwgry9+
	/IEg6zWvXsNFemXA6Sk+MFhrdVlkVjB+PHjzVlUX56fA33VtVSQyThkS1oU9eM8m
	ynryESuJ6Q9pMt6syxRDKa9HiuzPdWh21aN8SyMS7EaBRiHOtIIKJh5Mhbbu5vyF
	NCH6M5oC21Q43X20hEppwv7yzYwt4zl//A8T+nFcs1pJk+X8bpmoZVGSA50rzuae
	hrcTIwZPmeFxZv9WwL1EKUYTRGvkKTngE4Di19cXk5smW7/cPa0BHWrhKFrRd/4H
	HMsGYGjdK2L6AK0cZbM2dK/xchyIBpxDQyQ==
X-ME-Sender: <xms:Ss-Iaogn3uqkjhWTL6TGqbyLgSof74DDzioy4a3weziFPgGWBdaTVA>
    <xme:Ss-IaoDFqVyQWgi1yIrx5RlYGSHlEP9sNZjjjT_zGjB5_rIfGXBf_JwpT3JyDBaX1
    lgh3DvKYUFXAVsSJcMKUGR7qdT6JeLLSa2jgAGWqyrbjg0hE3Hu21k>
X-ME-Received: <xmr:Ss-IalElpHuV0nguKE4IR_-X4nJvOU3URwKj9SaSxj0bmUV1VKGeofDQBTarLATKdbUPKlrlZtgn88q4b0JZ0BCaY7SJbXnfig>
X-ME-Proxy-Cause: dmFkZTFuD3asiKNe9R0gIDKK8Yx6I+gEWIb5JunutWwbCz9LVvysZZwwYmz76mxrSEkQft
    OR1NnnrsrpM1Z0rphS0MxTV1F4VhxMrNJWLQ+EbOLybma636lKwGaS2xYwABMhDfUj8Oys
    RP1NNc2JXtLQygjxFfuI2rsGvO7VW2wfLAw53XfZWstSwq4H3q2mLBfPJUHxTGO7eSSGdY
    U06B51vjdbQO2uSoJt67STszswcNaQo9C6SSi5I6xb2tOoCgyuwZFvXx1TOypvFCH8Qwhd
    16Yp+O7PGkZ5DX82/hT8X+Ozk2N/v+oKi1ZabbaYs25WAmQZXq64niiQs1cew/FliA1SMW
    7VG12jEz0/WjDGy2HG1cUOM9+k3EnoOe4lacU4UPwDNfVbfcx+Bezp1+Eispnjh4CG+XBi
    Nnhpd1n1CWNHhCSztoROV9hBulwPRtS0kb1puUEFJpf5B+Y27ocvPAP+TlA1RSzcd/uKFg
    RthkAM/gDJGS+1MQzvwGzqcShfgAF/NMOMEY82w3X+rkjWxWtb49px32RZrpkEaoSNHu7o
    bk1DDXPEwHwKkie2WEmftzI34auLxMi5CNYZuo20ZmEy1NkcvmiViM67Rqj0IG1QJj/MH7
    1aYNe3RuZP46SsemWpY+Y5011mtPALM7WlAjqu4sq4cK6nzJhje1eLYBIyyQ
X-ME-Proxy: <xmx:Ss-IaoK3NpxNyHsv4gtlCj7dsSHvn45jUR1kMX0mvcWT7yJnkrf-sg>
    <xmx:Ss-IahkkREH-OweOIZHEDJ3tNFdYpnGmyBETVxSg3ZKHAC-oPINJDg>
    <xmx:Ss-IaoQiFEYqCrl6NzYAEoRiAOqwoistachMOWvHocnctjWPMTwVkQ>
    <xmx:Ss-IarJdML95inP6FvH09nybHWy1u_DayP2oZqRo8_JkvvX4Eu9nNQ>
    <xmx:Ss-Iasm6-8QIABSvUNoEJJZ0ZCJQ4N7yWnGJ-y39_WrsxjbNZPIeMHIk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 18:20:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Yoichi Nakayama <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH v3] worktree repair: detect relative path in .git file
 correctly
In-Reply-To: <xmqq8q5zyvwd.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	21 Aug 2026 15:02:42 -0700")
References: <pull.2205.git.1786799480344.gitgitgadget@gmail.com>
	<pull.2205.v3.git.1787344586470.gitgitgadget@gmail.com>
	<xmqq8q5zyvwd.fsf@gitster.g>
Date: Fri, 21 Aug 2026 15:20:56 -0700
Message-ID: <xmqq4ignyv1z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Among these three, the last one obviously belongs here.  Leaving the
> relative path relative was the reason why we wanted to add
> read_gitfile_raw() in the first place.
>
> But moving the other two to here is a bit iffy.  The worktree repair
> job used to call read_gitfile_gently(), which means it used to
> depend on what the first two did for it, namely, to make the
> relative path after "gitdir:" from the .git file relative to the
> current process to make it usable, and to ensure that the directory
> pointed at by .git is indeed a git directory.  Is it correct to drop
> these from the caller, which now calls read_gitfile_raw() instead?
>
> IOW, I am not sure if the two functions are split correctly.  I
> expected that the only two things read_gitfile_gently() would do
> after read_gitfile_raw() are (1) upon error, jump to cleanup_return,
> and (2) otherwise call strbuf_realpath().

Actually, I take half of that back.  If we pretend the leading part
of the "path", which could be absolute, the result will lose the
relative-ness of the original.  Keeping the tweaking of the relative
path in read_gitfile_gently() is reasonable.  As is_git_directory()
needs to be called on a usable path, if the relative path tweaking
cannot be done inside read_gitfile_raw(), it cannot check if the
directory is is_git_directory(), either.

So, the change to setup.c is fine as is.  I didn't look at the
changes to worktree.c, though.

Thanks.
