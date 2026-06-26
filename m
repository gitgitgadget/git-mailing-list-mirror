Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A5B3E2759
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488582; cv=none; b=EccPXLlmK1XWc9HaPQVtDDRT0LlBsx2KjMMOBNGW9jP47PiKGaGW2v7ggcg4O4JJaZ1nwYJGncpUJQct0pNRJCBS54aTOu1ZcvFende0aOe5NnbHz0y15oIR90LnAueI2WZ78kY1mPuGpf1cvZcKxgwEgzlHWBwctCZVtCQLhLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488582; c=relaxed/simple;
	bh=HGq+1q6d3zbw7LP2pzBlLbwT5mpecbYIJBSCFB321i8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RqzIMPGRommc4NqcPCJMItIqiaPjBkiUPzyjVQJdqCkziL/OD9qCHczGowwTwDadAjkIB16cEwQ6ASbEdwZFvIdaJ7UKNVyzDy77RloC05ERaql3Ocgdehh5oxeYF3d/Wm9dmMZ+rAtrKy8CsjxAdZsTTjhQWfULkeZ2RJINDWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WEP+wdKv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=le5Gdedj; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WEP+wdKv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="le5Gdedj"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 27C927A0174;
	Fri, 26 Jun 2026 11:42:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 26 Jun 2026 11:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782488579; x=1782574979; bh=91lY/syWgs
	3hfhkNA9RWQqdMZaObl+x+Yq/nqV4g6eg=; b=WEP+wdKv5JuuBpz+7vQfmdaL5X
	TuF9shejzWShvZeAHhETM6jn7cclFaz45SSfc4jN+OQL7Ut2TBXZWNqoHjXfz/P4
	4U3/AgLCChVlp4eFB++QOKvsEO/QzIxFEcJSdAh/Jt25JosY/HPA/w/5crqqGbI4
	OJ4uSTYIqLUWk2KqyqxDGsA4Srq7Nt+4E+7QW/gVGaWveNu+lDgz+tMHN0RvzlvB
	X5JnkgdLvpaZl2L00VjutTfyJECFeTeai4zc7Av/p13lrEvqRwti2g7gq5F9cVDo
	uSrFyzDFHrR1j3P6rH1916wtvz4VggQd4QF2+W3Rr0om4mIvaW7soiRGutPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782488579; x=1782574979; bh=91lY/syWgs3hfhkNA9RWQqdMZaObl+x+Yq/
	nqV4g6eg=; b=le5GdedjA4ETsU67iwUvqKV5CgSt1duiuDqC+05pO/qD87uaGcp
	0TaNcuSfi9k8ZwwcCBiqntI4v5vjqp6jHkViblwizwQYfBYIO9/cfnqN0N4FoVl2
	CKw/FglwMN3xnb0G20EvlDYf7zVzxXpPNNgavFQDNKgNIYmyi41wSdCdXTkIAlL5
	KRI5jC3Q63fZ+ray3uhd+z/v9OzWTtuuZd5XOQ1cOL+WKNjPTUFsQcItsa4eLw1c
	EwhDTaYQBbgmAJ1zrwOHtEGJWWz+qDiFu4wRC7S7xoyBhEa2g7TdvA+BAMGBA2NF
	rq13+fdh8x2moaaFYzQrUlJV+a8uUh0jksg==
X-ME-Sender: <xms:Ap4-ahEt4qU6Nhbcr5cMsROT6XqBye2uAbClmCKZ3skfC8A9Tx9gug>
    <xme:Ap4-aol6RB6rUw1BC7LTp4Oo_ldVuzwmD0ffCQ1SPP4sA7h6vT3lGJkscobi3OUZO
    pWz6HArnA1pB2T--YdYrLMR-LyDCk2kpiMN499CAe8OlHOMBl_P>
X-ME-Received: <xmr:Ap4-alYezxjWZzPgyFUnktcVyQmEGWQP8Mt5AcMmdfPIiHJ5Ebzh9jl7diAkamAog7h5bp_1KlSXszBWBodvMlgdX6DIlb_KT2wdAVQ>
X-ME-Proxy-Cause: dmFkZTFi3tlw38/Qlx6XqaU+5PpLxgEtzizoaKeZH26ynVfclMPPxeHMjvlG1jrx1PC0qG
    /+TIBttrVu6gEDJ/dHDt8NScpw6iioWVbaTPGaPLRLHUqDPBXONFlai5BJmADGKJpl/0jM
    sURE9UiIXJ7W86ES79w+90MaeIeoZcae/PzXO9quuRCkjCmr8MNK/W1XeJiXrTPOS+2+0A
    rpjvMUsHKLff2nNi30jdx9HgxFh/ZRV8qFbgNf50i181GrDuzh0RuE8ssi3H/rhvLuplUF
    sQF1ImxofNkeAjNiCgEPhdYYwJWusiQ3RySIqOgRjdgPGRLTj7WUhQPDXNJ0S3x4IJbskC
    1Kd2T+bH2KhDRvfK3lRULoLFi5xoCb/v3jMJFmofuq4ZeO2xb1cVtzGjBddkRL5ihnNoae
    I7TQaLG1lZ9A2rmpCzZRfH/bGp9v/1Ats25qxqsY6P5jrWFQFTAjYVTGI9m/pjAWZOVwub
    L7ae4mzaJRKWbI3/XHO/mtyy/FUBpHzxASGliN6DmoyAvM6EYz3bWMzF8tkri8boH/OnlA
    PeJAiwDlw/lMcGPeBltao+okcYsD7yTVlmTuSZvNOz9bkMF2TYCPQyuMny1EJqAtKPhFHG
    UXsml7/FeTB6A1HZpNnMeN+ueBZrnc8Sixc2c24eJFcTzeG+2+QAzxLX0eNg
X-ME-Proxy: <xmx:Ap4-atGcaL8YVIat6JX5Cwln9bp1MnHicfUGiirGUX4GpG9bFR_kYA>
    <xmx:Ap4-amJfz5Lu6b1Ez_yJnAHdLOHwLC8Z1nKzWuTXMChbIMZHuv4MuQ>
    <xmx:Ap4-aoMIow7gmOdrfnkFefD9HyoOZBFPT-5wq9yBW-v3PNujltm4XQ>
    <xmx:Ap4-ammtrpsrP8CgZvd0wThTzGd9QvTrBo39W1DMMpZXJtlX8xAA0w>
    <xmx:A54-auy0luiQGmafjjiJ2Sgmbgy5lpxuhuIfPscjk2gXQaRgzdbMDUQ2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 11:42:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  cirnovskyv@gmail.com,  Christian Couder
 <christian.couder@gmail.com>,  Ayush Chandekar <ayu.chandekar@gmail.com>,
  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v2 0/2] environment: move excludes_file into
 repo_config_values
In-Reply-To: <20260626075037.532164-1-cat@malon.dev> (Tian Yuchen's message of
	"Fri, 26 Jun 2026 15:50:35 +0800")
References: <20260626075037.532164-1-cat@malon.dev>
Date: Fri, 26 Jun 2026 08:42:57 -0700
Message-ID: <xmqqh5mp9uke.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> This series continues the libification effort by migrating the global
> string variable 'excludes_file' into 'struct repo_config_values'. Since
> this is a dynamically allocated variable, the migration requires proper
> heap memory management.

This appears here:

  https://lore.kernel.org/git/20260626075037.532164-1-cat@malon.dev/

and as you can see, there is no linkage back to the previous round.

The lack of In-Reply-To and References headers unfortunately delays my
automation in marking topics with newer iterations available to be
reviewed when I come back to the keyboard, which happens overnight.
