Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 540A81F404
	for <e@80x24.org>; Thu, 16 Aug 2018 21:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbeHQAny (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 20:43:54 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51993 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeHQAny (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 20:43:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so5777590wma.1
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 14:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DztNPblQCseg8UGRLrTC/K20kgtYiEIPJWugOoEdBTA=;
        b=uPKVwkZMu5AW9psA/0mDoKNejjws+F9tB9mjF6etIP9c5ZvBorD406WjNH0MmE9Ec1
         zDIZPFONBH2nG0zfdY4W/8XFSiMTP7+/MUSmxQagsECB9ZNS8MkmchLdItogtP6olvbO
         85MiW4PjMPiVjkwesY4C46mAvCoXio342nflfqEjUsJcbTV0XCF9GwDb8E6wLQnA+3Ug
         7EaVRQ7/2u/PMFsG9/vLAnO8fVcWM+o4Q65IE27sJCtjOimz6R1sBRwQP8hkckV9/nGW
         j8eFZmh7qksIXEpgsEom1uDJiLW6f2XEij/SNxKQeAKl/X/TNRKrjh2DTOxx4WsMMfbP
         2yMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DztNPblQCseg8UGRLrTC/K20kgtYiEIPJWugOoEdBTA=;
        b=BHVEexjN9t6lfqa6FRSiP0BHjcvjTXRLyNUp/yD7IbNfqTz+duLxG5m54JXoKmggoy
         Owiff/22VrELvxmwPMB4P3u97P33QKf5ahMnreP/nS/wKakcYZeDTd6H5bKvO9dUdRqy
         rYWs9HSMlxg6iaAsUbjeUv+df0TEAHAYyJi6wU3j7HuWvkdsv2CBd2DkG2g4/SI8rHdR
         QPq/bOjuw0qjYNXKrfvsD7/kxB/Q0J3c6tNnlNMd2zCyVyKEQ441T2A+hgoi3aogQYzg
         oyPxd8a1HPV8ZHdEV5JnDHOWK5AqitNc+WUrZ/Afj/T3BX4y8N4GA7xF00gpka+PYnpk
         H/7w==
X-Gm-Message-State: AOUpUlErn0acOzHNhXbkK7KPIDujsNfXvgqE9SRb4kA1Zp6eJHutzrIH
        fGmbiOxNEW7qv+1DvZouBxs=
X-Google-Smtp-Source: AA+uWPxTQBLpc6Ph8DKv1jgBmAy53TLIox414tJqSylIv22AMDAqgH9JwDWdXv57Bty+WJsmyNGPvw==
X-Received: by 2002:a1c:a813:: with SMTP id r19-v6mr16452464wme.100.1534455785511;
        Thu, 16 Aug 2018 14:43:05 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 199-v6sm4710459wmp.37.2018.08.16.14.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 14:43:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratik Karki <predatoramigo@gmail.com>, alban.gruin@gmail.com
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, sbeller@google.com
Subject: Re: [GSoC] [PATCH v6 3/3] builtin/rebase: support running "git rebase <upstream>"
References: <20180730162920.20318-1-predatoramigo@gmail.com>
        <20180806193111.12229-1-predatoramigo@gmail.com>
        <20180806193111.12229-4-predatoramigo@gmail.com>
Date:   Thu, 16 Aug 2018 14:43:04 -0700
In-Reply-To: <20180806193111.12229-4-predatoramigo@gmail.com> (Pratik Karki's
        message of "Tue, 7 Aug 2018 01:16:11 +0545")
Message-ID: <xmqq7ekqdm3b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now, there is a parallel "rebase-i-in-c" effort going on, and of
course, setting various shell various and formulating a command line
that essentially does 

	. git-rebase--$backend

of course stops working.

> +static int run_specific_rebase(struct rebase_options *opts)
> +{
> +	const char *argv[] = { NULL, NULL };
> + ...
> +	switch (opts->type) {
> +	case REBASE_AM:
> +		backend = "git-rebase--am";
> +		backend_func = "git_rebase__am";
> +		break;
> +	case REBASE_INTERACTIVE:
> +		backend = "git-rebase--interactive";
> +		backend_func = "git_rebase__interactive";
> +		break;
> + ...
> +	strbuf_addf(&script_snippet,
> +		    ". git-sh-setup && . git-rebase--common &&"
> +		    " . %s && %s", backend, backend_func);
> +	argv[0] = script_snippet.buf;
> +
> +	status = run_command_v_opt(argv, RUN_USING_SHELL);

