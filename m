Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DFC380FFF
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783439762; cv=none; b=D/VVyFJU62TLqCcVQuoRZZ7tTZaaCAPg25vQoijfiYo+9h6pZCn/J++dG9oXoav9GLi1GlN3FBVibgmjxZpg4eLAgpJUcn7kH5lEb4cKb0oGjV2NiSS0QWtKgeUKbY+gZPsoqGiTL1WVXJOgTSI0ttonA2Dw25hUrwsreClPyUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783439762; c=relaxed/simple;
	bh=8y2jixZCUVnD1forPXyB7t6D2Wu84J6VIxAPHZgvgFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcoJSRZmRW50NAzcWsG1m4R+ivhvFkWiKYNxeTR5k5Im8tClukKs6Db6XEVowUHfZ/gK6b+dYTYbvbio57OeMSunDAGV4WrXT/kgJOREKqWlsWVgAJBM32h4lmIo46RRbWrDB7xsT8mvv9CecDTA50RNedx4H+Tz6m3VdB8C9oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SnN1Y/yx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E3gHTj0+; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SnN1Y/yx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E3gHTj0+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0455614000C2;
	Tue,  7 Jul 2026 11:56:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 07 Jul 2026 11:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783439761; x=1783526161; bh=6Tf3hV8j3K
	tblnIbeylPjucUZ0m/J/YG438YhwOirbE=; b=SnN1Y/yxgim8H2MFIkbcCG+wu1
	WhYQwr5n8t2SOZJtaWki6/CgOPc7jH3QVY88VP9OZUT7XnJ2J/lvcQrugNy20zU/
	OdBeATVrMxs9QIIuwruV/I1JfGEhZH3VLsX18wJ4RRhpLJtpROXHixpCZ3mKu0e4
	0RxutrOcwSPnU16AVsje68YaV7pmoLKBBI0iGIT7tr6iZQQzMACV/eBAkZKGwgoi
	Dwm/o4xG3Th/wG4zVAJmLtTgmzgLc0yEpeKGCjgPBClLcBymX8hHPOMwNuhcbMLh
	3FI3skrxkBQUZAduuaim0gpWS++jny6DSDcYGmqFat8erYISmNVgAI4PRuyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783439761; x=1783526161; bh=6Tf3hV8j3KtblnIbeylPjucUZ0m/J/YG438
	YhwOirbE=; b=E3gHTj0+oxf1R7weOw1FpVqpXLCJv/I+X9HaxOfbmLGB4Xdn3MJ
	VseSXQwwLglOw3ZcuLOdsl2gA+bc+3zX9G8pCabQD/KwXjRvp/zjXa3T+/B4U/C/
	fYaFOIG+Ve6kPlpsNalb8vYjx/ARbJ5in9gbzFWJ7j6Eb62EgKNeJIEDV6IUhHw0
	oKQ20W4Sw0QBstqJP6T/f1xtEUnKK9FcSUAX1E1epYHz5/av+btOzXU/NBICZplP
	CkWObmxih05IDJMu8Keld305PjHxUFd16zGXpqHe+Y2fOLkkznbOWZ1UDMRmzep4
	pdZVVi1SKOueLqBydbaewcNHwHsXAI3vbMQ==
X-ME-Sender: <xms:kCFNauriHH14Aat993WgulaBdbL7eAcB3m5XgSsAOFHFnX7HD7PTPQ>
    <xme:kCFNakHRtAZEHbXHzWhmKdhzQxHNgscxoLcUAVJKIRnoLpJSDIN2a6-3ssXSDUIyU
    9bVrZfhRKXCOOFhaBN42E_OCw0a6vDVx9oSPJjaAgwHvpNG391ESQ>
