Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D233930100D
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783100036; cv=none; b=dEdqegDyNUvlnXB4s6i2W+KiGWBYYBVwOIr2ziukz09J0KXR/Iiwb21Mq29XB5NTEEOabndUykoT9kvuujbScaZHMUYczRfY43FpbBsFyn/ufQ8UAhCiukYIv7sLI5g/njUt1mBCv5kYbmpVlMoslkMfPtNuMBVIz2U2h2KuDPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783100036; c=relaxed/simple;
	bh=ulCUNSWh6R3ADDlJRIg8juNdBU9helIKsjlrWPRJtEk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZuBZjg3i3lnNVF9PdaW7Ftr2CCagObzV2IzMLX5iqll317NkQgDQgOSdEhCxvopVXMnHeaN0fmwaSeXFwMqMHtNztu5AyJcDnQEJHp751GLx44mEVl2E6Bxa4dyhXzY3Sq1tjwbwCDwOkXOVimhWHEKtHUDw3WI+Zq5LmSnq7SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=igoGMbsc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Br3zvqqT; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="igoGMbsc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Br3zvqqT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 079FDEC01C5;
	Fri,  3 Jul 2026 13:33:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 03 Jul 2026 13:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783100034;
	 x=1783186434; bh=IfvIJZtTldWE80A09NEeKDMlpZuvZfnjOpDmvtx8kDM=; b=
	igoGMbscb77T3LjdpE/vHY4XkHWgEUxhu3CrrrsmVbRG3TFx0TC4IrRS5Wg59Caw
	cXbgmJgfv6iIoiBxIjS8Fx07ud15BUIHk22PJwvjESPRiQoHZNGeT6nwIDitDiTJ
	ofmVFdy6Kde7L2W6aCa41G1x9cMifUqVLMV3HJpagoslRRjTwnn3GvXpwv5SXHaq
	ZvVQ6uAir5918wjsREI/pDLaJ2Ex/41LgDaNhVncrdGzR8StjUa/fzBiwjZ5DfIL
	92cf0kZC3aOzGVBnhXsAFnDE+YkFOP3HcKHV0VIokhPPRYrbAUgTtmnxTsfbCwSi
	C5fHxY11/Pr3P49JWvug9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783100034; x=
	1783186434; bh=IfvIJZtTldWE80A09NEeKDMlpZuvZfnjOpDmvtx8kDM=; b=B
	r3zvqqTg41Jop5S8P22gTn9SwRF5L3YOmKoWF01C2XSX2yv98n/KOdW6gOOFqNgj
	WQt0ABFtQP/PqGqrDQyQgkhqoGesPtKhgk3i0RB25bydkvRsjEDA6iIVkJGXWc14
	kI8zB+4gNKYls4ZAFDF46mpbe8LCL6sT99K6Sx2xasogvTtl7qnyYV6UMzHh4LHn
	XpmiPMVwuiXhoAXead1bMuiGGz39iu7GFOsL2YnhV7vKzuueJmikrl+cnt19KTxa
	F4w+YbIbBgMYXJW6oXOOiVAypvECvy5LZYWufe2lJ1nZdVqx+CJuZw6apqZ19iXu
	3C+piAb/dAMwVYhzY+dGA==
X-ME-Sender: <xms:gfJHalkzZKUOrj2YpemWt_q6MmfRnvmVBKPMLOTtQCE9KxaeRhR0Hg>
    <xme:gfJHaq3wwGroUiECrovuK5vxny0JQ04FMcvIV6WWDmymQBw5TkZ9Hs_jTORtE51W7
    MWNZ3Ixmj-TcFpSZriM-wRt9bJqunEeAohYqd8g1vvqWiC3taeJjQ>
