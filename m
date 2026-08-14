Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747E5480DED
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 17:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729787; cv=none; b=X5TpAjS9eaJyyvacESXRKinaDmmHpEI03A96pUKiapv06MdE3M4376c046TxNLZojvbuR+Ao3FWKPk6ZAGQJPpOQn34SvtkCSCCNfnhMkV3JQr+KRcVZc1Utns/qKmycbCSbrezIS91dWIjBbz+lXhHFjlVvl07eTYvN5sZUUxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729787; c=relaxed/simple;
	bh=+eyZJI3bNnp8G43YGlOKem9REMObcg8WBwwAvBaGX3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KKZFF4M6Ok+y9heLNa3MhHABcQ5tVGFbxsMypjcdfUQGwrMqpe653k7BsP1gDN7vhCLG5pWr87jcTRPAybyiuPP7tPsJyB7F1bzurVrbx7ZJCIh+6134c9Oczjr5I8lOHbAklpeLynzJL6Pvu50IG4NRQ+/iBxMg0noG275Osw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tFTzLvKw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QBoZ5Pkm; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tFTzLvKw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QBoZ5Pkm"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D74DEC010C;
	Fri, 14 Aug 2026 13:49:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 14 Aug 2026 13:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786729784; x=1786816184; bh=j815/KxwpX
	05nXTdMchdrM0k6QVaaBtuSk6TI2m44ro=; b=tFTzLvKw2P6IjZBmJ/o49FnirJ
	lb+17+Me9nk+n+KH95zNu8s6/i4GLZJOQSlslVi5zX+QnLBTxWLjri8Pq7xGILC3
	73l9K+PIFRL6+0E2xaM0F1/v6cWvPZJgYYc15S2wWhUshU/4HgqiZSfIC4QhUoCS
	UKdpP3ilMBIIdlbOnBymJt5dvbs+28Eg9KhC52klFfu2HseGKyGeapNvtT04Ds2m
	3BD2fzt6L9IQM3Cah0LUurWiz+ofo5dP4v08Ern1tmoAAXJY6IKuCacJmyxJMMxX
	j11Ql4kl/E5o2tv4t5nzB0bQEKMr1zYCSNdfgsiQvBKvHjLYa/CyreZMlQpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786729784; x=1786816184; bh=j815/KxwpX05nXTdMchdrM0k6QVaaBtuSk6
	TI2m44ro=; b=QBoZ5PkmmbvllX3sH2yxJSRv1WEGynOL6Dh9ttxIgaPb38+jXn+
	GCWoNUqOSYlaelr/UwyqOBdmdaoTfR3xSP9icyPEsSUpDfwoErM2A2pXoWFd5Zcm
	tD0LWtEvw9wKFhZ9yQZvf1iUNNQqsHsb2OiEfnrjAhc9TjN5ggnKxzfwMncUWdGM
	0JdsPU/QbaD95Wzd9cDWs3HZ2hU0jfxGTS+dRNlXwqm1lehcUZkx+RsVcYOYnk2c
	Gczo2XT83M8SXQ9yHUvhkRRXulSDHs6v+luUBlXNnPW3tSHUABxTtARj6+YkCDkP
	s2KonZAVYBeGdD7f1nkiYzZFcT07rR2bw0w==
X-ME-Sender: <xms:OFV_asUVJ-368zAGqLIYIjx-mbdOqQ5cJDvkpxehEaOqkpdaJ4D5sg>
    <xme:OFV_atgAXJIUCQ5SQkUZItRCh43lhiZH8BfkX7un2mopEK-zKj10M_3WZDz-zWnNj
    v6DR8NvZ8gt5rbUuVnNk0xCnkgpT3oHpePj_kwaFMSp4SB6EmcU>
