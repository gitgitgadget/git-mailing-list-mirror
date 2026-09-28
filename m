Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD7B4BB7F1
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609031; cv=none; b=oql4FqIOx52hlgB4H4N9tE/FVGt13p2ueqZbW28DdHFvwuRwyA8dWn3zP2WxPkQBAY618RD3KllvozbhWYBWCmmJpAVsZ09wCDbRlFQC0VMuOp08koQQYEia5QfhNd7jHJhyO1L6tnhVo/9OvvJYThj8FBRoZ2eLw05DE2Wrtzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609031; c=relaxed/simple;
	bh=CULwimxrN42ITP5nJcuEIgP9KXvQc3ZMhl4eQYTGL04=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aixxoEZNauuyOLAW+ibW0nUekE+YKg4l4tpmq3EMiAsU4NxDYWRF8nBHqQbLlkyEibr0DAY+xXn99n19izz31MIYxSxxBimzmePWJp/3/Lj6fqhh2T6lseVPRdYXRvXhuDlfHuwc8OcT+jAKrYoTLAx0hAjfGx0MuhIEYdGPZgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nElFQVFO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tuZgU5BL; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nElFQVFO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tuZgU5BL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 19995140011C;
	Mon, 28 Sep 2026 11:23:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 28 Sep 2026 11:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790609029; x=1790695429; bh=NuiyXQLPbN
	ZRKIX/SxyjDWo8N1BQTjE1xgbAfFwx5K4=; b=nElFQVFOSCeuBQffmXeiYg+cfK
	rpaq1EnCwwa7ubh8ZahauHq7KJExTB1+cOT5Pku38rGRvsadhhF1lMU829fhsnQl
	+tzR71koZh7jHBNuIXadQgIZ+tNImQdmoUqhHDmQtXj9bwcns7rTU0rImH92CIBx
	nzv2ArTbyKVopnkhyfLlgl09HvkIIldc5wEu6a4MT7K0sKNkZ7x+tAgI3ofxZ2Dh
	PRVPU4VPxjzXm9OCAhii7/G55LqFYofFnxdSd0Bo+QhaLjbvBQMgiYvi7FKMxkSF
	tIW6CVdbeJx7Rm7Njf+xV3+GOyhHCNN8Fwo2JijhyhqnYMrGW9eGTWARUE6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790609029; x=1790695429; bh=NuiyXQLPbNZRKIX/SxyjDWo8N1BQTjE1xgb
	AfFwx5K4=; b=tuZgU5BLYJOrQrT3tBAM+FvbFWzng944g291f//W5sMInNQUXD3
	Norio5pTOR257r+lpQEPZo9G+hsQDV824bIgTCfohSZBVJWjIKZoMmacsA6boSgk
	Jzi9tjdLC7nEXi0Tk4UGFyAIDw88FvFKnlYfYwGeCOrgJHqvv4grLRPfwy4mils6
	lGhdMlHZhTWHOh0Xt5503lVY+GybPXrTJaBkVu4dqKmDSFa9Q/YvUvzNNs/OVQ5h
	Opx/XSd82ToirgrlYnR0yoXNQlir7H/C6HNClNyDBpuNZgqIQeR1HjMgWy345W8Z
	OQyH5pUDatY77hCVD7xG5PzD2/xz451aNFg==
X-ME-Sender: <xms:hIa6akDteG6u0G_xjKweHdMKbLQQffE6nfONr-EfsF_slTJH9C3vqg>
    <xme:hIa6aqPFFd3bO0zG0VL-QFl0U_533rscVJHngFmokL83VGn1ipjzOZkt6r3vbSjiF
    VgO3L1bNUvwfc-7D6OUyTJsF3haD512zkOw9uLUkUVt0Do97wDYjw>
