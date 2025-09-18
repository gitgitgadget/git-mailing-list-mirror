Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBB52857F9
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 21:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229391; cv=none; b=VcA/KvgDbLr+3egEQo9sJNpoxRMXpQXGlaeP6HUzy0/HhA2C0xpDSBs+N8oIg8GiZvFMRWZVVE8fkFA4HEctjqvKWBVuPQ0bLOSbDH4zcjtQsmuwt+Q0UDCWopJYoKT/2Rb8w+1W9uQDmcgnXLpdjOTNwBy43uL/H4IeWRN9ehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229391; c=relaxed/simple;
	bh=C5sAT93f2VcboFs2GN5m3Dge5OUgGGJApn3n7CwTog8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JjAv6XbcwEa0tSOL7ITXsoVbPRtVINKPaV798V8a6k+NlAEOmaa1VIHHaEzXhnAkDkBxEOQWBe45eGbEz5GU6pFV8UnYl8HbIggwvFWAxt0BVVlRBhpLgscv4/sRjYj540kiEHhoV4aZGajWCKjATOq77duk2fhqbUIXFRQ2gX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=OiFhGyyn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A6K40IOL; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="OiFhGyyn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A6K40IOL"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2FDAD1D002F7;
	Thu, 18 Sep 2025 17:03:08 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Thu, 18 Sep 2025 17:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758229388;
	 x=1758315788; bh=DUQFC/WA7dGzRBsDtQ2P1MmdZBp6WmU3Zn0YYb2gqv4=; b=
	OiFhGyynOpunxrBJEjan6uvABF3z5zVqEJLo8336NjvDvEsi3Ams8ZUKuXCJH5Ex
	vUvfunDr1saxsPn03e8MGTNtUqtpAgMG6mpCLS5lF3q8F27JXPpZCcpTeQwY0NJA
	Loez4/KO2AzoEMMppcRdv0i92LRD47HEh22+z7oyW54yxjtZQLXZ8su9KZRlN0cf
	3+oQP+eaFsyGNqYM52tZufxZVc/s1NKdRf3NZP4mhNa8rW+3Z5/6IvU5bWhDGYBj
	uZynWnfsMLE3I1dUtecHuc4ofvkxDdMWJ7R2yhT5wHfXkUHljzy2VqR0dhRLOuYZ
	9wdnOUeOzBCsw7y/Bt1whw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758229388; x=
	1758315788; bh=DUQFC/WA7dGzRBsDtQ2P1MmdZBp6WmU3Zn0YYb2gqv4=; b=A
	6K40IOLBe3DhQf+rkDRnKY4sn75IEXsJ1G5dvh4sap7TR0KGtWPDOyaDSzHo1yGu
	BGqzeNN3l+94WhtFMoM/Ak+WrNubJC7v4q7HrWc/2QtZSs5QpIlan1dRzocEi0T1
	vknxb3hAW151OcLNe8h7QOYHMcSrdRJljipYq+X+dSH1Hv3aOoMXoTJjvMKTGB7Q
	30QwvidIiuoZNulKvS4rJmh40FbOvf2NhneN63aY0ph7xzC0oVOmW3G6mPtaxtcG
	xl8ICt8W+4DuRgD1CkrfVpt+Ts7+OjnkQuC+S+jQsOu1vDwpX2FLWzu2Nw1KOxEn
	lZB0IXVj3TwecyYoLomHQ==
X-ME-Sender: <xms:i3PMaJyu1c2CEQza0KuQa9ObmKXc-fIQT2UR_v8lpKKAIA_RVxjBsA>
    <xme:i3PMaJScoSZV7jCZ78WUlMGZhAgAU8fYZHn-SrBd1SGfErn4OszNcke-M2ChbUqzc
    mYo74PlxKhh8-qNA_k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjeefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfluhhlihgr
    ucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhnshdrtggrqeenucggtffrrghtthgvrhhnpe
    fgveekudeviedvveeuhefhvdetgefgffdufeeguddtkeegtdeltdevhfdtuddttdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjuhhlihgrse
    hjvhhnshdrtggrpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtg
    homhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:i3PMaNybYqFC4RI-NeNX8WDc2rL8G8CsUCZ4xGYJWMhzFadPGtFYFw>
    <xmx:i3PMaKbB6fpB-4zxFGqJSRWffajDVvKgSRjah_yCl397A7mjLC59Dg>
    <xmx:i3PMaGXxhlbhVrlkqdvBPB6aWPqzOBLdI0uRFZdPPnKJVx0YgOGgmQ>
    <xmx:i3PMaAjOqonfIijeu9zxOfOx4ZXXVOkk0skfWivGgDAGuz-PksBEfw>
    <xmx:jHPMaBDpC7oxBe8TEN_rsuBuXRLRNzX8LWRvMUzhuV2urPsACsFkfAf4>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C10DA78026F; Thu, 18 Sep 2025 17:03:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AiyWxa7EEqz3
Date: Thu, 18 Sep 2025 17:02:47 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-Id: <deececa7-522b-403c-924e-d045224b67d5@app.fastmail.com>
In-Reply-To: <xmqqms6varcq.fsf@gitster.g>
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
 <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
 <0ec629d4037bf5d1ccc248ca1bbd87ccc08119a3.1757703309.git.gitgitgadget@gmail.com>
 <xmqqzfavarz4.fsf@gitster.g> <xmqqqzw7arls.fsf@gitster.g>
 <xmqqms6varcq.fsf@gitster.g>
Subject: Re: [PATCH v2 2/4] doc: add an UPSTREAM BRANCHES section to pull/push/fetch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, Sep 16, 2025, at 1:39 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> For now I'd locally patch it with the attached, which does not seem
>> to change the output at all when formatted with Asciidoctor, and
>> does not break the build when AsciiDoctor is used.
>
> Sorry for the subtle typo on the last line.  i.e. "AsciiDoctor" ->
> "AsciiDoc".
>
> What I meant was that Asciidoctor has no issues with your
> version (while AsciiDoc complains), and with the attached patch,
> Asciidoctor produces identical output as your original, and AsciiDoc
> no longer complains.
>
>> Thanks.
>>
>> diff --git a/Documentation/urls-remotes-upstreams.adoc b/Documentation/urls-remotes-upstreams.adoc
>> index 1e9c56dc5f..f40db15b20 100644
>> --- a/Documentation/urls-remotes-upstreams.adoc
>> +++ b/Documentation/urls-remotes-upstreams.adoc
>> @@ -107,11 +107,9 @@ Git defaults to using the upstream branch for remote operations, for example:
>>  The upstream is stored in `.git/config`, in the "remote" and "merge"
>>  fields. For example, if `main`'s upstream is `origin/main`:
>>  
>> -```
>> -[branch "main"]
>> -   remote = origin
>> -   merge = refs/heads/main
>> -```
>> +	[branch "main"]
>> +	   remote = origin
>> +	   merge = refs/heads/main
>>  
>>  You can set an upstream branch explicitly with
>>  `git push --set-upstream <remote> <branch>` or `git branch --track`,

Thanks for the patch, will fix.
