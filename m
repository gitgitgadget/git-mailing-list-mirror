Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFCF11F428
	for <e@80x24.org>; Sat, 16 Dec 2017 02:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756074AbdLPCCh (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 21:02:37 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:38175 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755976AbdLPCCg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 21:02:36 -0500
Received: by mail-pf0-f174.google.com with SMTP id u25so7391234pfg.5
        for <git@vger.kernel.org>; Fri, 15 Dec 2017 18:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=aXA6QHaI0pmTl9WrCgRBjinOWp3YFqYvzEZLY9pTTr0=;
        b=le105f/9ugsWNiHUZbHqfoL0jPDChdMwJ8cchqEVWdIRyEYhx1xwUJFWXPavvrwzYu
         nd2T07Vm83AoF5H1KqAf74SHIGN7BneeoZpnuPZE/fyxfzwFb+hSTkyWw7+gERDBCZ/e
         9j6gImtFtM0saE/n0mfDODHZf2gmacNCm6rBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=aXA6QHaI0pmTl9WrCgRBjinOWp3YFqYvzEZLY9pTTr0=;
        b=cAhtszkUgPZg5gyohBPbiN1J8JjNK6g/jpep6w1c3qnLNeswCvpMV6Exd2i4qg66sU
         nelSmM7Qpkzp/sjY3O+j4DeuKx/Kpdr3QQhU+OHkWl/bFx9M2gyp9NYa+CJ1nAGjsVzX
         /l7GTSPxMY8ImBQ9AK1/qQn4xClTMTXJMTxp2qxfoVwHfZvkv6Z2lUy8L+awX6vZbNV0
         VBSvIEQimAYo9YnujpJpGupfv7zhpcg+jD4NkwJgFM+lHN102oBTdYfSA7miDC3fOaDr
         5ylfWDzF1CB0KxzoTP7xA/Lamcs4dzZryTKfb5gsLKf8KrJd9S5iIUK8IDHWcxbIpBFZ
         RcWQ==
X-Gm-Message-State: AKGB3mJseYegz4aLY2YqfzpEnR4DDrZleN7jhRukEy8BugoMb5rXlXP+
        L68uZjwQcQKv2Fd9xdIGh6GTzg==
X-Google-Smtp-Source: ACJfBovytmRw0HdUWEEIEtxkT48JN+dMwy7zL8nh87oRXWhRQNErmshwm7oZ2ukwOVZdaq11aHnzjg==
X-Received: by 10.98.152.25 with SMTP id q25mr15377031pfd.58.1513389756116;
        Fri, 15 Dec 2017 18:02:36 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (v160-vrrp2.corp.dropbox.com. [205.189.0.162])
        by smtp.gmail.com with ESMTPSA id y3sm14817351pff.122.2017.12.15.18.02.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Dec 2017 18:02:35 -0800 (PST)
Date:   Fri, 15 Dec 2017 18:02:21 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
X-X-Sender: alexmv@alexmv-linux
To:     Ben Peart <peartben@gmail.com>
cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] fsmonitor: Store fsmonitor bitmap before splitting
 index
In-Reply-To: <9b6679ea-b7e4-b45a-32bb-448cd2e891df@gmail.com>
Message-ID: <alpine.DEB.2.10.1712151800010.7105@alexmv-linux>
References: <20171109195810.30446-1-alexmv@dropbox.com> <4ff73be656d5bbf9e2cada6bdec61843da9d1516.1510257457.git.alexmv@dropbox.com> <9b6679ea-b7e4-b45a-32bb-448cd2e891df@gmail.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 13 Nov 2017, Ben Peart wrote:
> Why do you redirect stdout to stderr and then and perform an "echo"
> afterwards?  I don't understand what benefit that provides.  I removed this
> logic and the test still passes so am confused as to what its purpose is.

Ah -- the "echo" was purely to clean up STDERR as I was running the
test interactively.  It serves no purpose, which is why it was hard
to understand its benefit. :)

Apologies for missing this (and in not replying here earlier!).  I'll
send a commit that drops these.
 - Alex

> > +# test that splitting the index dosn't interfere
> > +test_expect_success 'splitting the index results in the same state' '
> > +	write_integration_script &&
> > +	dirty_repo &&
> > +	git update-index --fsmonitor  &&
> > +	git ls-files -f >expect &&
> > +	test-dump-fsmonitor >&2 && echo &&
> > +	git update-index --fsmonitor --split-index &&
> > +	test-dump-fsmonitor >&2 && echo &&
> > +	git ls-files -f >actual &&
> > +	test_cmp expect actual
> > +'
> > +
> >   test_done