X-ME-Received: <xmr:hIa6ahbz3IbpsKpr7burTenIuffl3Iby_okD5J8Vl6TG8uVOELTb-CFWqmqlkLQK14NcBC-Dr2obFdRNwpxiGVQVj2YbZYb-K1Fa>
X-ME-Proxy-Cause: dmFkZTE6gRc1hUMlipN1KbpqV6CKoDyrn//uCrQPc/CQbZr+OTLn7476Ti2ChNhd+LD7Uo
    Bu6hAtWqw6W7mtkxvUMkISjwtmzo8yldKSUZswAo0+5ZSN4NnEZwoYtQAaHif9nGABoCh7
    lH0vE+pNrnUyV2UpiZIJ3X2pgs1QXHnTopU7Etjx/4ygZ99rWez8SOPCyVGF0Wck9fxabA
    5SboGFzG95zZfbnTzunyuIza9Izbnq4oIIqvmpYO8oNElPQASpX8IfYzQhYD23ALTasR2x
    nWRm8LcVoZgzjoTXTDxn//qWnCMjsSDidzGASwwSo9ios9Fuk0nU9DFwnambvkQYkjsZdo
    j6VjU5afq95nLZddufbyKzl1TLvvP8iK+CuPkobM39K7IBXBAlzgrl96EKE4MbQrLZbz3L
    3cWvuBoPOgMR6ewZe3m+Sr8T759KajxV5/ryID3xKWWZuvmNCx8e+UyHV5yt2GtyG6CYpD
    BS/kjhRSAK+b0/7jOto2uvArVebPh7YNkBOmxzaSyGczHetKD8avA24GqNgLIMfQZTIqTb
    IkqNRcHl3de4AxMUzJTmq40sxofxLJJTbOdw7xzdlSSsF+jjDJHocBQgzgcRA4g2YQNznc
    PgdRqLObwdxe5egtJrs4UVD6lRGgIAKwHfXJhwb4/ix3uh37Q6jN2Ju1vrZQ
X-ME-Proxy: <xmx:hIa6ahu0rv6jmInK9mLpnRS3qIE-5uNrDGUKM74wBdEmcWH-vVPpzA>
    <xmx:hIa6arPAjD9JR5ATuGYyTJ1HKH_Tngjr9zS9Glbmn8mdhZhjRC3oTg>
    <xmx:hIa6ag79QvKWg6fjixiWohWnpBR9udvoLa1LIiYeH7tfWPjQs6rr5A>
    <xmx:hIa6apTJ0NDiiLTZOeu11YK5P4f1i0mYsfpbiaeH5DBRwa0-hYRicw>
    <xmx:hYa6aiqz3I96nGEim594MHGD_S8gEB6wMNKl1hQ37fTni5Mi2PQub-5L>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 11:23:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Patrick Monette <pmonette@google.com>,  git@vger.kernel.org,
  newren@gmail.com,  toon@iotcl.com
Subject: Re: [PATCH 0/2] replay: add signing support
In-Reply-To: <aroaOsUFWt2lYOVS@pks.im> (Patrick Steinhardt's message of "Mon,
	28 Sep 2026 09:41:46 +0200")
References: <20260925205348.1210154-1-pmonette@google.com>
	<aroaOsUFWt2lYOVS@pks.im>
Date: Mon, 28 Sep 2026 08:23:46 -0700
Message-ID: <xmqqcxtxo0vx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> On Fri, Sep 25, 2026 at 04:53:46PM -0400, Patrick Monette wrote:
>> This pair of commits fixes a FIXME in replay.c. With this, it's possible
>> to sign commits using `git replay`.
>> 
>> To follow the convention of git plumbing commands, where they must
>> behave the same regardless of user config, `commit.gpgSign` is
>> intentionally ignored.
>> 
>> The first patch fixes pick_regular_commit() to ensure failures to create
>> commits are correctly handled, which can now happen more easily because
>> of signing.
>
> Note that there's already a patch series in flight that's adding the
> infra to sign commits at [1]. Your patches will conflict with that
> series, even though you're ultimately adapting git-replay(1) and not
> git-history(1). So I'd suggest that once the series at [1] land, you can
> maybe rebase your changes and then send a new version.

Ah, the other one says "history" but touches the same replay
machinery to update with the signature feature, hence this will need
to take advantage of that.  The sequencing makes sense.

> Patrick
>
> [1]: <20260912160045.36064-1-git@5ouma.me>
