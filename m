Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848DA40D596
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782072180; cv=none; b=LjTQ1d1KEoGUVFck2OPKiOuvAtxP+uRBdT6SDxzPgYja1CTXvgsZFupQfuvLbp/p7PnFCYlufeKxEpYn1ZfZWg9oxOrZDBeOnyVynbeeH+5B6HNNrAE8Gs9W6IS+rUuFWwLVBA2nsMQmGzQHcPwh1dakPnTv3NkOHHhQ2aGmEK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782072180; c=relaxed/simple;
	bh=QcyaruBhtQdaGKsQrZKRBijkKyCM28z5RueVJdChV8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cRt1eTqsfCpfynA6g7qNSyuzRzcQRakzOBpPnHaxIspOZScBWAytEDd5/LVZuRDMLEgs6I1yq1IQpK2jI7BqtHORQzLpBxjrrTKK61QZGButh+9L4IzN25xCWO84pgpwk5dNX9eHex6qKYE81i8tfQe2guEhVUtLnXpGb09gU3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F/MY7SlQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RIJV0NhR; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F/MY7SlQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RIJV0NhR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B685FEC0285;
	Sun, 21 Jun 2026 16:02:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 21 Jun 2026 16:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782072177; x=1782158577; bh=uwt9szBtUL
	ridyJQ6hjjUlrE4tzafrzGUH669ZJ6lwk=; b=F/MY7SlQRDRlNrJz3uBvGrii7/
	5xwhTAIydKqn0j2bU/bVlo7+Yx9Qg0+anyqLqQ1ADTa5mL0R2Lf1JrpmokemJ9ej
	78j+iEv7EIwUkHDSXNd14dNecZciZ6D59jrpowXYrm9eu4kHSy4xcJLHlTq9gRjL
	Bi6l9zGyUUQlLHr4Or0QrxMIqLLiIwGPNNScb/wptZk+jh3zu1bAH2J2q5j68jmO
	A8agQFezv3GRpE8D/+FVteoAD4yzak4NnK5owburT4Xpy2/1BXln0WdH0UsS8wPm
	xQ4lJkk5NufrmrOYhhaE7ZjJ9e9T9UGe1+cRBVDb7oCb6zHyrbxkiZSorurg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782072177; x=1782158577; bh=uwt9szBtULridyJQ6hjjUlrE4tzafrzGUH6
	69ZJ6lwk=; b=RIJV0NhRFXZbf36fIf38nykuNgQM2SEXNhuY/nLkE4p+Y01IweX
	GjFStPU/o757T/e6SpYpsUocU+BcrfDGkrlnbVIG/gXEFtInV7YshfJRc5cvuknm
	YZ0aySotQl+45LM2fGp5DZubt0FYgQ7ANBU8Mvlhr/a7nzxSOL4hMeE53jnLtCim
	3MGRGscPAl+fbtKffRcaL3FmBBaZtvjQoSFkoS/2WGIQCeFWlBrE1r2xl58cI2LW
	PZ4BNI6Yg70EAUr04z67PkMu/ryrpnNTMVeanTtXnL7snIdAYijRT2FEJGXCZT3k
	nh1DcyU33q/MpWiPGPQsKfNnHdQ2kR7zRIg==
X-ME-Sender: <xms:cUM4amJmCZT9Z0EH4cOMKvNpDhzrk8L1kR65owr8YZfwDLFDPGa45Q>
    <xme:cUM4ap8OhpXtRGF2k1Anw99U0AqNgzjFfjjgXQQPLUylXD7pZ1prpn3R8E4Wcrr6O
    x2OlX0YwAiLC93fM5rGu_RCa241sL0OiWeCY-Ehm0K0XwzvGsejCw>
