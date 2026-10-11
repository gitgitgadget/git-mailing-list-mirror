Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0F636C5BF
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791745134; cv=none; b=fRzmL89qYNxx/SNvXeEfZbQ8raedWwsCOTQgo05y1PD75tRbTfPuIBAOOuQ1p71ltDFil838w0997e+I1y6HN2TSs7AceTPC7ZgM3DqVRB3dQpRbegyUeLOYWBdL8W4TmpbhtCr88QHp2jdXoM2mFMQYRJ4YfEap9VeX84+9bvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791745134; c=relaxed/simple;
	bh=A3syRF/MgJ9p+jzxcdSeIeqVZVUJpQ+xMqX7CbM/ghQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D4OK12nGLQI4xPJc4IUA4hAukZrLsa1flv8s6dXwAlbbNufVsThtBP+3c8r51+7dSj5wc0IIAoytyifxCqySaopEGGdoyfZTr7qxPqLW2lgoukzCJEfR7CYcSOXmi+6AXqwY9fSvhJJCyZWtV2Bcw21o4G/AzVq6OpN3EJx9xYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pJQlVYkW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=chsrwrtL; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pJQlVYkW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="chsrwrtL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6B950140007C
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 14:58:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 11 Oct 2026 14:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791745131; x=1791831531; bh=RgyQablv6y
	9mkhq42WJ/LEHnNNsbEqGSb4a6Rz10sDg=; b=pJQlVYkWtc2AmVY4bLlkzKP+UG
	Y3fLiPp4ikcNMcYY7Adi2WZby/0b+tx8NMoqYFeFwvSQVEx436Y8UTbHmaJS720R
	NJC/1sA8tLS2bCnDB846K5jepCAEN/f4Xxn/CnMw9SX8/+PgAooFNJdbQbPf2FIz
	fYVTx3vuRNfmx6jDHp8IMqHgej3qYGF6RG9OVbCfCBxxAc9vp96KsxSXCq9c9BV9
	vgtj+bFrnsjo5wfwbYslmcRPSFAzEOWXR+cUC+RvnSVvBueUS+KTjA/6AGkNXRPq
	67todrY1AZmLm4Ha6jtKD1jSzJkaTchym5OYQtGv2JPfg6dZ5eaTl8O2blWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791745131; x=1791831531; bh=RgyQablv6y9mkhq42WJ/LEHnNNsbEqGSb4a
	6Rz10sDg=; b=chsrwrtLN6WBF2j4Y17WA/Uw8uOza/gK5Q8Nntr1mKNrdItd7zr
	J9/VhM7uBHXnaYexZhEzmFWmf2SR6OpCAYt3/6biUoVX2+bT7pAjwgZP6e2vfd6J
	7wPW8ULi3ffTQaHZyBewn379jEl5KEW/u/R3jpzYkFPKCUh2PEimYy9EmIllw8Nu
	HPKqd9J77liczw5x4PQp9SDNmTr71gjHzXC70EwaJB9q09MjiQXsYKKlpVERCN0t
	JEGZo4m8gSgChUrsMhGd18i/A2uXWVvSsl8IzOzkgSWpnqWkvT1xO4DlT0Mb1R7f
	d1IQ8dKfBhg2nlWoFIqe0Cw1CFip+eQBmeQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791745131; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:TxVSDTpYDO9ci2aiO2Km1Qrj3zlF+SioEQjg6JwaShpDTf7
	4GQ5QaNwZixWRYpkU3MXWVEMEhy65OqlHpUh6ZCUM2OyVN5k0CkMIQUDUKljge6/
	oUdAJ6hmy0T9EzqdiiK+ghlGMz+cNCpywo5er6HYh8Y+NtwhYxIhgwElJ/FO8epK
	xsdCHJ8Qxdxcvk6K38QrB3gKpgoZpTijv4H/JaFT7KxNsvd9DKVUg7rMdBT2TV9V
	J1B4mf/nkh/UWbdjTjTtzegdUmw2aAPtxJcub2TTH0MZ7xlOEdlaRmB0GOxWoVyi
	PxRrKVcGyy/4yUwyrdWULkSA/IAZqyIAHWPjemg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:THbMtkCwnrofiLe+4O5dR/2V2PaRlerFfQRuSyCfDpw=:A3syRF/MgJ9p+jzxcdSeIeqVZVUJpQ+xMqX7CbM/ghQ=;
X-ME-Sender: <xms:atzLaq3lJPSkPoWNg810Os73y_C3EzyoGLgmhNsSrZzZ3_LI8mQEXw>
    <xme:atzLanFWdFDnxGfH_zT0vvGTUnRioRnqRiQD5-sN5axkEg4Nq1RC55vpnDr1Xt-bb
    fWR3kbynXQWroksGa9nj8FAfbpeM8H6SnfvTYl7t_cpImcZ9ScnGA>
