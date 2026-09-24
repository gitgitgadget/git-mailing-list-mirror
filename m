Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70E54078C6
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 22:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790287485; cv=none; b=Wj3r77mGvvVdn5fLLCy+i1xHGTIFG5St2vJgMf33ljEVBE8Je+WlrbzXefsXXmN0U5SAJJrLUbE6EDojMdKWQpwNPMeGLqQHdt3bW2bs8LG4mX0R3WEaP/+O6lLTqozbU4QL3wBSZ0YXyiVUrnkGS82ohN24Lnq1qozjmBx/HIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790287485; c=relaxed/simple;
	bh=eIANIiXklsJ1r++79fcRWmgDyWfD4W5673wrTnD4Eeg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CHl0+MFXbE/djfc/xsVspAjxSDQb2wg9dqsgJqFSOMuogGzd+il1Qwcbt5FIF0u9bJ0ppX15HpM7grEErfh6nVhcs6ejPK27fkY3TbAt+68mVZsjM9KG35PfrZ6i9B8gPejEYF8Xdnje/y2uoVCLURl1vxRnFCUqmEh2xZZY8bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XUXw3far; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p32ypO/L; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XUXw3far";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p32ypO/L"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EF7C014000EC;
	Thu, 24 Sep 2026 18:04:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 24 Sep 2026 18:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790287482; x=1790373882; bh=57ZqCAOKbo
	9uTwJcFG8rRKQ4vWXIt/RKwsKyceU9G/A=; b=XUXw3farz5LXXYhEdDjvwew3iq
	9n5FD8qBL3PlPaKW7AWDZD3Rf/f9nBYc0T48uXk3whTy69by+p/W84wNQWrq5O9N
	2YHxmC/LbD1qjCrWuMEKBe12HDQzCOoyPg9LoL2dn14+Ws4dpiFrGYmA1WrxUPxW
	5nNbIluCih+cnATs8Fel3fiLVb2YRW9O63yCmc5yUKQTA1SE7qgHDeItTDLjcEHz
	wHNLN2M0+Cy9bfKSGHnM3jqb8xXTBAUCyJe2xiFvdW1B+P8WPGQPWGHiagwOaZif
	/2xqbkKA8d7xGooegWZC+yUcnT6ba1ZNoqGwKbrPcOhTQZCxzQKoBVhNoedw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790287482; x=1790373882; bh=57ZqCAOKbo9uTwJcFG8rRKQ4vWXIt/RKwsK
	yceU9G/A=; b=p32ypO/LWFg91aZgixtMR1NLYNbxgRRzSr2YgWVS/TmInMrY5a/
	R1wXbCOiWaRM50uHXkeu+YVzi8QATs/7t6msAk88xaxoytbNLIhXWo4xLa6RAoiw
	2aLNDJVeGA19YeIFGkgFPOo1zHlpJI7ldqDnanlRWokysWRwDmt6FAKo5x9bGMMH
	uTKZynr69+A3W/CH8mS7thRahaWswtBc4vQ2VeejzYTqXlm2B1NcBPgn+WbqRro6
	UHZLVE4AXx0+chkIPP182HP9vG3l+hSIi5yKxlrjD2upwzXOvw7Av86GWJyoBqPB
	wZ8miMV98UbmdrJvolBQvWUW+aX0DCEFAMQ==
X-ME-Sender: <xms:ep61ahm5UX4hMWFlOeNsi5xmLmxg19Vrjx-KFdvdFSu8DQBnemoukQ>
    <xme:ep61ajssUaE1hSZIx0PVZnlZGJJkLX8RCYiAKutcfSXhBUN3syl8hdnEedfEhRvUJ
    BulPEYnJjtdiMMqt9oFiUj7XRIp0E94SWTul9wo1cOv2XDDaTsVWhs>
