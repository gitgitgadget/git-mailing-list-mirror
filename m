Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D49291F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 05:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbdFJF7D (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 01:59:03 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36308 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbdFJF7C (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 01:59:02 -0400
Received: by mail-pf0-f196.google.com with SMTP id y7so10644917pfd.3
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 22:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=lNPgxK0Qo651gGk4CkjY9c8LzGtBBasAEVmpxhXFibY=;
        b=u1lg9GzGC+RNvjZQpod4C8CGt6NsvCdHNrhujWmQBrR/ceuNCb6ygreteIGarOnE15
         hezY7RSO4DhIEdycLBFON0KiQ7q55p0D6PwFb6m09oA8mkvBPFpFSXALIqTcHKXvPctZ
         59xuYQrwLdnqqgoZb69/FoFSWik+x8ls0pPxVWK9kMZrvNyUmp+Km/eXixF9ZNPMBvez
         45igxUTOyzdp3UfxMzczN12VV+xt6YYrb7pZ7In6vBIx4dH83eRknBXSkWO5BjiVguTe
         JHUfchkHQo5WSuQk6h/fllO5PofsnA1Xenr+6t7hkTmj2IZKFjR2+Apg34lgGs2eGbGw
         +U6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=lNPgxK0Qo651gGk4CkjY9c8LzGtBBasAEVmpxhXFibY=;
        b=lfOY6moTSTZ8/BFyDdIENllULtpKJcybYI5Fqcvhp77zFd5IHBf02sXf61HcFBD1ii
         VCB3Wq4i+fjJGoq5hRWR4VJBdv7aR7/gtjMRr0x5zjWMtXWGwTBvq7l2/cPQwWmKOZqS
         Mi/vz1WHu8UIVHQCdPbZpRDeESm/BCStLkRC9AL5mAQoEMNQhwP3GRceLv4UjE+RhE0V
         yXBlQ97EpzYodOJEKghU1A/SUKgObS3TQq7oahmbPQRfNqgYLmnDJqMlbl6Jm0/5Rkte
         buLwh/4JozkLIwXjQgzEhXo9WyguwAiE1m6mkLsYpuhJOyv55i1HRjobv2a0XGg83q+r
         1RaA==
X-Gm-Message-State: AODbwcBfkO4ZRAHzGdumm3ilo9GVmXc2Y+8E6sSKwwcoFthk39/L8X4Q
        XfAVpAqIKD1crA==
X-Received: by 10.98.62.193 with SMTP id y62mr42959489pfj.49.1497074341941;
        Fri, 09 Jun 2017 22:59:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d192:93c8:4f75:5879])
        by smtp.gmail.com with ESMTPSA id b65sm6680067pfm.29.2017.06.09.22.59.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 22:59:00 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        jacob.keller@gmail.com, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, peartben@gmail.com,
        pclouds@gmail.com, peff@peff.net, git@jeffhostetler.com,
        avarab@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 32/32] ls-files: use repository object
References: <20170531214417.38857-1-bmwill@google.com>
        <20170608234100.188529-1-bmwill@google.com>
        <20170608234100.188529-33-bmwill@google.com>
        <20170609000849.GA130522@google.com>
Date:   Sat, 10 Jun 2017 14:59:00 +0900
Message-ID: <xmqq8tl02xjv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> -	if (read_cache() < 0)
>> +	if (repo_read_index(the_repository))
>
> oops, looks like this should have been:

Queued, with this fix-up already applied.

It had a bit of conflicts with topics in flight that may added some
more globals, so please make sure that the conflict resolution is
sane (i.e. do not look only at bw/repo-object and be happy; rather,
please check "pu^{/^Merge branch 'bw/repo-object' into pu}".

Thanks.
