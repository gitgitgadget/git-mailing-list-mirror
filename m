Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC162379EC8
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 20:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787862529; cv=none; b=gRblQh+7p2Cn1S91TgERKj8Xxoysx6ILSce4KmGTHQRpoGvLdk2/omtq/oUcBgsiEsgs+7VI+mCXI57ywLgSSo3h8JdLz+yZ+wyhZG8gFPSCWQOuz47xd1eektNIaQFvQJJ5dp+L5gSaxJOUXYqH6IekfXcr5ALJw6Xafllhz6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787862529; c=relaxed/simple;
	bh=0VSYaHposUdaVXjf6RRmKcXP+9jy8qBxtG3JDm55DbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U3qxlt/CT3qpUI+pQYoP5D+tCKdt1As+w51fznCo4LdAXCVlyvG/1k0bzlaoKk+yZ/0DKUfpn1XODPAL416HZRmvFmWYOSVIP0pyYywWyFa+GL0toThr21mc6jm172Z02jAOAnqVNSh3ifiTnfw62DGjKCRCyOc4tSbUD5+R1C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RiIU9baC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lia9SNQ8; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RiIU9baC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lia9SNQ8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 34375EC0100;
	Thu, 27 Aug 2026 16:28:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 27 Aug 2026 16:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787862525; x=1787948925; bh=O/7i1E4lpS
	zeozKYNRa08E31U1ecUmVrHqoE9/Teyuo=; b=RiIU9baCow9rL9R2XLjMCXI5nn
	TtLlUOUVVg2n06qVt0ApX9qAx6LEM2SGobmKwKrjZyz2pvN9A2MKVWGGuRjkDow4
	2DjF45QJadNv09dzrGRRyyva8QTYWzpAKSBRzAlABFf5MTJwRduCDKXwk0Hbbx7h
	GUzn3nBQq6CqZlCANyIgpKZoaAV/x6i0fmOIHrZ6JuLu07yzZlpwHjrqyT6qhZLu
	DSMfP6qXnj6mQsolrixtb+mrBmJtNeMLHSr+iwC4x2YpfC3NE5donYaWtQhAtEMv
	6CA/ZaPxaoUKKui9Onli0j0oaAOShjxn318iv1KWjP0qUoJoZbDn+7Hvpbtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787862525; x=1787948925; bh=O/7i1E4lpSzeozKYNRa08E31U1ecUmVrHqo
	E9/Teyuo=; b=lia9SNQ80Pi+qkQBGsfBxViocVpcSQFOPcWs1nZNdJf0Dg7N8LA
	/I8qKaIzLHtI+ahvCO6HVGHaQ2FlqUzg/jwyK2IUhkX3tEJ/eT/an4IuYwd8UkT8
	/P3BEiV8kfNkDkSoQV0z37wz1Na8O2L1HZudziV76ysK7iUpOcB2/GXLmVIZRiCp
	44bjcTeKooVXuEg/cJGae/okThw6SOWra1lPzmFENCwo0yb4MGkr+qhQd06IF4c9
	LEKACm58ly/lT8GEIwkUtrYMHrCXiN+AjQzfH0Zjc8BdXtBkktkRxPXWQAeOmlFY
	SW4KMMb29yAC2otpp/wpVH1pc82yS3EBCrw==
X-ME-Sender: <xms:_Z2QaprJCs5KkeHJwZmhZNFb_WBeuw2ujZ4oJF_G6DxmSJoH0D4XtQ>
    <xme:_Z2QajEqgoNNQaEaq1M900KV7G88FXfCrZPANQ_5fnCHJKpnbAoPf4UKd5Ll77Qx3
    vtSiF4n-H8fPxbqwlqB5LLZT9xOgRiBXPgWu9ItPOI2EwZxuDSCi8g>
