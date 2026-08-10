Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6123D9535
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366238; cv=none; b=K9vvCWA+9W6KjPAIOG80MT4UkkxNte7E9oSk5vUEfc09mB1sua55OKW499cV6xZVmEuO52EjWCWtphe/GmmiurxvJoHG22koUSUc6RIjJ42NNyP2lrWsHaNSBldBkomymI0JidwkDFjXtmDQHhugJ+VD9JFQacCJPwPXOtdSz4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366238; c=relaxed/simple;
	bh=Aau+BqbzLGEf32rNsb5x7i2MYI+1x8aSJTX+PWnjNrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKupo3yq543aTTRFwbUbs2c7+EyL4jh0kbYwiCj8hD1agZRcxrSd/yc6Sb7uG+Xl8xV9aTO6YzeBbaslCrdCOZew77pnkJ2ogcS+OBUV6Kur8tgsKLaxIMxK1r5e8Zz2yHghw+pK4Pv5WddiwYR9O9BcwLIYBvxDG+pr+XXmLDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NxQDge0Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fjax0Ir7; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NxQDge0Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fjax0Ir7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A2CE4EC017D;
	Mon, 10 Aug 2026 08:50:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 10 Aug 2026 08:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786366236; x=1786452636; bh=KMQ7N0TMhu
	5J2xpvr59OLu2cn2G7kZ7ARIrBeQlK1l0=; b=NxQDge0Q1/V+dbdcJ+nvhmgI9V
	17503/P0cGkaReUd8ymMb/iYRK6lPhJeeyvbxzCR3keM7m73NsR1IDNwg3Sd553M
	ewGCo+u3ZDaug0wC8+QJTQJ6zK4R/Kzlh1C4TmAPueuLGEB0KceZe3fbmd6SvqRf
	XXGLBD+mUSQGJpOXVoI0dt+42RfgP3a367qFVSK9NjySQNnuJUNbfJ9Nhqm1P1wN
	0fpYmqsVUNXGfLcXeDJ6PsjtSYSs2uxS6Fg1HRszfRofHafOmqQlO7WpNBXWDJXN
	mXvCa5LNYPFS42EKeixcjAYlkeLZWLhZc57nGMLrf5r20nOBU3Y9aiKMTsWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786366236; x=1786452636; bh=KMQ7N0TMhu5J2xpvr59OLu2cn2G7kZ7ARIr
	BeQlK1l0=; b=fjax0Ir7p5SRLaWLjGBeepL4RD24iZGL8yGjo5OSfAjzcOsL8Kr
	ArZ5b60LsH4Ni8ese50wb3fB31bA4W+fVrBnTGZqu3SJilzlL2R75GNY4B53TsDG
	lW/0uOAziD1Nziyi5c4dElayzPDwZhYoms2DKZxjgVYif49UQ1+KooEUQZJLxERw
	5YMBiIS8X8qm2bKx+1S/lliUS2TQz7S66ABD3OY1uwigKs5y4tiGTdL2wX04uVOu
	nLm6BbxFNCGO4bpxAejTxXPGf0/06GtLwEfCkhmIec1O9Y8aO3x18aFYko4aMRcl
	s9AXeIULBEKQ+o+PIz0rm40pEG5tcp2Tx4g==
X-ME-Sender: <xms:HMl5ajDgSs9OkKBK2br7BwZkipL_FQmyiOfyFqdvICG3sJDdpqtNJg>
    <xme:HMl5ag-MXoa-thySzAS3hosxUWK_WY7JY-kct4y9CGTyTBv4VGBc5IZ0S6O__EuS_
    on85jov9ULRcge1VN4UM8_F2DZLYC3VJi_2acbsR5oqBRldeRNc>
