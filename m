Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DE0385D86
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277250; cv=none; b=qmBwIsbxyZOe+Kyx7miwEW5KsrYuP/BH+zy00laWXG1zOeA9lS4kOerazmhPayB915YX7e7wRwu4BolMcFBPFPBu7T8Cn0ADQSTHxljQaI5zipodwqlAA/JbHpsm06gmBJdVbzo75tFyXaZsVjttytFpqo/0EYZMST/AQqLF5mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277250; c=relaxed/simple;
	bh=IpfnOehmzVgmRC4Okz03MjQy/b6cXD9RQHUvMqsn9bM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MMP0jyFTzoPewHJodmYCAi+kUFOP4hpOMSP/j6Pd1eJdx6KEEbPsLzvhpiDp9NUUjQbCw1VU4Eje93ikQQfXcNxwB4dbFlnITAqE7iAFbAvDMScI6RTL1TBHe3ABLMM5fWXXHQRpI7732O7gCgc4N/WIP33u6+TDFtZ1CRsfYrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k06Pvi1O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SyvIQ7iv; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k06Pvi1O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SyvIQ7iv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 214761D00195;
	Fri, 12 Jun 2026 11:14:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 12 Jun 2026 11:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781277247; x=1781363647; bh=AFFWlrsQ3c
	hwrwYChLPV3afEKEXfE1dKBjIdcWTqO7c=; b=k06Pvi1ORNI3jKsaSB2xNJLH1O
	Dd+z5zKAqF+HKSr05728RS8Mgq4nPLrcVovzIvGmtWgXHhUIuKZbm3hDDzEZzzBE
	DVWnUyGMsgMlwCEpDyNIsBuxedaevuSQ+bmlCx/JfgGbCaWv2vI8/NXFRGoxbHUu
	LtlpuVQgZXO2INr/R74QDLrSxGZl+tSRKoCa8lOP1Wr3I7ncCjhlwWPhIseC4ixv
	ewajPFdQEfpagUukHNCUxIRiVtLvgiKPva5QwjR7/pfUm6prPpU4ff9l1I1npdf5
	T/UootevvVfVTk8FZsS8Q2/WXaYHYOSHXr72gUdaI2D3t/U31zrbYnoYyWzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781277247; x=1781363647; bh=AFFWlrsQ3chwrwYChLPV3afEKEXfE1dKBjI
	dcWTqO7c=; b=SyvIQ7ivmmXWVewGfOIqZmosiScQtjTutrgdlEgtI1sZPXgzNFV
	HsBDGSbRvokuPC7y97nEHl9o+8naDiLndKABsOF7IXNZXJO4jjRnOTs6PwhD7WH5
	wDVyas9CWRoQ6IkdeLUdip+CL9U4WgvPxDH7YfUWPE2MEtaNlVHJQy6Yyq036lxt
	gnMAiVIPEODWwhHWLwyHBQ8VaYwCNyoDQhCR/c1LnFJEHWzOnDwFRlbu74S+1GzE
	ZMHshI1b9U/Y//dtk4W41/XsySkRZz4kK/pNfZqiJEVrwsJ2cG5Og0zjJCQNdcad
	cn011TI7ASmD/RcfwcjPt62vXp/8j6yS8jA==
X-ME-Sender: <xms:PyIsaq-bwK1HHAPfjGQEuSTthRE64Kadm50ewqwpoi1HrWlIZrlXng>
    <xme:PyIsaiJ7BwAwUnmM620b5iL1S5Nmp13rif_3yhgqgeDyksuxGwtw0yHxCVCNTLy-f
    y9vJLeLeyPCwoGX4k-3GzSfFrob6Ma3pcKSJQoUa3qFXxp-pSVfTw>
