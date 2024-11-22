Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D857D148FE8
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296791; cv=none; b=iG2PFhSKhlFTkeEC2fAr0KOuFYdmcVzeIUEKhgV8X3LZgUtbBoOiLiF7j4zyNYO0cjb6qhsQQjw+HdY2xAj/XkcGJPFSkqdHzSbf59aYMweiM255MpHXJL+DXTK+3nHoGou0dH3YugwY8ZpmXJNrAnZxMgNqJeSpH+OylpmzST4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296791; c=relaxed/simple;
	bh=Uof7I/5g4voQuVNEg++BwGw0SqM5XtuKPL/NDFG/oMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VR4rEcmLnsOa8/v56kByHzzoymhTAC4meDC555aHMmF/ut0EruwbgoKLfq7a5VJdZztqmSDWGFyDPA1pU/CPQojy8EZ4DAiW1QDLscaY94MOi5iVxqdHOB55cxSuRPy7s9woJF6eWuT3ppzzIpcgAHdHqiy76YaO7JyKhkVREIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DdGUt3fR; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DdGUt3fR"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-27b7a1480bdso1336902fac.2
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 09:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732296789; x=1732901589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=czPybRxKtTglqXaaw1XG6QkbJAJwf5d1TzWWbff9JyI=;
        b=DdGUt3fR8yTj/dV1QpC/JcSM6H3S+X0VESTF/HZImisnPdoewSJryU4h8C3iC0thgU
         icuxf0ATx+j61KIM4//G6OhoTfor//0R3MScTmlDcCPakG2tC10BPfMKN8QjnxBOZToM
         kaZt7wSVvmD0vSEXfnfLb75MCdxFGd/w9/rsKc+64QFWAmAlOvrxMbUj2vq2DP+uyVCs
         VCQH30qbd8R89nR1xOL+LxCb3QX+WYnW43lMRhXIn8zg0otBleZh6ArugrI25UBkMAiE
         oFIWn1GedyO8gnF1GQ2geG56jeFU29L+vPqNrIjpi6pl8TMQ6fjS3xkW/QGV2fva4uPQ
         4Jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732296789; x=1732901589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czPybRxKtTglqXaaw1XG6QkbJAJwf5d1TzWWbff9JyI=;
        b=sYkvDSJO9TRPhaYNSwhCg1CpmcgYiFG8W4qMYj5HYSu4sHIhtpYFHUtgmP3KvVyoUv
         WJ/Evy2yET/zT9FceK5cNyow5d3Fs1Orfmj7foX8Yd+w7yyaNN1bD4PFAR3jQbU2Fow+
         ZBkxe+5tPjQWVuJ0oYUgoSyOQAk99Jux9HT54PWZRAVWZz/rw7iHxRs6cuaw/TvPqj6X
         TcGJlyM9MYGPtwP2vRt+x13Z48Q+LYTSa/oo3DOmUrvQyrFb4FYg7IevOHFiMkLjsIoq
         SKmp7A+xvZ4yV8OJU/YfIsipPDUCX0dMoVyeuRY3g33k7ChMMliUw2kNiGOB4gOw7PI+
         dRuA==
X-Gm-Message-State: AOJu0YxUORumDSA3cwiuZAmomp1GRpD2Y+Uhy3IukgXWLRMpl9iNFMUY
	637aRCVkZM2YUMF3JrM45vkFqL/1u4Z9//mSgCoq+qaOotBc+dQXH4HRNQ==
X-Gm-Gg: ASbGncvrirAqqttLSmzHzyLmiLu0XQIxeQ3Z/4vTTegpsKbFX1jgal9lNwLkppfHeAT
	gvpAi1IA8okO2qHJQEtFvm5iChslQ34yAO2gq8zt+RhpQsqxxqnaGL0NcZzIIYZ/nYg/Enw5IQC
	5znRjI/hVQfqeKacMZa9leHmXdNjF2ACKo/r5yB/6/FHjwHMFSNuvJwTsCckUbyhkKtioGWKbG4
	3kYNJxeJMKtAGSTJ32oqinyrUOcM6c614iVLccEqF4=
X-Google-Smtp-Source: AGHT+IE9IizXFPbH80RADaot88r++PrKWgDk+KDSbcpYqSLVc2i5bd1871Ot7cJUoyw6zP0KgFW4Nw==
X-Received: by 2002:a05:6870:b48a:b0:296:e366:28ea with SMTP id 586e51a60fabf-29720e02182mr3699469fac.33.1732296788854;
        Fri, 22 Nov 2024 09:33:08 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d5e2fe6sm668299fac.16.2024.11.22.09.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:33:08 -0800 (PST)
Date: Fri, 22 Nov 2024 11:31:16 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] fetch-pack: introduce `fetch_pack_options`
Message-ID: <whh4tdhqmsjhfwsdkxjigw3j4ef33r4kpfika6azuonywil4eh@uf4qleljqxkm>
References: <20241121204119.1440773-1-jltobler@gmail.com>
 <20241121204119.1440773-4-jltobler@gmail.com>
 <xmqqjzcwca74.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqjzcwca74.fsf@gitster.g>

On 24/11/22 10:46AM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > When `fetch_pack_config()` is invoked, fetch-pack configuration is
> > parsed from the config. As part of this operation, fsck message severity
> > configuration is assigned to the `fsck_msg_types` global variable. This
> > is optionally used to configure the downstream git-index-pack(1) when
> > the `--strict` option is specified.
> >
> > In a subsequent commit, the same fetch-pack fsck message configuration
> > needs to be reused. To facilitate this, introduce `fetch_pack_options`
> > which gets written to during the `fetch_pack_config_cb()` instead of
> > directly modifying the `fsck_msg_types` global.
> 
> It is unclear how it facilitates to replace one global with another
> global that has the data that was previously global as one of its
> members.  With the above I was somehow expecting that the option
> struct instance is allocated on the stack of a function common to
> both callers of the configuration reader (i.e. fetch_pack_config())
> as well as the configuration user (i.e. get_pack()).  If we were to
> allow the latter to keep accessing the global (which is perfectly
> fine), wouldn't it be sufficient for the purpose of this series
> (which I am imagining wants to call fetch_pack_config() from the
> sideways and grab what came from the configuration) to just pass the
> fsck_msg_types strbuf through the call chain of the reaading side?

For the purposes of this series, the addition of the
`fetch_pack_options` structure as a wrapper around `fsck_msg_types` is
not needed. As mentioned, it would be sufficient to just pass the
`strbuf` directly and have it modified by `fetch_pack_config_cb()`.

The original intent of providing the shell structure was to allow for
more easy extension of the fetch-pack config parsing in the future, but
it doesn't probably make much sense to do it now and its purpose wasn't
explained.

In the next version I'll drop the use of shell structure in favor of
passing an instance of `strbuf` directly.

-Justin
