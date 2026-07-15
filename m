Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3A448C409
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784136718; cv=none; b=QZHwrOhRgZ3xr8ly/MQMTCIb7bE57h9wgYQkmIn5pWZ7ftDJVVBymR1X62vLNKWYILZSejUd8KNY+R3wcAd6DkxlsrYtT75NGeXwjbbWOxxZPsH6HGrv0VME6jBRkgXPdsqHMEzlakJ7znKu3hKG3MMkLzKSYCxR2ATuK4ToIic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784136718; c=relaxed/simple;
	bh=nSkzUhshWlz4wa6d7RnNeb7/IWTcOhoeNAob5nDY0uU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rkr+zBcSBKkyF9pmKqxRdTs046fOpZNxLrnDCwK/60Sdb+O2fZzjLx2d1PUhCc9Xng0pB6X5Wyn2/gvsf1h7Prkqj8a3z6UniW/6A6HI8ZyNAKhFX3QZjLk8jlit7Z6Dzm8UfNSQAY6NZd6GcvHe0aI7kceW/mfOh+VUOmNe0wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=T3/G8qdN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X4a7ZKRB; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="T3/G8qdN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X4a7ZKRB"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 5976DEC0196;
	Wed, 15 Jul 2026 13:31:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Wed, 15 Jul 2026 13:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784136714; x=1784223114; bh=U63yXqAQmN
	91JcqWtcs1Nwrf+nEuoG4/m8T7hIAgo0A=; b=T3/G8qdN+2ru+Ytz81+H+fkoit
	UbuGKnCZmkfv/0OwwjXyiqN+opCcNsffRprOla2TVJhZpL6pM0r9DLN5dqQgrcv+
	1zy9gyPboMJFrryBUhRl6f6L78tmnekOX3nshe8rkZdd6D5XvAsJbr49afwg0agc
	atUItGdSjyoZhBzSxXtaew1gMvDz4p2yWJOcj9ktIZVMchts5W2+Px4R/IfEDZqv
	08s4EXIwkNztHvMvP20KjiFRbod34oa54AQzhtGFuNRHbczDvvrUVm3/o4Ex48sj
	3RV4/JHJuLn4K75vkivtlEsv5WA+4mr0fFKtM4O7U5gSx9i316tq+puHffSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784136714; x=1784223114; bh=U63yXqAQmN91JcqWtcs1Nwrf+nEuoG4/m8T
	7hIAgo0A=; b=X4a7ZKRBTMqYwSVRg6NT6KILgItw5HSVrW+AVZIdmAuM2UT3P6O
	inDSqzP3JJZdzV29wXGosfZgALVzA1X0JDMqlnRvC3HoGpL3kY2M+3L10dAWwuDj
	U6ITurb0OzoUOXIiGBtXSESctV+6zqtEuSsbVolqbec2uhai3b+LBILJVISCvqtU
	wIZ/IWkgdPVxVkK6PrY+nYsq1r/uPGU2WyaPi18NIoTeMZcXue0i1DPlranct7Um
	Ic0ubEIqeqokwD7KBp339UGvMsbIkaD9m+hdQj/t2Xd00fJEzd7dbiBLG485gvyv
	4XmQo4RuCNGpqfyjH5Y0mUeLiS7tObTHaFw==
X-ME-Sender: <xms:CcRXaiwuZeVCOzdUGDWhkFxhhr8YU6309Puvv_5kSNGMKIGtb6Lw4g>
    <xme:CcRXaqGbUQlqDuFMB5f244wNXC12a4uBWHfdCxUbjffYb3xsbd7cpK9h52l2VFN0L
    Rp5lFDR3G43g9gLZKKU8g6kG-TrLNGAq4ON33cYySDt6Z2bVcTqrw>
