Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5C941F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 21:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932584AbeGFVJd (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 17:09:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55436 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754227AbeGFVJc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 17:09:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id v16-v6so16000641wmv.5
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 14:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oRvhUqsudbxnSZh1pQ46sqhz8qAKr3798GnEXNIcUck=;
        b=KSnRTT6qBe5Iyc7aH9vJ8pLmrpSmn/HuZnxvXv6v2BbVEf6RZ+GsUsPScue0hLQpSr
         8AjcPQLrTs8WKJ+6nKM6HUqvqV79SbVOdkmV2jWGBRGW07j6Tr3FlVZq8vez/25hgKxH
         B0I+V253SY6yN1jsS5eAqEZl3dQolml2aBXxzde1k61H3nRjvPFI/k50/fELT65f1XM3
         HQvcxF+oiEu3Uqcy5LW26dQ0Yb7IluQcQj9KURMJCwA3+MamS3VB0d3pnmV3097qkODL
         K+9bUIC3EGwPcqkOolc739zxQ2wWo6fp6yIBQNLDf55FdJ/jN//2oFSJ5Zc2skTlyhE8
         0Hzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oRvhUqsudbxnSZh1pQ46sqhz8qAKr3798GnEXNIcUck=;
        b=qC5ciDKspcfUbVWvkTGut7n5gqGxagvJOyRQm97XWAaQ5cmgh8WUYn3SRSM62C1kaI
         IboqlO1quR5HuY+f2LwG5DZ1nBPiDxjqQnduvlgkBTPQk383Kc1f4ZEg7cUECimPzPBp
         KT2lb+Gz2E68fEtjgnbmY0WMDGlWIRWUCJ2Df4JHDFMkNrNz37g85Ew8uLJdf5aGbL9z
         stQEQihOT5ulSg6rXKpR1duWt8eWSICq8N8gptFYUaQPY6ImNVoiwVLj3KUew2O/DvzV
         v5xGwrwv1ipJz9teCpcnipKxTPc4QtA4lEsgwpjps6iD8JbBd8xM/3VjrzGjLN1HoHdB
         FSdw==
X-Gm-Message-State: APt69E2W95AysDaR3tSMd+JMwoda07nNlBXxiZECmOMBOzoFT/XadU0F
        fodYvDpfIkxadxYwb9qzPNs=
X-Google-Smtp-Source: AAOMgpf8be8g8uYRgJeBXgaPo9CopOR2q15Usco1HScL/XFtykr3Nta0FvOwgO+U/+VHfq1UhUz/ug==
X-Received: by 2002:a1c:570a:: with SMTP id l10-v6mr7786029wmb.56.1530911370609;
        Fri, 06 Jul 2018 14:09:30 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u7-v6sm18315592wmd.3.2018.07.06.14.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 14:09:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        alban.gruin@gmail.com
Subject: Re: [PATCH v3 1/4] rebase: start implementing it as a builtin
References: <20180628074655.5756-1-predatoramigo@gmail.com>
        <20180706120815.17851-1-predatoramigo@gmail.com>
        <20180706120815.17851-2-predatoramigo@gmail.com>
Date:   Fri, 06 Jul 2018 14:09:29 -0700
In-Reply-To: <20180706120815.17851-2-predatoramigo@gmail.com> (Pratik Karki's
        message of "Fri, 6 Jul 2018 17:53:12 +0545")
Message-ID: <xmqq36wwjcl2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratik Karki <predatoramigo@gmail.com> writes:

> +static int use_builtin_rebase(void)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	struct strbuf out = STRBUF_INIT;
> +	int ret;
> +
> +	argv_array_pushl(&cp.args,
> +			 "config", "--bool", "rebase.usebuiltin", NULL);
> +	cp.git_cmd = 1;
> +	if (capture_command(&cp, &out, 6))
> +		return 0;
> +
> +	strbuf_trim(&out);
> +	ret = !strcmp("true", out.buf);
> +	strbuf_release(&out);
> +	return ret;
> +}
> +
> +int cmd_rebase(int argc, const char **argv, const char *prefix)
> +{
> +	/*
> +	 * NEEDSWORK: Once the builtin rebase has been tested enough
> +	 * and git-legacy-rebase.sh is retired to contrib/, this preamble
> +	 * can be removed.
> +	 */
> +
> +	if (!use_builtin_rebase()) {
> +		const char *path = mkpath("%s/git-legacy-rebase",
> +					  git_exec_path());
> +
> +		if (sane_execvp(path, (char **)argv) < 0)
> +			die_errno("could not exec %s", path);
> +		else
> +			die("sane_execvp() returned???");

This part got changed from returning 0 since the previous round,
which makes sense, but if we are making this change relative to the
original in be8a90e, just because we mention explicitly that we
imitate that old commit, we must mention how and why we "improved"
on it, in the log message.

	In the old original used while converting difftool, if
	sane_execvp() that attempts to run the legacy scripted
	version returned with non-negative status, the command
	silently exited without doing anything with success, but
	sane_execvp() should not retun with non-negative status in
	the first place, so make sure we die() to notice such an
	abnormal case.

or something like that, perhaps (but you should be able to shorten
it further).

Between die() and BUG(), I am not sure which is more appropriate.
It certainly is not _our_ bug if platform execvp() returns success,
so BUG() would not help our developers all that much.  But end-users
won't be helped by being told that sane_execvp() returned, so die()
is not all that useful, either.  I guess it does not matter that
much bewteen the two, as this is something that is not supposed to
happen anyway ;-)

In any case, this one looks good.  Will queue.

Thanks.