X-ME-Received: <xmr:gfJHaiR2HNoCRMPpBCK0QjYlOuAYWihlUt1sXZKI-dfyMGknanr1PbktTLrnTLV3ITF9Dqz6Z6bCf0pzIKoK39H0iKFeJgs_iuvsrg4>
X-ME-Proxy-Cause: dmFkZTFQ29rdV+AD7i/U06BxqJ9THXaIp3m0W+2UgygChGr+t1Fep811Ztyt08t951vhM/
    ziWH47L0dc+WOz5J12RPLlaB70jin/TObt1oFs/X7lkPmq5jZbb7/I5h4g6hTD3+FJCnqz
    pIHTfNwvCiF8yzO3w/LbVYsqrFbGIm8N5xYWxiSQOXs61wH3z4RwlBLhhw3HxjF0Mm3gpv
    ZB1OAjZ+CLly0F3o/ZAfOgtL7r+Mf4At1xEfI+ac+h5RvfnbclRmHCm2k5imqMXLNFo2eG
    bcY4qXtH1EfiaOmDOeBUgwyww7/QcDvG3ODBxCZvVtqIpbIUkIZt+0LJS0VLgwMYp2Zyrf
    gVLpCnHqWg3dzrhpHHv7ahG7QhHEFmHhp4VKWVSqP2e+FI/IDV9WN1tjvdy64PD7li+22m
    8ZYx9HQqLkvqLcfYcl28FyY+qjQpH6N2W/H7DJIx4AYgblf/1lAD9cevjJ+dLx88Tv3g+9
    fR4Zzrjp6xr8efoVEDXCoNZKsRCMqn/M8aDgLrHTos3Vb4J7blVu1Bl70OECKVlEKDwizl
    9ih4dH9YABJ7XDR6SkgZt4z3yueY3u1mM5zGdMdW0liJhVJ91OzlVs57sFb1/vNLZrHTPx
    sejoPXi+xQSnKHsYchRiYla+gMdPssO7gyueDOOhG8QZyx06+ASiaSHwNXvw
X-ME-Proxy: <xmx:gfJHajyjKnJN6Qnx9Z-KRVTe2KsRSPHnPeCdI1yqxkskGUVqXk3B_A>
    <xmx:gfJHaiC54vBrPIodTx9tSe4suHP6dlFv6BJumBjtHk6TORfwDgvUgw>
    <xmx:gfJHavFyD9-ZroK1ckZEDLSnYwEtwo-zqwX1CbwISfMPzwdhhTuRUg>
    <xmx:gfJHapNLIlYVOAyydVUEIl1LGQSk2I81mzpTIrFUfKJh4oWOW4qdiw>
    <xmx:gvJHatiL18eTp2MGTgKlkOZWdQw3jGRVNBdfxXqdlpJa7xGTJb_4KTRO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 13:33:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  Pablo Sabater <pabloosabaterr@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 06/11] reset: introduce ability to skip updating HEAD
In-Reply-To: <akd14OKLT9lAMKTf@pks.im> (Patrick Steinhardt's message of "Fri,
	3 Jul 2026 10:42:08 +0200")
References: <20260701-b4-pks-history-drop-v8-0-19b5cdf1facd@pks.im>
	<20260701-b4-pks-history-drop-v8-6-19b5cdf1facd@pks.im>
	<CAP8UFD3RZv=PGC15xms3xZZkNQsGLpgq_ogt8P9ux-8p4HwW6A@mail.gmail.com>
	<akd14OKLT9lAMKTf@pks.im>
Date: Fri, 03 Jul 2026 10:33:51 -0700
Message-ID: <xmqqwlvchta8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Jul 03, 2026 at 08:59:30AM +0200, Christian Couder wrote:
>> On Wed, Jul 1, 2026 at 1:35 PM Patrick Steinhardt <ps@pks.im> wrote:
>> 
>> > @@ -113,6 +114,9 @@ int reset_working_tree(struct repository *r,
>> >         if (opts->branch_msg && !opts->branch)
>> >                 BUG("branch reflog message given without a branch");
>> >
>> > +       if (update_orig_head && !update_head)
>> > +               BUG("cannot update ORIG_HEAD without updating HEAD" );
>> 
>> There is a spurious space character between `HEAD"` and `);`.
>
> Ugh, indeed, well spotted. Junio, is this something you can fix up or
> shall I send a new version for this?

I just locally updated it, so no need to resend the whole series, as
there does not seem to be any other issues.

Thanks, all.
