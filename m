Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F9647ECC0
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946548; cv=none; b=q4Khdc71DfCCxvr+hBf9VRYAF54wHs4NHFFFPJFvXcge5G2VYrnSG2vu/cf0RT5kLt44ukj4ybz1RXW/SoLyf7F52oyb+bp9aWw1qaOz1/d0RNRCkMT9lIwRbrRbY/LbLtzYxvzhW7Xu9epD2ZSw1Jyj0b5PgtSArmT4nB3olhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946548; c=relaxed/simple;
	bh=3um9Gas9bbhAEIoriviXok0MbTAUTz3QLwIj3ypk4EA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RcSCQ/Nk7YsGdv0lrx2fSVdEzhzwD1iWFgIISb0A2lbu6+2vNojHvg6Rq9AVSNTRkWp94qdenWzoKJ7bMG4GY5XwqXlDwxZKv5wjZMzcnu8YQ3Bq3/iu4DEvJEPmsifASoFkDN1cgzt3TI3/tALUr7pv4IGpXGQb2W/4oNndyv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VNGNcfkT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JnTDLcv6; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VNGNcfkT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JnTDLcv6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 7C3751D00146;
	Wed,  5 Aug 2026 12:15:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 05 Aug 2026 12:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785946532; x=1786032932; bh=KyYILR6Vfu
	1j8sHfDRE4xdxLMGMIWeT/gXdP3pukIm8=; b=VNGNcfkTizxCygin2hIdTnRq3b
	9c1qX4wN1TwQThb4wzjPcNbl092eGBYat7oqBcphLMUMAkEqHp/YKQzwqQJlaloC
	HeIChYEXH9IHzJWMr9gl4ndljtuQbEtS8G1N7wEWZ5bgt5pJLzKGghx3mAMOmczX
	i8luGjwqrdvev8+TtvPLLkbmEQP7uIDngYYSRU+TTNLCvUduZkkpV8fQk1kkvaUs
	fnxwsDUkYlh0+Ys+ma1TkDMkttEgSk7U5xNPQqHf8Y7d/M0T7efMAoNhnbRxTy7p
	KxuSq3cCh0UKVm5/hR+Ir5nibX+Wg1I8dbXYSStjtze22JpqThABIG/iBBPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785946532; x=1786032932; bh=KyYILR6Vfu1j8sHfDRE4xdxLMGMIWeT/gXd
	P3pukIm8=; b=JnTDLcv6yNIhLV4Ioifur+PK/rzd94eTx4ESwjtyvgAZRTH1O7F
	dkojA0aSJJt9Ai/RKieTpzCB1K12WbZ3sK/YGCoHktmG1jIQARZ6XPQNvJ3dQTO/
	XTH8CaGFBqq5niSaImNQ7DS6gHNWSWGRSzG3nqD/bs0qdUZUfoMdT3GsYHQ4CVOY
	6R6+V4a3FVMghBC0+tB2uD3ZqveNGL18813znGhBiKOeluBNvTIsw4GcGdjMYUfk
	1VsEAPi1PJnff1xLpYqG4IBb2q4Wpit7eUgpDlu90GRuUrS7SoN4nWyU5TfTWpYF
	feteUOM5lyso4iWQqKsFHmZHQHboQ5Vrt0g==
X-ME-Sender: <xms:pGFzav28voIk1ME-U41xFqDsuZRoeEOgWgCcj46A9u7hiXx0c8HyFg>
    <xme:pGFzak-sasPq6g2r84mvmwM94yOwSWV0jInItu0vfHFC_xJ1SiGOgAq5DWomm3ig1
    edNpuoZgAgFtFD3ikxt1Yn0uwTDwzRNiFfaz2ZPMoOdRLSeCDhs4GM>
