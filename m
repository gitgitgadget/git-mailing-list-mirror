Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84A743D4FA
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469111; cv=none; b=pIMCnhDkl3HnPE6chscjS8agxaPEmq4LXS3GGlepdBQ4dbf2qNu5BVXKcktNgQWRQ08cARdWWKn3N5+JU9Ys8UbCVi+aIATsKK/TBCgSDmwFkngLBf8OZIjMI8ZR8XD5y9TJdA/OYqwACblAZ2McUqYUqM7cyoRv6l6M0ThXvzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469111; c=relaxed/simple;
	bh=ArtqEYi4h8RIsMMUen7H60OmTK0+aFT+5oulQBjEKXA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UU40I8KaHjpuF38/1+SZQ/KfEtbn0LQfCs56Tn/4xFV6RJVkAoui3Jrd3bXTBvamUE/HA9Bai+WVYyxiLpWixNTuEQ6qflEJkgynJlXNmGGPsO77nPJ0cRF/VQM4Ch08A1Jur6YuMuopS/5AxUrNXKNbfLA3Wm+bogaCQ/vHs40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=s6vWtmrK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YEDEOx6e; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="s6vWtmrK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YEDEOx6e"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 02F811400147;
	Tue, 11 Aug 2026 13:25:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 11 Aug 2026 13:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786469109;
	 x=1786555509; bh=YEloKd4bkXtD5JX5Hwe8Xqcsuloowl0GQ+sbHj6eypY=; b=
	s6vWtmrKv6IHgjQbncjlAYYe6kQ8JnaW2Goyqxw6LqJazNzBzn/PTtF4RCK5bkT4
	IWt5JUnsx795xiAZzB+Ml62H3CK2tzdmG92pUrRgENHBIigiAz220GlWHjd++7Tz
	QTsTDvvGViXxFx9DdDnL2vso1rcRqBrfKVEfhPtsWLLxoYBFzRvqcb+bFhfRsFpN
	VrDpJi/mpLIKxYbD/mnqqqWgLv7sSXBXSFVpscFhPq5+biAura3uNkWONFoeD030
	9w7wt5d7h9kDP+P+1QezWBHVbo9ySDfi+swiacSqH1QfUA87vgUc4e14rEC/mbh7
	HmRZ8DUIv1rlfCwFwFQYiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786469109; x=
	1786555509; bh=YEloKd4bkXtD5JX5Hwe8Xqcsuloowl0GQ+sbHj6eypY=; b=Y
	EDEOx6emQUJ2+Bif1vZlkW7Z0Ez2LqdOyIDNRZIWEj2ubQWtMwbZUETs+y1Y5jjb
	dHxi8QJutzWacTli41yntHCnuIovfSRA9MI7qdMCHErTktsi4GBysSEh14mhxLUJ
	556I89XLDwnxZZtQYrZKUjTZVOVGCwawj3DYrra+K4lD6lebyS+1NSYSl8G1NIXw
	5cQfGOwtpvcOK9D4fbGTxK3UM05H92fJnHDltvqxXHZ7pHBz6gb4MZqyD9Zokgn5
	LIeX/Ya5vUgIhxLFWrYusGh5qLRNotFIOSLCeVujyaDippRH/B1hJbrHAkprlzbG
	AyF6UeL6rYFG81vS4vM1g==
X-ME-Sender: <xms:9Fp7aqWzH_SjHuFRgwM2dRAPzaOspep7AfswYXbEQG7Xivswb45jBA>
    <xme:9Fp7apKbtVFZuUJKrLH0Ufc-uZ45Onrh1rX3xstt8e5zEwQ7wcxvqFZcaHt69KZmt
    wvvFeca1xHfLoc7SHrl0rwFlAVFu51j-iuhg4rV4nX3HPTISQdu>
