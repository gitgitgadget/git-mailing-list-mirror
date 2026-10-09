Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CF5368D46
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577895; cv=none; b=dicNQ28jCHu4hc9e0je0tZB0Fu7lgxwF0ZvL+L4vKxLonjjwJ7UgMLTF6Xb7G94Dqh6hWFUeQ7QSnmv11SpdnLymOId8ppHDCY7CaXK4xDvFXKUteza+XStUF+M5kehzLy+cV2lTM0wx6m9UuWSGloOijH98gqZrXn2Iqpz4N20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577895; c=relaxed/simple;
	bh=HoeTdrsVIjfh5cL/SWMtSWWaOuLIpg+qDGL4YUoq+u4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FKBBdOW2F9YnpAOjcXjNkOudbMsR5s6FVmYLbxWr26ud7e4emDNVuOj4ipbv872rUkZ8APvveOlWzelqeiQPkXR9fyWx6ICQBIvXu5J+ABHfFUejR7MIyQr6/B0d1nzChAKlB7jX+EiBM3BoIAs03ZDr/556q3V4cTYzxzlqnx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b6EWb+pF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NiSkODai; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b6EWb+pF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NiSkODai"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 74EFF1D0010B
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 16:31:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 09 Oct 2026 16:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791577893; x=1791664293; bh=cVUuLWgsld
	7Q5nRb33rs33lwBBrUE3+AEB71eUT2zRU=; b=b6EWb+pF8M7ZrgA36vDnUt0oEu
	1qx7I6iC0dseLx/e3sI58za4epQ82o7DFMhlMTItCYmzEBgwItOCQLE+f29a86ZT
	96aWDoV625+84kyOPA5U1V/5GEu0ZWIoMXIwBULAAPL/zJl1XzjUmTZsgOhTk4K8
	NQoP70LZxrjtPy1jmerM1S4S33aap31zUTyp8+n5yTblmxtZp+9HUc4UN4Jjo54E
	at+gHI9uIOW/ta9JBF9cXOoxiA2UHSnlQWDmty0zNv7m2ww2ymKS5RhFWDz9luo3
	pX1xsoHUyuKx3e38vFY3EZbtsXQD6I5nCpkj8nXIdMYOaou93ZHFtrfKw70w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791577893; x=1791664293; bh=cVUuLWgsld7Q5nRb33rs33lwBBrUE3+AEB7
	1eUT2zRU=; b=NiSkODai7pJtRTDdtg3ga7bscpDFj4eTCH4xV9tX2EPzmvyyiov
	t9Smxice+MPGTWtPR2byjjtM23VxH1SmTddUzt7uM5iC2MvPxlbDfk+SOWfWVtxt
	smONa9fkxavWdpEDHV5o+ugsfcZCzifnGLyydUO2zWCYNffOv08JEO3Gwj22LuJF
	1Ny/21MyvvMA/pEdsJChbWB9vnOMYUSTg6rXfYM/7B0d6eLao4JJknahhPmDDrqX
	/po1/jam0pwiDMuWA8Xt/KRkNZ3HId5Beiaqv/7OpN/UNDtmwVtmbpuE1OPmy2Wy
	dVXzM3SlvfgEiUjPuHHX8l/qrtv83Yk2C1Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791577893; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:kkFOZqi/+qQpydPFHq0DNl/ESbBiBwv8/E4gcABIj+fYXeF
	rRNIeWTgHankSN1mm8/h4mY/EsLNxeTvq/hETsaliH23Dobi98BOZWd31PFoNCVx
	m70sT16j41Ru7jfIWHw3EIces6J6IADyLZWgbdoq6w6P2V+DyTBuJpyl1Hy3eUps
	fS2i4oMCQxT17+VbF7meAtEOFxeUy1hWLVF5iB7oHVRc1IJeLmw2GB2cHNcVdE8c
	GW6hIG23Iz2IRLC6QBEUpX7m251CYJNkab5LiJFAEC7zlILHMA5WPMJ3TvB6Zk88
	pjtExtzpUkQHGXYrZYzFuWNj+zOdKTRKajkgQFg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:wC0hbcsrba/JZCmNCmtJfeIZ24lql0pMeC4uElAGdQE=:HoeTdrsVIjfh5cL/SWMtSWWaOuLIpg+qDGL4YUoq+u4=;
