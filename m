Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7098A535FD9
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790700890; cv=none; b=LKMuq4N+e5u0WlzREecJSJjCV3L9fTp+Fdv/K3b7CtRIP+P0pFXH+dHtd01RhnnN8TqYt4LmkULjdbNSyeDxO/45B0JpqgJls34fq0gloWEi69RmEDS6azX5/iIEzsWmY/KjWq3N3qoRPCJ2p/mh9oHdm/S0op1bjDt+B1oD0GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790700890; c=relaxed/simple;
	bh=5w8KLBzSFoZkvgkQtBwQ5NfIzpvBc6aMlud5WOAIvMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NAOr9LW9idXaDLtZD3M2Llj9nJKkRrvUEu2z2Mbh7cWT8msPukfFVVrrpyebQrwpZ9qOqjAdxQnmO8BnOpY8/JZsmPFOKNdbFFaQddWNa7z7WwqZMDnyq2/0qef5SwjcOCJ1jEghEEVMbEFAxXuWYiTQb/bUvrUpqDLVmGxHmHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LA449+9U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iVsOXUqV; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LA449+9U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iVsOXUqV"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 855921D00458;
	Tue, 29 Sep 2026 12:54:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 29 Sep 2026 12:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790700888; x=1790787288; bh=dJ9b9xie+K
	iheZ53SCktqEeY4TLMzvWAsY6oeC3g1K8=; b=LA449+9UhzTBfUl2ZXMDAdfj34
	HaqoPsGa9WVmVf3MDKAfII5SeJ3aIA3XeMPn6TB+SbaB8DakY2BnxmTWMD3g6uV1
	ZSvYEDbNvuArtSg/tRHhQgP3grMRnHjcER5ADQgthELrCo4U1uQc3aO7HVZfcGOC
	UwiwhLMK4DqWSJ40VA3Uj6Zv2ddVMYvEmaIxz0YOdTBLaFGpFsHeC0/LqXis61LK
	AWnj06hs5g5Ag3MrZfNzlmcmX3ZJsM2c/NpayygEta14kdxUQDcyBPGzqHs9Vewo
	TgGyujZc5onL2l/4bO3u4mqSe2oZPrshK6gbdyHOkKfKcy1Z6xG8sc3EN8RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790700888; x=1790787288; bh=dJ9b9xie+KiheZ53SCktqEeY4TLMzvWAsY6
	oeC3g1K8=; b=iVsOXUqVQFST4pD9c81onXBsZVlJ6MfjGwhAKI/h2oPcY0AMx1b
	+iQPjctaoad8MfMbc/ay4N/QNZtZAaTPQO/U+kt8TCGNg14AkliN1arYEO7q4tyl
	SvH9Ph9cyvoec2eztADKNayW5Ox75PoKLHT6/64YVtq/bm4fl6S4uuRH42+qTr6S
	LdjUEwye4wcgA0cjJ+PWaaEZbU8oDhw/NYsHiVSrzSVxrlCuxZKVU8yoo0zxaBMD
	wu4MYbWpqn76LhAY+tlc56tiPTT+dhQzJg877sS3B1ECC7Ns50X/K/OUG97jCpBc
	5YKSk7+xP1mDslOlDeva/GasvCkoJG34wgA==
X-ME-Sender: <xms:WO27astihkPrWCN5cjPpg7jd7bx7QWaqyyS3Hayh9VmQWgyrAej2KQ>
    <xme:WO27agczTf23HRpTxgEcCEjhqZmnyauWM4NpX63otgBm6bp6Kkkz5HZrX1_jxtyGk
    2-45shMqyI_DmfOv0xaA0xevXPU8wHwfx29FxbuXV_AGCzVhunO10o>
