Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE74207E13
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738679893; cv=none; b=Orocd/PAtdLuuudFB895jor02Mhfx9pk0ptJn2pyyWT5jS0pNicO7DTB0NJh8teXsjdVNe6so+ha4F3jSs11Ex8yxVV6J853GfqQK6EwHP2kuYomR//K+QE0c91fGcS5hh3stmC2ZydixUrQbYozjHG2tORAJCrkKWACnC/UkVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738679893; c=relaxed/simple;
	bh=Yod+MxMx4WKKsB/UdGBNADv9neEMOxXpOQ6T1nxHxI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=id12pMRti26WFF2snnKoPJ0snxaUg8UezxqRj1Hy4E+90wPyap0Ht3vSUl/RGhqKH5ORvaL3OiR7Ub7tkja4cusaaH8pH+a8dPm17zLZy39fXIWMlAY8HvxMdWLA3tM9SwqnZ3GGy0T7bD6wk2WyNaKnWxVq038kRmLBqdBu56s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fx8Lb9qr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pLE2EEYf; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fx8Lb9qr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pLE2EEYf"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id EA732114015B;
	Tue,  4 Feb 2025 09:38:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 04 Feb 2025 09:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738679889; x=1738766289; bh=IaNmJ7MzdR
	K9qwa/X6zvStSdG5E1Kb7eggT16PH+kjY=; b=fx8Lb9qruxc3VgPWSV2g94DUGt
	v3RE8FlWHPPx4KpTCfzulzreMesmRGQbBXTaBr0Rd8/UjaehKme4YsvahQqqIAjJ
	zZuWGQvZNFFjvVHmiywYs4NYSrhEBL/xcyvv/5jvVaim3paqcBMvAin2f7DuFQnW
	eVoT2qdaVYpVX6QExF0xvLydRiaeKU2oWy+gfQoaBTe3UUqw0tlkmVgYsQbC2a5r
	bZVcN32sgkJSKbB+ZRhmZZbAtdzGaPd9GrVOpGc0ef8zQ6ISADGp1Yew/91kzQBB
	5mJcKl1TD5AuFVZjq+WtcSvHawgnwbthTLVGSVWEZKk2TwTv9M5y+HGalNmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738679889; x=1738766289; bh=IaNmJ7MzdRK9qwa/X6zvStSdG5E1Kb7eggT
	16PH+kjY=; b=pLE2EEYfjLNsHNlHlSFm+ZIRh8GLCsp7V1OEZfjYnXzJrmRsiTz
	THtrzMWrHSmRuEr2t5iU7OJ8yKRHpWXck7SGz6m+bXSGlj2ev2xbxEdMELE0P0D1
	iAto+vitSPmrHdLkwv8vtwwjRxWWjlkQq1lOc2ceHgw74pr+tfvs0kezisVFe8eZ
	YkF2AiuZIbTmmXF0D9C2XE3c6ZcPwnuWPFHNeCDq9wrPOfqvl8k2cwGuG7V0xCun
	lqtIZbw2uyoERGV2J6zU27Mmlsn1jLhPmtpsTaugkXWRNfhKfXcFfpXQToD7dd28
	3r8kC8AQRgYpla1VXYcF5M7gwZUo3SwWU7g==
X-ME-Sender: <xms:USaiZ3BZ9ZDeQK5FfLpAoa4CjL5yPZM0jAy_Qw67_KXrOWSqqHiv3Q>
    <xme:USaiZ9jQBwJYQoCXUZru-5p00lzThAxNF7CgHWC97CEpvFQz3gTsGEtosnWQ9dVDp
    PNdkDdNpgZ2lhPuNA>
X-ME-Received: <xmr:USaiZylUdrGc050h4R1suOfw0j6Yf0hClSJ4Wr1yA3J485PgSzeafV6cnRjcEdXcHPGxM9LUElDf0pCK9wgbJKash0tnOPqXwXkB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepmhgvvghtshhonhhifedtudejsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:USaiZ5wXrkdYBmiZNUh-NczKczd2RIVt7NXJ4dk2Lje9HbcuaE2Glw>
    <xmx:USaiZ8T5aTY8M7dLER7oCExuTyRGQIL_ICmI0nC3vhrROmfIR9xwbg>
    <xmx:USaiZ8YMHBunfcApX89fcFth-mRYbx9mDDWq8DsMMeiF6NUrFr-dUw>
    <xmx:USaiZ9TlkKsGW991KNRy9Vn1V5Xjh2Tf99oQ_Zkk4DktdPdzN-AYcQ>
    <xmx:USaiZycF06I80H_oW0Zd9EtbMCrTQ_TnYROv8zOJle2FvauCkGdfaXp0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 09:38:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC][PATCH] remote: relocate valid_remote_name
In-Reply-To: <20250204041430.36035-1-meetsoni3017@gmail.com> (Meet Soni's
	message of "Tue, 4 Feb 2025 09:44:30 +0530")
References: <20250204041430.36035-1-meetsoni3017@gmail.com>
Date: Tue, 04 Feb 2025 06:38:07 -0800
Message-ID: <xmqqr04dvkq8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Meet Soni <meetsoni3017@gmail.com> writes:

> Move the `valid_remote_name()` function from `refspec.h` to `remote.h` to
> better align with the separation of concerns.
>
> Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
> ---
> Junio mentioned in [1], the `valid_remote_name` function belongs in remote
> header. This patch addresses that.
>
> [1]: https://lore.kernel.org/git/xmqqikq0ruuk.fsf@gitster.g/
>  refspec.c | 10 ----------
>  refspec.h |  1 -
>  remote.c  | 10 ++++++++++
>  remote.h  |  2 ++
>  4 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/refspec.c b/refspec.c
> index 6d86e04442..83ec7d7e62 100644
> --- a/refspec.c
> +++ b/refspec.c
> @@ -236,16 +236,6 @@ int valid_fetch_refspec(const char *fetch_refspec_str)
>  	return ret;
>  }
>  
> -int valid_remote_name(const char *name)
> -{
> -	int result;
> -	struct strbuf refspec = STRBUF_INIT;
> -	strbuf_addf(&refspec, "refs/heads/test:refs/remotes/%s/test", name);
> -	result = valid_fetch_refspec(refspec.buf);
> -	strbuf_release(&refspec);
> -	return result;
> -}
> -
>  void refspec_ref_prefixes(const struct refspec *rs,
>  			  struct strvec *ref_prefixes)
>  {

This cuts both ways, though.  As valid_remote_name() is the only
external caller of valid_fetch_refspec(), without this patch, the
former function can become a file-scope static in refspec.c, but
with this patch in place, it has to stay to be public.

I do see how valid_remote_name() would be useful as a public
function, but I do not know how useful valid_fetch_refspec() is, as
a part of external refspec API.  There is no reason other than that
it gives us a handy way to implement valid_remote_name() for it to
exist.

So I dunno.

Thanks.

