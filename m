Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEE14457B6
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 20:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800640; cv=none; b=B75RiNHl0yqNg8GPNFrIS5qj2o6jlFW3M1v7/dz1535Ukke7Vb+lFNufJa98ERuyJ9tJn51Z6kra6p9StxX2dFvT93olGqJPFcLpdWB7sQfFfJl349+1QIPzy6Vs3YgBzytpai4PJVCHiiKojoNwkt8WKUE1v3SUSUHmao2nsmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800640; c=relaxed/simple;
	bh=JQ6jeKi1CiXnboHKfe5HfyWKoVqf+9PuNnuqjvCoA20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PeWnBOrjuFUd4H07+QftaDdu/IyvYm/bizxsf5sR/ChyFZEfRSgi/AeUSer/itwYJ5htJXajEduzpFEtSNXYB8SeJpNVJqtp/n8ojTk0qp+OpHk6PJFxcgShh/SiCLqgcN6lLgE9iYQmrVgHH9lwez/j0iSIErMPjuZXMl2IBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=I20voQxW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NIFqYNRw; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="I20voQxW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NIFqYNRw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BFCBE14000BA;
	Wed, 30 Sep 2026 16:37:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 30 Sep 2026 16:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790800637; x=1790887037; bh=RlY4RONvum
	9J9CixswnCXw6siytr32T0cL2RdDsivGk=; b=I20voQxWhry7+FApooDgrWd5TO
	HtllJSHky/PKaTpSACUlzBRFzivzfhNyI+RbvokXCB4hdZyWHX4Q/+91Q12q4WGu
	C+KXgaJQQVXXdqurGIlSLGkUvZuKQ9xB7OK7i+C4quvJQ3KQfb36/+RIGTjDK775
	TqeyY5mkX1HKw5AKOty25xRiRL6eIaA9hMCecY673cXxCJWbAEEPKiWn/TPftZTg
	+LOukfg6CjzHjsuZ/Yf+YW517WndPHLRkV5epjwyojV+97qFMNI+fiQxQc3rDJCX
	8UDzf75ecjKsyk/t05BUvkN1ZROVT5W+0WZK6Wf/rJ6TAD4BXlXrg9H+FhQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790800637; x=1790887037; bh=RlY4RONvum9J9CixswnCXw6siytr32T0cL2
	RdDsivGk=; b=NIFqYNRwbuDmqzFUeWkyXtPhGNNkiuGxhyLIHIrpwXVH0RrGU7v
	aHO5eJ2VM5g0eVE179oAf8OLuHz4j9BestYaNLUMQyuNkTdbAr4HEDMjtao4mBga
	hHXQCQ7/if+BVBhtyfA/OZ5Pn5A75r46upQndsd2HMt3lzaYZ9JzlR984IXNtIaP
	WLy8JfhDCyMcQ0111cDfxAoyfFVkpOR48O3PF1fhfBiuERPXAo/vchXBuOTkVv2E
	2ujpeQnLw1sSwxGjn/l876He56b+1D30t/+M/hDdqh/nx12LSGtunAWW4Ak84zfB
	VdStq2kvlNG2RGUrBhN36Qo6Udv72c+5zow==
X-ME-Sender: <xms:_XK9auSo7kbXP1lUUNsXWM8IKx1NU0NmFCaUK62bfBgWffQDFzzCmA>
    <xme:_XK9aqqntySwVU4BMoCvONG9h3Q7dmYEfD4cvO8Cxn8OBmJGXXL0Z0TH7mNpN9wzj
    aPRxVD8jaHPlXWwIIxuBHPiWWwtXfQbzOHvNTJiuAz7rl06XxE2-dQ>