X-ME-Received: <xmr:WO27aswRFcBzaizTnHLHTIq56i7uLBjUFrNpka-lMhCvXYFiz6okkC-oKJZIFhgXzNW6WHGeQmYa7uXi8kZB5kQNLugDRVeQo2QN>
X-ME-Proxy-Cause: dmFkZTFJDY1w/Ey+cCfjuoBJB/6mRv+tfJYFRYxUVB391HYKnFgY3Yp9vmQcVKicB4esQn
    wK6sAvoOgYc2WjZM+/Qnv5sqHisPJaKYgWUoAhR1mqW7l2RndFuzgWC6aK9keEcIBk3N9Z
    e0+mQVtP8zds0gCRNiNMBi0aIXW8Xel7sPPlOUb1m+sROEBVT49jQTcQBtsJapTYQ8SuMr
    Rw5yh8PvYEEVGvvIajUiV78n4jBkrYunUrHzU7NJH9D3L4kzzOIli+y1cNmLmnlOS9vdVw
    U72/kE96FH90+YjB775NNt2Pzd999ae+TWYm53S9pE6QdZfT0mgFiPHuxg4vL2iN7BpDnu
    0qTVfsnXJ4wJzJ6mJ31Fu1WxXtsC01/lhlI1R3qxS06CM6Zt58RFlyLY/UydnZNDU53fj7
    OnpR0aSdXYqkULFEpS6G6jGIb115LPnGY27Dn5Re7Qv03o6Uwq0k4UMfLIuUwBpybrFWOs
    mnPHjq+u2kbbtGFBveQR275d7ybcbWD6zGbI7Mzl+7J1ze9cc61M5ghgNLP/JBrKfhzPHZ
    8qfDZ2cqv1+NULef3tjaAg+JWLer4Fnx7UsyHKYq2zuE1gX2096ImpuGCwCgjfJvxIJGIW
    TtKQeVddclAq/vBkARxBfjuiNR5FXAHfpcLBAH/emvycrggPzLhOtFf1Xo7Q
X-ME-Proxy: <xmx:WO27auHpJeAL0iVksu56UKkxbwRNbDayUjOy9MlqF7hziP2yfHD4mA>
    <xmx:WO27aozw8eZVCFbEKAyYTgQSa7xNIA4NNubhxmszThRwctmOhuuewA>
    <xmx:WO27anuBxyrqjRUyuefX8BotQ6jmj04JFzNqxlOLG0TI7O93q44Veg>
    <xmx:WO27at22lQSkFjhSvscmPP0ZvQj9NPUsTahULmrrai-uChpd0QLnDQ>
    <xmx:WO27aoMGkoVSjgbgewCB6HT8DjKtOJ6fNsx_q6rsvY7y_mGGWOXNLQ3S>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 12:54:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aleksei Sviridkin <f@lex.la>
Cc: git@vger.kernel.org,  Tyler Cipriani <tyler@tylercipriani.com>
Subject: Re: [PATCH v4] push: fix --force-if-includes when remote-tracking
 ref has no reflog
In-Reply-To: <20260929091319.86392-1-f@lex.la> (Aleksei Sviridkin's message of
	"Tue, 29 Sep 2026 12:13:18 +0300")
References: <20260905171330.34646-1-f@lex.la>
	<20260929091319.86392-1-f@lex.la>
Date: Tue, 29 Sep 2026 09:54:46 -0700
Message-ID: <xmqq8q4khuax.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aleksei Sviridkin <f@lex.la> writes:

> Changes since v3:
>
> - log message rewritten. Two things in it were wrong, not just
>   unclear: it read as if a walk that stops at the cut-off skips the
>   merge-base check, and it said there is "no such moment" when what is
>   missing is the record of it.
> - test uses setup_src_dup_dst and expires only the remote-tracking
>   reflog.

Both changes look sensible.  Thanks, Aleksei and Tyler, for writing
and reviewing.

Will replace and mark it for 'next'.

> +test_expect_success '"--force-if-includes" should allow forced update when remote-tracking ref has no reflog' '
> +	setup_src_dup_dst &&
> +	test_when_finished "rm -fr dst src dup" &&
> +	(
> +		cd src &&
> +		git switch branch &&
> +		git pull --rebase origin branch &&
> +		# the bug needs a remote-tracking ref with no reflog, and
> +		# the fetch above wrote one
> +		git reflog expire --expire=all refs/remotes/origin/branch &&
> +		git reset --hard HEAD^ &&
> +		test_commit I &&
> +		git push --force-if-includes --force-with-lease="branch"
> +	)
> +'
> +
>  test_done
