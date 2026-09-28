Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2E536A341
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 07:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581307; cv=none; b=g2SXWrteAnkHVOyrxStOGsG1IGV34xExKX8lr0evNlo9LNMTsg7y2tN6SCbLsx75EbIQ0ky3TfSuETUU0CLGarJp/fWKMIvG+TaX80xL6pulh/sK5hOfMSXP8sPUffXUbpDAcu3onZKgsg3V34ARBiDzEaVCmBm2ShMyE4Oaaw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581307; c=relaxed/simple;
	bh=6VDoGvhg7WQiLV1qtU5xf+6kKElYjnsJAA19XWeyG94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+4mLSPatee/UIqXwb+e2WLTY65ET+Oq8/5NvPEHe2Qx0OaYNjSSwmmrJJSawzm+4yXQXDc1HEgLwfIP9JyBi9UisCZcdBN8ZYjNJyd1bssPu9wdFU7pYTwzx5c4DmkHkXHDlRQmFy7efwgIp6o8X9D8G4UB1BXWRkSjAzc6drA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZtagsTng; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N0Y4kp1s; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZtagsTng";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N0Y4kp1s"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2121CEC00A5;
	Mon, 28 Sep 2026 03:41:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 28 Sep 2026 03:41:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790581305; x=1790667705; bh=gpIwvIdD39
	z8cWVYp8rjw5tSvSlt5z7zA9mgW1mdxO8=; b=ZtagsTngwfXgYVVsl5aVrW2aPN
	U8k9ryk3OzafUO5ElOrQIHZSSdud5cgU3K67QcKAWEP7z7rMhwPNandYagA+B1cw
	H/ila/PDDK2MRox++R7LYadEaALSeb6IQd2aFdEDAfmC8YrYdgMPH0WxWE6740Is
	cwFdSVLfPNwg8o0aajQR0xzWAS6sqMEa0Baai8qBWcNwZ5wBv+CFwpfps0tYhRqG
	d/JWkDbBbdiaCbGQk5rdqJ+q5yy7uyEZx7+Ey1SAW4CQ0WyXDBeQa8Z+0mQSWm3a
	CdzFEQWuS/56rK4B3GX/IdVDwqJ0tM/JyZo6usykek3146QgCKTQ1GSWRL9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790581305; x=1790667705; bh=gpIwvIdD39z8cWVYp8rjw5tSvSlt5z7zA9m
	gW1mdxO8=; b=N0Y4kp1s+LgWIimSU9S/LSxkxWT0tqHD62mI40afTLqOKkQIIu7
	c0WM/m+vZFAnX4WKLM3NpHt1TGKMSeAnNCpQZjEhmPD6idViGri181CrMs0E5awb
	WzEjcFrOBAZUTzTv9tyqt0uo9GvD5FiONV7K6kYVn5SyhOW5vc6hGfHALV/ochD1
	kCEgQwDnvVMJJtO1rRQbI7CRpvAiZLYnZ5VHKWQ/vZcho2bNaIwMtxUhx0bzsy2+
	dqlnGCySGGlgyMNkpv0aBpmLlI/qyiRATQucbhIbeLnMXZI7wXEJLueS7xpPz+Px
	Q1l7wPTN8OjFEiiueVwIveNuWVm3sPdFArw==
X-ME-Sender: <xms:ORq6agVioGzN0K3TetoS-p73bx_AZu9QqcEzrwskPyJb7TryNshrkA>
    <xme:ORq6arn6JG7gV-hIN11sbFofjo-we-2m6peJdIrgCEAjkso8xJuLWcPACuIiLUwe0
    JBfGYxdUMZ9iXS19jvSP33-BLbxYv2FwGpfGuv2p32YWGom_C3emrvf>