X-ME-Sender: <xms:JU_JakFdguz9_pg6tWAdAQW-z6BLbaHHR00xIg-mrl2JnglsC7E7yw>
    <xme:JU_JakMBY0TWaYREUOyse2_dC_LNdkfIJqlI7_yPqLVrRe0mBgS5hlt4n-uhQaq1v
    o8YY8fqiBw0yMQD5eOcZsucGXZnfulTJmxlCbOS_d_gpI--qaNNdQ>
X-ME-Received: <xmr:JU_JamdOIPgLwXwUO5Eb4cNOnyRYoIBHZOeFEki7HMT09mvL6MjDzfWbWKxQLAeAvaC64TQzkYmFwYheqgp7i_jveP39yql4fADk>
X-ME-Proxy-Cause: dmFkZTGqzE61sOeE79cnr9/mzh+WTT+hn9yYh+5Z3AeFB1X8Psl95HM41tTdPdFb7Pe5g4
    Tp77rcnTw97nf0U+PuUgekpUTkIb3EkLdBEXyFAbNORvzwWWVQViBegY31DXULR/7I96yu
    AsQtWLgnfVCuALYKr6X2X0e4qh6iG/TRkVsPsh3p5Ri6IgVS/0SyUuL2qzibPhDrFjP9pX
    fOBoBmW2PLgN1Ea4/C+RgxTzQsu9J3oF/+DmPuvFM9lcLukM7x3MaY7uu4lCj3I2BgpY+e
    qY6njGiXzCtqRUlag9zjWQ48Kk+eJzw1lT5P5G2Tg6ywy+2+ZRbWEzK0WOBWtDVnhcqVWf
    iDxRJNbDS+XMKCdhsXhPH8Rik6yjA8d3oKNw8aVqyVxu3hEck3zsGBSyYWh6O9z9+6xGUe
    Bn6lmySUonL0RutODr850eCfi2Nm1ymR5W/NCasDomey5799bKeAHND/I9jkJJ3QIwakrB
    cfYxYQC+934zswqf/6pZlly9/Mi0xu7N6ygFsLYH8DuLy5NLpla8PCTsNbsPrwFLXswNlD
    2yvr5AQ9O32lqx02CE6AT85j/Geo8sk7MN0rbmeaO8REHBO/8Y58kUGB0l3WHgpzm+ihHO
    ea88Xc1rDSEl4GuEBAZpqtUlOG1qXR5yGfKueEQnCA5J8H0ss9mJAYanHEVg
X-ME-Proxy: <xmx:JU_JahsWx8psMJJLONx8pzx5Nd7_5k4L2v32FeaID0FpfZ5VNEnbrw>
    <xmx:JU_JanlomjTmj_hUdlgP8f44JNT1PgaJ90G3KKvddx9fdFmiITeMdA>
    <xmx:JU_JajyLI2E-7muE1DFKeYpZtuXgNTZzF_m1v8EheaK8s17oq5I2QA>
    <xmx:JU_JapN4wwSlfBQ4kWXPl4jhjqM8R8VcN9Jjir7Z3t1BuY1CZ8AgSQ>
    <xmx:JU_JapfWHnbVmXR147wk-Usll4Z9dXhZqVU8W7nP0Go_82TsqbfhNV94>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 16:31:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Johannes Sixt
 <j6t@kdbg.org>
Subject: Re: [PATCH v3 0/2] checkout -m: recreate conflict labels
In-Reply-To: <cover.1791537203.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
	message of "Fri, 9 Oct 2026 10:13:23 +0100")
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
	<cover.1791537203.git.phillip.wood@dunelm.org.uk>
Date: Fri, 09 Oct 2026 13:31:31 -0700
Message-ID: <xmqq33ueobto.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Changes since V2:
>
>  - only write ".git/MERGE_LABELS" when there are conflicts and added
>    a check to an existing "checkout -m <branch>" test
>  - change write_merge_labels() to take an array of labels
>  - use a local variable to store the internal merge state when writing
>    labels
>  - use strbuf_detach() rather than xmemdupz() when reading labels
>  - add a comment to say we ignore trailing cruft when reading the
>    labels file

These patches looked nicely done.

Will replace.  Thanks.
