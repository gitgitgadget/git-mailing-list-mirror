Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB0F37B007
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920997; cv=none; b=S7pYTGkXLf/Fw5hORoHOmuBXGqgyFBrBmG+Epp9jalESYjPgbp6eqBYMnj1OHei+jKB3LNqDtrHnnb5kL5whZLUlmYu2e6msU7bZpwqYdNk+gdIMRzk70e60D3A0tvcpfSIgMkLz3SVfAsLmXLiNcXkFbWHHEXTX9odsbEWj860=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920997; c=relaxed/simple;
	bh=OLmWyvCdpGxNiQs51e+fFf1SIQxuPX4HZnnCFMNrAck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U9HQvFBqTlD0mj0jwSVi6S/S9jfbTWR1AQ44ziFbRnKuE9jceo429UEnIR0iX3AhYwWonxVFvQh1HcxTO+X3x9oINHqOaUXO03agZ1advx1pCZXpIIV0uRCAzWDCm2TbJCE1Xrrs9unwVnfP3lOHkKPzVfdCn+sbfrq1kpZqdDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BYSKtIQD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lVX5wQrB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BYSKtIQD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lVX5wQrB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1EA9E140004C;
	Mon,  8 Jun 2026 08:16:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 08 Jun 2026 08:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780920995; x=1781007395; bh=PThEpS82Go
	br7mANEh6v09kYUEsynkVxBM1ogNoE36E=; b=BYSKtIQDf/F+sRBUwrwMS81Fqi
	/B4vQWTGd5JFKJluzVqKI+t0qLRFc9ycqu3XZgkDfEHyOGysorXz8tGsXBw4Pzoh
	8Ez/fK9wFUJxQ5aYPkJNeRVCnUjc1sbbwygJ/5lGKTMknEgbmzq0oARQBup/97TC
	DfF/HXLn5DHZsJMKQ6F60NCpN2MFAi3K/JFIBTXefwqZtkLb2nhNqt9BMeVdo81Q
	0E1iiVn2G+5pUSXSGBmMuXj2TX6eyBoYToGaH18SyRLPQRroYAXjS/6T9RAmppAC
	jeMArh/1sY/hFiRSv9zIEe9cPPBnX4jN9GfI2K6RnMo2SdGgsBDHfrxTxz8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780920995; x=1781007395; bh=PThEpS82Gobr7mANEh6v09kYUEsynkVxBM1
	ogNoE36E=; b=lVX5wQrBKXGm3MdXYPQAQevRJTjxRPW1tR19jhZIOhLXV+rD2t4
	8SaJhKU56p0yn1UpKLBmnaSHm5TlR6J7Km5z2mMErAPH42QTokd5JhJwk21WKBK4
	SbbZOGr0txqogJZg/+9PhnPmsqouJm7T+sg4LQhSmPyFydkK4UPrPicxdQKrzQJ0
	XwlLIuGWHBqOZMYKei6kxP/nq2PF+cpA4yh9hVYWRTn9DZxI7ZKv37DYkszmwlBC
	T9R9nWhIWhwOd3V15gT0EHLKWny++EHBr7MZzd5vYUCo1JLqPQdXk+yuFg0faaoO
	LiCWpFRs1LMKoXflpMF9A3juBc7TZhUB3oQ==
X-ME-Sender: <xms:orImapi1AzM0m0lIlGMWC3lnf3ZsPS_CsO5l4ULxdiPLMEkNsypmyQ>
    <xme:orImak7IB2F01khwp3FSWCqyMO4qLrT2UvVe52nQOPo5NL0MjjFid9Qs8gmteNPcU
    bDDkmkFLPv4Tk7CiEXiKz-ynFE5Ckbw4uLwcZgm7xnQ514EYaa-eA>
