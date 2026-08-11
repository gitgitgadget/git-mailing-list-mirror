Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C2C267B89
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 04:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786421077; cv=none; b=YXKRUBQyVUG+ksyzrMBz29nRz9FwjqrtHHDkcbs2SvRjaFCl4UyjURGTVa+qs6KWlIVdSDtcd/IGeLXmB63GgpT4lI9qsoTAAcv4mUdrx2UwYy8xKy3FX/OPJ2v29aP6nuGjvlrKRVb2oGwBiY2ERksrsM1nbaqQicrHkwleQQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786421077; c=relaxed/simple;
	bh=8cdu7Fsjo5aKyT+1YQlT/We38NPuI2ddlvZoxZP6w9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XrySFOBd75Irv6UBjryVsZb6zE5YUgzPFsyWHUhNkhMmn/HnY3N+8wkRTQ9e2UyJphqQl7jIGjaoz+K7s4pMcuunR6UF5LPqA4bYMon5+77DmVlXk/icdQVAkcRxAzDjfP0WqYn6N8z4gSpJ9pJL31zGWm+5MM32MsFlNqaJCW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dWMa+uCM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lx52MMIU; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dWMa+uCM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lx52MMIU"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 84329EC01E8;
	Tue, 11 Aug 2026 00:04:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 11 Aug 2026 00:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786421074; x=1786507474; bh=5Uu8i2SUyI
	BfJYmtOKZs9ASXc+Y8AKm6nWtQCIIjpmY=; b=dWMa+uCMygxpcu0z8TRAowzJw1
	28oaWn/zs3v2anaYOoo50g/Ehg0E0JpcNpQdulfHBp/n2kNbVEfkJITKYBAmz3jH
	dfehttad1KE71L9EY867FH9svZoN5+UnQyz/NbCGBO9voEO8V3bQI0+CPf8S06vr
	DLiDdbikoM7XcZipVsoAykrMkDEuj/i6ViFWliDUrUVupVt8FekmN4AM6ntEBAKN
	gZwXtRqgv1pedVDSfB6GAYOhcwZ93kT9TQcdNeQ+jYoactxbgl/PXNAL8XMRjSg0
	gaT9N5PIYySg/zE/Nmj6WuDFBcPviFmYRjbeoKCqc5dUeUIjmjXZBjRAV0Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786421074; x=1786507474; bh=5Uu8i2SUyIBfJYmtOKZs9ASXc+Y8AKm6nWt
	QCIIjpmY=; b=Lx52MMIUAKsPuPx5oVLN+i7qNfkVJus8C967TBimO53dh5aEVv/
	M2wApI6dBAaxLo8YbSx/XWq+Sew1oond2GEZ0U6Qr3UkYGIHUmpZtZjtMFuRdX7s
	gd82cvjjgj6cbHAet8ydQUfrXjXgh4PjEAUTZ5y41/lviZz/unpikWjb9LHdQ2zi
	IeFpOXp+jnrvAdq0jDZDN6x06ZdJvvmoFgz0063OUBfV0ceHn3mnE5o2oIjRNRHU
	XvKvFm6b/r4ORmJCNH0Oxg2+Hg+sN1XZeozBE1o9wDOhGuI+3+E26Wp9IZBIludA
	4d/B8UlYSasV1mmdJCy/gzpSSC9v2DWcp+A==
X-ME-Sender: <xms:Up96arW9eKDABWSQeTBoeMBt4bBifg2h4sYAEDqKtevKreYH82Rnkg>
    <xme:Up96amJEadlAHjcUXt2oVbaVAgEpbOcvEU11i554BU_nQM4zn5VlW8ygMj9-XXVdC
    7mgn5ghZqZdpkvvIU5BobxcEZTzWih3uS65L2KgamSKqC2SCQi5>
