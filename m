Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C46A20281
	for <e@80x24.org>; Wed, 27 Sep 2017 05:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbdI0FUp (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 01:20:45 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33543 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbdI0FUo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 01:20:44 -0400
Received: by mail-pf0-f193.google.com with SMTP id h4so5949891pfk.0
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 22:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/oGDtezVb3JuLu0fWWEloK1RAxspak/ozmN1XPzojm4=;
        b=mj3WyENSzjsBaFyy0tfZ9LlAESV9JJn5uq9fdlTI4G7IB2JCZqJmmmLaqcG82SuRB7
         RibfxluHR+CQ481XsXS6bC8zIp9IoI6wQ6oJ6gBUgYHhohdmlZbuZcUSRts7+/mdPkUI
         /oOTuN2jnF+h6KjAPKhP8yvpOy1E+MieQCqOCMZPtB60oLJHktyzqK3TI3aQaUjgRQym
         m0LP3BtzJChTda712/MoYtEdqAO5p7lslgl4O4se/wQvn43i4nPCXSKmVX1LbMY8Fy/3
         3vFEP0A6MffHoCi/Aiet3pdah5oAOviQB3y1hfwkUMHHBZibr2mQh7lYpd8xAM2hvI2t
         Y7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/oGDtezVb3JuLu0fWWEloK1RAxspak/ozmN1XPzojm4=;
        b=JviePHQHsR3ZCpO8oV/1kagi9LdvzL6I3Z3ZDsD0UipSLp9g+cvhpudpSFzW4o0PuK
         GO88HJVGxMhXE/UYbSwTWu84gyMhOvwiZ1JDkujC/GpFoT+7vGpfDvjjX6rr1pKMxVlW
         Ob9HQpVuo7/rxyU/wz9eROBFB2KHqrxmPgX0Ho2yCuznbXpfMwRu+LIBgL3ZTeOAW26Y
         rBOcOcrdr8bKbYzLQkTCFqyzZQqmbv4RC9i9BKNnwhN4NHoPfFpxidtsHfNnxFxA6WIw
         9RLn8YDgE0gbDc4OGbjAgfPbYZxpCsNeZ2X+gvQEqgQC8xzvf1Yq7ha4eC5GaVHLpyIW
         VMaw==
X-Gm-Message-State: AHPjjUjO7ZU/YZOj0fzIHN03fBI/vLpD2YU3xkiqwhjF04Vi8eVz+Ycp
        hh6cji8WnPvBh3Orm+29L6s=
X-Google-Smtp-Source: AOwi7QCpg4Nn1NC9MPYef2a65zBYtjRx7anEy5WtL27yhRDs1AlEIYI1M+qNigKyM9O6GhOs7wmwKw==
X-Received: by 10.98.73.2 with SMTP id w2mr230987pfa.133.1506489643560;
        Tue, 26 Sep 2017 22:20:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a541:226f:6d4c:7f7a])
        by smtp.gmail.com with ESMTPSA id y1sm1694011pgp.15.2017.09.26.22.20.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 22:20:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v2 4/9] daemon: recognize hidden request arguments
References: <20170913215448.84674-1-bmwill@google.com>
        <20170926235627.79606-1-bmwill@google.com>
        <20170926235627.79606-5-bmwill@google.com>
Date:   Wed, 27 Sep 2017 14:20:42 +0900
In-Reply-To: <20170926235627.79606-5-bmwill@google.com> (Brandon Williams's
        message of "Tue, 26 Sep 2017 16:56:22 -0700")
Message-ID: <xmqqzi9g67kl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> A normal request to git-daemon is structured as
> "command path/to/repo\0host=..\0" and due to a bug in an old version of
> git-daemon 73bb33a94 (daemon: Strictly parse the "extra arg" part of the
> command, 2009-06-04) we aren't able to place any extra args (separated
> by NULs) besides the host.

It's a bit unclear if that commit _introduced_ a bug, or just
noticed an old bug and documented it in its log message.  How does
that commit impact the versons of Git that the updated code is
capable of interracting with?

> +static void parse_extra_args(struct hostinfo *hi, struct argv_array *env,
> +			     char *extra_args, int buflen)
> +{
> +	const char *end = extra_args + buflen;
> +	struct strbuf git_protocol = STRBUF_INIT;
> +
> +	/* First look for the host argument */
> +	extra_args = parse_host_arg(hi, extra_args, buflen);
> +
> +	/* Look for additional arguments places after a second NUL byte */
> +	for (; extra_args < end; extra_args += strlen(extra_args) + 1) {
> +		const char *arg = extra_args;
> +
> +		/*
> +		 * Parse the extra arguments, adding most to 'git_protocol'
> +		 * which will be used to set the 'GIT_PROTOCOL' envvar in the
> +		 * service that will be run.
> +		 *
> +		 * If there ends up being a particular arg in the future that
> +		 * git-daemon needs to parse specificly (like the 'host' arg)
> +		 * then it can be parsed here and not added to 'git_protocol'.
> +		 */
> +		if (*arg) {
> +			if (git_protocol.len > 0)
> +				strbuf_addch(&git_protocol, ':');
> +			strbuf_addstr(&git_protocol, arg);
> +		}
> +	}
> +
> +	if (git_protocol.len > 0)
> +		argv_array_pushf(env, GIT_PROTOCOL_ENVIRONMENT "=%s",
> +				 git_protocol.buf);
> +	strbuf_release(&git_protocol);
>  }
