Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABD0370D5A
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 11:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264155; cv=none; b=Z6MFS+JxEYmmmwOAwQGJNZp04rfFDaCaM/Bt5sb+ZVAFXITS6Gumun17SpMHMYNIfkt/AblQTCWRB/U1eexXXaQwxx1u0JXf8INO0XcoR5Upvw1rmAHqHDk8InfTgEvQ4cFk+5Y4s22sO1ivghFsiILDlAWwLEpaKSsrPPR4sBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264155; c=relaxed/simple;
	bh=Ix+rX8TdnMCGCDMg43yBShl1Hjn7c+Ty0JCiqms0Yjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kf6v9eRsC/lFRT/MuCcAtLG8hssFCZ+ssJzy7tzadVGKF3CEL4Z/2/Jjh66LYQhZdVv7xB4BHbhWU6LeJ3dQPlqn98J9kt/K1b7CBVnRG8khO3gKAPb0PRtty+tWLCyak8WxXxdufbJS7eULgzGGijZiMFeGItoFmbe7G6SqUT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LZzMqLjv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rq92np7V; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LZzMqLjv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rq92np7V"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 296B3EC01AF;
	Fri, 12 Jun 2026 07:35:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 12 Jun 2026 07:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781264152; x=1781350552; bh=eGCUGhfo6B
	uBHLRsr32CMuDrvCZ504QPVqcVNDi75d8=; b=LZzMqLjvp7HfyOpixIdzv0rrBw
	vP8hFK9AtGi+bdxCVrn6C67uvY3m+S/aUu980WeqVJ4O40alVLVuGzRdJv/jcQMW
	jjIXjOLKLfxq8uvMcrjVTHZVz92U9eAFOQB++4IPKw2YVDCHt5SH9W0+LlLHRa1E
	o4EvauRhOfHPrJovkqLB1KFHBVMzyn505/e8YpuKFA4iy0RqOjLZrKKdGjwxh3bj
	mfgS2hudBjeOapLy3leq7RvZc+pwHbTG3dIbnozafnKNk/QDZ5TdXaVO1aKeeF5S
	Zg/qgNMD1KeQzxsqH6klK/6aHD76kxkGNir+vLjWg6Cxm5q4ayF39sBJus5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781264152; x=1781350552; bh=eGCUGhfo6BuBHLRsr32CMuDrvCZ504QPVqc
	VNDi75d8=; b=Rq92np7VGi3fV/j4+6TD6SEwg59IsfkZa2uC2y+jLS3b371eHWI
	BlyPuThqJOwKxQ+RM/LjUZXhh7XIC7LxyiBMYlx8LqAiOKU2SyWyBBlWQmxDJkoC
	684jV/F+naacaYOsE+k+KlDjuCo5RZlt64gu4uT7+kkpFmty8PLkC9m593lWJv/q
	CJXcHUmqvjJIx3y4b4lBY+RA6RlLAlnPKc4Dahi1xaIRmSAchg16GhOEifXTAyaz
	QQYjRPCVoFC1LLhtNRFpz198F8dNrVVa2l3mYS0w/6+xXf9PFNBe0eutYVHTK8di
	PmpjoQ84A+ynGmYEvh/j2Bweh8joy3R+m3Q==
X-ME-Sender: <xms:GO8rajb7AFFWc4Mnt09F7gmD7uWusDLsEnxVnCPYVtMXbBidyvZiEQ>
    <xme:GO8rap1xt3pBS6JvaGGDujJ05J8jvhbKd3y1_wpuWXeTEz6ok55mcwzt_VGCBLGxP
    YdAZdLBBaoJH7Ick-1BnZ0lkTkiZFsyGbgTRNoB6PVj5J4F7JGPzA>