X-ME-Received: <xmr:HMl5ar8kaXzXmZsVDWOARILd-h0tkXfnVKzeea-44rcngIT2XIbkvry4YVDvvI34Si9ue-R-H_Nx6GP9Ut5C3lRy7ZJ1eOkMCAEo10lvLA>
X-ME-Proxy-Cause: dmFkZTFNOPOUMY0i7kPgTcXEdjdwggZOMM2zwAZTLBO0Ty/zKeCLnVgekD+BxedYPLogHi
    DLeauMGhkIf5AXR8VIEYsH+Grp5pdfc0D4YchkC5nrvK/Ki3ZQKt4L1BbXYqab/9LGadnE
    yrgv6Fn2GctCrpEXpTADkHeiCZLWhI6/LEELebwnOGUmVjJR4AdFUWNzmk0MfmaLwxnq4T
    2zfYugrbk5PKAWAwITcLdA7yIgeJjI72hAeiXMJ4EJxVXkjLMDbdMbNwitrgv+9H5ks/j6
    09fNkoQTz2Zq2h0oCX4xi5agBrDF/vYzZYqgDpEHoLNcD8WJHEY0HJK7lLRBM1CZCUaETU
    SBBZuYqZ9A5P4iK/3p5esJE8bIKr/cQIbIs17lYTAm6g5OCjPqGfWxxOBhDtXwX89t6Cvy
    ZTMiKsfxed5VOJwxzet6wI022u5DPvGYBuTErOvumdbjF6ieh6Scfn7fScnAb/tnAs7qb4
    Zumxv5bztlZsACOU8eg9Gk4x6YAd31YIuB5RPKf9dzMMJcHETcO9hZuL7jr1y7MMSynlpq
    oJ7QuXPOMKH2ZriwUTZtVaung0mrlNo2P7OmzdkTBdWLaFjMl20W2kfd2xmWSn8Ff8wmW/
    16hYyOqB73XQ4iCP8xHoHTDYkDpmR1klyC0br8pNszxKNQkpQSLaAEpLO+IA
X-ME-Proxy: <xmx:HMl5avfCptq_389YIJ2ToOlTQGjToBbupdABU81o2TphUC4KSz0_sw>
    <xmx:HMl5asFoQESxEuBxsj7mILHCC1KRhBLcAHZVHaDxDgkcUOGCcBLEtA>
    <xmx:HMl5aleBB-hyflr_sd_Ps-JmVLEgSlmJJeS4ydKHG4094MnOwRBwSw>
    <xmx:HMl5auFFbaVhD_bN-SmOceoOujVVMcEXRgzvNgomK9jaQSur_ZWFbw>
    <xmx:HMl5ag8_P7hKe9itO_6D_EBWSQiUrljC_welnKvHQYndQYGeHQoUdC4Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 08:50:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 85fbfd28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Aug 2026 12:50:35 +0000 (UTC)
Date: Mon, 10 Aug 2026 14:50:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] meson: expose knob for xmlto relative links in
 manuals
Message-ID: <annJGNtPnC_iA_9y@pks.im>
References: <cover.1786103607.git.ben.knoble@gmail.com>
 <d612de6c2de615f368b5985f200c5ea8e3116c08.1786103607.git.ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d612de6c2de615f368b5985f200c5ea8e3116c08.1786103607.git.ben.knoble@gmail.com>

On Fri, Aug 07, 2026 at 07:56:24AM -0400, D. Ben Knoble wrote:
> diff --git a/Documentation/meson.build b/Documentation/meson.build
> index f4854f802d..cfa9c67609 100644
> --- a/Documentation/meson.build
> +++ b/Documentation/meson.build
> @@ -379,13 +379,18 @@ foreach manpage, category : manpages
>        output: fs.stem(manpage) + '.xml',
>      )
>  
> +    man_base_url = 'file://' + htmldir + '/'
> +    if get_option('man_base_url') != ''
> +      man_base_url = get_option('man_base_url')
> +    endif
> +
>      doc_targets += custom_target(
>        command: [
>          xmlto,
>          '-m', '@INPUT0@',
>          '-m', '@INPUT1@',
>          '--stringparam',
> -        'man.base.url.for.relative.links=' + get_option('prefix') / get_option('mandir'),
> +        'man.base.url.for.relative.links=' + man_base_url,
>          'man',
>          manpage_xml_target,
>          '-o',
> diff --git a/meson_options.txt b/meson_options.txt
> index dc88f130d7..d590c21648 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -111,6 +111,8 @@ option('default_help_format', type: 'combo', choices: ['man', 'html', 'platform'
>    description: 'Default format used when executing git-help(1).')
>  option('docs_backend', type: 'combo', choices: ['asciidoc', 'asciidoctor', 'auto'], value: 'auto',
>    description: 'Which backend to use to generate documentation.')
> +option('man_base_url', type: 'string', value: '',
> +  description: 'The base URL to use for relative links in manuals')

Makes sense. I also verified that we indeed use the "file://" prefix by
default in our Makefile.

Patrick
