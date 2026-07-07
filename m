Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDAA3859FD
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783447771; cv=none; b=NAOqT5+5cVnOG/ZqDli267tdxb5DFd+Pds/nPE+CMJmDhjpQxbxsUTy0TomAmfsrr+UNXHxb1wbqTnjbbBI+e16p3VCJAcdtdU+CVkUqkVdG6lpsSaVs0XPt3EtE3sdbSs8GPgl70zvjDq2ZrbP5SXvW8yZLL4QNnBfVofjvFGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783447771; c=relaxed/simple;
	bh=1KUikAPYiwSj8V14cfpwAS3XiButSOEaifgL3HDqA3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LA0ECmTM4/W+vrP9+BC5EQH+MH5qvKt8/3t0bPZvWqaPtAC75jjH9w4pK4rtetMdHKTSCAG6MkuBWNN0u2aG6FBm1t1DnR8hJegkfKIv0zvTXLkuR8mAdJclyyK9BSVspP0mFNjuwMVWfHjtDt9AaNPerXN1wNhNOm9QENVNuGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wetjLAoq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KCMcdJ3N; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wetjLAoq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KCMcdJ3N"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 505591400026;
	Tue,  7 Jul 2026 14:09:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 07 Jul 2026 14:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783447769; x=1783534169; bh=k04lYsWA1V
	3qiSfDmoKBl1NCLrUo8yOXqB8TATBLDfw=; b=wetjLAoqrTtNlIOei3Eli6ys5O
	RuDxbI77/8RszD8SQHi9A9Qx/UNpg5fhgesCJpg4dGKa8EJDukAYoTc7wvS23B1s
	sieN3X+PpAgqnHKkDvlL7kq6I/xHp9nCKUekl+eNoLnifOzb2nJ8WPJklRD8cPVa
	NYwIF8OVUah4xxS/bYjSsz0HmRb07Qo/MnzUoarOkmRMOm3pbkLO/34erVmDjBNa
	YR71ZiLdsiWYyv0dJApdChElgJYE2n0qpaZanFZdGz2LHWxw0XC3ZqikZeW3NX0u
	SKivf7PZFJZaNmaBk/2Utaalo/5jXcib8NMvsP3UkKf8BOtcmBQKT0tPI82w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783447769; x=1783534169; bh=k04lYsWA1V3qiSfDmoKBl1NCLrUo8yOXqB8
	TATBLDfw=; b=KCMcdJ3NagdNp6IvyoagaORysIvo+9ru2htJf00ZJP+LJJ9f86O
	EJpskNNdjfRJ3p4QHGwoVJa2Aih9a4wQS4fMQK+nf4tBdJ2nXDVWOXRVYWq5arlC
	wepH0j21Pt0M9shbGoDeyeobpnPEJuHkZlkWhBZX0nA6OSWJLw71vZ8RYLGlbVja
	BsgvFVGMsigfMWGeDSKcKOxs6P6Y/x8NG+8B2+IVzJsjWmcfoaupvUOPfL3kNwA9
	uDwtj+HNWIGFxIo4JlVA9qJj7AsHpLhGKd1QMGoX8FkpSWLwFFbQO43n41M7/gKq
	1pNXH0WDrKmO4HhTkv5t/rX1YuX1np7jg1g==
X-ME-Sender: <xms:2EBNautJ72J9r8O7tXvS0MEFzIKAiaK-lmlFWAuVJJHnVK90dObcjw>
    <xme:2EBNagCCu4KFRjpJLcRLkj65cFbyivYoap47dtvgeBvRIMZVXyaOnz4bYObIVR87r
    NBwqLwNnKZMIY82UKXrB92urRVJDgYr8Z0HgWqB4JOMoJZttdSmTw>
