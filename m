Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65F401F404
	for <e@80x24.org>; Thu,  1 Mar 2018 18:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161058AbeCASuT (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 13:50:19 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34104 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161054AbeCASuL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 13:50:11 -0500
Received: by mail-wm0-f66.google.com with SMTP id a20so32360601wmd.1
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 10:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YqKVecmvyELNK0eExF8s8lLPm9yP+FOfZSEWo4mKG9A=;
        b=IEW7fwb8hvWx6pMb51iekhDLgLtBYUQ4HeKgG+BzoeTg6TOZhMUjICZIya+pDm8DHB
         yPX8HAEwpG92T2KLFq9q0OAEIvRi2DWa9rJO2dpYkWdsb5teJ4Tgv88js4Q6XpaIheAs
         y4C9QQKuqduzt50EUoyIhAbdsqsAKSGhALq/WrrsUz8o7Io4603VgGrEiD6H/ciZaGUp
         HiwaIPjSVx07iWbVNkkPjTzavlNw/Mi0WTo2/BwbE8UcqGmvsNr+iPeskxnrsU2MJJ2u
         6CTW6YLxwXxh5xp+hyThnL3zrqJHoM3XPea3SE2khFcP03bPWqBZfYJZRTCaO6QUGxKJ
         BJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YqKVecmvyELNK0eExF8s8lLPm9yP+FOfZSEWo4mKG9A=;
        b=NWgTMPh0gotdyryeM+plHSQY1ZTeZ6Tcfis2r+ltkaDPd+bi/c59GFbAI3UhCpQajN
         Wvu+wWZ+M1B9il7J9dZH+QhtJGcO+vpKF/mmLOmQdKFh0xBVRgUy0PJku7aMnprLLYlV
         6ewMdC+9o2rTk3KrzohUlTBU9G+YNj5vvxJotg6EeACTsnmhyePXVL7lyUKlCUrdUo6s
         Pnmo6HZEsvCeY60+VzcKEiqOVxpFtp3Y2mENIRmfKNugqpMd3y5kDPKyb4D4lUA6Sww6
         pKklAk84VxPlts8ZQezMKvRJBcBinYt0rosc8Jnup7TTjo2YUKmMSyTsKeq18nnTWv6r
         Lw8g==
X-Gm-Message-State: AElRT7EyjD35+oPRbDgC1fckPRybEck30yMfaYAokC4YKlmewm/pm5rE
        f9PANwsurOWIDV+FBTM0yqc=
X-Google-Smtp-Source: AG47ELvf6EP//h67H3AHUp4wq6lJYWfUR16a/QCaF8c7IuGd9IVLfTrKxCx9hlU55grTlua3YDd/KQ==
X-Received: by 10.28.131.66 with SMTP id f63mr2492668wmd.12.1519930209978;
        Thu, 01 Mar 2018 10:50:09 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w195sm155360wmw.9.2018.03.01.10.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 10:50:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Sergey Organov <sorganov@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: The case for two trees in a commit ("How to make rebase less modal")
References: <CAGZ79ka6PXgs+JDicaQYWYSKgEthj0A-2bBaRcdp_0T2H+sREA@mail.gmail.com>
        <CA+P7+xpB36t7WHpYOa+8wc7kLY7ES_bVEnSHPYHJ50gJ03uQBw@mail.gmail.com>
Date:   Thu, 01 Mar 2018 10:50:09 -0800
In-Reply-To: <CA+P7+xpB36t7WHpYOa+8wc7kLY7ES_bVEnSHPYHJ50gJ03uQBw@mail.gmail.com>
        (Jacob Keller's message of "Wed, 28 Feb 2018 23:25:07 -0800")
Message-ID: <xmqqd10nhbq6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> How does this let you defer a conflict? A future commit which modified
> blobs in that tree wouldn't know what version of the trees/blobs to
> actually use? Clearly future commits could record their own trees, but
> how would they generate the "correct" tree?
>
> Maybe I am missing something here?

If you write four trees out of each stage in the index and record
them, you could in theory have a new command that reads them and
recreate the conflicted index.  Oh, and then you would need the
fifth tree that records what the working-tree files (with conflict
markers) looked like, in order to reproduce the state seen by the
person who ran "git merge", attempted to resolve and gave up halfway
in the middle.

As a local operation, extending "git stash" somehow so that it can
stash even in a conflicted working tree may be a better approach,
and it does not need cruft headers in commit objects, I would think.
