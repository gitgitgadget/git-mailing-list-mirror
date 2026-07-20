Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EA53DA5AE
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568027; cv=none; b=lWQsuLlNI/xLf5QPkdK474EXovJDnkNUmL0aPI/C51OrRodzxN8iDlND3qCFKAbJ+GXCPpM4GgZUsVrOYCS2DuOTCqRgWARkyH5Ct7ZMr41frXLv7GlvLQH+bZFGUqU42jZNp7ztMGZalT/w384By1KScSZiz55spkifjapEOYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568027; c=relaxed/simple;
	bh=6QGdKA4LDKC3LvBTY2sOiS/T8L4W4AQE+dzRnE/GUeA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HbsIDgsL5TFq49CtMllYk35kFUxuikYYuu3UNdOydE42OmGxWAn2GikdnVaG/kop6ZQOZqvDSaEXC75hHbRbZzv/hHBSb568/FzxV0Hte27rc/68JcF/lyLiJMpUe2y4St+cSV6//Afn6wVIhPcRrPUD+eISORqxfZ76SvG0jzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f8hn1w/X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AVicJZov; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f8hn1w/X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AVicJZov"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6002314000E1;
	Mon, 20 Jul 2026 13:20:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 20 Jul 2026 13:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784568020; x=1784654420; bh=nbIMocH83n
	5/QxhqyTOjkjgaayBkwLSOe+C/Ybpqsxw=; b=f8hn1w/X3EOvgT8qwtKWgeBSNv
	5ozL49OwvNV9zaXzJiREl7QYM81wT5IN8KFCxZPBpgorFXwH3603eTmpJwn31Yac
	KFGxKJNdAWC3TYwwgeiU2eRlPQhReley8QbBSMp6jujEaAcIfgIZqXZXl/XKlr2T
	kqxF9zM7Zi68WVi0oan5Duzkg0HZEeKJZ4cafZvpufjDCxiFx77ST7LY0CwinKnf
	sJqerC8AIxT0cSqGjSO2cL2CXPGK+aQ9gW3N/yphSzdLrCyvbFIU0hqyFMtn9lSZ
	FBQHtKV2g85M55PgD1LoWt5JBeogi10x5KXeBzYClE0hC3v28d86XWUDBj/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784568020; x=1784654420; bh=nbIMocH83n5/QxhqyTOjkjgaayBkwLSOe+C
	/Ybpqsxw=; b=AVicJZovU3z2Dn+KH9VdgouRQ3TmEypC7j87hVl25WJKDIwz0fO
	v4dpo5HFnJ7+3B8UeEl+xWJy5Bs3RuM8lNAxh3x4DaoPwM1wfnJtF9mlfYBAHPlA
	74tt4Occyw3kf8c9VyyTpk2M3lqJQx7zYuFlN9hWqN9DYlXiwFuiCKAhI+p5DKa+
	E1h5KyT+L6t1UyEyKtAvbPSrSgt3H4BiHXYGpyzXcNUN4nrWFAKoUpchCcBWbrR+
	CKFqWBFHKEK3ELaiH9vX7Vecq56aaTKAm2x60KWKrvRpoYci4g4usKoVErVIBi0Q
	sJbhRsg5ibuYX67c5ZDdPU5dhegPFPOwITQ==
X-ME-Sender: <xms:1Fheao004RFYA6ggiWyuvyNDRVya8yvFJKVbiIh7fMZGmO7qUydp4w>
    <xme:1Fheap_0QsUByNX9jNZ3_3vkuXf4m8P87NZouj0BsgMLiAzl0ApfvOJkSrXd6s5xW
    xmDR4gmLyKQszJffNECpRSlmg4dKHmwN5Vgw0-UJcZJG5HphsE_4Tc>
X-ME-Received: <xmr:1FheapOU7yzbohUjoeRsa03kg-a1m6UMSF7mUXIfNx7rzSgGV39zwFmBJDUHJh5IWXizbpinVN18SKupfTjD54C-waNJbKjMzw>
X-ME-Proxy-Cause: dmFkZTFLiIMiCabbhT5kiHE087SfEyOqb7Qi09nb2eC9WaZBdfNhNC0Rb+Ot7aZGaqZ2Q6
    mzgLKaVs/LaqD4LXwuPfBAV3SR86ytg9DyElClveSN0FJ4vhbqKejYYwNfXdUz5ExGqqgu
    2P/GWsc3SOsz1M1jCv42JdJCUme3GV/UGoEv/B21p9LARjZ2Cm/h3nFKVaIgf0jkRmC2ml
    XzSIV99wR/4YJ8RMbSHEroUKfbK1g9bEmfdmzlabATbHao9PCP6YkdGN5ePPIHKrMnx30z
    HRsxEjQ6+0Xw8ZirohTdZTT3DbEZrgKB9FCcvRrWqI0DoL2f+wgUf6knfSKSNNp0yNp4a9
    Ni32Gnufl0ndo+TIZYePyY0zOEiUkT3hiLBbMckaylLX9hPxuBtu1O5Srj+Z7qQ4SdUlox
    q8Y773zC+a4jbCniXXT9JCA7J3V7Y1HgRrd5hBHaT8ClLBfeAZNP6oqnyF4f7p6vwG3Rto
    zmLLsuENjDXs5xFEL4+0FZFpW+X881w0FtprE1YHSpPAkctBxfEI+JbPUBBQnHqvjJ/dsC
    CLgTNNP42jpIocM43zklQlpEorP2WmYDCFGKXtZsGaQ7CIpelBONwUSCa4C4F1RSu5Wupf
    ROASFdKVVC6PHm33f5bQTMntyc5C/j2IQRTZfresDILNpj+kWy3nvdygfdag
X-ME-Proxy: <xmx:1Fheatd-o1iQU-EkYSMTxxQ5dPj8F87dtoTxoOv6J4p5CRxZX1HGUQ>
    <xmx:1FheaoXo2zYH2O0SYDgahIx9Yjc5Sm1WD3m4fiw-nmxnZsCefFBmeg>
    <xmx:1FhealjYIaPACm9di85Pl8OtyXAFn9EgHkJg8JXIaRxpECeCQ7K-Cw>
    <xmx:1Fhean91IfVHnRr7H9W6OhIWc49pkM0uMzA5bies3i1N0fZO76LObw>
    <xmx:1FheanMEwY-F8Vzt6m7FfVKO4Kl5mYeWHf9s3YbdaeYiXewNOg7o1RRq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 13:20:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v3 0/2] bisect: add --auto-reset to leave when done
In-Reply-To: <pull.2335.v3.git.git.1784538619.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Mon, 20 Jul 2026 09:10:17
	+0000")
References: <pull.2335.v2.git.git.1784312854.gitgitgadget@gmail.com>
	<pull.2335.v3.git.git.1784538619.gitgitgadget@gmail.com>
Date: Mon, 20 Jul 2026 10:20:18 -0700
Message-ID: <xmqqldb5d1d9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Add a --reset-when-found option to git bisect that resets the bisect session
> when culprit is found.
>
> Changes in v3:
>
>  * Rename --auto-reset to --reset-when-found, including internal names.
>  * Defer git bisect run cleanup until captured output is printed and
>    BISECT_RUN is closed. Drop the open-descriptor preparatory change,
>    retaining the existing filename-based output handling.

The range-diff looks very busy, but it mostly looks like a fallout
caused by the renaming of the option and internal functions and enum
to match the updated name.

Looking good.  Is everybody happy with this version?  If so I'll
mark the topic for 'next' soonish.

Thanks.
