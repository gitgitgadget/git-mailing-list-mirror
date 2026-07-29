Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49043DCD96
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785363597; cv=none; b=R8liE7wdcL0N8sqCvLEfjTaoBGgFQRbpjuJL0MYFFLxbpVjUeKDgElVOBc+2GvwTcQZsRUj4pUaldUAT/a4uvnsogaMpP8C8oHLd8IBaNo3INH/085V6UV6AWCSIiIM2Ax1MtHhV7kCwiiYB1/nUQnzcCFgMfq3s9Tn0p4YLXJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785363597; c=relaxed/simple;
	bh=S9H0HQrFzzP4RwVWb9oK5FQ0RBdQJOUflFIvJLEIvR4=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AgtXqgOqG010Mtyt2YidSHno8CvX+arl2alfvYpgEEolvq4dPJ1BNjD97Chh2kmRrx1HGR/DAFBA0wizIYy6t43nadERbKkwwxbt0EXF2Mg2MvGWRM0K+2d709i01FdKXcB8mfhghGBZTwOgrVb6q+6gpjbza9uXsRyWBch6qmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qUn8VmKx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H4m098WO; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qUn8VmKx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H4m098WO"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EFF2C1400469;
	Wed, 29 Jul 2026 18:19:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 29 Jul 2026 18:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785363594; x=1785449994; bh=1OERDToIMB
	qsI56AIJE29L5adjK9CHKqFixh7zKbiCc=; b=qUn8VmKxjqwa/tzle238z9Q9QM
	4SqQpVkeJbNCQA3T0Q8iPENg8LfKMBWpxJHWSW/dXunlZaJt3AHwIENegs2zat1J
	twh3pjB5S+AsK1PRjWMdnH150/Nff496mHO+g8IN2TemHT4Kw9OogOVR652hFSdf
	XWMBuEHTT8Yb8T4gGKe5J9SWJa3oT/1qFGyWMG5upwwp/uoDdcLSE1YQT8lJ/vMU
	cXZrfCtNutDXBzOk4wzrbctaXr5xemBQwHL2TRelEFepBrz7+qx6g/fGakabO8gI
	cjkwNbC6xyMvCfAonQu3KiY2UIA4qws2Xq/wUwVR5BX+7LRN8cnE4xC5dYOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785363594; x=1785449994; bh=1OERDToIMBqsI56AIJE29L5adjK9CHKqFix
	h7zKbiCc=; b=H4m098WOJ9jBJdh0GmNnT51tKVfZfojBjNge7B4S+eD6o5NKzjJ
	rxtjocUBy3+7OYM89mFKpLFMQuPFaOVmpzJYDWDHf87t2+OIjXYdKY6p0BoLBFrq
	PW4Hmv2zmmil866fkQhgJXEYyEbFDAAdFhf4svATIAjuw6YM1RXZsOaF1BZyVBr5
	1zeI95lHExHKBrbLiqyE16LSRPBnJCJ0pTdlmdIUJ8ygoJER7F71W+Bq/eMlgH1N
	E1bMjPMRDrU8VjSgNcaWsDVwcWQJss6zlNttYsM8vW7OV9bl4HcAAmGPhWc7fEVd
	+GiWOKPgZFwsiEJ4uTOPHv8qeyED1eWMDDg==
X-ME-Sender: <xms:inxqaox37U2h71I77jc6-mqu_DA9Bf1sEInmxP9vWWgFAS_EAOWMkw>
    <xme:inxqaiROJ_2xQJdfB_ToZEu11E9aWYdtzcea_nQ3sItGl2w_W6GGtRaCbvHdvzRE3
    czoZWdAq0iEqLNtFIWdzGovwFBgPGRRw5Yv1Xrr5_wjIxCrTDfFDG4>