X-ME-Received: <xmr:PyIsatYBpu9fcOWJiJ76PpQZNGamvN6aaLvhMATWkL2pECpa87cjOBj9YbkGt9H0IzF_0QBFGw2nPPdLWMzR2R21mDYy-Qr8sFSI>
X-ME-Proxy-Cause: dmFkZTGs9RoehxB8VNmHoMkqrk3r6K4ER1B/Z5ocR7G46jvoBQIBUdiObOCPwKFG91OaHW
    JtqBLf9Fq+cJ0uMIBbAJWFG/HcDDrvFxxslhGTzRUvIu2AY7W8b50dzRDzzEAXyO6CcPbo
    Qvo4yvzdnqEqaCgwOno86LUr/t4oe6LK+k+ecDrPzhPjdncG4GLb2R2xIBs9f/Ocd5STne
    adtrwU0o8KAur/DNYIMoBXVnQnjJRk/cabEoSHaQMP0XG6aBa4oiX1KTmXQRDlmED2sn9W
    ZcG308W+X76ghFrUfZXegS8fh/NVb1KsijPpKs069HOkQWfypb+4NI8PRg0maiBnbaocWw
    Eo4Az0qgxfm3id3+To/Xz9MZWhBngbSOhuipFqzrn4NwxUC5ZPRSW0vBA7LOCG9HmPKQ6C
    vVCDeSociNbb35BrcucYo8mj0JERej0xZT7qBQVY+NwAcFlGnvSs8GNszwDmtEUoCTl5QW
    wigqrCEnJVmvogdEgvK8gvxD2cim2JgRcg5+KTXGfPJXYA/baEMeNOSmo5Uam1KK0O1cyY
    CXMuBI2Ne+I4D+c7rvzOeLjzmSQKlqca0aqhIK88XmOCeFAMBuf3w2JXfyULI9D8YLdJcM
    PFaA0uLQCVLNryDeBcz0Zhl2IwLN3x4fC4KQiWWMLl3Gu/C/+eEieacl9VgA
X-ME-Proxy: <xmx:PyIsasKPZ11xJeoErQlbNu-SQjxXUL_whq0-30r6gTh-8JwoG45b6g>
    <xmx:PyIsajD9ef3N12pBQDLyIP8idGgPjffzhTWJFzkEK3m2A3BQPBPhgQ>
    <xmx:PyIsappuO5knFHdzfijtwGg7zXGsejW_H2GZLdFPAM4kuBfppsY7uQ>
    <xmx:PyIsamh9d5PzlQX3b_srPn0ZB3mgu9Zwmsp_a1hovLNQyXFeCvLTSQ>
    <xmx:PyIsas2yjLY1IeWhyIQ8rIYn0oveNwGwiyYbVEuP0hapglXyuYL8k-iw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 11:14:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.55.0-rc0
In-Reply-To: <065e01dcfa75$ade00690$09a013b0$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Fri, 12 Jun 2026 10:13:39
	-0400")
References: <xmqqik7pqeiq.fsf@gitster.g>
	<065e01dcfa75$ade00690$09a013b0$@nexbridge.com>
Date: Fri, 12 Jun 2026 08:14:05 -0700
Message-ID: <xmqqzf0zhjuq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

<rsbecker@nexbridge.com> writes:

> On June 11, 2026 11:32 AM, Junio wrote:
>> An early preview release Git v2.55.0-rc0 is now available for testing at the usual
>> places.  It is comprised of 397 non-merge commits since v2.54.0, contributed by
>> 70 people, 22 of which are new faces [*].
>
> Cargo is not available everywhere. Build is not possible on NonStop.
>
> cargo build  --release
> /usr/coreutils/bin/bash: cargo: command not found
> Makefile:3021: recipe for target 'target/release/libgitcore.a' failed
> make: *** [target/release/libgitcore.a] Error 127
>
> Is there a way around this?

I see this in the Makefile that you may or may not have read.  Does
it work?

# Define NO_RUST if you want to disable features and subsystems written in Rust
# from being compiled into Git. For now, Rust is still an optional feature of
# the build process. With Git 3.0 though, Rust will always be enabled.