X-ME-Received: <xmr:pGFzaoPqIAl5S9Y5XfbYLpsbJM6jArimOqLVlvcWAuu661hv5nLuwirfLd3KEgnWY_Afz0Vg68LmnMUk60dBv53RuT9mHAnM5w>
X-ME-Proxy-Cause: dmFkZTE9uFC/6W6AOgc08UdpzilgfuEcLsq0QhlN3MSGckB8xnYI2zc727vu7htlorB/sX
    UH4lBjfFEYc6Wz6dx+cXCNin82/UAShBcvl86fP5tXhsJ7QNr1zmrFkKpLnOm+7EKz9UVX
    V6MQK7alIWYXcDSpBMVhg8/ja7kBmaI6+eCTnfDjctBaOBuGIK0ZckGxcJ02P0e1ATieQ/
    72Ubtf/I25k83VLwNN4+6Fdp/kKVK1Hj20ke+zeXuzYYi25qGGlR1gAHjx/BcGPHN6hcGx
    1R3ek+lBGwZIW2XKDgEr09w1EkyF6A7ACqMuubxUYX9lumKvCd9n8WslvwG+WowZP86wSZ
    auN1XN7snhpOhFHlmaFH+So3Pyu1KYTZ4YyHPNGA7SlCrg/jsszXvOB0+gH8L2lu2dEi/4
    eGiWsZzs4UAa4k4VQMuC8LIGsjam5+K2KVz+7SLSOFX+CR6AZ4K9W+w+9fM1i/S3mTg9ZC
    HQu4bdu8h/VTaJDOzX2VMnSPMrD3TXAKqFOj8scEhkSOz7u/QJbkmk1S34MM3a6RGmkGx7
    Ks7lGPCvIWn26OBdQCNmcXw2UIflfHS2Xs8DKphCGDThpX/N9InC386feqhxaeYDEx/+WT
    k/wg+1eSEp4lmcswVdlbWaD3QbN9xCFlNQF1fy04UXyoOVHJc1b7hsD4smuQ
X-ME-Proxy: <xmx:pGFzage2GsaIyc2bv9tPGWjYzLicAkZKabJiinRHAHiVAmiMELS9tw>
    <xmx:pGFzavWHc257HmOmwJsfqn8OzXg0vmXbInKjqgcje30KPQy2lWvcRA>
    <xmx:pGFzaghbL6Oz1ETh15s0feb7QsFn_2u-5jMFy3IsPfkbY5ePP44-_A>
    <xmx:pGFzam86jDjZlsiHnB45ONCpmPSQlt5HCvi4mEnXoO60cqMzwwquLQ>
    <xmx:pGFzahXwnGUnzYnZZ2LRuqkZDGQ3TGb63PNsV_J2764Tby4kaXk1Ty7o>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 12:15:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Vincent Mailhol <mailhol@kernel.org>,  git@vger.kernel.org,  Philippe
 Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] completion: add 'git history' subcommands
In-Reply-To: <anLV__4THdvugj8f@pks.im> (Patrick Steinhardt's message of "Wed,
	5 Aug 2026 08:19:43 +0200")
References: <20260804-history_autocompletion-v1-1-6f7459ffb677@kernel.org>
	<anLV__4THdvugj8f@pks.im>
Date: Wed, 05 Aug 2026 09:15:30 -0700
Message-ID: <xmqq7bm4sfvh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Aug 04, 2026 at 09:56:32PM +0200, Vincent Mailhol wrote:
>> Use the parse-options completion helpers for the "git history"
>> subcommands and their options. Complete positional arguments as
>> revisions, and add coverage for each kind of completion.
>
> Ah, great! I wanted to write shell completion for git-history(1) for a
> while but never really found the time to actually do it.
>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index e875787710..f10813c8d7 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -2137,6 +2137,30 @@ _git_help ()
>>  	fi
>>  }
>>  
>> +_git_history ()
>> +{
>> +	local subcommands subcommand
>> +
>> +	__git_resolve_builtins "history"
>> +
>> +	subcommands="$___git_resolved_builtins"
>> +	subcommand="$(__git_find_subcommand "$subcommands")"
>> +
>> +	if [ -z "$subcommand" ]; then
>> +		__gitcomp "$subcommands"
>> +		return
>> +	fi
>
> Okay. We first try to figure out whether there is any subcommand passed
> by the user already. If not, we complete available subcommands.

This may be a tangent, but anyway.  I was looking at this patch (not
that I think I am capable of giving a completion patch a serious
review), comparing with other completions, and the similarity of the
boilerplate part above was so striking.  I suspect that these were
organically grown, but at some point when the tree is quiescent, can
we coalesce the completion routines for subcommands that share the
same pattern for better maintainability?

Thanks.
