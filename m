Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 069561F404
	for <e@80x24.org>; Thu, 29 Mar 2018 18:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753650AbeC2SWS (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 14:22:18 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:39195 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752969AbeC2SF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 14:05:56 -0400
Received: by mail-wm0-f46.google.com with SMTP id f125so13096343wme.4
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 11:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VnTccLsW1YN1lu1DdZekxXqkoHGpzRz6jUg1SqfpJyM=;
        b=nh6ivehP7d8XBh+Pac3Rnrv96hW8IUu17X6ZPv3IMpYaE7GwMA//HDiTm3uRMKRNPz
         uWlGMCxPZzY2vBHYKedg9Kr5yenuLzrtKWEUd6mzm3g6htF4Wmha5D3AAWA37nesJ/de
         uF14d+xn/YbfVHIeBY79zgm6GPy+eq6Z/ZTGyHtTKbXSCJE73fvY3keDD8xBtPLurKhv
         RPufQYEPPWTcfomrSKbaN4EVpHoRaxZU77vXJFWIFXxFBXLnt4+YT/Vhi/c3FDlClDyh
         bRQECAOfjZ7roH5vH+dsm/H7EfRD1v+5mWRetnKT9ZmM73XMZM0AK1k7Is6uYn6UG6MP
         FvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VnTccLsW1YN1lu1DdZekxXqkoHGpzRz6jUg1SqfpJyM=;
        b=Ur0QWFbU8j+cLrbKBNvATm1OCbOxXaYpK7NoBFaQSkulu//wjZ9SXcvnMkV/hNPJGP
         jzQPcvvZhvyNP+/VLcl2xizwAzCNIVZ5UY+zRDv5ODcrF0fdDxqK4S6+lJRqpzG7w8ND
         RkilLPXaqX+BAYPzPZkHn2XUqAqfeJnq2+CCrG20nVZIxLs1PLKiIuYLbgyoAu5zBf3p
         Zzpg45DyW288mgwFY51A6E6z29YQi2wZK0TGkW0wYMFEC5rebQzRJ7BeTxvDYuYu9Pqe
         igQM72b2aj805GW1/RN9Ix5x0zY6XyndB/FU9Ew7SPseHONtHiywggeaCOZKDUgY6xGT
         Vjmw==
X-Gm-Message-State: AElRT7FDsZzchUUpVeEYLMTHXAtdjDZHqmh7VB6pcysmZo1ECdfnVGHC
        EUF9+RpDGvP6K8ki8AMaueM=
X-Google-Smtp-Source: AIpwx4/ffe88fYWPjWHA2ADgfd3GXp6Zi6/v2sGMNhoyBqP057Lyd2CvFJBY0pXixCzba0vftv0CGg==
X-Received: by 10.28.213.204 with SMTP id m195mr15986wmg.6.1522346755234;
        Thu, 29 Mar 2018 11:05:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n21sm3204416wmi.37.2018.03.29.11.05.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Mar 2018 11:05:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] rebase -i --keep-empty: don't prune empty commits
References: <20180320100315.15261-1-phillip.wood@talktalk.net>
        <20180320100315.15261-3-phillip.wood@talktalk.net>
        <nycvar.QRO.7.76.6.1803201630380.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <xmqqfu4uslar.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1803212336420.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Thu, 29 Mar 2018 11:05:53 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1803212336420.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Wed, 21 Mar 2018 23:38:21 +0100
        (STD)")
Message-ID: <xmqq605e7o5a.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> But I wonder if this is even easier to follow.  It makes it even
>> more clear that patchsame commits that are not empty are discarded
>> unconditionally.
>> 
>> 	while ((commit = get_revision(&revs))) {
>> 		int is_empty  = is_original_commit_empty(commit);
>> 		if (!is_empty && (commit->object.flags & PATCHSAME))
>> 			continue;
>> 		strbuf_reset(&buf);
>> 		if (!keep_empty && is_empty)
>> 			strbuf_addf(&buf, "%c ", comment_line_char);
>> 		strbuf_addf(&buf, "%s %s ", insn,
>> 			    oid_to_hex(&commit->object.oid));
>> 		pretty_print_commit(&pp, commit, &buf);
>> 		strbuf_addch(&buf, '\n');
>> 		fputs(buf.buf, out);
>> 	}
>> 
>> Or did I screw up the rewrite?
>
> This looks correct. And the postimage is easier to follow than the one of
> my suggested change.

OK, let's squash this in and rebuild both pw/rebase-keep-empty-fixes
and also pw/rebase-signoff that builds on this topic, so that they
can be advanced to 'next'.

