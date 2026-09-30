Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7F92E285C
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790800838; cv=none; b=BFxntYqpWLPSh8KJtjFQegwVzaDIFDBiRJG6HNsCqKdkGmcobhAUckaxZq2gOhH26PFyUVGjAnR1CY328uzsE+YcGULGRcwgMDAsJFFlPIffuS7rpK6TxWQUVUuQNhqkii+8OkiTDMnHCv/irC5pFJ+Wrc1Ca5Nq8qe8jKV/Pcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790800838; c=relaxed/simple;
	bh=RWIcZFOJK3FTfgOnXvV7W4WSm5gqzcqNxx10bX1jaNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ihQObVWUp28wsA3TMewKJTUi9wpvUGcJoVJ/HFaoifY/GmqdJaIQPpIe3vNAx9SF64TFSlQzMEKWQ8ufyYv0134iRWny05PplVgPrWF0f8neBKi0vj0p//XnWeZvjB7cY1e1tBpE4z+XXxjxxrvcSd/TMb9ft2B3yEo3WtUEwuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cK83ZOO+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z7vJMekz; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cK83ZOO+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z7vJMekz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2B3601400098;
	Wed, 30 Sep 2026 16:40:36 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 30 Sep 2026 16:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790800836; x=1790887236; bh=Z4zjIhnCju
	Oy0U/4DOwZlhF5yFnUickV4Ccz6YYkAH4=; b=cK83ZOO+vlL5edQfz3R8zuf6YA
	bGN1pDKvUaxjRQ4EpMxiYVsLFtFgqGisciPwsKirg+ogqiHOxclAOT5n+wPWly55
	0QQImefgitnyyAb+Rg5RUnkhKGEGu/6E8STLIRVSx/DiApEBB7z5Q2h4epIwtxQx
	wjWzkKnKqiSC8e4M1lJW3gbhn9oKzqagyzba17Z5jDOWv5zQnMk0IogrgtgBOKmu
	gwxGdMPptZH0dyOycePZCqjp7TP4kITVSZwMZt7MiiStEDIjMS3nBX0NrlChPb+E
	fCw4rswOpZJteF5dIYp26VzLkhj9MK63mfocQ40Wkg5/X940RRk0FdFN66IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790800836; x=1790887236; bh=Z4zjIhnCjuOy0U/4DOwZlhF5yFnUickV4Cc
	z6YYkAH4=; b=Z7vJMekzkL5wntThOQmMXzfdDnJzMc5wMCCFvUJmZtpY5bho9tJ
	DKsb2/ClxRSax7ooaA1u6ErUK7DFhxAYZZ0Z5Cnw4KhhN1HKKnxFoKc2MujXid6+
	zI9Uscq/5eUlsdx/GEW5NjyC8DVjMczRWSUj6BaPEDKJASGcQDHudx1Vw9scBlTR
	M7UqMgFk5auGluxP55cKqqxRUZLOj6AKFDLZunN8M9x7mtAoQCQFM02Z2GUm6Auz
	nuYwGGeghn4R2UdNYBXPj8NfMxMq53+YfpdUNZwJLxCelb7re5vKBpF7K5k2WQwH
	Kkl4L9Srq+hX9dptBcJQeGWnrw/28EX9Hbw==
X-ME-Sender: <xms:w3O9ai5nPUqFz3csWtZC8CtK43RL8XHe35qguF2sRRc-C3DG0yfplA>
    <xme:w3O9alOyLa3hKkw4f5sRD-lq0CJQVDKHSO8FfucdOAlnHXANPewtTRvndgdl5sIiO
    x-eJTBZ6sVHrbcz92Y_QfU2Ef93h9kA3wr5ToxFq0TyhFN4SVdiIw>
