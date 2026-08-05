Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04070481FD0
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785949932; cv=none; b=gGazMg9/+jN/MCzyzXuDWRQgZ77rGK6z2LHHso2AU6MgxTu/GuFOf4a4IpwCye5xJKQVmImC7cz4CS0YWuhTAO+gAX5Q3U1yiAbm7CRx1cW8rgI4pDCIkPHzgiO7xz1uP1vzeQOZgycuJauVVS7qwa50+td6vBfj/wEsT2oX/58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785949932; c=relaxed/simple;
	bh=c+LhS3+aOkyUY/ZYhQDGG7LLRrbpZgDlzwO0ysPBfL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uxZD3p6wjzFP8el/o9SX0KYUsowjepoSvjs+bFTJwG9SLl8WW3UxjhcPKp787yTUcbQylzHri09JitJFilW513y8djNlvYufJGbh74MhM/5+Mc6LM+1QqqGYDk5A9x0EkJG3KjCh5HLsbcR4M5EGSd4/x/oKjMSnBljkwPMULWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dT091I/X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iscsnpL2; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dT091I/X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iscsnpL2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F32EB7A00E6;
	Wed,  5 Aug 2026 13:12:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 05 Aug 2026 13:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785949929; x=1786036329; bh=ALSd1HTO6n
	LcADf4/DYOBs4g6Jll7Nmtm9pS/ESSfTA=; b=dT091I/XKteBj4dTPmz+r6ulgz
	9ccJE4fiHPL8/SgiaJPS8wL16690C5/jnWkJERShyqAnBY0qJWrWKwe0gWXscuFV
	z/JkqzRwxwnMcL9AGj+h5PnE/ctxp1nnsJOnNcD2PpCneDah6CXMqJ3cwSt65cN1
	ozXjslFAyWf3QmUOYFh1gxQsjb/RPAr5WLOaqbCZAcIRwsb/oqjupWTNEB80t/FZ
	yFMIHpyFe1Y+jsjCygFKzwWJjeRnK5DQhT7uq7gVK+s2j6dZQEbgPEW4+PWXxiT3
	lzRCTbEQW3r3YI0jhGL2AMys2oPTXO7pWGW+X4md/54ok3UVJxZx2EUJhKAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785949929; x=1786036329; bh=ALSd1HTO6nLcADf4/DYOBs4g6Jll7Nmtm9p
	S/ESSfTA=; b=iscsnpL2JN8KXFYgk9FGAagj3m1fT62abvUwJBHUqjegNM4xAUY
	Qkt1m+IGn9PC2U85CsU5WHbdE5iCvi7fnXEqfw4NO9zn+uC2OBWYhHMES18a3jRU
	8OKVO5XuVlXN2O7Bk6evfEdCkVYx74VSEIc8L6hdLMUauqd/nGFsX97uzfBGq2Y4
	8tw2m3DRtvt3EF0YReocS3+ZUrbx6oy3iRwIjtkvBENTwTRskD4/y3Uf2MwNMf46
	Cmz71cAqdhDZrnHyl26530EkySepbPgaJQOjN+o2tRQEgftLN6G1HiUO50j77l3X
	IY5nLeXknXaMEgkTGdONpCDc/DZMXm6CkRQ==
X-ME-Sender: <xms:6W5zavA2bcu_stfEnXBn-dlWeRJmc9-pLlUlA1OjL-UJ8DHYihJijQ>
    <xme:6W5zasjESuUgBNuM10rW_7Y_hVPCib-VMt8nRke0gp8Q3HllpYangWYet_eAbof-J
    Yn_E98oDv54_VJpVPgQT-n1Noe-oDGKZziMGS5tgnoe7zT7f8ca>
X-ME-Received: <xmr:6W5zavmG6xPuMKAafXWYYN7HyhNRbE03qfew9iC9vxByL1XWrVgRq5sN20S6JWEo8wc-x7yu4mYg_1Brk1FdswrQojKdfo6spA>
X-ME-Proxy-Cause: dmFkZTGp8baG6Ueu8jXMVu0GMGUKerWz3xvX5QMa8KDDY3gp/u+mImI6dssuw5Y9KfZeUv
    ybTdMEU8uarQKoDDcjWTA/RU+oqB5KvRpGzxN9NqfE6Hk8MI1eHEoGHxpNEUBHcCtVEyRb
    2/WsQXYK3Oa0Yq05DUgzXW4KzaoWfsWUrdoRIgUoQPbxIIELuTRvtZnBw2zV3ZsXYO8rY4
    2lMEjENhdQ9z1FtmvhPxQltmF00kJ5xnAI6u57BRvN80Xl3eFCNWEF41RcK8iKJDifKHmJ
    IaZDxqKNr6SeCZWumw396yA37ugXe/D3la140ZiRdwtkiIbIQk3M2KSkhU/iMPNzMBHAG+
    xmazIEJxfSArRKu6Aotm7DW1hfz1cEnPExzI9NBoOp9kJ44tCqpVrlBQckM4/sWC9UdtH7
    +ID8ygNjueNycCwMYQ72CGindTWOle1m8hCcYSKeKMOOqEYccYHjHiWzf6UUyjBk0B/Wqx
    6rvlUs8FEfoM5sWiKuGFzqy9kVKIArNjPClfla/YC+sEy1MBVCy5UalBICTOu2XLUaVbry
    eJPOMG2xdbmPj+fT/2mcXyA4xNYka5y5V9a1bQ1lAPdYHqf/sfkygqy/FFGsvNQQ1bdw7+
    NUG88tHewSuKO7CuaSWMexcEptOCzzfiPe4PqxeMHjTIRkd6qynTVle+WNKw
X-ME-Proxy: <xmx:6W5zago8OEuMonYWUz_IQXCTwW0qmWet3CZjulyJYvvHmq7SHRa91A>
    <xmx:6W5zagHCWz9qj50GL9XGiQ2M1hXafA4eEwzikxE8E315T3bqr4UrVg>
    <xmx:6W5zakzO4G-F6lHOP1xvWAfTGXLke7_isWa_3n99VUEONr6P7lMbxw>
    <xmx:6W5zatoxCzpWHVBIwpK3yp23fuugBuQoG4DDFufEJJ8_hOpn8dtmjw>
    <xmx:6W5zak_XLwexM-0FdY-tPTH9qq7FCIEJLuONIoScpDBX3giNS7so819c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 13:12:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 09/12] windows: skip linking `git-<command>` for built-ins
In-Reply-To: <c4e97449c1065c5d6c4346803ab571eb343ed034.1785939999.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 05 Aug 2026
	14:26:35 +0000")
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<c4e97449c1065c5d6c4346803ab571eb343ed034.1785939999.git.gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 10:12:08 -0700
Message-ID: <xmqqik5oqyon.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> The "dashed form" has been officially deprecated in Git version 1.5.4,
> which was released on February 2nd, 2008, i.e. a very long time ago.
> This deprecation was never finalized by skipping these hard-links, but
> we can start the process now, in Git for Windows.

Good.  Perhaps somebody (you do not have to volunteer) can champion
their removal from everywhere at Git 3.0 version boundary?

Thanks.
