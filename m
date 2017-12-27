Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2169A1F404
	for <e@80x24.org>; Wed, 27 Dec 2017 18:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbdL0S3f (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 13:29:35 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:36801 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751145AbdL0S3e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 13:29:34 -0500
Received: by mail-io0-f195.google.com with SMTP id i143so16008000ioa.3
        for <git@vger.kernel.org>; Wed, 27 Dec 2017 10:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uQuH3i63mdoenKCcfmkAkWKF3asUw4XqUZqLB9ohWnQ=;
        b=p0Y/j+qBenLJ7TI0GoN2GWrGUxhz7doAdLliqipUsrKJcHgzM5JF8Ohb3jlg3cnkqV
         QxDuR7cU/312DPaRyo3fsgfDncHXAONmvoTZd8WdpZYh2bv0wcgARZlY4N1GlFElrImM
         WfnDTWcvrsF3/6yxjHQEPXOLSExKQtRHdRQKlcXjTXoqLr1Z6wfGIeYrTwrLxzPrBXp6
         4IhRoBQb7N7wdroU4uA6d43GcpwhERVFuVKmmI2ka0hGLTZwBnRu9Zi4rMv8GSPLo3M0
         Sqj43Dmq8/Wof0ik89EEC/ZCB75ltIpXDzBuszCSrnNBv3y8BlBq8Mn6i/tz5rrozeXz
         pt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uQuH3i63mdoenKCcfmkAkWKF3asUw4XqUZqLB9ohWnQ=;
        b=hsSwTcPSomF6FDdQtg2ONX+pdsbjHl6TDDvMh440TzmWlfGI7Z1AXROaYUUpMB/Dkf
         nqDwssbHK8JeFFSM4zZNik1Aerdr85u4Xq9KLoGykJLN7t7ZJB9pc+TITflj/MBrADLY
         W/myGooEkgSQo9pq2Wwq856gvipOQNKDTrvG68i5v6XNuNcIrT940ZwX3pP6O5akU5Co
         1xyRfGxwdxsAptLqAqUEkCNH3Rs8p/1TMiZWbHmBkYLqm2v6vaGEFhxSRcrueLJOhceg
         4hQXzszjSVhK7KPCseVqVyiFTArwC6lujhrTxyDIo4e2uVUm1CsotKtlELrcIDGSq0ab
         a95g==
X-Gm-Message-State: AKGB3mITkJIR0tAVLMJ0dxf+H5x3DpF3thmV9i7XUs8rA4FMG/VEGQwI
        mSvXRwQZ4N8/Qjfs19rC/Lk=
X-Google-Smtp-Source: ACJfBouxW9z0QsYwwxka8HMHw2/KFvrlbByYn+48sbxE2M4xTxulsWXU6z2pMsuF3MFM4BBooCI4/Q==
X-Received: by 10.107.16.77 with SMTP id y74mr42355970ioi.241.1514399374149;
        Wed, 27 Dec 2017 10:29:34 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id q190sm2079213iof.57.2017.12.27.10.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Dec 2017 10:29:33 -0800 (PST)
Date:   Wed, 27 Dec 2017 10:29:31 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Wei Shuyu <wsy@dogben.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [RFC PATCH v2] http: support CURLPROXY_HTTPS
Message-ID: <20171227182931.GD149622@aiede.mtv.corp.google.com>
References: <20171223150215.8615-1-wsy@dogben.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171223150215.8615-1-wsy@dogben.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wei Shuyu wrote:

> Git has been taught to support an https:// used for http.proxy when
> using recent versions of libcurl.

nit: commit messages use the imperative mood, as though commanding the
code base to do something:

	Support https:// for http.proxy when using recent versions of
	curl.

[...]
> To use https proxy with self-signed certs, we need a way to
> unset CURLOPT_PROXY_SSL_VERIFYPEER and CURLOPT_PROXY_SSL_VERIFYHOST
> just like direct SSL connection. This is required if we want
> use t/lib-httpd to test proxy.

Interesting.  Sounds promising.

> In this patch I reuse http.sslverify to do this, do we need an
> independent option like http.sslproxyverify?

I think a separate option is a good idea.  This way, I can use

	[http "https://example.com"]
		sslVerify = false

to fetch from a misconfigured server or

	[http "https://example.com"]
		proxy = https://127.0.0.1
		sslVerifyProxy = false

to proxy through a misconfigured proxy.  Alternatively, is there a
straightforward way to make

	[http "https://example.com"]
		proxy = https://127.0.0.1
	[http "https://127.0.0.1"]
		sslVerify = false

do that?  Something like

	struct urlmatch_config proxy_config = { STRING_LIST_INIT_DUP };
	config.section = "http";
	config.key = NULL;
	config.collect_fn = proxy_options;
	config.cascade_fn = git_default_config;
	config.cb = NULL;
	config.url = normalized_proxy_url;
	git_config(urlmatch_config_entry, &config);

How does this interact with the GIT_SSL_NO_VERIFY environment
variable?

> To fully support https proxy, we also need ways to set more options
> such as CURLOPT_PROXY_SSLCERT. However, I'm not sure if we need to
> support them.

That's for client certs, right?  Would it work to make that
configurable as

	[http "https://127.0.0.1"]
		sslCert = ...

?

That said, I agree with you that it's not a prerequisite for this
initial patch.

Thanks,
Jonathan
