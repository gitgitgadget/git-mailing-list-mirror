Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D24D202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751176AbdKTWJy (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:09:54 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:46445 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbdKTWJx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 17:09:53 -0500
Received: by mail-io0-f196.google.com with SMTP id q64so4485125iof.13
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 14:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HFNd9GAa9ZqZte3SN+fCER7cZ1ov/AEnpIupaP8pMhw=;
        b=ga9Cn6n7Hqul3sqqzy8UDmeBsAxLsKj0spO3efEVh8rmmJxmMbCD0Oq5oWWZdEy5rt
         uOBgEZn/xymSgOEUJxdqEWRuqzXBZowYeC4BgUElGG3oAi8YY4P3jcmBgZDOyPVHfsA/
         /NQRrOGemcHkRroAtmEEev6lvWRBzx+EW4AuiLHFIYpla+LvFwcy6jn35sZQBNUMDPMf
         EuuMxoKNC0vUyw8uG5PJgJncvzHeJDK/kuVT7ae/7KPPvRR2xjgXsRzxjjUaRgionRPn
         wiozIjYgBF2eVD18nibzay+Kd46MiRyYV+1zrmUs5fPWblHI779KU/KDLEQqGlIaJl2X
         WM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HFNd9GAa9ZqZte3SN+fCER7cZ1ov/AEnpIupaP8pMhw=;
        b=STnpAXqiJFvWLsgEyFj/Ak4njm7thiSV5AMMJ0ksPRFETxs3t3QtXkGgj2KW15Fuh5
         zPnnSPz869e40MvfJptbga9uk8tdCroJMbqbzpjYPbKM1ht5eg6vgCZzmeNhjztjgQz1
         Y35aU9Wx+ryJNb9BkWI0BK+9InrJrahpDmtIpy0Lw2utFqv5bdlLrMWrrtUhY+hNfv2D
         I2hd+54Qfpx+GOXFSWxgk6U35EGZliAxf+jaZma1yX7RtSLqcVqqmauQWUq8LMFStvwR
         URgMTVzfD+3Z3Qt6zpbvaIORCDC7wdhlfRmGx2ACe1OOurULBAHmlX0TTB6FBgPsUNgV
         iQmw==
X-Gm-Message-State: AJaThX6+RFqXLXaXsGqey99Np/++dqhnw/dW/rGeYv2DpELP+5Yx4kdW
        uR2c/s2aPUp1+FSf87RFW/A=
X-Google-Smtp-Source: AGs4zMbex4eF2WFegBnCiAfx93+27DhpqvfhKYVTbDcAuk6Pq7BqYlOnl+7hWGBgUcoTaIO9TX+XEQ==
X-Received: by 10.107.47.1 with SMTP id j1mr8962511ioo.217.1511215792776;
        Mon, 20 Nov 2017 14:09:52 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id i33sm4921825ioo.64.2017.11.20.14.09.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Nov 2017 14:09:52 -0800 (PST)
Date:   Mon, 20 Nov 2017 14:09:50 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH 4/8] connect: split ssh command line options into
 separate function
Message-ID: <20171120220950.f5ipri354x6squck@aiede.mtv.corp.google.com>
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
 <20171120212505.5t6vzvkfvhmjqwsd@aiede.mtv.corp.google.com>
 <20171120215404.GC92506@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120215404.GC92506@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:
> On 11/20, Jonathan Nieder wrote:
[long stream of quoted context snipped; please cut down the quoted
 text to what you are replying to in the future]
>> @@ -972,16 +1031,13 @@ struct child_process *git_connect(int fd[2], const char *url,
>>  		conn->use_shell = 1;
>>  		conn->in = conn->out = -1;
>>  		if (protocol == PROTO_SSH) {
>> -			const char *ssh;
>> -			enum ssh_variant variant;
>>  			char *ssh_host = hostandport;
>>  			const char *port = NULL;
>> +
>>  			transport_check_allowed("ssh");
>>  			get_host_and_port(&ssh_host, &port);
>> -
>>  			if (!port)
>>  				port = get_port(ssh_host);
>> -
>
> Are these random additions and deletions intentional?

Sorry about that.  It was to make the code easier to read, but I can
see how it's jarring during review.  I can resend without the removed
blank lines if you like.

For context, here's the code in question after the current patch:

	if (protocol == PROTO_SSH) {
		char *ssh_host = hostandport;
		const char *port = NULL;

		transport_check_allowed("ssh");
		get_host_and_port(&ssh_host, &port);
		if (!port)
			port = get_port(ssh_host);
		if (flags & CONNECT_DIAG_URL) {
			printf("Diag: url=%s\n", url ? url : "NULL");
			printf("Diag: protocol=%s\n", prot_name(protocol));
			printf("Diag: userandhost=%s\n", ssh_host ? ssh_host : "NULL");
			printf("Diag: port=%s\n", port ? port : "NONE");
			printf("Diag: path=%s\n", path ? path : "NULL");

			free(hostandport);
			free(path);
			free(conn);
			strbuf_release(&cmd);
			return NULL;
		}
		fill_ssh_args(conn, ssh_host, port, flags);
	} else {
		transport_check_allowed("file");
		if (get_protocol_version_config() > 0) {
			argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
					 get_protocol_version_config());
		}
	}

Jonathan