X-ME-Received: <xmr:9Fp7aiA-zoEwtpmie6M6Ko0ud9p8LJe_bslKYCqzc8Z9ItjLaeSUDmDFWcvQtCkuITBZ7stJcUdLTX-4bYPx2reuKKmkbBf6Bw>
X-ME-Proxy-Cause: dmFkZTFW3Y2MrrUyDHrzg7HHuYU0eT+cjZ+5ICuYGjUbnHFkv3wLHjpSPqdMoq6RvXR4VR
    6dVvpssAZClpsudGcDjZLGEx6StkauNKrIT0hScbw52jJyujqOsfJUFpqAs+//CqZl9ZAM
    bkjejqQvv+zKX7WNIH3tvK8CAQ8Gza3XcQoqymw3XnoqviweNjs0xp1md0ghWRlCmpHOml
    PCoiKYwBn6gFrpLFfV6THR1770oKTXE3uPY7lw04fSnho1ACI67hyNbRAWKW+vEeKtJu1V
    yBsgjZhkfcSAutBeK3w+u07/tzJWpMsa/vSYo6PLsJ+ybw3/la+vpzz4c7dVYkJPbWTqhB
    uHLK+N5P2J6QhBe4g4iXTgWwhdniq1gEboA/Hu16QAath2M6NmU+8omE24q/nrPMFzQtDQ
    um9dZD98R0yYv856/l+xz1U7bZW6BVCzEVPxkHqg59ihc+Yvu6BJ6sP/4kakfr8BNVoGRr
    vIVtefMAIbjZFz+uJ0rt2EBBb9CxqrUMBMgZi8pCJb4LM3kCMYyrdjGI7XSDFF+Sm95grK
    8h/6ReDFR448siGxTEjoKLbgzMnnUqfdh4GKBv+yHY9o0zOG0PCxvBJ4O3vFjADoss6Zqo
    345NabsjLGemU55smZUB8EVw2Y4aAwLQ31PmQ2Y/+QneiyN/8iiMe2HPImMg
X-ME-Proxy: <xmx:9Fp7ahfpraO2BwcHBi-RM1IDuVFcvd6RaDtKrluzZV0_U4nLlbieWQ>
    <xmx:9Fp7ap0YK0UXhD41af4Lr1BSSrrKxoh3TXhk_j8LBGuAILjRBv-z-g>
    <xmx:9Fp7agg_1BOJQI9ndpUwZOr6Ch7SIDzgybXDdlR1V40WshurfvkfXA>
    <xmx:9Fp7aqkCZ_aLOxEEOWAM4gsNyqu7DQlTQXe3CgCfH_RXa-fXfbiiQQ>
    <xmx:9Fp7ahTZKfEwWZQRByLIMQn-mXuZfkgMoVEGNb-lvexfGd_tqwNdAfPR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 13:25:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Philippe Blain <levraiphilippeblain@gmail.com>,
  Leo Kerin Britton <britton.kerin@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
  Patrick Steinhardt
 <ps@pks.im>,  =?utf-8?Q?G=C3=A1bor?= SZEDER <szeder.dev@gmail.com>
Subject: Re: [PATCH 2/2] completion: complete tracked paths for "git checkout"
In-Reply-To: <834FE315-FB34-47B7-9ACF-FC8194FBE8D5@gmail.com> (Ben Knoble's
	message of "Tue, 11 Aug 2026 12:32:05 -0400")
References: <xmqqmrut4a1l.fsf@gitster.g>
	<834FE315-FB34-47B7-9ACF-FC8194FBE8D5@gmail.com>
Date: Tue, 11 Aug 2026 10:25:06 -0700
Message-ID: <xmqqldac36z1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ben Knoble <ben.knoble@gmail.com> writes:

>> 
>> Le 10 août 2026 à 23:21, Junio C Hamano <gitster@pobox.com> a écrit :
>> 
>> ﻿When completing arguments for "git checkout", _git_checkout()
>> delegates to __git_complete_refs(), which only completes revision
>> references.  This is good, as mixing revisions and paths in a single
>> list from which the user can choose is confusing.  However, if no
>> reference matches, or if "--" is given, _git_checkout() leaves
>> COMPREPLY empty.  Bash then falls back to the default filename
>> completion in $PWD.
>> 
>> This fails when "git -C <path>" is used, as $PWD is not the target
>> repository.
>> 
>> Update _git_checkout() to use __git_complete_index_file() when "--"
>> is present, or when revision reference completion yields no matching
>> candidates, so that tracked paths are offered as candidates.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> contrib/completion/git-completion.bash |  4 ++++
>> t/t9902-completion.sh                  | 27 ++++++++++++++++++++++++++
>> 2 files changed, 31 insertions(+)
>> 
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index 38dec1cabe..bd4b6e9247 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1780,6 +1780,10 @@ _git_checkout ()
>>            ;;
>>        esac
>>    fi
>> +
>> +    if [ ${#COMPREPLY[@]} -eq 0 ]; then
>> +        __git_complete_index_file
>> +    fi
>> }
>
> Assuming the prior step was purely mechanical, which I did not validate, this looks reasonable to me. 

Actually the new call should use "--cached" to complete from the
paths in the index, I think.

