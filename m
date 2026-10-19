Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663794E13EC
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416453; cv=none; b=rSc8x7qEnQbCHE6DRfCX8Zx/M5z//hNQR3711AFW6VYVT4Ky0XrtYqcXdy3kx7zgRmT7KTbUt8UpPmHTGgSFG2dFuf5es+eTEOp8ki/dHtWaf6zUWnrbgyzmBXt4LqYlbBrfiXXFtt953hYqvMbKkmsHShLAO+ioYfWyTdc9heA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416453; c=relaxed/simple;
	bh=qtZaq6fR+5s6TcncFwIZEiLxrk13tZ2cSPi1B8q7qu8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nWx+4buKwBZToDKVKB0SRHWZZgEWZ9kYnRYDK2/kr8ZtcT8W/IXTwnZdW+j0zpq/8Y01oJ50yVmqRD0BLWDcy2uHtye9ZEpWvsliSfMCMpMzz7A4StdnZHP7rbX4rqcxHuUj0r41SXC5oZTfirfQXLx3DusUiDWYUXOjif0Gdmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XUfrS8Ef; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jOtOqiQs; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XUfrS8Ef";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jOtOqiQs"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 818A6EC00DF
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 09:27:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 19 Oct 2026 09:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792416450; x=1792502850; bh=pnYtP0gimZ
	slL9Z53YZ7Ri87jiUEnG2p5Q3j1/1OTCg=; b=XUfrS8Eff/toigqLF1PB4eQAwN
	HCXc7zmjDFuXSGAQcw2zETRmPJyH2ThDgqCZItw2HR+BFe1rqxU7mWLBscCcp09E
	ZotKc5B5EKCpt4yFQrS3an5Xj16LhUCFmBrfUBs62l3c93AVfg/Kfhz14KRXb17T
	EznGl7By2wEeX/F/HsYRBckvk68BynNAFuvKGGi+HNcxJx3kaphj/5dfdLvAzL7o
	qsnvJrD+EP1ZivJ6ZQ0hWB5DV5dy6Do071QAIqznxFVkFaDbTb/SN3SRKTjYTFlO
	FFaSNyhPJYd9c/H3wWbe8FkYwu3HFjvQ5KKVJnD5e8TLGsASOM8/gF9ci7mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792416450; x=1792502850; bh=pnYtP0gimZslL9Z53YZ7Ri87jiUEnG2p5Q3
	j1/1OTCg=; b=jOtOqiQsH3b24vARfQ4dptPh0TpM9MXtfMp9FqEBBfCOelp33W/
	wNOZ7xAfA4kAzok6dD4uh82mjKjVxWG2jDCKQiDac7FMektMbjQzqPQLiKC2vJ21
	gN4AvSu8Q45Cp3GMd1Pb7dj/tgHa2dR4g5iYOas8H1riU2IaU9zXG2nFRCQyZ5Y5
	CRRuHFggx/V/2hhQFT0I8wKVemICUXw/ezTehWOJctQUwcJnoNlKDVGvDot4GxDB
	l8gv7tbfWycrVUq4iVO2MdCfYFFMfB7XcBHOtuhlrO0MfonFVoZmDcV31ftaL3K5
	wGMMQRMDLQs+vs92o0dyJkEqI8CrXwjjWxQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792416450; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:gPIfa4HZbafsKd0NoFMa+pcYhoPRGTnocf3bQAowRjxsfPP
	7PchEHpSU90sN0F66INmOTK+WpwvqrbCilXc0u2YX6EMkis4EKIg+zDGE0dAUvS6
	Po3dJO+y8+oN+0F67k1Uj9B7j0u05ULQiRyRCbAFZflap6ILUSGvtY3ePEunWQUa
	gnbHsXHwqXC98q4ybM2bbHXKh0aZie/LTnP2HC0oCWap49+evsJ3vq6OZMqpnrCk
	ZFGJCPjciZsnfiaLM7h/bEj50pUi4SforkIWYkxytT1eIVNaCw3m460BBNaiRyiF
	vR91jrkjq8+qW6sUiojlm04KE9e/NIqv1fLvtEg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:8yDggZp9orOzZ04A4u4Uxcn9g3PFFPIHzv7XpvRMe7E=:qtZaq6fR+5s6TcncFwIZEiLxrk13tZ2cSPi1B8q7qu8=;
X-ME-Sender: <xms:whrWagmolFBPZVcPq1SrpKhh05Q4831TbdwtsN_NtV2VSE8e_uzkSA>
    <xme:whrWam1ivvfC4WqhlJGbhv4KCFpt-SyP6XP2JpnLaTCWNIJjRROJAHP-GgobHXBqa
    3ZnlLn8w3uOADBMc6smlydOYOeeGAUAS7UpMosbNNfXvZmYqbd5LCM>
