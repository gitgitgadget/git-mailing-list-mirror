Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F29B42018D
	for <e@80x24.org>; Mon,  8 May 2017 00:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750839AbdEHAPg (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 20:15:36 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35183 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750782AbdEHAPf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 20:15:35 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so7666675pfd.2
        for <git@vger.kernel.org>; Sun, 07 May 2017 17:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2OHyXbu9nsDFZkZh/TJ+Z7Ks3/Jg7t08pNmpaw5/PU4=;
        b=RSwx9P4PwssDxDzJr+lhOdjd0PQUNANrY8rmPqaUXZgGf+XFEFVuwPiZHKnoCHCb5H
         vQlvM48hCWxBzgOysKpmC8NAEK8VALdUhv0zHUX/At6J71vEr+o4qE09a1uRhhyDWQzb
         Ak8DSE4HeXkR44ExkUBPQTh+NsEvDWJqXBcyRb8jKa+DEpqjMq88RFUqpzbMQwVz+NKz
         55Zt/e4pk0YVx1Ay9cEXsC4Pqs/942HPar3eZV58cMPIKsb6MiuBWapRfxv2OgQ9ImZq
         t33Qq9nSyDPlmLAYIGZMXcEz6Kx4NKJ4Oo/u8LPHZSSvEOZXOWpMDrlH4zzWN70zd+Bu
         a2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2OHyXbu9nsDFZkZh/TJ+Z7Ks3/Jg7t08pNmpaw5/PU4=;
        b=jVx3Y1bSESH4KsCp8QThraIzSI97McpSZsiY4Cdo6tvZz/YcucZ3cEuX8nLE0vV7Ci
         NbhpRYAz+ijl2wzrygnKpF/PF5ja1vx5K/wVvJnFEbtC506MOhkYt0rzCO1LFrpXYEKW
         eZD9TupzupJMcbVLCaea3UM9wbm6zJnFRVCUJy8XQ4pUZjH4cgSKfuM4yrIzqAv/DArp
         3SFU3L1JJbNObtxkYNNKP/QxFfHmFhZ6eIQJBNSv5qJzb9dX4uKTLbK1u7zNAU7rGLM1
         uUVOQuE7M84nnziP4AHZgOpTuqeOEJGXOksgjACFWRvjvtlQLKvSpVcA29yYN1wvC2SE
         0bcA==
X-Gm-Message-State: AN3rC/47NBRT+4eR91dGyVMPN/HG7E3OqEHYCNTbljPTkJ0Hume3uh4S
        MW3f7PzBmA1dIA==
X-Received: by 10.98.11.205 with SMTP id 74mr28375146pfl.214.1494202535098;
        Sun, 07 May 2017 17:15:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id 20sm27574197pfq.42.2017.05.07.17.15.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 17:15:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        jeffhost@microsoft.com, peff@peff.net, markbt@efaref.net,
        benpeart@microsoft.com, jonathantanmy@google.com
Subject: Re: [PATCH 00/10] RFC Partial Clone and Fetch
References: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
        <777ab8f2-c31a-d07b-ffe3-f8333f408ea1@jeffhostetler.com>
        <20170503182725.GC28740@aiede.svl.corp.google.com>
Date:   Mon, 08 May 2017 09:15:33 +0900
In-Reply-To: <20170503182725.GC28740@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Wed, 3 May 2017 11:27:26 -0700")
Message-ID: <xmqqwp9scifu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> - there shouldn't be any need for the blobs to even be mentioned in
>   the .pack stored locally.  The .idx file maps from sha1 to offset
>   within the packfile --- a special offset could mean "this is a
>   missing blob".

Clever.

> - However, the list of missing blobs can be inferred from the existing
>   pack format, without a change to the pack format used in git
>   protocol.  As part of constructing the idx, "git index-pack"
>   inflates every object in the pack file sent by the server.  This
>   means we know what blobs they reference, so we can easily produce a
>   list for the idx file without changing the pack file format.

A minor wrinkle to keep in mind if you were to go this route is that
you'd need a way to tell the reason why a blob that is referenced by
a tree in the pack stream is not in the same pack stream.  

If the resulting repository on the receiving side has that blob
after the transfer, it is likely that the reason why the blob does
not appear in the pack is because the want/have/ack exchange told
the sending side that the receiving side has a commit that contains
the blob.  But when the blob does not exist in the receiving side
after the transfer, we cannot tell between two possible cases.  The
server may have actively wanted to omit it (i.e. the case we are
interested in in this discussion thread).  Or the receiving end said
that it has a commit that contains the blob, but due to preexisting
corruption, the receiving repository was missing the blob in
reality.
