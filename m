Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00E9E20281
	for <e@80x24.org>; Wed, 27 Sep 2017 06:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbdI0GYf (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 02:24:35 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:44592 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbdI0GYd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 02:24:33 -0400
Received: by mail-pg0-f52.google.com with SMTP id j16so7235989pga.1
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 23:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6OlJqxxmNiqdCjPCFJJg6bmzbCwCNh4PFzRM/mnKwPQ=;
        b=LibuU4M8aJ4BUToQ4KFQYl8Kay5gG3qqUmhHiu2umHBwVini3jP7wxllf6qYZYciPH
         cU2ffJwrsQs21+VgG41OJZ2RtbAAqbpWEAyCbUcxd/sMKTBwHwyCiy/DG7vFyn336A4V
         2TgAwNLkouI/IiUIrLhhzbbRMlsVoapDmgFlP4ebYHS8G7iV6PcYtdHyE3XLhS6fwIi4
         MY3Lebk+3PFkXUu2o1xINS0FkjptgOpco3mYFXHUzKMajo16ua7yZGZuZvkaOhzrhXpF
         E8qeBN++fuFmZ3FQqCjgceu1ZjZmbZA5Tr7JzlUh6on62RitHu5QtYB7myX4+52annGR
         Qlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6OlJqxxmNiqdCjPCFJJg6bmzbCwCNh4PFzRM/mnKwPQ=;
        b=jUqBovRLDTOL9fAv9VMgkh1+h7tixsstiJ/YImOMaapoT0Wxm7RY40fTmZtecmWShw
         WIW/xpXzXCB164CfZnKQKiMyPbuCsZzgLdz8umBQYZbWKAUvWgCeqpYwyxVNvJaUB5aK
         LSNUFN5tnYumXXZ7sjDcqDczT0DlkgnaZWQklaHUbqOH1c9wmuVgfRtnX5b2ejSkT12B
         ELMzdWdlxMdiBTbKJ1zjnY1lnw08E8jySJIkRL3UWGou6AcVC2EtvbODnav22SUXd5Nh
         tMJuS3R0ShF0tM7jBRrAnB6hqStvJNH6//fr46Ch+oDTw0mILkqqkyEYIoTHO/4b33LG
         HXQA==
X-Gm-Message-State: AHPjjUhwHOBdq8b61rKl2Z3E3q5yTyTAbFeqnVCcumBGZ/+TBDQvgHKm
        0p8bNjJz2lBpNBLDKGLxd4Y=
X-Google-Smtp-Source: AOwi7QBA/NXCKJbgjH9vclrEUQAaOpDsLm19iMMzni7f/aOMn7yS8dgFgnoadH6nJcwsit6dKK8k0Q==
X-Received: by 10.84.225.2 with SMTP id t2mr330443plj.425.1506493472853;
        Tue, 26 Sep 2017 23:24:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a541:226f:6d4c:7f7a])
        by smtp.gmail.com with ESMTPSA id 78sm18612551pfk.70.2017.09.26.23.24.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 23:24:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v2 8/9] http: tell server that the client understands v1
References: <20170913215448.84674-1-bmwill@google.com>
        <20170926235627.79606-1-bmwill@google.com>
        <20170926235627.79606-9-bmwill@google.com>
Date:   Wed, 27 Sep 2017 15:24:31 +0900
In-Reply-To: <20170926235627.79606-9-bmwill@google.com> (Brandon Williams's
        message of "Tue, 26 Sep 2017 16:56:26 -0700")
Message-ID: <xmqqfub864m8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> @@ -897,6 +898,21 @@ static void set_from_env(const char **var, const char *envname)
>  		*var = val;
>  }
>  
> +static void protocol_http_header(void)
> +{
> +	if (get_protocol_version_config() > 0) {
> +		struct strbuf protocol_header = STRBUF_INIT;
> +
> +		strbuf_addf(&protocol_header, GIT_PROTOCOL_HEADER ": version=%d",
> +			    get_protocol_version_config());
> +
> +
> +		extra_http_headers = curl_slist_append(extra_http_headers,
> +						       protocol_header.buf);
> +		strbuf_release(&protocol_header);
> +	}
> +}
> +
>  void http_init(struct remote *remote, const char *url, int proactive_auth)
>  {
>  	char *low_speed_limit;
> @@ -927,6 +943,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  	if (remote)
>  		var_override(&http_proxy_authmethod, remote->http_proxy_authmethod);
>  
> +	protocol_http_header();
> +
>  	pragma_header = curl_slist_append(http_copy_default_headers(),
>  		"Pragma: no-cache");
>  	no_pragma_header = curl_slist_append(http_copy_default_headers(),
> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index 0642ae7e6..df1943631 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -67,6 +67,9 @@ LockFile accept.lock
>  <IfModule !mod_unixd.c>
>  	LoadModule unixd_module modules/mod_unixd.so
>  </IfModule>
> +<IfModule !mod_setenvif.c>
> +	LoadModule setenvif_module modules/mod_setenvif.so
> +</IfModule>
>  </IfVersion>
>  
>  PassEnv GIT_VALGRIND
> @@ -76,6 +79,10 @@ PassEnv ASAN_OPTIONS
>  PassEnv GIT_TRACE
>  PassEnv GIT_CONFIG_NOSYSTEM
>  
> +<IfVersion >= 2.4>
> +	SetEnvIf Git-Protocol ".*" GIT_PROTOCOL=$0
> +</IfVersion>
> +

It is very nice to see that only with a single extra HTTP header and
the server configuration, everybody else does not have to care how
the version information is plumbed through ;-)
