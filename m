Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3E23A0E8B
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792254430; cv=none; b=m/QTAUt1hEG0dLGE012+wpuGjmSVWkYkN72fmMHlGP6W0Br5Dott2nvl3I45tkF+oTK17Hhwr3Rx6QGgDexV2cHt7cm3395Z25qkOqmXVi9MKN3ib8/yc/q4pnZILCRiQQM1EHZCcgyfoCvcGkCgdkzJE+h2184Ugusl6fUYi9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792254430; c=relaxed/simple;
	bh=2lIv+BDTJVvkz7FC+teV43UiSmRlmxf0GIdXerKwcl0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KwkL0/K275Ibs0YmySLPiTt4EwdIqI1vcjO8K5qgPYGvkWJAf7hCzupuiSdiRKa/0w6CWC/1lRh1kn5ds/uNonbRweVZG9pL/aofzmJlfEN3goFPpwOYDr4KumhQGqfiXSjR4bIED1c5tGawUng08T99rtqh/iFa1ynHuKpvQMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pm/2jKSa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lRAH3KFB; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pm/2jKSa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lRAH3KFB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D30517A00B1
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 12:27:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 17 Oct 2026 12:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792254427; x=1792340827; bh=M2VMWvbK2O
	9xT8YGS0yJbNO6D+LoAJ5BsD4DnpUzrXg=; b=Pm/2jKSaLxKXY6S7AYOoWWXSGQ
	DxRxqXuRP2JdPWLIpNl7D3A81rdhNIKQsOaf1FfeR8xKQ1zuwre4KvIj0RYUXjE3
	g9UhUC7YMlTiXNArt7w0tsDmDmd3gD/nIMBqsD6NIRh1enIkUCQVVb4lBuZlWBzt
	CimtDFGu9Q2ClZHbXGB/ag+rG7IHtG2NQSelwmhCCXGcfdTmXF7y10oo3xQxFsCA
	6B5sI5ETk/JpsEJ1pIGfhPDSdQy/rzFq0wAX/FIS589VN5DHd4jAgQiER96gXbO+
	9vw1d7XGwYtUGQZvpCG61YBxZQY2U1UPaKeIoSGk3FBbjl6XmedtoIJNHO6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792254427; x=1792340827; bh=M2VMWvbK2O9xT8YGS0yJbNO6D+LoAJ5BsD4
	DnpUzrXg=; b=lRAH3KFBxVFJKGKDMspRwq/kplCvbeLCpiHUErXtWxqn10hF2or
	Ulsh5cwbDrnhFmNk3zXXGrM6s+z4b8sEvWOc11ZjaqKJ9ABBreey8pqLV2ePZ31+
	wP4p3XBhuTZWFDR5jTsMDZ9vaGOzeH7jlGKfdFIlo3XcANVSRBr4Qp/NOCwYr9NK
	K3Th64S2/yf7H2ZQKFldBXzduwX/yUkLfSac5MOGGQgKid40X636qMz8gxWcjro5
	XOrverjMIoW64aewY3Bl8xUq5S42FuYlUs1oYPi0DrKmH5MLw+7vNjtWMyGVlCQ9
	QlcO3pJyUlXZTr3NzMvwk+ZkEcnD5pJ3Muw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792254427; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Z2r2RhhGgVbTN3/eEYtvgUUrx3iZ8NofPQnd+XaWxvt4rjP
	oDcVLTg5M3lO/odEHAnyZgola2fgJG4xZrh0rCibElbuwLAgsIq3HFxbw7TwbsL/
	9Wgo/05HYP/lFsRDOVz5xS68praypwoaYzbuDAVEd3q5BoxkaHCgdTxOMl882PaD
	kGXbxDErFv1lMR6xRbSyuBNlVd8+Iyhq3JbhqqOhe7lm+vP1UYurZvYu70Mpoura
	P4s7rjLokG4II15RFqTgYh00lMq+kki6q+MavWD+oX3jl6DCTYJ4Ita0u42B80Vi
	QERuShimGHuHZoXMZOp1oneyKUiMFQq5ir3R1gg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:keYRM0t4FW+kzykgIQNUtLdpgnuqUr62XUu+kCWAbVs=:2lIv+BDTJVvkz7FC+teV43UiSmRlmxf0GIdXerKwcl0=;
