Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 965891F404
	for <e@80x24.org>; Fri, 30 Mar 2018 16:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeC3QRM (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 12:17:12 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:46651 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751167AbeC3QRL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 12:17:11 -0400
Received: by mail-wr0-f178.google.com with SMTP id d1so8398978wrj.13
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 09:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YrRttccnVmxiHeybcQ/i68PQvuCfxszBeZT1VOucZbQ=;
        b=a5slEjtBRJC1NA2x9BsaC1tE//YRHvb8hNeGsByk/Sg5F3YyYmwzK0KQmB+XZ6hmr/
         WwKN4tBnnyPmrEA+C5FH8Yw++SxrYVoQ/euKAmNRmCV9GOZWm2q8YiJkWHttcfq0IThq
         eed6MXeaQhszTKvQrH66WV0brZYOts6DOdOHb68gaIJEFiIBXP6+/9jZUZ2XAO1fR9M0
         WN2icQ4ToNK+rqSddSQMB6SFxFTJVd9joxn55BL2LPRtk3Ubep4oJYRJoDO5ruv1Ohgx
         O8IjbfvuB+jsJyB0WOZBoeg0Ipu7aWLYWNx0rB6SXOqWEWueMhAfgTfrl9lem9mOtYTa
         jb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YrRttccnVmxiHeybcQ/i68PQvuCfxszBeZT1VOucZbQ=;
        b=fomHWpT+pcKzh3Zfg8fMsazZ/+Ba1kwyMQK0NplZWe3XLg7yz7X1Gs8O6MyPs/Ercw
         lVRhjloXmevaydT8ijzDsHdObHJc7qRVxhoG5mLQf5uBh6kBzcQBN93x3Mu9eTfVxc8Z
         pKrMzzCca0aEHDhrChkxrtw8Iu6FCQr13qAmhD4bG/k/0OlZM7BxYzrpj9C+IOJvc4Bs
         +nuefVMIxgIOsKraqrJROnmpAc2CpDx2RS+FiSnCQ4Z1KRBVVMnkBLbwC7dgH5bdpLeS
         fjrkn1AqjnwMSdFndOPPaYSXGysrcHMM4g3NfOqPpJ7Ak2sRRmsBVmqV4NxGccoT/8bh
         q9TQ==
X-Gm-Message-State: AElRT7FXErifFQUNGJHHjdP0S0eHD0y+t06DqBjQxAvGgcxNV85sftF2
        RBI2pjqzGhMf9dtk+XQfB+c=
X-Google-Smtp-Source: AIpwx49n1NnzZOXZlnz4retsJT5kVVcdTG4H0mtvinFqWuidGblRxozYL4uMBaF5R05rDJNeXBFXtg==
X-Received: by 10.223.154.182 with SMTP id a51mr10891228wrc.176.1522426630325;
        Fri, 30 Mar 2018 09:17:10 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y9sm7605712wrg.34.2018.03.30.09.17.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 09:17:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 3/5] stash: convert drop and clear to builtin
References: <20180328222129.22192-1-joel@teichroeb.net>
        <20180328222129.22192-4-joel@teichroeb.net>
Date:   Fri, 30 Mar 2018 09:17:09 -0700
In-Reply-To: <20180328222129.22192-4-joel@teichroeb.net> (Joel Teichroeb's
        message of "Wed, 28 Mar 2018 15:21:27 -0700")
Message-ID: <xmqqin9d4jy2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Teichroeb <joel@teichroeb.net> writes:

> +static int do_clear_stash(void)
> +{
> +	struct object_id obj;
> +	if (get_oid(ref_stash, &obj))
> +		return 0;
> +	return delete_ref(NULL, ref_stash, &obj, 0);
> +}

Here you see if the "refs/stash" is there, and learn what its
current value is, using get_oid(), so that you can call delete_ref()
with it.

> +static int do_drop_stash(const char *prefix, struct stash_info *info)
> +{
> +	...
> +	cp.git_cmd = 1;
> +	/* Even though --quiet is specified, rev-parse still outputs the hash */
> +	cp.no_stdout = 1;
> +	argv_array_pushl(&cp.args, "rev-parse", "--verify", "--quiet", NULL);
> +	argv_array_pushf(&cp.args, "%s@{0}", ref_stash);
> +	ret = run_command(&cp);
> +	if (ret)
> +		do_clear_stash();

Here you call out to rev-parse as an external process.  Isn't doing
the same get_oid() sufficient?

Not limited to the above examples, the conversion in this series
feels somewhat unbalanced---doing easy things like this by forking
an external process and then doing a relatively heavyweight thing
like merge operation (in 2/5) in-process feels the other way around.

Thanks.