X-ME-Received: <xmr:Up96arD-t7KeNrnqFE-AeI4C56G5VEyri2m-YldsxSqSaqUHObx4KkB3YHAo2T8lNc-omesTRfmyN_7JQBzaNYEx1NCS7SPjgg>
X-ME-Proxy-Cause: dmFkZTGWSaW1vkzCJtUA+dlx2BQP4dXZ+OxSxuBS4m08cvuE37rwEn+Gi4Wb1UnxfoNSF/
    olgFgIRVzOdsdcefMZoSaU4CZ2ghf8w99MxOE/1PITcWjc024LcefVh1Vn+Iqxi3y3dOsa
    ihzYvqFmntVW/bNn2PcvddiZwyanzg/UsTAYcYhxmGdhXp3ZhQ6VJ2mps4V8negK7tp7po
    NNpfF/PdfXK+giALTIekRdsdqEPxaWNioabuMBTHcaiUfdGbgdxy+YSygpobsSwqpRU5gl
    VmMD3pfWPoMUsQYF59JKVpsMPLHJqM/2Li9gFb+OOv5X/mF9e0SZFlsIBJasiViP5xSFnf
    GyG1VvKQ/qsHWRinBQNkCChOvkXO16HOW4pxe4K+CH6JzI+1M9jEiDt27mXbk7P+BYShjF
    ogDeP9IkzPPpSmL70F5ouo5LXce7U4dehLtr7GnKGPw0AHVQEhO3stEKXoIRlrnsFOMWfm
    Cci4I0V4JUQTdl4bfpTOXIgVmIB1ZRZT35FHyOB6EBnJWedZWHPC/CbL2yCrzmL3Cz2KSK
    iHg6aHT0/fGndqLaTPGzHjMszuxLPUOOPnt+UEjPZKA15dEQfwjDUdBuosjLCT0BKehsKd
    jL8TAvYMzXg/JriGJ7LIpje79ASEKny9Quf1YSlwZ6n55NIfBZC1iuUYoxXg
X-ME-Proxy: <xmx:Up96amdG9t40uqFdxFjm9Vey89t_OC780FSx8ZwGQtY1ffNp3Ddh7w>
    <xmx:Up96aq2zkOxxCtUO9NGaCiC1HZFINEPKE6xXd4j9u6yHwB5WF8FXpw>
    <xmx:Up96atikJ3YpFW8HZ6pBmwelDBGrgvtkzKtkX1fE75tl0ovmFfj1_Q>
    <xmx:Up96ajk8Iv3T_polYoMzAlWKk0803Yg0CKmGdTMwV2rvoHwA_ypyLw>
    <xmx:Up96ajbOmJVQqYsaa4kRgo3cqfWRnoYsT7h7RVLConHIQ7im10nQFgW8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 00:04:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,  Britton Leo Kerin
 <britton.kerin@gmail.com>,  Elijah Newren <newren@gmail.com>,
  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: Re: [PATCH 0/2] completion of 'git [-C <dir>] checkout'
In-Reply-To: <xmqq7blx5oor.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	10 Aug 2026 20:19:32 -0700")
References: <xmqq7blx5oor.fsf@gitster.g>
Date: Mon, 10 Aug 2026 21:04:32 -0700
Message-ID: <xmqqcxvp481b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Continuing from the previous 'git [-C <dir>] diff' series, these two
> patches correct completion for 'git checkout [-C <dir>] path<TAB>',
> but without falling back to untracked paths, as "checkout paths out
> of the index" is by definition about paths that appear in the index.

I suppose I will add the 'untracked, too' final fallback, just like
'diff', because 'git checkout other-branch foo<TAB>' could resurrect
a path like 'foolish' that appears on 'other-branch' but not in the
currently checked-out branch (and thus not in the index).  The
'foolish' file might also appear in the working tree as an untracked
path.

This is not particularly useful, however, as it is unlikely that a
file like 'foolish' tracked on another branch would be lying
around untracked in the working tree to begin with.

I did not, however, find any readily usable machinery in the
'git-completion.bash' script that allows completing a path within an
arbitrary tree.  If such machinery were available, 'git checkout
other-branch foo<TAB>' could capture the output of 'git ls-tree -r
other-branch' and offer paths that begin with the given prefix.

Regardless, implementing this is beyond my 'git-completion-fu' right
now.  As I mentioned, I barely managed the 'diff' completion as a
monkey-see-monkey-do patch series, and I would welcome others
building on top of this once the dust settles.


>  1/2: completion: no-op refactoring of checkout completion
>  2/2: completion: complete tracked paths for "git checkout"
>
>  contrib/completion/git-completion.bash | 86 ++++++++++++++------------
>  t/t9902-completion.sh                  | 27 ++++++++
>  2 files changed, 73 insertions(+), 40 deletions(-)