X-ME-Received: <xmr:CcRXavsiTygfVv1BzK22Ddyax3i0VdnVDySDUhLLxPnzo3nsAGMh-x5CuWlG-bHXEuVEakrvRwVVtCrCwXcTjc-omXnuzd8CeVnGArs>
X-ME-Proxy-Cause: dmFkZTGG1utNGwuGeQKe2wNeuoxD1u3O8cJ0Jt8s5wJFhRyqk7Q5hRAh7wx/PwxEhDt7Y6
    rjU12/l5hS3LCABuo7pmKPKM+hIkLcSaKFOjwnky7m2Drgfu+VaBTaoA8Ng7nrUNI6DJLU
    k39P9vi7Pb2nFDyFHR7FdEv4QZaw6/5+7yriBYLo9ewirLQzfhiOsyLovuyNUpcohyx5N0
    uzPJMivaDBxS7MtdTlHiMA7DEzDTure9QQJLDcIXh1bPs5k4dJzVlvz4BggHOMPEcNJDWo
    Hej5Id8Y6xm78oqfyN5VJaU+IKpcpwd5WLGK5BYyd/TawRtTWE9ERmvPLVnu6d8W8qNhEy
    T8qvGNrDD2FKSv30uFjdrn3XMk0NjHmTJAzsH9CgiQuNFDXVWS88jE4nOAzQEI/kK8jCiD
    S3ofHJ4QeJ/WE4cYjc8Tk3I1M+n2Ddv5a8RzvFZ8fimnWsg5Kd+VKiF0Vd0ChYrl98MvEw
    9WK7FEYwz5ZHFWLXsiTlxra1UfxYkDnwEd7UhGLm4TAXWuB0hq8fieAEI5ikiBC1YJxYPd
    G8KwqXNvioAI9xiztr4SGK6m998mCO4nNGC57GCo6FQZdsOML/FLQL30o/L8XxahLWz1Aw
    jbY3cHpuvXyVeStQUF+cWuz1ETLzYRquTApG3RKeCPzkAmVj5djTGvSgPC5A
X-ME-Proxy: <xmx:CcRXaiCkMV-ghvRSj9z7hK_RgmjrWUvM-c6JI34JFd_7Lyn9EAIwyg>
    <xmx:CsRXaiA4onWmWCyO4HlXKMr43Odq6BSfFkFUFqn0veiqp_4HPU4IcQ>
    <xmx:CsRXakp3_XyiEGXEkh_QY1rq3vhHpGeyyrNFXRKaaRj-DB6JQm4oMw>
    <xmx:CsRXalFU6d5oToWJWKiaM643XbC0id-SZoJCszkK0c-kCXVKncgYdg>
    <xmx:CsRXahPHQS75WfLvnJi5a8gRuG_3VLFCpJgAg87J8KzgbH8EpVcElulr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 13:31:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  chandrapratap3519@gmail.com,
  chriscool@tuxfamily.org,  eric.peijian@gmail.com,  jltobler@gmail.com,
  karthik.188@gmail.com,  peff@peff.net,  toon@iotcl.com,  Jonathan Tan
 <jonathantanmy@google.com>,  Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH GSoC v18 11/13] cat-file: add remote-object-info to
 batch-command
In-Reply-To: <20260715-ps-eric-work-rebase-v18-11-34d7adb051bb@gmail.com>
	(Pablo Sabater's message of "Wed, 15 Jul 2026 11:52:19 +0200")
References: <20260714-ps-eric-work-rebase-v17-0-afabfc83260e@gmail.com>
	<20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
	<20260715-ps-eric-work-rebase-v18-11-34d7adb051bb@gmail.com>
Date: Wed, 15 Jul 2026 10:31:52 -0700
Message-ID: <xmqqjyqwnoqf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> +static void parse_cmd_remote_object_info(struct batch_options *opt,
> +					 const char *line, struct strbuf *output,
> +					 struct expand_data *data)
> +{
> +	int count;
> +	const char **argv;
> +	char *line_to_split;
> +	struct object_info *remote_object_info = NULL;
> +	struct oid_array object_info_oids = OID_ARRAY_INIT;
> +
> +	if (strlen(line) >= MAX_REMOTE_OBJ_INFO_LINE)
> +		die(_("remote-object-info command too long"));
> +
> +	line_to_split = xstrdup(line);
> +	count = split_cmdline(line_to_split, &argv);
> +	if (count < 0)
> +		die(_("remote-object-info: %s"), split_cmdline_strerror(count));
> +	if (count - 1 > MAX_ALLOWED_OBJ_LIMIT)
> +		die(_("remote-object-info supports at most %d objects"),
> +		    MAX_ALLOWED_OBJ_LIMIT);
> +
> +	if (get_remote_info(opt, count, argv, &remote_object_info,
> +			    &object_info_oids))
> +		goto cleanup;

Since this function does not return a value, the caller cannot
even tell if there was an error if we just silently return like
this.  Is it really OK to silently ignore such a failure?  Should
we not die() loudly to report it instead?

Thanks.