X-ME-Received: <xmr:kCFNagmHZ8mHAxfDd-5llfN3uGt6H2H7VLYmMVqwZ3CUP8JX18tHXRDPlTSfmPZUIDOLDY2fqFkNlZwJdS5R5OaLgNcqGE3yZRnSV1xzJQ>
X-ME-Proxy-Cause: dmFkZTGRQWY737Bj+RY5CV+iUbt/3jxoCb9zGxe5zc9oHPytoc+hcxZm9RRAMFCMKWuvik
    VbxtB12Kugn9lcaoRqgHccMbP24ZLJosgFXswp/NLh5PXP+Xa+LSRAuzBiCbbSlsM8jQgL
    5yClx4MNSo8cMJksqI2ZfK/xLKi7hEyLTBOTWmXyQvUsP3gjKtotvYbarjgNnnpT72/IAP
    91G2fzQ8t3qOXDcQxOLwTT4a48t+zgYjsRw9GTF1K3VfDMizG2XFaHjxochf1zabOI42wK
    HOXGi/EzoI2WdEzXfP8BcoYrqbEZQUHI20C78/gGsCX+UkExcXR49vvqwoEAwNk2NiT7EQ
    /Q5jwByRTKZrLAk2yTzWkvf/EetvnBeicGQZxU00is2m9dprWg8Q9utItrUZOU4GxOpBRc
    SwCtSe9NPxTdgcOPF+zPC8972MuzQ5oRPjdyy5tI9KpGYI0bC12Q2vgMlXQ03HBwXXuqqI
    mayKc7XheNQeWOgaU8MeTh4bp3UtUvMKfsaO1IqpOAIj4434ruVgqtnoLsN6jeg3jwOOBT
    jut3WQyy0lIxpcouPr9vmfY0mMR+lS3NvarrPjLhGMBY/BbmdeqK6B12igi2cw2SBQgeu5
    FNVORJvZr82goRoP4KP9Q6aoH/IMq0R+cvYgqePj57N9Hwu+RLLIjMFt80cQ
X-ME-Proxy: <xmx:kCFNankYfffQxnIgzzWUs-WCaBadAhQOk7_VrQjRmCPGp5k31okVIQ>
    <xmx:kCFNahudLaw7v1xMUbfoqcDvBbfKX-_qHcYTRdey9LCrlHlXh9uK-g>
    <xmx:kCFNaqmnB5TfknW5YooLWqF8WAUj_Wl86GB1iPh4u7Ir9sofLUu0SA>
    <xmx:kCFNastCg3PrvD1KDF7VhByBccgDbowtDm7x-6YKJCYPKam8txt5xg>
    <xmx:kSFNaqnvm0tHqY-b14RCmExXVhfndgATAW260L_yrwvDlRRwOHyNIyDM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 11:56:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5a8f99f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 15:55:58 +0000 (UTC)
Date: Tue, 7 Jul 2026 17:55:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 01/12] load_one_loose_object_map(): fix resource leak
Message-ID: <ak0hjKEOwfo9lgkf@pks.im>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
 <pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
 <80ae35227d566977ad21eb6e35f49e1ca5d5a940.1783239870.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80ae35227d566977ad21eb6e35f49e1ca5d5a940.1783239870.git.gitgitgadget@gmail.com>

On Sun, Jul 05, 2026 at 08:24:18AM +0000, Johannes Schindelin via GitGitGadget wrote:
> @@ -98,13 +98,12 @@ static int load_one_loose_object_map(struct repository *repo, struct odb_source_
>  		insert_loose_map(loose, &oid, &compat_oid);
>  	}
>  
> -	strbuf_release(&buf);
> -	strbuf_release(&path);
> -	return errno ? -1 : 0;
> +	ret = ferror(fp) ? -1 : 0;
>  err:
> +	fclose(fp);
>  	strbuf_release(&buf);
>  	strbuf_release(&path);
> -	return -1;
> +	return ret;

Nit: it might've made sense to explain the switch to ferror(3p) in the
commit message, but that alone isn't worth a reroll.

Patrick
