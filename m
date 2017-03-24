Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BCE31FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 22:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbdCXWiy (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 18:38:54 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36212 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752484AbdCXWix (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 18:38:53 -0400
Received: by mail-pg0-f68.google.com with SMTP id 81so589897pgh.3
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 15:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OQRbaMDz3JV61xCVB0oaHv7TwU81tZ8qMS8+BdTmTkY=;
        b=TNVKW3ic6CROs4FZEH2XK+1BfNwQUrUbxpgc31kn00QEx8OmO2UfQ7EPvwC+/uEHD5
         SuD5jQNVQtNIu3w/U+sef1ZBU/P6//a9QGE8Nl6F1gZZOMdL2HPS7oFxrdZfY9nzlYG7
         MQbr/c6tCXgJ60FkB1xHmXZGLYvzRAv78T53s/K85QqZRXpQlmbYWTp4Hrd2YqqwPauD
         PNYzPaAA9nl2Em4RqTzBb78GoS/szK9O6llswQ5tRp/Rc6KQeoTB8CmlHqLf2fO3EAyA
         A5WI25lgvKoS8ihJfvfcvC+2ly5jFnuVZyx4TKFueNDh2EzmNCZ0hamZXegYtC4mYVKc
         1V8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OQRbaMDz3JV61xCVB0oaHv7TwU81tZ8qMS8+BdTmTkY=;
        b=YgXVatui8TZKGLRpHAUeu6Wo1DRG7Ni8gZIQn9EvQs70WG1KSVBIp66o/paHywLHx3
         Sn6M1Dmqg6yTKA5WcBLxJFsvz/mZnvP6s/tyJaUWCf2jt8Hl+JqUzXC38ziWHP4CzLaV
         ocu0yKn6eAKHDQ+wqjY+co84z/dYmmw6U0zvRGDEpzk8QNzek8NUSmD1wHmJHgvvy+LB
         2aCeL8sqrnDoABD482CfbzV8mBdMAGW3nWuzKY/N6ZXDEB9LxjYcGOMm2xymDiuZH+qM
         Ypg7KT2Lk9bYHU+VfqmBTh6d7UqIKUTdU8CBv3rUiBWtfv4T/pUww1Up9mtpoIeKrnhT
         2YNA==
X-Gm-Message-State: AFeK/H0iBavk5Qqz22jWuV4Ulu5oIRgpveDIMeEtUqzR6qModOC3t+aEbXep/YOgVUsgGA==
X-Received: by 10.99.114.89 with SMTP id c25mr11843102pgn.163.1490395131780;
        Fri, 24 Mar 2017 15:38:51 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:8597:ae41:db75:6a97])
        by smtp.gmail.com with ESMTPSA id e63sm6559160pfg.40.2017.03.24.15.38.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 15:38:50 -0700 (PDT)
Date:   Fri, 24 Mar 2017 15:38:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 3/7] submodule.c: convert is_submodule_modified to use
 strbuf_getwholeline
Message-ID: <20170324223848.GH31294@aiede.mtv.corp.google.com>
References: <20170323223338.32274-7-sbeller@google.com>
 <20170324182902.19280-1-sbeller@google.com>
 <20170324182902.19280-4-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170324182902.19280-4-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> Instead of implementing line reading yet again, make use of our beautiful
> library function to read one line.  By using strbuf_getwholeline instead
> of strbuf_read, we avoid having to allocate memory for the entire child
> process output at once.  That is, we limit maximum memory usage.

It also overlaps work a little better.

> Once we know all information that we care about, we can terminate
> the child early. In that case we do not care about its exit code as well.

Should this say something about SIGPIPE?

[...]
> +++ b/submodule.c
[...]
> @@ -1072,28 +1072,27 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
[...]
> +			/*
> +			 * We're not interested in any further information from
> +			 * the child any more, no output nor its exit code.
> +			 */

language nit: s/, no output/: neither output/

[...]
> -	if (finish_command(&cp))
> +	if (finish_command(&cp) && !ignore_cp_exit_code)

finish_command complains if the child dies of SIGTERM:

		error: status died of signal 15

wait_or_whine(cp->pid, cp->argv[0], 1) doesn't do that but is meant for
signal handling.  Maybe we should rely on SIGPIPE instead (which
wait_or_whine always silences) and avoid the kill() call.

Can there be a test for this case (i.e. having lots of untracked files
in the submodule so the child process fills its pipe buffer and has to
exit early)?

Thanks,
Jonathan