X-ME-Received: <xmr:_XK9akKyn0KoVJu4dFrv-dXttwytYbaVp65YAvIklEtHFuZExGEU_L3xki3HHy0gLg_5nRZBJitz_LpE2yiAcQt6my38GpH513dR>
X-ME-Proxy-Cause: dmFkZTEq0t1Sy0tIm3nJf2Q1mM8C8GiPGnlxroDO2O5xQo3cxXWH0f7xZ4AdSnT6cm9F2z
    LeWgL81ThFAKUbFx8C4V4NdIKi24NOkxCDx8GOx8S21vV3UEtbxAHgiGN8sgOAmufFZyJi
    UUn3sHbHXMtlF3qtmQR4B5/MYA6/tVyGMRV/8Cmb87WPxhM4XYGJnukaiM39S77VMpVT7d
    KAI1YEronx9GPzw4L5LX5hZ1RYMM9UOtOTVnN/nzNFgvGfvNMeEwPUxOALCyHN6A0QiqKl
    i3Da24Dw0MU/a2EmxFtD966R7l+EiYhdbMgIbOEMZunUe6ucOP0mFYLhKDE2PMgqK38tdV
    OhhWuaMyLArhQckE2ig4duu9qoJtnNE/Ot2u98KTe04EFtzeIb3DF2zkgwqAMK2HS6cFYw
    TyH8Kw+7uJ+m10Ac7vAcflL0unis0wZcgTqB351mEBUGdvWpaIEhdF9zD/ObubD4YSM85m
    pDKCKiGYFD7jxmlX6O4As2zeXElYSlduLG410dbiJvLoeK/wZP4sIvZGRKfeMJ/Z7CznxB
    js6a6aUK4cZOH1vXI9N4It9FqgHD3xiI3BLaFj96NiX4sKxRUSUz/rEDyXY4WIXszyxPMY
    8kKw0WCXKijbmomEaaSVjxMePf3lePOmdVWHjYSn8jfagCErlth/AkyMlY9A
X-ME-Proxy: <xmx:_XK9alpcn-44_sWdovlTOGJAtkqxfcFWfmx3lsLQ3gOMb327kOZNIg>
    <xmx:_XK9akzr4CpH4HbCLUiqGgsT-R2isyTHw3Y68xW-RfltLXuvh4A-TA>
    <xmx:_XK9ahPRNiv8I-gSq22wHV4umtFIy7UxfHevTtmnQ--ydPfs413UiA>
    <xmx:_XK9ah5f6zO9OfVsRahhH7q3AWo9Y-rXvWh4VTSUWTNY4N8gzof67g>
    <xmx:_XK9ag7zUN89laUkJZj3NnBGNGKb3bC2C7KiS7xCaOBxs9ui_vgdvfsk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 16:37:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Patrick Steinhardt" <ps@pks.im>,  "Julia Evans"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/7] [doc] Add new gitmergeconflicts man page
In-Reply-To: <5ba2088c-4919-465f-8892-4ed0685f81ea@app.fastmail.com> (Julia
	Evans's message of "Wed, 30 Sep 2026 15:53:17 -0400")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<ad4853dc36cdb883c9a8dc6bda747a5ea318e7a8.1790261062.git.gitgitgadget@gmail.com>
	<ar0MVRV5X8zgZfLy@pks.im>
	<5ba2088c-4919-465f-8892-4ed0685f81ea@app.fastmail.com>
Date: Wed, 30 Sep 2026 13:37:16 -0700
Message-ID: <xmqqqzia8ohv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>>> +to include merge conflict markers `<<<<<<<`, `=======`, and `>>>>>>>`.
>>> +For example, here's a merge conflict where both sides edited a list of
>>> +fruits in different ways:
>>> +
>>> +----
>>> +FRUITS = [
>>> +    "apple",
>>> +<<<<<<< HEAD
>>> +    "cherry",
>>> +=======
>>> +    "banana",
>>> +>>>>>>> add-fruit
>> Hide quoted text
>>
>> A bit of a tangent, but sometimes I wonder whether we should make the
>> respective commits a bit easier to access. For example, we could put the
>> equivalent of `git rev-parse --reference <commit>` here for each of the
>> sides.
>
> Personally I'm not sure if the commit ID would do much for me, but I feel
> like it would help me if it were possible to include the commit message. 

It would also help the resolution, not just committing after you are
done.  It may not matter while picking between cherry and banana to
show your personal preference on fruits, but in a more involved
conflicted merge, it may help to be able to view "git show $commit",
"git diff ...$commit", and "git diff $commit..." where $commit is
the "add-fruit" side of the merge to understand what they wanted to
do, and what we have done while they weren't looking.

>> I tend to forget that by default, we only render ours/theirs in the
>> conflict. I always feel like that makes it way harder to resolve
>> conflicts as you don't have the context of what the code looked like
>> originally. So I have diff3 configured locally for ages.
>
> Every time I show people diff3 someone tells me how happy they
> are to learn it :)

Yes, we should encourage "merge.conflictstyle=diff3" (I feel about
this strongly enough to think it should become the default).
Knowing what the original was before one side wanted to say "cherry"
while the other side wanted to say "banana" sometimes helps a great
deal to decide what to do with the conflict.