X-ME-Received: <xmr:2EBNauOSSGwVS0ggTIzIEVsNvo3YQ1ThkUD3g8QmuWaXH83aaEHuSbB0DBLP5gSD3WYMx6xumHmLRxFDtQwknt7dRc5qywMXiUiud9c>
X-ME-Proxy-Cause: dmFkZTG2II4pcbU3Ixoj8yPWpinZR/LhFcbvloGpJT2N9skOnolWi1Vet0PGCXa4k8wNjj
    VpzYIuZxzae/o8i6HRugYGMg9SGWS3EluX4IV2daKdecv25zXPmdiuIriORsfigkS79DJH
    dDYWvPnXw2N6+EltiNnQxi9DiefxvJGWKCGVZmodgX9dKi473LDW9oIZkQotEdART7u5rz
    Dv2CpQ+zymNAgZECYS4YJj9B9TOcET8mqWFF6UZkjkyKriY0DQ4ucoLy07Ab9OWtaqr8bf
    69CkuITxhRgq6PTartR/1h5+KmRJViv6C/HjU7qqRJuXON1fE+E9raMRQupId11ieoNSkZ
    BLbrtD7fcnfBnTVgXLxTeNLNrk+XYRof+Bgsc63Jk4+Ka191dTrkUbWknLVbSeAXw+fraf
    +pdfupg/yiwXZxQKZLMVEBQiIUX3ousJo+g65u6r+5ENX9VifZh4J5mVczvoFlWxSs37/Q
    ZypJhQfSSjvRTRSVQddE8mqXei/N727di74wI6Id9V1qmD+eXl6mBO4sdoP5msN+44aNKc
    5JJ/lXhuEmXCqF7nhdz7a/X3GrX/PRpPFe9nHt7mTlBsskT2OVfLfD/qjXnXbin8DijB7r
    smUv54bmNjWfYKMCSZ4B+AWw5/gqQhwI9vh+44IzZAHR3YQJ2/G/wn5MP06g
X-ME-Proxy: <xmx:2EBNagB-l8Ko82-GkSd2EP-CoUGV9Hgo58_0HT2FF3VDCMR9ixyuTw>
    <xmx:2EBNav590nmzNYuggdDuGWvmoDPECR_ln1ezdMwkpT_uZpVo6CTxJA>
    <xmx:2EBNaq5Q_D6wRGFCf-9m2qvvIqI6B_0XYAOfnow5tnwK-cUc7avEhg>
    <xmx:2EBNahQXE1qlIKsezNX27jsM5HsdBrHrnBg1IX-WKWA8fDnYeeE4gg>
    <xmx:2UBNan1tbRbXR6rgZWxmMt3WsTmx-EbtRAGtbElBDnb9frW8TmTxZ2gp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 14:09:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  chandrapratap3519@gmail.com,
  chriscool@tuxfamily.org,  eric.peijian@gmail.com,  jltobler@gmail.com,
  karthik.188@gmail.com,  peff@peff.net,  toon@iotcl.com
Subject: Re: [PATCH GSoC v15 02/13] git-compat-util: add `strtoumax_szt()`
 with error handling
In-Reply-To: <CAN5EUNTYeDrQMor29eYMhJD0jcdRQq36ZA6BgupV8gG9xs9rFQ@mail.gmail.com>
	(Pablo Sabater's message of "Tue, 7 Jul 2026 10:50:41 +0200")
References: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
	<20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com>
	<20260701-ps-eric-work-rebase-v15-2-c88a43b63917@gmail.com>
	<xmqqse62obwh.fsf@gitster.g>
	<CAN5EUNTYeDrQMor29eYMhJD0jcdRQq36ZA6BgupV8gG9xs9rFQ@mail.gmail.com>
Date: Tue, 07 Jul 2026 11:09:26 -0700
Message-ID: <xmqqcxwy4qp5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

>> If you are trying to more explicitly insist that s[] has only
>> digits, which may not be a bad idea, as that is what we generally
>> expect, then
>>
>>         if (!s[0] || s[strspn(s, "0123456789")])
>>                 return -1;
>>
>> perhaps.
>
> I like the idea of only digits but, even though in this series I only
> use this function in base 10, I want the function to work in other
> bases, that's why I left the base in the function signature instead of
> hardcoding it. strspn(s, "0123456789") rejects bases >10  ("ff" for
> base 16) while strtoumax does support higher ones.
> I think that it would be better to explicitly reject what we don't
> want similarly to "-":

Let's step back a bit and think.

Where do we plan to use this function?  Remember that being a
superset is not always necessarily good for a helper function that
serves as a format checker.

In the output of "git diff master...ps/cat-file-remote-object-info",
there is only one caller, which is fetch_object_info().  It reads
into object_info_data[].sizep.  Do we expect to express the object
size in anything but an unsigned decimal integer?  Remember that it
is better to be unambiguous when designing a protocol.  We do not
want a third-party reimplementation of whatever is talking to
fetch_object_info() to send object size in hex ;-).

It may also be usable to parse the size of the object payload in
object-file.c::parse_loose_header() but notice that it is already
even stricter not to use strto<anything> system function and instead
handcrafts the trivial number parsing.  This would avoid system
dependent funnyness, which is a good thing.

> if (!*s || isspace((unsigned char)*s) || *s == '-' || *s == '+')
>         return -1;
>
> About that, strtoumax works fine with "+" and ignores starting
> whitespaces, but for consistency (we reject "-" and whitespaces
> between or at the end) rejecting whitespaces and +/- will be better
> and make the caller format it correctly.
>
> I'll do that for the next version.