X-ME-Received: <xmr:atzLapjinJ12M8JrK829dZKBaBDnGW1vh7gB919fVjdElE0Nvyt2EKFcB0G7FHXO_HkDMnp9aOB5SyM8t24BmTTZaxs-kNE_SzDa>
X-ME-Proxy-Cause: dmFkZTF9dEq0IyMF6eq6NXlCtp/JKKd54pmc53FCVSSPNMsnxiW0O9bdgCbFY9x4EytLrM
    45xI7EV2jOiUsP2mSCw4Atj1IFxWGFv6DMAr1EbcGM2I52Ci6Uruw5XccLWmAHDXsgOpiR
    qHu8Ap/MVId3Z1BkUefTkPKZv7oJNPiAAiUgYpQDZTmjylPouEc/ihhNb/GS4vdQL+U1JU
    6M1UGdpsecVAy0JXOEXSeILZ4ElbygQWUxFooAYN2pugO7NEi+g4RT1HLufmApE6jsn/4W
    uJv86N/cXmPh0C8kg4V/Fqs2nsr1wK8OBzsJ17jhZ3O8yzMRsXaxRFBMuCL8ZrN8M9OffF
    xA/2K299sPVD3j1gB8d69z+uoIpADaiiFHZBtsYljJPrrs1NxtWhgOpe2sNHOnj95XaTKG
    9EtfKF8MvbULcTOQN8D2qhXDU/7dzTIXc/gvgNZSslG/hZMxnK8/nVeGdSerlZV98U2/Kl
    OdvkBJBjWPG5KIckSwHwlIdbVfZWtX9lbYyT8DJIAuI17smI9FHSntjYOsnpStzpl1aLd5
    I3Smh7OepfALrflMyZ7eDotDYkLEYkn7BNPCbxOH8G6Sjm5yNmnHbBsw5EzHCNnNEu9qAH
    Cc64jCqMMIdkdeDbGFyTrJ0f7uG2ILUr1bmjEoMfLbZDFm3qJuNT9i7o2ZYw
X-ME-Proxy: <xmx:atzLaqAIOaQfDm3Nkv8X0v4olh4zxtpt4p-fo3XX1R0rCWsXTd5pPA>
    <xmx:atzLarS8S2BNU0ekEPI3K5RW8JsWDyL7ofgQD3lvErSIObxhlh68vA>
    <xmx:atzLavXwbEzHUok-i37AU9zuHrPOL00UrZnHk_lOyckbUNSmzuGkyA>
    <xmx:atzLakeL2Im9r2x4qUydJMjyKGqknh4BkgpKcFDpE-FdqLn_QdK5fA>
    <xmx:a9zLaoxeSb6uRxSXbGNcQRr42xbufPZ6h6vnitIddROZJDvTcimOdSuO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Oct 2026 14:58:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Abhijeetsingh Meena <abhijeet040403@gmail.com>,
  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Eric Sunshine <sunshine@sunshineco.com>,
  Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH v2 2/2] blame: ignore revs in HEAD:.git-blame-ignore-revs
In-Reply-To: <35e303d65bc378e733b1e9e8d6908a829352e857.1791493644.git.gitgitgadget@gmail.com>
	(Ravi Mistry via GitGitGadget's message of "Thu, 08 Oct 2026 21:07:24
	+0000")
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
	<pull.2224.v2.git.1791493644.gitgitgadget@gmail.com>
	<35e303d65bc378e733b1e9e8d6908a829352e857.1791493644.git.gitgitgadget@gmail.com>
Date: Sun, 11 Oct 2026 11:58:48 -0700
Message-ID: <xmqqtsmsdpxz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +static void parse_default_ignore_revs_blob(struct blame_scoreboard *sb,
> +					   const char *name)
> +{
> +	struct object_context oc;
> +	struct object_id oid;
> +	enum object_type type;
> +	size_t size;
> +	char *buf;
> +
> +	if (get_oid_with_context(the_repository, name, GET_OID_QUIETLY,
> +				 &oid, &oc))
> +		goto out;
> +	if (!S_ISREG(oc.mode))
> +		goto out;
> +
> +	buf = odb_read_object(the_repository->objects, &oid, &type, &size);
> +	if (!buf)
> +		goto out;
> +	if (type == OBJ_BLOB)
> +		oidset_parse_buffer_carefully(&sb->ignore_list, buf, size,
> +					      the_repository->hash_algo,
> +					      peel_to_commit_oid, sb);
> +	free(buf);
> +
> +out:
> +	object_context_release(&oc);
> +}

Since the scoreboard is passed around throughout the subsystem and
has a pointer to the repository it is working with, a new function
like this one does not have to add new references to the_repository.

I do not think it is ultra urgent, but I suspect that many of
existing references in this file to the_repository happen in
functions that take the scoreboard pointer, and they should be able
to replace the_repository with sb->repo more or less mechanically.