X-ME-Received: <xmr:whrWajrk4zhFxVa0WDdpgoGH1it-u0gKoOz5iK1JkXVdrboKjYz9II0bYdclozFJl1Ok8JB0qOi2_-p-o40KbudJ7OliSW0wlCUo>
X-ME-Proxy-Cause: dmFkZTEsfZ6dJ7465i6kQ1EVgpRIwwNFcRHY2AD8CvP/2L9rTS8EO5Z8DvCDmlHJvKiJU3
    lyhV4l1z+uwvXP6bygNa+1CSNSjwAu1VwPrqxr++lEgpEJdnkIKUFILGPuntv9JjiYwMRT
    wycHjHKhgcW7Oywbn5xsUkP3fW/NAetyVyla3MstJJbArb5zjtPv9GUpLTkA7oAYif0ILS
    WxEkf/SLY3AeA6W9/fL5qf1t3BRm/QVBLbX7FanfjNI7YrW/aXqZkSVtW8w7it5qg6Zo1F
    ezVo18w02dyb8OD/zKN5M64nMmw1fYyXlppisqi+MhDdunor7eh39h9eqH4xigaLrmoxSc
    Ly0BxWQZGz1dVigbWYOF7fu6NH9SlMU8dk4e0NNb/mSGIeBNo8hvSkFcwumUL1E37YgSrk
    n1618mUkxpuy3oxCX8AyhIYmaCXcAuFV9ZuJvKo+Ju5M3TJmgd8NQ7rZ8pZsYetu3Q1lO3
    fLexopcQhbUJ8fzHCGs6Obhiqu1BNK0YMH5z1/dhiEH4yBqsxvBEfZsvnqL2VsQ2wKmzJd
    PHyvposDJUFZCrvWdbYsJaypAC8b7iqClWRB8XevA7h72W1Nb/+I25I/GXepFVARqz6bph
    nwp4g7gQZcjGRztO+Idx9/+zi815/3ohvcO5cfw2d57bIYfpzvutO0NCvgPw
X-ME-Proxy: <xmx:whrWardWrIL8SnMTkLrpOa5eqv_ZXJ4O_BXTVlIi_VndyUc-3VEz-A>
    <xmx:whrWaqqLPslHcLQ53i8B-LIUG-JuCSZY0JqToTCBs7aRanPF99lf8w>
    <xmx:whrWakGBalxr2_jF6vXeM1Zk20XUGwMT4Wf0thYn4AJsYV9sueUYRQ>
    <xmx:whrWaiuCUBfgknCHBIcbyZ_BaqTcz3-Yi79d3REu4ujAka6tUxBSKA>
    <xmx:whrWavLWPmUtMWETqv0ZQdQOnZrZY59SwKdRLhb1l5be6ucpirKSz9LA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 09:27:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH/RFC] upload-pack: fix slow fetches from a shallow
 repository
In-Reply-To: <pull.2455.git.git.1792275106640.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Sat, 17 Oct 2026 22:11:46
	+0000")
References: <pull.2455.git.git.1792275106640.gitgitgadget@gmail.com>
Date: Mon, 19 Oct 2026 06:27:28 -0700
Message-ID: <xmqqpkx57rcv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/upload-pack.c b/upload-pack.c
> index 197bcfa279..844bf80575 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1718,9 +1718,8 @@ static void send_shallow_info(struct upload_pack_data *data)
>  
>  	packet_writer_write(&data->writer, "shallow-info\n");
>  
> -	if (!send_shallow_list(data) &&
> -	    is_repository_shallow(the_repository))
> -		deepen(data, INFINITE_DEPTH);
> +	if (!send_shallow_list(data))
> +		advertise_shallow_grafts(1);

The advertise_shallow_grafts() function is written for protocol
v0 and uses packet_write_fmt() to write raw data directly to the
named file descriptor (in this case, fd #1).

However, protocol v2 negotiation uses the packet_writer API.  When
sideband-all is in use, the response must be multiplexed over the
sideband channel.  Because the updated code fails to use the
packet_writer API, 'shallow' lines are written without the '\001'
band designator.  The other side then interprets 's' (the first
byte of 'shallow', which is 115 in decimal) as the sideband channel
and dies with a protocol violation.

 t/t5702-protocol-v2.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git c/t/t5702-protocol-v2.sh w/t/t5702-protocol-v2.sh
index 7e69ba7f84..df3ec8c1c9 100755
--- c/t/t5702-protocol-v2.sh
+++ w/t/t5702-protocol-v2.sh
@@ -15,6 +15,18 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 start_git_daemon --export-all --enable=receive-pack
 daemon_parent=$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent
 
+test_expect_success 'fetch from shallow server over v2' '
+	test_when_finished "rm -fr server shallow-server client" &&
+	git init server &&
+	test_commit -C server one &&
+	test_commit -C server two &&
+	git clone --depth=1 "file://$(pwd)/server" shallow-server &&
+	test_commit -C shallow-server three &&
+
+	git -C shallow-server config uploadpack.allowsidebandall true &&
+	git -c protocol.version=2 clone "file://$(pwd)/shallow-server" client
+'
+
 test_expect_success 'create repo to be served by git-daemon' '
 	git init "$daemon_parent" &&
 	test_commit -C "$daemon_parent" one

