Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0117265CA8
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098705; cv=none; b=txtZVSg4pSLq/ZmHeWMYEPU/W3N1JB6hlLvNe3TPbOmup8M9mZGfxmpWQP4VlVD5oM94ieC6qOTE7CbTmum3vah4gexTHobHxf02Wh0fpwdTeApEpqHu6M0sfeOgKqkluGEUrYyQT7Qp9rlgl6EsMmRYC3xiBMM6dmwamdqy3Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098705; c=relaxed/simple;
	bh=qROh+93lQU26C+ohbs8Zn0MGwn/193OXT6FeJPC67Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbGgDgku+jb2qlyGJlo6dDG5dl1VtH/MZtUstz5kx4kauJpNJPCuuhLSe6EJzRzoBNRTeE3ZIu+LOCYqFvk/xLfMuUPR0NixRr4/kDam6yCMrGOaH7gS/rhUn+BVnzJSLk8zVKlbOSuxTdH1JVSBwgfYPSVifk7B22e74zyVF+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B/LFcvmv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JA/nbzEl; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B/LFcvmv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JA/nbzEl"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 010EC7A010F;
	Wed, 15 Jul 2026 02:58:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 15 Jul 2026 02:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1784098703; x=1784185103; bh=WxWVp7jLAn
	hB6ASrNqMvZr8mu1RWkQDnvmfvlF4xSRA=; b=B/LFcvmvYEWerVNlVEo0d7NQp9
	i39EWZLB5rjIgqMmBr23i3sAwi8kA7/B9tEdaz8Sj6/sV4jbEwESQuaeTnL2E+LE
	d527wQj25TX/k1Xq9lZn25K8MDeejO3tC9VBl1P+fO29W23ee2bMqpNFnfuMLSS+
	wTD/zF3g1rFlLF7rOKiyQNB6b0N4QO/gs9lJEu/ZnQySCsz2AtBBIbkJAQsMqrf4
	kMOzGZTkT/QyzEYLEA4PGGx/tmfafUCfZsO7JKDouf8ZXXHkHGOllJcVvK5/30Qq
	i5VXXjEBcWSqosEENzB3a6eTRoTA6ONRC21MBM2V+YQIc3aIrlHm3zZCGqyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784098703; x=1784185103; bh=WxWVp7jLAnhB6ASrNqMvZr8mu1RWkQDnvmf
	vlF4xSRA=; b=JA/nbzElog6hJpggZhFM20UvE3VHL20gCtk737N8wTpxb2PDgo0
	UQC25r+JYG8EzJYvwWz+0mQuamepzXyl0qur19J2609ikfhO/Qu/VdTLWlbsIDSY
	o+e09FR5KwrXwVcu0rIabDV45W83Ev+YR/QECGx40zgiQHtdi8+uratVYwWdvxE5
	Irb6yAmVxbCHYQbgHqhShp86VihZ03r0tCRbaT/2+2YOIy4nXhlBBgKp4TgtIfRh
	PwnaIr39TZDdqCdFJVjvdA2YIt/Uiz0BNN38SnrN+nGBojvnRns+twD4IGJSflem
	3XzqSaPY4CrcmuJlcS5okDP4UF4XCcby6Rg==
X-ME-Sender: <xms:jy9XalXouwvTZFzxqdUy5zmqKCQYQsndH6lDK9ImCOhP_4VrqMGxIQ>
    <xme:jy9XatBB7Gfdi6qEQliPSHkaqZJqd1pqd6lFSMvwQE1qJG7KbsaCkLYMUxtmxPMx4
    9GEO4P8RbJEDul_ym2ZsFnzZwMSXE5HGrUInCYUFPCtjgy2GNukJQ>
X-ME-Received: <xmr:jy9Xauzt9sLyUexTlATxdTXkSh4KqwxslpWulpYCIANsBzvZ33vd7W9Hi0E8LkYgv81UFS-fDcQu9lzR8rCj8YYQGUZbRPjpzuUSFY0RH4g>
X-ME-Proxy-Cause: dmFkZTG1WWLcByQmmxMSO/Is/1htfmCFwhWIbKc8tIyFwIy51tFCJGhWeULuMmLOXCSBLQ
    MFx1NYf4CviGlxGqPgq43w2i6MMCPtAwKkpA08/2Yta0HdXwCFPrSj0n6YWWjj4yYRMvdj
    m0qyDTj6SufVs3QizVkbE3H4edg3c3M2MnQPEQDOyz5AjnzUcvuGvK++Z5CbADHe0XZePf
    Q6jFCZT8ntJHMp4+oFMZl5p845ZNgpHlDOSm3eoZSpB2FtBvTnTwkfeVjeecBnDY75Aqfh
    XZnCuuGXJnvxOWBdYCMGi+rojKUK1izkSXYOhntYw2Z1/dz+wA/Hwfa0SczX5RCrgIR7pt
    MdXaqCJ+vqNaG/jiVlaRWloyJRb70UlH7J/7RxOctTSaDSNiCn6Y76a1lhguP5CKTsxDbN
    yPSjh7BUho/cn56hAs6lnwGEBqlFQ1vvEThWmJ+FhtODL1gjGFx2orhuzxjPG1RRvDw+6J
    D51tv43m2R6jyamS6noeRgOT4pAjPxnCTvjuydERIEJVlwL//6iZ3KVtG3nnP/hG7xMZR9
    k8tRtVcZdtlHqGmrnKH64HAkSzhrZiOlcfVyrFuVka1pC36+/Fml0qsf4HJAPKhcXcwuQV
    TZl1pCXSXysqIJMOEWK1H1EkEsjRs4go55Ig0VhbiMGhFdLalj5xa5vh6+oA
X-ME-Proxy: <xmx:jy9XaiDZP8MzB6iJZJRqmYRzyB0qCmmUqbIFIVnrQaGRoqTf9LjTuw>
    <xmx:jy9XajauI9MpitKMZXCc665HprkWypkK2E4nVV984r31MmnIAffyvQ>
    <xmx:jy9XaigyD203wEMuZ7vG77ddxW1daArY2iFbaCWSFuzJduqzrJRavg>
    <xmx:jy9Xat5UO3HuBFT1w_psxqjFcFKs1NiN_Wq5eaARvfWXHcJTnZHIMA>
    <xmx:jy9Xaujuqi2Q-e0-gFBmJ90p8FTFxFQ9Kcg6Nux6OY1wsBOgCyAa0VvK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 02:58:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ad20f1b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 06:58:21 +0000 (UTC)
Date: Wed, 15 Jul 2026 08:58:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 02/11] config: propagate launch_editor() failure in
 show_editor()
Message-ID: <alcvip2czKFiiIhV@pks.im>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
 <0692704d45060a62579b50dd7a2f07da04f435c8.1784069325.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0692704d45060a62579b50dd7a2f07da04f435c8.1784069325.git.gitgitgadget@gmail.com>

On Tue, Jul 14, 2026 at 10:48:35PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/builtin/config.c b/builtin/config.c
> index 8d8ec0beea..1307fdb0d6 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -1313,7 +1313,10 @@ static int show_editor(struct config_location_options *opts)
>  		else if (errno != EEXIST)
>  			die_errno(_("cannot create configuration file %s"), config_file);
>  	}
> -	launch_editor(config_file, NULL, NULL);
> +	if (launch_editor(config_file, NULL, NULL)) {
> +		free(config_file);
> +		return -1;
> +	}

All error paths in `launch_editor()` already print an error message, so
we indeed don't have to do anything but bubble up the error here.

Patrick