X-ME-Sender: <xms:26HTauOeRsM6ep__3kVz6HFHdhbLsqpIDn1ODCpPKuQVB5sjIRixsA>
    <xme:26HTaj1_QgZiaWnk1OnfiwVoWjniYvuH-9V48keIipZ3YHrWqpCxLSEKYH7EMj_Ms
    VacmEru5O6jVqAnE3p62Iw6QN6p06ubTcmt5W7VprUa2LYOv3RN3ss>
X-ME-Received: <xmr:26HTatmN7z2M2x28SgilT9wmuL3XCVKGCyVexScWloBADFh0s5QVvBh8Oj6CjWwjVUGKRCNskuXmbOs6cNvv7QikXCIm_4hn87EG>
X-ME-Proxy-Cause: dmFkZTF+mdCuCTIYOLVOwFoLrqDJ0vcZiHkgZJVqSt/ovQ6JXdIQQQsqtJNEiD4To2A/qg
    34A4EDeLFo6K52VZU4tcCy1h2+7vIJ6CZV5fCZHeVS68+7DI3tFuu0XzOGz9tZHWOIWrlz
    Ug8PgSKSIzcDtzSDbuUqO8DA2Vio5GRUIwKCfLhdO1xKc7Lk3hjnle/spj4YeCmSH7p+/o
    exDgXtn1Zeh451lnqpT4t5Ermdcl04cKeaRscA2brye3EbD6q5u3oeZu50bqNe7E0aGJYJ
    SOrZxsqX2lIISZ+wt4udnJvocTNykkn0eRTfxwgUuQrUf35oisR9HZTjMk8JPxDdJsF/n1
    tjEwlS/oMGMLLjMfN4YaVQcyXCiNL13Bm6Amts7f2Xy7Ag1DM7W/QBy32PEtCBezOhXQQ4
    VXeGe67A+/9gOxCQTq6T5QK/VU5xF8uBVgqNF9FK8Q8/EgaHTzwXWhXuSJqaoHnM+euW4+
    noqA6Rb5+bvuh/7QdHJu3Q8THdZLDZr1mtQtfPxX+NoBdSY0TmYlWR+wrAsiFKotCdI+Mm
    Q/4fS6wzFjK/hH3QfYbmraDIsrTv4eWBwaTrl+zGUA9JRHQ4Rnq5EupGT3KcH3cq9iM6vW
    4oHWi6IrfTVEq+Fp51ziSf/BasFs3ajAg8AaxXccUaSR4ULLJmSUWyBenuPQ
X-ME-Proxy: <xmx:26HTaqWFHRAsDaTKVpFrFXrg5sEjw6Esqw-6nzZ20Jhuld0OxBtuNA>
    <xmx:26HTajvi1eFsqYRfw8GjU3M6xuRatI7Tx3Oe6Kb1qw9zQRZS0nMTvA>
    <xmx:26HTatausg36ZZQ5PvpjWDxUh3guSLgSUC0Jqizz18wS_juSkGdsng>
    <xmx:26HTaiX9qXVur_gSQ6dKQcvO_HzgLWpdsnNP20Pn8RLEkYa24i_V9Q>
    <xmx:26HTaotT8w2EC3Fk-xJpsTlyTb2owmfwpAX3KE_vItMDZXdYI_1i_312>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Oct 2026 12:27:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: Raj Ojha via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Raj Ojha <rajojha047@gmail.com>
Subject: Re: [PATCH] describe: use Q_() for pluralization of commit and tag
 counts
In-Reply-To: <atNHlNl9mpDqUKb6@ugly.lan> (Oswald Buddenhagen's message of
	"Sat, 17 Oct 2026 12:01:56 +0200")
References: <pull.2257.git.1792058069306.gitgitgadget@gmail.com>
	<atNHlNl9mpDqUKb6@ugly.lan>
Date: Sat, 17 Oct 2026 09:27:05 -0700
Message-ID: <xmqqmrscb8di.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Thu, Oct 15, 2026 at 09:54:29AM +0000, Raj Ojha via GitGitGadget wrote:
>>In `describe_commit()`, debug messages print the number of commits
>>traversed and the number of candidate tags found using basic `_()`
>>localization format strings:
>>
>>    _("traversed %lu commits\n")
>>    _("found %i tags; gave up search at %s\n")
>>
> i wonder why _debug_ messages are i18n'd in the first place? their 
> target audience would usually be the git developers. or is this just a 
> misnomer?

Funny that great minds think alike.

  https://lore.kernel.org/git/20261014092923.GA1344504@coredump.intra.peff.net/

which led to

  https://lore.kernel.org/git/20261016185418.162998-1-antekborowski11@gmail.com/

;-)