X-ME-Received: <xmr:inxqan-TaY-trc7NFzGEf86Gi_cb6gl9mp1yZsZZ17JnXldZ6zb6u3xeRIWVRrt6DLq_HDDoTfPuqL1axR33Elz6nxCuMqw5hg>
X-ME-Proxy-Cause: dmFkZTGjJmxJLYZicIGNvKkbt80YqnAjw4wkpL1bj2k0xO4dvA86i7iHS+8TWTTGw6dzJ6
    ipvHt7qLoHtAHs01NKZotorLZHeF81PsrY5+z86AMzqgiAbTbG9dI6oMBeoQmWDFbWwuny
    oWolacafR88lzTlR25HUZeg8kPwGCQcdHJDeVNtiVyxAMvMDt8uC4/oQQ3dmjKmqtCylfg
    H7dEXYmKoqzSJW7b4LU6xGr/q8Xmey2rXg3GDKVTBhdhyEFv5OSJgmoLx0LoNaolSaXHZQ
    97QP7H8cA5PkaJiu4K3IDkhV7n3rAXpKlntcTCelOpkHQR1AnuTihUKTfsHwt/E/jtkeKh
    HHtH+nH/hNuCCagM6mG8iGCVVFfxNgV/ftNjU4ywbYZaLR3XxG43moDhkLxGwt6EqZ2YhK
    3DSrs5CDn4pNOUQH/1zykhEiEuPtTF35lNeL5Xa+4w0kpdx8uzy5M48YR0UVyZplE1HN0d
    uki1UTp8MCVTOTHtuPbACmrdncNRP8ZboBMWSUDqhi6WRbY6nz9eouRZUp7EHM9xSQRzab
    T5wI9Fy4+51qPSJXtSEEvPQ3aBnxzTCjk1inGRuUeVY4XfCkkrgRt2g2vXZLql4CHJ16Eb
    dWrtQEzJljWnJPQb8mosM1gHvu8g1P48mtS3ixbBmZHCX44YneKdSs3vRNBg
X-ME-Proxy: <xmx:inxqahowZi0ulf_47C13DYiSZvwemmDIkcGjX21q5tbbR9Nbx-0G1A>
    <xmx:inxqaslUePFsYoGE8rmwGSXne8kmXYEChm376PE6VK1_QxwsmlbltQ>
    <xmx:inxqagKbTAHX23IN0XiIucaXSyeO1o2pukvrzegG38PBw1BwZMddyw>
    <xmx:inxqapx-Tt6r62bdcCgwxThfj1Eq93ss3beGvtx1FfBU1BRMiYqghQ>
    <xmx:inxqasI78Zxb8rescUPChOh4IriWDg_sf5PP5GY00ezvPpqPklV3DjsL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 18:19:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] add: introduce '--resolved' option
In-Reply-To: <20260729172524.4022621-5-gitster@pobox.com> (Junio C. Hamano's
	message of "Wed, 29 Jul 2026 10:25:24 -0700")
References: <20260728215219.753678-1-gitster@pobox.com>
	<20260729172524.4022621-1-gitster@pobox.com>
	<20260729172524.4022621-5-gitster@pobox.com>
Date: Wed, 29 Jul 2026 15:19:53 -0700
Message-ID: <xmqqy0etmoae.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> diff --git a/t/t2207-add-resolved.sh b/t/t2207-add-resolved.sh
> new file mode 100755
> index 0000000000..f88e3f413e
> --- /dev/null
> +++ b/t/t2207-add-resolved.sh
> @@ -0,0 +1,108 @@
> +#!/bin/sh
> +
> +test_description='git add --resolved
> +
> +Test that "git add --resolved" stages conflict-resolved paths and
> +refuses to stage when conflict markers remain.'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup repo' '
> ...
> +	git branch topic &&
> +	echo "ours 1" >file1.txt &&
> +	echo "ours 2" >file2.txt &&
> +	echo "ours 3" >file3.txt &&
> +	git commit -a -m ours &&
> +
> +	git checkout topic &&
> +	echo "theirs 1" >file1.txt &&
> +	echo "theirs 2" >file2.txt &&
> +	echo "theirs 3" >file3.txt &&
> +	git commit -a -m theirs &&
> +
> +	git checkout master
> +'

This will fail with breaking changes.  The last step needs to be

	git checkout @{-1}

to go back to the original branch we were on before checking out the
'topic' branch.
