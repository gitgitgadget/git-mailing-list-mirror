Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 053081F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 20:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752719AbeGCUhb (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 16:37:31 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:32937 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbeGCUha (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 16:37:30 -0400
Received: by mail-wm0-f50.google.com with SMTP id z6-v6so11371451wma.0
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 13:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/1v+jY51ntKBYVsN5t0pjTMNTLjW5b1PscbkQgCNJFQ=;
        b=AWfS8FsYQFlrsvVL+Q2F1NLtqJRFNGoDE+H8tAx7QzgYmHUojUhmniVyBC2iJLv0uq
         Q3MkwHwVm2FnXbOdZBcbaqF2IFnDwKqhBLSVvMZku4PSBQaZ1lk0s99BGe0hJIhtji7f
         bUBpFQtQBZNdykH399SiSbZcjt3BwoFR+IS609juhFhHD2MzPS7n8BwMaRNtRyDnuur9
         HOKQ+VE/PVEKtjz4t2F9ZiUoGJHPHP3FZiB9e/qo+bNQQTVNjQKkGc7aXRpCAxESpvnO
         REWnZsZHzCluC7+rNWoMzXrL67i9e80zLTPwu+CelWI6PYFTx4Lz+F1GfNh+6yVUI7Ns
         Dorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/1v+jY51ntKBYVsN5t0pjTMNTLjW5b1PscbkQgCNJFQ=;
        b=TXFlltKIx5KLnGyuQgScp26df7SWrncfxFW+260nSm3keahVRftx4ACNbEg6s3VZqx
         ZnuvruFo8QqcUnGXDmgoq2jWHOrV4GdnN7I+bXhHtR4bZRAXhtCO7CEyHENPZVvOvSPX
         m1YcxqqSCuw1AYej1bIljGDXepZzYh5hd1DUaGD+KC6CHcoXKpjMPBnUt661P8843srO
         BFPhbovzBoy1/J1BHHEBZFe7sqJc5MuZkTfLw+HuiQooEKWtVyZe2nL1wMEQknbZJdr2
         ipakmqS+JCSncDuo+PzTWQz7XmSVV0W/CMQK6+eQH0nW4McflMd3byZCEAUm0ErF296n
         GJNA==
X-Gm-Message-State: APt69E3UoAb1PcdzJef7LZNagCGlOpnbtJdkMxa54baUe/HNk+UlQeWD
        We4dZgoZfuwhy2sccskoszF7abpQ
X-Google-Smtp-Source: AAOMgpdI/vnIpy2aoH0+oXcAFvRrj0u3t01R2Sp41xp/8NhrmwhLT9PzkxjOFM4vnEFe4ZJPV1jYJw==
X-Received: by 2002:a1c:2dc8:: with SMTP id t191-v6mr12349574wmt.94.1530650249082;
        Tue, 03 Jul 2018 13:37:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i12-v6sm2073798wrn.48.2018.07.03.13.37.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 13:37:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v2 6/7] rebase -i: rewrite setup_reflog_action() in C
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180702105717.26386-7-alban.gruin@gmail.com>
Date:   Tue, 03 Jul 2018 13:37:28 -0700
In-Reply-To: <20180702105717.26386-7-alban.gruin@gmail.com> (Alban Gruin's
        message of "Mon, 2 Jul 2018 12:57:16 +0200")
Message-ID: <xmqq8t6soy2f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> +static int run_git_checkout(struct replay_opts *opts, const char *commit,
> +				int verbose, const char *action)
> +{
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +
> +	cmd.git_cmd = 1;
> +
> +	argv_array_push(&cmd.args, "checkout");
> +	argv_array_push(&cmd.args, commit);
> +	argv_array_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
> +
> +	if (verbose)
> +		return run_command(&cmd);
> +	return run_command_silent_on_success(&cmd);

I thought we made this into

	if verbose
		return run_command
	else
		return run_command_silently

to help readers in the previous round already.

Are we reviewing the correct version?