X-ME-Received: <xmr:w3O9aotOpY-zDTEJyaAsCas6Ku9n-yvmbuHRj6kduBQmFLVz21dkCqirQ-UHfYcZjTicqCUalExavnBJSxx8B7OqQDG7ICdHN8Qi>
X-ME-Proxy-Cause: dmFkZTEq0t1Sy0tIm3nJf2Q1mM8C8GiPGnlxroDO2O5xQo3cxXWH0f7xZ4AdSnT6cm9F2z
    LeWgL81ThFAKUbFx8C4V4NdIKi24NOkxCDx8GOx8S21vV3UEtbxAHgiGN8sgOAmufFZyJi
    UUn3sHbHXMtlF3qtmQR4B5/MYA6/tVyGMRV/8Cmb87WPxhM4XYGJnukaiM39S77VMpVT7d
    KAI1YEronx9GPzw4L5LX5hZ1RYMM9UOtOTVnN/nzNFgvGfvNMeEwPUxOALCyHN6A0QiqKl
    i3Da24Dw0MU/a2EmxFtD966R7l+EiYhdbMgIbOEMZunUe6ucOP0mFYLhKDE2PMgqK38tAt
    MI2Z4PcGi20470bAYv8VlAC57u0kPN+MQ2viBtf+vE0CmgA6keoOsgiSYRqtGF15Dr9lpW
    Hyg3N2lSx66HhPhFZ3DgVVhYNuUzPSTZ9/vzYraAVmGF/zc90B3OAUJIWqcFhtKaBOBVTr
    DOqhYlxe5Bs4z/AJWluT1LguJ8DVPBAmWPzchFXqW6yo7LCowl7JTkGPIHM9C7A8eAITSI
    pZ1my52X8Q9ZCTOqt2GqTHZRaU2ri8q7/t0sE7L+6HOt8A4yuMirbhMQ4qVdF9lSwrQG5B
    o3xhiBWFIF443+6ABgUA4IYyH4AoRbvn7Go7g6U6Gmnsuo0rNUSqT07TES6g
X-ME-Proxy: <xmx:w3O9agZyRy8SRtCPDSDs1Dn9VhdPHqIRpqY8NRcpuhwvUIOQOqeLjQ>
    <xmx:w3O9aixnbbF8F4dpDcA_CF8Rg54nNKX6kTtDKVxHcslnN89TmjNKyg>
    <xmx:w3O9agh6pBmoJl7-2yMW9Ji5cA8yUwkK26eir5z7o0R160VhbBXvMQ>
    <xmx:w3O9amkBTwsZpYrRZ_CAkzgDUZEWPnDK2TBGJDSa9q03hYZBPx7juw>
    <xmx:xHO9aq0WroNNVvhherTlbrNcO_ST-3tlvZjaND1KLZc8FyBWqxT-qbD8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 16:40:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,  Elijah Newren
 <newren@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 0/2] checkout -m: recreate conflict labels
In-Reply-To: <223c99ea-64d9-46da-9631-ed8035f1a062@kdbg.org> (Johannes Sixt's
	message of "Wed, 30 Sep 2026 22:24:33 +0200")
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
	<223c99ea-64d9-46da-9631-ed8035f1a062@kdbg.org>
Date: Wed, 30 Sep 2026 13:40:34 -0700
Message-ID: <xmqqmrsy8ocd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 30.09.26 um 11:48 schrieb Phillip Wood:
>> When "git checkout -m <path>" recreates a merge conflict, it uses
>> the labels "base", "ours", "theirs", rather than the labels used by
>> the original merge. This short series teaches the ort machinery to
>> write the labels to ".git/MERGE_LABELS" when it switches to a merge
>> result containing conflicts, so that "git checkout -m" can then read
>> that file and use the same labels.
>
> Would an index extension not be a better place to store auxiliary
> information about merges?

Wow.  MERGE_HEAD, CHERRY_PICK_HEAD, and all others replaced with
index extensions?  That would unclutter $GIT_DIR/ quite a lot (for
some reason, I find ORIG_HEAD is a bit of eyesore).  It makes the
information less accessible, so I am not sure how I feel about the
proposal, but it is an interesting thought.

Thanks.