X-ME-Received: <xmr:OFV_asCJ94VMadOoT09LrEOKbNpeLvvH4h_skm-4PFm9Z3OcnrWLXfsBWu8rEerdX0Z8WOcpg-j5zjAOb-cIwYFn8wjCSljt0g>
X-ME-Proxy-Cause: dmFkZTFXwUOUdc+SqKmsPMQLDOEQMxamfZmMoxEpxgsjQ4JpFMJcnVvUYqd+jZFajh6kpl
    PzycJci9rDR3YOV8hsLfhHYRagD53m3u1BMrhTPMsI746WiAjgU2eeKfBYXN0DetjJV2r1
    OG/7LqyYMDBHfV5Vb+exIW5xmyRBsVl39ekyWAWFZ+RtH9bqT+TxTg0tQCV/4KyWENyAgC
    qjRjgAHUPXyL09ZihGGl4JQ8h435Ncu+EGkdMmnMAou3Wz5CjYEsEc9y9N3BPoFBpNgx7s
    nRKNlf7aCGNCW7TX9bOldmkzOMh3aNr1e0Ym7AO2i/4vad3dNGLV2pvCBEFK09yN/+w9C6
    7oz5sGx0ZTid+NOPlPLkBI7sPPLnkjpUPLxDT42e86sMAmJBJ/r9jNIU5C49pRR4IyF4Bx
    H0+qzz1ia1QcZmAvfgE+hFbEtXQz+AfnIQFe78ricdcY/aqO3PqJbIDnD1CTey2DzEat9/
    V9CMKxBUPnEbDn/YheyXm+gQkkhHcazGKyvdPA1p1X8Ce6QKVQG8qGUwQO/yYhuPKrAvfY
    RPccEzsDXRaI5Zp+MbOSMWrwUseimOrGma6NHSrm3JjUBQ6T1SVnIX7gh8HNE1FOAmznOD
    0CUr19J2FEv0CSwJrc9912UioT7haWQsKd2XkWH4C3aZqbwKi8gns41HGQXg
X-ME-Proxy: <xmx:OFV_aju1ZhX9xotR4C7i08RoygCfQU5uG_7WQWmOo5nwmM2jIyXXhw>
    <xmx:OFV_agcqqoAQ59y5SAAdeYZWYcLAupc4VGPUVNqpEw1wxystNWlbWA>
    <xmx:OFV_ao9_bf00u7BBDtoEhXJeKuHrZ6sanZ2edHyUqg63WNA36N5rPw>
    <xmx:OFV_ajSqwRQPQLn-jrWTKundYFRzt8iDSH651Q6Vq1Qpea2xz5zANA>
    <xmx:OFV_aonHGJb4r0rGnLxloNca9sPvVg5O-YnPr0xOk-Kb4_x9WRUSZbLv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 13:49:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Karthik
 Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v2 1/5] promisor-remote: factor out lazy_fetch_objects()
In-Reply-To: <20260813154748.2378747-2-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 13 Aug 2026 17:47:44 +0200")
References: <20260807135511.1818458-1-christian.couder@gmail.com>
	<20260813154748.2378747-2-christian.couder@gmail.com>
Date: Fri, 14 Aug 2026 10:49:41 -0700
Message-ID: <xmqqjypsoami.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> +/*
> + * Return 'true' if all the objects could be fetched, 'false' otherwise.
> + */
> +static bool lazy_fetch_objects(struct repository *repo,
> +			       struct object_id **remaining_oids,
> +			       int *remaining_nr,
> +			       int *to_free)
> +{
> +	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0)) {
> +		static int warning_shown;
> +		if (!warning_shown) {
> +			warning_shown = 1;
> +			warning(_("lazy fetching disabled; some objects may not be available"));
> +		}
> +		return false;
> +	}
> +
> +	promisor_remote_init(repo);
> +
> +	/* Try accepted remotes first (those the server told us to use) */
> +	if (try_promisor_remotes(repo, remaining_oids, remaining_nr,
> +				 to_free, true))
> +		return true;
> +
> +	return try_promisor_remotes(repo, remaining_oids, remaining_nr,
> +				    to_free, false);
>  }

Perhaps writing it this way would make it easier to tell what is
going on.  We try the preferred ones first, and then fall back to
the other ones.

        return (try_promisor_remotes(..., true) ||
                try_promisor_remotes(..., false));

But more importantly, I wonder if keeping the list of missing object
names in memory will later turn out to be problematic in real-life
applications.  Without knowing much about how the current code for
bulk dehydrating promisor objects is structured, I expected an API
that looks more like:

 - bulk_download_begin(): performs the early part of
   fetch_objects(), sets up connections to the promisor remote(s),
   and calls start_command() on the child process.

 - bulk_download_this(): after calling the _begin() function above,
   it runs around and collects missing objects that it needs to do
   its work.  For each such missing object it discovers, this
   function is called, which sends the object name down the
   '--stdin' file descriptor.

 - bulk_download_done(): tells the child process that we are done
   feeding object names.

but that is not what I am seeing.  I guess the current arrangement
cannot be avoided, because we are going to fetch from more than one
promisor remote.  Under such constraints, the way to deal with a
massive number of missing objects will not be "streaming" like I
imagined above, but needs to be done differently, like spooling to a
file or something silly like that.

In any case, except that this avoids checking the environment
variable multiple times, I can see that it is a no-op refactoring of
the existing code.

Nice and cleanly done.

Thanks.