X-ME-Received: <xmr:ep61av9pwzC9GGOV4-LOb1ILb4RyyOFYmFUlgHgFfx6ZR8LItmeZIK5D_tG10uzYPcKIf93w4faCySGRj8Bqxd2eDtFymQsmTz7p>
X-ME-Proxy-Cause: dmFkZTEDO1bSOLPGSlup3lTj6Rf1PvQPc63kelUpae/fJ9ETGulBLlOC6RpWAN/WANk/Ht
    4n3gkQf88wSeKrVZtY3O/AGTd24xnjJzfxzTpswTAeKmHCI/dwXmsCCTuJbHf6jeodZAnW
    9dWz2PO/p5a2j4V8W2sdKNko2y3Ug4REppaUrWHliHzswuLgAc51jl+fpRL2VyXyeNN3gm
    YHzNFAlRLdLEaRbKXFjjFFTUZlPVyg5B7ygd10BB4cluq1qN5rP9fwyZystUf9rFH+zaol
    4Qihm5NjbG2fiqmT2JDSz1n09XRbEzt5EcQZjUgHhg45V9j4Mk9KnrAlXvKOyTzT9E1uOt
    4hNSblE8reICx5Qup95Ce/1E7LzJkFSBnawMAqjFoL5EivwJPfx8+D9eZhaub7zIwbHkSQ
    IPLCQ6FT9OiHoKrjSN9cRUQHnGubNeOW5TPM4Sg+kE/X0yczIzTGLT/kwtMSb+m6W+zwIc
    d2a/070YYNKPuxWo385L2T1OjoN9s3hOYiXIOiTOI2Rlafpf1DeHiTXgDGyc5f1+aHjEGb
    WsrrCrd29KVzY2/mbSNGiUDEQ9UAekbXrUT03jlfcTs9bdcSYU5MGNcwTL+tsrGVI6keya
    okOFzsoEBkEHjqUiiepZP1iLtj4u9FfkslbB0entpIgWBQxOkxKcbqKgc14A
X-ME-Proxy: <xmx:ep61atNlJLOe9MWq3mLgLhod0OrBr0qRTmoPAjUklhugAS9Xb33WfA>
    <xmx:ep61atGplAdR5t0y6imNKwoORQwikIL-X8XN0hXZ50e-Y6WJQIXocQ>
    <xmx:ep61arRthpmM37DxvvwopkBtY2DkswxarrQVyX6pMFyls77NjkvulA>
    <xmx:ep61aqu19bQkbEnAnDFCDsAxvX-b8AGEItSqqQNPp_GHDIVPzzrwuQ>
    <xmx:ep61asct2lEJKs24GemwOWzDh_aaKJBMaLo_uX3cX5-Ofe0yhL7dOhS3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 18:04:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH 1/7] [doc] Add new gitmergeconflicts man page
In-Reply-To: <xmqqa4p61j4w.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	24 Sep 2026 13:36:47 -0700")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<ad4853dc36cdb883c9a8dc6bda747a5ea318e7a8.1790261062.git.gitgitgadget@gmail.com>
	<xmqqa4p61j4w.fsf@gitster.g>
Date: Thu, 24 Sep 2026 15:04:41 -0700
Message-ID: <xmqqo6dmz4p2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> This unfortunately needs to be accompanied with a matching change to
> help the other build system.

I did get a build failure due to meson, but apparently not due to
this step in the 7-patch series.

> You probably want to move your change to set conflict-marker-size
> for this new file to this step, not at the end as if an
> afterthought.

This still stands, though.

Sorry, a wrong patch and a false alarm.

>
>
>  Documentation/meson.build | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git c/Documentation/meson.build w/Documentation/meson.build
> index 51647957e0..10b0637991 100644
> --- c/Documentation/meson.build
> +++ w/Documentation/meson.build
> @@ -201,6 +201,7 @@ manpages = {
>    'giteveryday.adoc' : 7,
>    'gitfaq.adoc' : 7,
>    'gitglossary.adoc' : 7,
> +  'gitmergeconflicts.adoc' : 7,
>    'gitpacking.adoc' : 7,
>    'gitmergeconflicts.adoc' : 7,
>    'gitnamespaces.adoc' : 7,