X-ME-Received: <xmr:cUM4aiFNHEAQOKQveNfQcOpAgF0Q-Cdgp7ilWwasizHxpvo4qAMS1Mz0Y1waPYan03CALM7wkfotvFNVZ9vSr_m3pAkjeyqtYfWuCGs>
X-ME-Proxy-Cause: dmFkZTEEP4vZ0zeVc/mph9n4ICOTsO+7qiP5zKlX2+tZNSgFIZ+nNY6ofPmUFK6sS6Tb5/
    jX+GwXhdXu/F1f5EWBOeeEc9Isq9VYABzhuFHLnL2eWbRhuo3tabx6Cd/C+D0JTeqHR6+p
    WRNOfs5xtjWV35BBRgqNDnJ5RF4zW9JUbKe2vcWamBNz9ozI+3xi3/EwIlkGpO/rEfpNEY
    qjMZhSnoivk+uCWQMArysWZXbD0z+8z4kG0kzqHjHzf9O3GIo7V4PrqyxADV7NmOsMrpj7
    7ogJYBU3ngH2/SN9gBoXEEO4KfHcaPpo3aa1BXtFtLtz0tI6PpOa9mKMp57yg0DhnNFVhS
    YxnwJAXXSrBvA6UO5j0rdmwk57oN3QblY3X9i/FyDZ+Q8c9/Q1n5HcX3ZMPuvqO8wDS2gX
    aKWh1n14ajTe4ST2F5cDLyGLbseyq6m6pIrg9zdsnOWKGdC0O0h0dmmsBmdYRic/AzGezr
    HyPAXh31+SgkwaUCyGCZey0yLnGo0mq59/trCdXpf60Y12OhQtGspnc64+WV58pruJP2C3
    /45yIf45A90fa2ZvpW7QSjbb1sz0tP/TMmL4QncZAMCYlRMLVWJLpAs4rA1oSy0l1+Bbgx
    O4fEGBmjccovVJ00n2lHGOAeHyURZC284QIvogNxP6kY7cTTJKCexmm6fMHQ
X-ME-Proxy: <xmx:cUM4ak66cqRWR-j6ckFbiu3rSnK3KXT3nOeW4t5-9bYMQFihAHwOBQ>
    <xmx:cUM4arb9rcKVdkndDjJkB3ycP1gtOqAXus2PYCGRCtKXS0kMVnV07g>
    <xmx:cUM4aihczRivmiGp9EjNI0sM6z5xVLfV7IHycrMDPcjkhaODgRhWvg>
    <xmx:cUM4atc6tX78KKzhz9A39hGwXLbRVi4JSCLJHguxj5AbWJWuU45kJA>
    <xmx:cUM4aklLwC3bJ89rwebd4XrpKX4uA0ImIRAafkm_9AqSMVgR3cZPfNGB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Jun 2026 16:02:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>,  peff@peff.net,
  eric.peijian@gmail.com,  chriscool@tuxfamily.org,  git@vger.kernel.org,
  jltobler@gmail.com,  karthik.188@gmail.com,  toon@iotcl.com,  Jonathan
 Tan <jonathantanmy@google.com>,  Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH GSoC RFC v13 10/12] cat-file: add remote-object-info to
 batch-command
In-Reply-To: <CA+J6zkTjgHAWtJwxY8jo0i9zDtxwj9uUsKAtLS3z1=WxZfr8Zw@mail.gmail.com>
	(Chandra Pratap's message of "Sun, 21 Jun 2026 11:31:16 +0530")
References: <20260608-ps-eric-work-rebase-v12-0-5338b766e658@gmail.com>
	<20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
	<20260619-ps-eric-work-rebase-v13-10-3d4c7315d2f8@gmail.com>
	<CA+J6zkTjgHAWtJwxY8jo0i9zDtxwj9uUsKAtLS3z1=WxZfr8Zw@mail.gmail.com>
Date: Sun, 21 Jun 2026 13:02:55 -0700
Message-ID: <xmqqo6h37jbk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> [snip]
>> +static void parse_cmd_remote_object_info(struct batch_options *opt,
>> +                                        const char *line, struct strbuf *output,
>> +                                        struct expand_data *data)
>> +{
>> +       int count;
>> +       const char **argv;
>> +       char *line_to_split;
>> +       static struct object_info *remote_object_info;
>> +       static struct oid_array object_info_oids = OID_ARRAY_INIT;
>
> I don't get the point of remote_object_info and object_info_oids
> being static here? These variables are allocated, utilized, and
> completely freed/disconnected within a single command cycle.

Great observation.

> Making them static gives me the false impression that state
> needs to persist between calls.

Yes, and makes it thread-unsafe, even though if is questionable if
this particular function has to be thread safe ;-)