X-ME-Received: <xmr:orImahbwQD3jOiPq2Ws9nMDx5CPhZeHIjmPON0MMlSx3Xw2RfBGw0lNtT4zJMcFzXtHroRofob8kMAWDdB1rreuSVcQRWglLaWoe>
X-ME-Proxy-Cause: dmFkZTETtZqumtu51J9qQh5+/F3QLsgt4N7BSEKSO1Ta7a+LROkDtwmvMD945dSMI+IN2D
    V0P7NVrItwh0i985aV0V7I8E85LsLzDtC1syV05BOn8j4MlC8dz99iXnn85q6+8G1HSL6S
    6sjCd7V7a5JvcfI8YN50PLob1hAm4NwPIZ6lAnsbvH3iZcvqNklHmgbLiPhHSEMF/WN/EU
    EUfNL6DP1BEa26bUm+bP3qbBqVdBu/wLm9Vqw6wOX0RG+5+tbxYQ3fzJIWZhV9FF4Z7+Ef
    gH/5loizmn9tM60p3Wit3PKMfk2svsZXQuGvujjGqkdHZQnzy71OmVCcNQtiPnBPyXpkXm
    cs+32RRUulS5MHV3npBuzyreV5OzKEJFGVyPmwIwKTTgWl7D1lZ+g1uC/WlemvJa4+ngMA
    SOfe8LKkLD4WVnqpFaQmhP3xBbyDXZts5XgiY4XlNhIoXWZLbDkjYS0E/p/mRypN2uOz2a
    WUzeFByyOixQphLKBN2/Tuiq0NMCvoX9QxnC17LHDPzb2MN41/TpfzeTOSdwD09PdX0dpV
    YHUsnMroVCG9c6xLUHUJRNYuEHN4T/627P7xAV0heJ5//UIsTLBIdvHtm0gWgTJMUcumBg
    IIW04CEUY1poojpob/Zjh2p4Ap1N6v2nl5X5aoo/na+gwp0uOGdh6Wznb4dA
X-ME-Proxy: <xmx:orImap4nQ1pEKIjIY4q0KltkBJ37FyORKT0FVaC78-bK-IFuFZ4isw>
    <xmx:orImakCP7YIKC6sBms22uX3yrhd1ZKdKHl659w69B359tOyXxKkVmg>
    <xmx:orImavfX1cAlowY00d196nzDlEUD1Uoul439BGFxH17r5-2jeA066g>
    <xmx:orImajImAttMnJJ8BCuIAmf2pzS7XkWbNcpBN_aqmVZtNOyeX_t3-A>
    <xmx:o7ImalL7pfPwTuhjUF_0kZnkUDUnPJzkShY-b4Mgqf8s1xanIxnn_-ZA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 08:16:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH RFC 2/2] builtin/history: print feedback after
 successful reword
In-Reply-To: <20260607-ps-history-reword-v1-2-ba43a3cbb81b@gmail.com> (Pablo
	Sabater's message of "Sun, 07 Jun 2026 22:07:21 +0200")
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
	<20260607-ps-history-reword-v1-2-ba43a3cbb81b@gmail.com>
Date: Mon, 08 Jun 2026 05:16:33 -0700
Message-ID: <xmqqqzmhz0pq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> Unlike `git commit --amend` and `git rebase -i`, `git history reword`
> doesn't print anything, this makes it feel empty for a porcelain command
> and hard to tell if the command did anything without using other
> commands like `git log <commit>` to check if the reword was done.
>
> Print a message on successful rewords so the user has feedback about it.
>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  builtin/history.c         |  4 ++++
>  t/t3451-history-reword.sh | 14 ++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/builtin/history.c b/builtin/history.c
> index 51a22a9a1c..0f1ba3b531 100644
> --- a/builtin/history.c
> +++ b/builtin/history.c
> @@ -739,6 +739,10 @@ static int cmd_history_reword(int argc,
>  		goto out;
>  	}
>  
> +	fprintf(stderr, _("Successfully reworded commit %s to %s\n"),
> +		repo_find_unique_abbrev(repo, &original->object.oid, DEFAULT_ABBREV),
> +		repo_find_unique_abbrev(repo, &rewritten->object.oid, DEFAULT_ABBREV));
> +
>  	ret = 0;
>  
>  out:

Do other commands in "git history" (split is in 'master', drop and
fixup are cooking) behave with similar verbosity?  Consistency within
the same "history" umbrella matters more than being similar with
other commands that can be used for similar purposes.

> diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
> index 54ea8a7207..4b22d761e3 100755
> --- a/t/t3451-history-reword.sh
> +++ b/t/t3451-history-reword.sh
> @@ -416,4 +416,18 @@ test_expect_success 'aborts if the commit message is the same' '
>  	)
>  '
>  
> +test_expect_success 'prints feedback on successful reword' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit first &&
> +
> +		reword_with_message HEAD 2>err <<-EOF &&
> +		first reworded
> +		EOF
> +		test_grep "Successfully reworded" err
> +	)
> +'
> +
>  test_done