X-ME-Received: <xmr:ORq6apYEdx2WInZFt5VN7aOsE9IzI6G_EpIUXg4lp6ZCe91S0yV_rg>
X-ME-Proxy-Cause: dmFkZTFt/wpTLgKEMMtRlerCaOswsXO8nG3jYoTEAcpLcDqOcskYUW7m0c8U2JMVgT0CiU
    NTxziYohNW8creqX0hNGmUOQyiJykKFObmev/WJnyU1YW6i7lNs4UDASjzzc4Nxdnl09RP
    Bz0UYWsFIIi2VeJqsn3y3+1rNZV9rtU0zCRPo0Xau5y3f2x3jbWapU71BeqZK5ZeJHyjnF
    LQ8Eq0HZ7NuxfpTEXidMzCbwPR7ZMN7RlWCfHYIlJE6LmZMvl0Yovmdpxp0XkYXJPks8AU
    qak/SqH2ESfATdCgWoHoJ+PkF0TPdlY9UbjCCeyB1gC9SK0/3myBvhdsNALA9t5z0qapHZ
    SOPlJBq54470PSb/e2bTnAtbafmeJVMiYG0E9ryNH/SCumYm6HG4/YrhAN3LYFm9kDqYLv
    IxYcdJvPEtm4Hd8JNDONq7Hozx6/ts6eQ2MlYK+HPS5+mjFQTrCInxrJzeerzvXq23pMTp
    RsobtGr2UIBSTdmjWWVON7s86Q6a3edMyn6PVVMmW2UAIvM80tgTZQzJBix9U6hcSS19Mh
    1TvK9pGsSnffadCd7ozawLwCW1XEaMs0E4Y0jFIj/I0zuiAaCEoaUjcKBb0ES0v9I4bM6q
    UcyP4XJCUhTswH0DG7gwyPvScLWUlPW75rTEQeuLmb6VQf/MDVNXGqejfFeQ
X-ME-Proxy: <xmx:ORq6auPFM6F-QWwHKCv3DYdJdjaVZJasmcD5MT6mVvlU6mR7Y4J5Sg>
    <xmx:ORq6amZpWhvgTn2nOAju_GSMsV2l60DypWkTvVmTSL3ZAU4p8M6D6A>
    <xmx:ORq6ak3Szsy1nQHa9dwoe-o-R0X-lYCHdBnC1ae2qpN7-3DFARvdpA>
    <xmx:ORq6akfM5zFusDKse6croI1KNMEm4sEzh8H8cfrxVweS_NAI4oSyNQ>
    <xmx:ORq6aqILY3OqLLp82YrvWu7b72gtkYjbntJbgXMYs9nsnM1ujSgKUbas>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 03:41:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4c7b2f05 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Sep 2026 07:41:43 +0000 (UTC)
Date: Mon, 28 Sep 2026 09:41:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Patrick Monette <pmonette@google.com>
Cc: git@vger.kernel.org, newren@gmail.com, toon@iotcl.com
Subject: Re: [PATCH 2/2] replay: add the -S option
Message-ID: <aroaNcYqNIXcnQ-L@pks.im>
References: <20260925205348.1210154-1-pmonette@google.com>
 <20260925205348.1210154-3-pmonette@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925205348.1210154-3-pmonette@google.com>

On Fri, Sep 25, 2026 at 04:53:48PM -0400, Patrick Monette wrote:
> diff --git a/builtin/replay.c b/builtin/replay.c
> index d39626a37d..87c628e2ed 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -113,6 +113,16 @@ int cmd_replay(int argc,
>  			     PARSE_OPT_NONEG),
>  		OPT_BOOL(0, "linearize", &opts.linearize,
>  			 N_("drop merge commits, replaying only non-merge commits")),
> +		{
> +			.type = OPTION_STRING,
> +			.short_name = 'S',
> +			.long_name = "gpg-sign",
> +			.value = &opts.sign_commit,
> +			.argh = N_("key-id"),
> +			.help = N_("GPG-sign commits"),
> +			.flags = PARSE_OPT_OPTARG,
> +			.defval = (intptr_t) "",
> +		},
>  		OPT_END()
>  	};

Okay. We can't use `OPT_STRING()` or `OPT_STRING_F()` here because we
want to set the default value.

I notice that we don't start to honor "commit.gpgSign". Is there a
reason for this?

Patrick
