Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 664E3211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 23:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfAKXUb (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 18:20:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36315 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfAKXUb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 18:20:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id u4so16908347wrp.3
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 15:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=YaFxsCt+F5ViqkhP0tfGIwvaehePcQ73LQew2TudL9Y=;
        b=RRimrxWT6MRC04ZubhXnJ2Dny6zMLncyV/VqfY3irUajLT4imYpDbtHzeC8C+0pfmW
         CMcU16mzgVS96tTeSwpKKUxcYFWZt9vca9S8PMZ5sIUGV6RPwh7cpwKFp+LB+fSFCr9z
         MhovloOkQ32VdeQqwcMMLaeOTw4J1z7mIIFMQjk1YueaPjQjiZURD9mo8+c+2tuQqThh
         1wpjD5O1sDJew0NDQDAVl9p2yohv3v84Cvn6ohSNFTx/Jbj0qD0SnAAJVhKyo6ySHoY5
         /smtM2EP7uYQnqnnFCrTqU7YMajB3sp+Fh6N/Q/6mXhawK4/d5myZ79SeZRgKRDsjgKf
         /IJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=YaFxsCt+F5ViqkhP0tfGIwvaehePcQ73LQew2TudL9Y=;
        b=MdrkNyr2oN1aY/ebeBBVsiwpmrE7JCSD4Y2XWS5c688Nbpx+e6lUMcbQ+LC65nWL5q
         WrIQIED2QxpkvrePhtsSN876fTJd4kbchWHC3dk5LFgakCO4qsyIhEPC5w7OtYmZgcHG
         33d8TJqG9408PLaCMFm2YW8T/kzToZkZRsfPu6HwkoyL8ODoy+7AWeITA53EFmiF1qjB
         YmCSkVhywOVGA9uCAWaUiIvyTe3rnjC+zADYyw+6BXshByUrtXeV7efakOUTqajlKOmS
         UHAIkjfOjaoewRn3mgy8vE/Kzs8hF9xIL2cZj6SxfAIuNVjXd1Sr5C01AApiPcboP8SU
         e4Vw==
X-Gm-Message-State: AJcUukdcd7V3nmX3hZXOTuRsX8gb+YBE2lf5V6rD8Svxe+TYyZS0BOZD
        1Qiz1cPGrfvG1yVYip3fuuI=
X-Google-Smtp-Source: ALg8bN6HCYjb0abQHbjOaf68M5AN4X7c2vETzCk7WOwyPpdcPNhnaL/pwl+8DshzvFOCLFb/VTtz5w==
X-Received: by 2002:adf:9323:: with SMTP id 32mr15138139wro.213.1547248828821;
        Fri, 11 Jan 2019 15:20:28 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z12sm58893364wrh.35.2019.01.11.15.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 15:20:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 2/6] list-objects: consume sparse tree walk
References: <pull.89.v3.git.gitgitgadget@gmail.com>
        <pull.89.v4.git.gitgitgadget@gmail.com>
        <39dc89beb91ac12c94d13f7931a4d9ebc602681f.1544822533.git.gitgitgadget@gmail.com>
Date:   Fri, 11 Jan 2019 15:20:27 -0800
Message-ID: <xmqqa7k6ye6c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> When creating a pack-file using 'git pack-objects --revs' we provide
> a list of interesting and uninteresting commits. For example, a push
> operation would make the local topic branch be interesting and the
> known remote refs as uninteresting. We want to discover the set of
> new objects to send to the server as a thin pack.
>
> We walk these commits until we discover a frontier of commits such
> that every commit walk starting at interesting commits ends in a root
> commit or unintersting commit. We then need to discover which
> non-commit objects are reachable from  uninteresting commits. This
> commit walk is not changing during this series.
>
> The mark_edges_uninteresting() method in list-objects.c iterates on
> the commit list and does the following:
>
> * If the commit is UNINTERSTING, then mark its root tree and every
>   object it can reach as UNINTERESTING.
>
> * If the commit is interesting, then mark the root tree of every
>   UNINTERSTING parent (and all objects that tree can reach) as
>   UNINTERSTING.
>
> At the very end, we repeat the process on every commit directly
> given to the revision walk from stdin. This helps ensure we properly
> cover shallow commits that otherwise were not included in the
> frontier.
>
> The logic to recursively follow trees is in the
> mark_tree_uninteresting() method in revision.c. The algorithm avoids
> duplicate work by not recursing into trees that are already marked
> UNINTERSTING.
>
> Add a new 'sparse' option to the mark_edges_uninteresting() method
> that performs this logic in a slightly new way. As we iterate over
> the commits, we add all of the root trees to an oidset. Then, call
> mark_trees_uninteresting_sparse() on that oidset. Note that we
> include interesting trees in this process. The current implementation
> of mark_trees_unintersting_sparse() will walk the same trees as
> the old logic, but this will be replaced in a later change.

It is unclear what "a slightly new way" refers to.  The updated code
adds the UNINTERSTING edge commits and UNINTERSTING parents of
interesting edge commits (the latter is done using the new
add-edge-parents() helper function) to an oidset and calls the new
helper introduced in [1/6] to ensure all the objects reachable from
these UNINTERSTING trees become UNINTERSTING.

Which seems to be doing exactly the same thing as the original.

Puzzled.