X-ME-Received: <xmr:_Z2QajkF_of7bx1xeoD7uIODMEZcLC9G62FsBlGGfZpOhW4EvFq-fzN8Aez_nWgFTRzfxp6Jnyw5VZHendK8u9iHIx-UQcfSbQ>
X-ME-Proxy-Cause: dmFkZTFO5ZOOSjJs9A4Ro/n6AgMXt3Dk4EIgHXFkJvPQCla1XA9+Wzl3PwsBpJo6HlMa5O
    6yOwpvn9ECEmgcgU8RSKubDWOf8topiQHp5i1iOivQtTbX+Sho60jaZxKfWFsE04ckI2s3
    bnhEbDNAt89SirtTpq17lzsLzoz3/6/GC0O7WqPeL+x3JHp4pHYPKPppfsfZKBvDcLAbQI
    r4fl0BDfAYnQt0FNMfTUZSgi4NOjpvJFu2AQEzX/w7Zy44g96ZLrqMF1qeg29ua4HRO57h
    3haRkQ5WQa2oE7pbdy9BOW6A2V95OnH1WdS71NESFyzcL+2RM7YlxN7J1PMJia6s3z+KZj
    hySL6ec4X17SgOuTlM2djP1HaE61m9eFsZtXau7hFtydIYuTKhBR/pDmznnRC9ciH0hZ5r
    24VmWTOktDWI5deHzrkGQl+DZBgfGAgXYAXJ7nz3kbXHwS69iykyirazzp7d5SdU/y7bBW
    2W/r8Mi2AcjUtTqF/y/44l9Ot7qPykdtIszX49AXDgiUOL7KWSuvE/Lo6BM5sJqbX+SiRq
    xnZRGdI1S6GQDO/dudquwAupdbyqNQMo/xUXDY+IIZQGXHPZDLv+BENvCyb5gNMpo4GZbc
    dkTE/6uAF8jqUPc6BZuRSRamccqc9BYDfjbzGspVmxaHgQ06Rx1IeVGKgm9Q
X-ME-Proxy: <xmx:_Z2QaunyL0cJPeHuM7xnR8aoTX9ZeoqHULFZlDDKPZpWo6WTJrRQhg>
    <xmx:_Z2Qass-1crkPwIA0lVWSRm8ac4YyB1FcU7t8FeYMEaC2ksaBflOsA>
    <xmx:_Z2Qapmf6-oNANegkpmzczZqdwzal8qSi4SCokk4EbT7yk1dmecAKQ>
    <xmx:_Z2QavtzlfQR_JuZgvSjsBcPxqyDr30Qs5O3t7ucp_8Chnu5dRmffg>
    <xmx:_Z2QarEbZ7MemFsdGP_yRKlfSnoDMUQZuhB9IyDRSlDZ2ggseL0Lasqd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Aug 2026 16:28:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Hardik Kumar" <hardikxk@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] builtin: replace the_repository parameter in
 is_bare_repository()
In-Reply-To: <DKZZYSTLY6TX.2TDQEBBOG5IAV@gmail.com> (Hardik Kumar's message of
	"Fri, 28 Aug 2026 01:39:43 +0530")
References: <20260827-env-is_bare_repo-v1-1-aa99600dc213@gmail.com>
	<xmqqo6en8jof.fsf@gitster.g> <xmqqh5kf8hqc.fsf@gitster.g>
	<DKZZYSTLY6TX.2TDQEBBOG5IAV@gmail.com>
Date: Thu, 27 Aug 2026 13:28:43 -0700
Message-ID: <xmqq7blb8g04.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Hardik Kumar" <hardikxk@gmail.com> writes:

>> In general, builtin/foo.c::cmd_foo() are concrete programs that work
>> on specific repository (i.e., the_repository), and there is not much
>> reason to rewrite the use of the_repository to use "repo" given by
>> the caller which is git potty.  You'd also need to deal with the
>> case where "repo" is NULL (hint: "cd / && git foo -h").
>
> Right, but would safety check be required for single instance or better
> to find and work on only the specific ones which could lead to an
> exception.

I do not quite get what you mean.  In a single function you use
the_repository and repo interchangeably, relying on repo, when it is
not NULL), being the same as the_repository for correctness.  If
they ever refer to different things, then your updated code is less
consistent than the original, which would not be an improvement.

I actually think a good medium size project is to fix the last
parameter given to cmd_foo() built-in command implementations that
is a pointer to "struct repository".  It was a misguided design.

This pointer is either NULL or the_repository; it never takes any
other value.  It is misleading and invites confusion that these
functions can take arbitrary repository instance.  It also invites
people to replace all references in cmd_foo() to "the_repository"
with "repo", which may lead to an error.  Depending on where
parse_options() call appears in the cmd_foo(), "cd / && git foo -h"
will cause segfaults with such a change.

If we change the function signature of cmd_foo() to receive a "bool"
that says "true" if the command was run inside a repository and
"false" otherwise, cmd_foo() can still tell if the command was run
outside a repository, and programmers will not be misled to use
anything other than "the_repository" as the repository to work on.

The utility functions builtin/foo.c borrows from outside builtin/
directory are being "libified" to reduce the hardcoded dependence on
the_repository, and cmd_foo() can call these functions with
the_repository as a parameter.  But we have no reason to waste our
time updating (and also reviewing patches that make such updates)
the built-in implementations themselves to take a pointer to an
arbitrary repository.