X-ME-Received: <xmr:GO8rajV2aCeb9fAqHtWF2LQs5V5mx6ClpU2JWqBjFIG59pCONi3_Xy7ZUMVqBiLvz6HGc7uboxmU9rZYLRaPjB9rbLLCiTtac4mXfjD4NaA>
X-ME-Proxy-Cause: dmFkZTFOtvkdFI+KMl/oCnj7tORjSP7E4D+0n9C7soy0oTriB7bHmiHJqZznrgKR5hN1yZ
    Ehvf3/w3HhKxrKa5ZrHsmq6A2Z4RbQVyUhmbyBABvZbrKboSejautqL3MOShOMRowBT3Jd
    Msvvg7ST8B8E7pttGb+1UaG8ejscQ1LLwb8n3IA/Ng7kyMlbwpkkUXRxQjZ8AdCsUrPMoy
    JfbCIXa1Pc2qBz7eicfMx7ZI1HwLZ5xuwEvWUgJWP/gclEUQoOPBwNm1d5EA9A51FBfw0D
    GKrsdAAUn6mdF/BAY4Fh2Bj49yg9cccqnpriLCpOJsTCSYCBpZ01/4lNJhaRxaf5Ob10dM
    p9TO78taG8i4P+8EgoXtzl/PhJuPx5zehMzkolQs8XxttHZoHRMlLeehuGFoXNhtDd7cMI
    rNE8RIPpCmX0PHNGa4p7N0bJrQP3KSeUoGhiJ8a3o5xqWczy6C0xwE7qzyGuK279w/9x0Q
    G4eLwTV9pidZtjGHnfatXHlqRDDJArhzg6gIiWLkixCK61BTnoJYkP3z5UC4AfBGteAOrT
    xK8Kd09GROhg1uNSYeFKM/cOdV3biP03LOgW8lDcBRimFeqCxlb0ih2yzofQywoRSIAahp
    /8NvpE7neBlMKre66+WHphOjNy17w0kRuLWLp6PQ5t7iC+XaDMfH8nyon7Gw
X-ME-Proxy: <xmx:GO8rajV2VHkXdGT2SxjRB5FwXnaKQsWBNo6qQO8gsKybdj2942qBRw>
    <xmx:GO8raiduZ-SmrMudJxpvK1LaKjcpLUirGRmiSrXDapMzBN656MqAzw>
    <xmx:GO8rasVxhpUcZz8jFrrWbxySikF9QqFm2oRCfhNti7oA2bAeAnJd5A>
    <xmx:GO8rard45JkTFGPtszq4NIfLb9naUb7bDAxVnPPUPWvGXjus93jyuQ>
    <xmx:GO8rah_y5N8xoVCD1YhUJKJdUHbRd9StjfZ5qGI39fjERyX8nauUqpck>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 07:35:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 24c1315d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Jun 2026 11:35:49 +0000 (UTC)
Date: Fri, 12 Jun 2026 13:35:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH 2/6] SubmittingPatches: discuss non-ident trailers
Message-ID: <aivvE6gVMGWhRbCB@pks.im>
References: <CV_SubPatches_trailers.8f3@msgid.xyz>
 <non-ident_trailers.8f5@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <non-ident_trailers.8f5@msgid.xyz>

On Thu, Jun 11, 2026 at 12:22:45AM +0200, kristofferhaugsbakk@fastmail.com wrote:
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 0b12badf86d..51c308a89a8 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -474,7 +474,10 @@ These are the common trailers in use:
>  
>  While you can also create your own trailer if the situation warrants it, we
>  encourage you to instead use one of the common trailers in this project
> -highlighted above.
> +highlighted above. A trailer that credits someone might be more likely
> +to be accepted since these are the most common ones. But another kind of
> +trailer might be relevant, for example to link to an issue tracker
> +belonging to a downstream project that is affected by a bug in Git.

Hm, I wonder whether this is a bit too vague to really be helpful for a
newcomer. Instead of alluding to such trailers, wouldn't it be
preferable if we added those as actual examples to the list of known
trailers and then tell folks that they can invent their own ones if
there is a good reason to do so?

Patrick
