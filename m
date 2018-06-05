Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C64371F403
	for <e@80x24.org>; Tue,  5 Jun 2018 21:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeFEVku (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 17:40:50 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35071 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751619AbeFEVkt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 17:40:49 -0400
Received: by mail-pg0-f66.google.com with SMTP id 15-v6so1871434pge.2
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 14:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b5jjyAXtsNEtGcg+pKF0mtwWyg8H37WCMDFYTqH90Ss=;
        b=FGClLDid/qCvapcdbrJ2pXZ16yZqQ0VdK/KPQ1li8bLcVYbnOs2mtuTPl0IQOFPyZ4
         AgetiXEeQ9GyIxjpQ06fK+bNdoHsgoHEV/K5Bp7GcUJyQxoTP4WasT+hVKVgQ+QqN175
         XztgSzoWvBKZhPqE0VhBqVndQ52Zctdd/J3tiGh9H5OI+8DIsrD6xZIz7D9xiNfKkWHP
         5BIWIn1+1XjQRlyadKcllThQP17KODUI3e2kjBdrfUOJCudsV0c/0jMMRja09dKh+rnP
         UpeeYP2kB+OrthrUUwXCV3qymzSwVaI1E/gu3SNy2HdE6y9G1y776V1qfdGMLuJFj4Kk
         6nzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b5jjyAXtsNEtGcg+pKF0mtwWyg8H37WCMDFYTqH90Ss=;
        b=nvYaI00MdkVGAygWknu4Ke9+HEoYlZB7l1nm8TDgvXR5Yzrww7fQeJfDEytn/BwtGK
         bib0m1szIM/HyO/AoNZcj7lJ4QOZY3EAOlLXpe8xhbvOzCk4vzZBmhhjvwhING7hwgtc
         FWbaCguj3k2PX8QPuD2GDB3/vhZnnYQfhEklWG+aUZ6cwDXqA4N8lANVx49tEIYgtQvl
         u7vWuu0mErr/rmPUONnu3Ul4AA4CM4raWWB/ZrLnTZLokRVY9RHq4/Ny8KDE7+nfkMCF
         s3/oO0Km+iw/OAZ33/l5jGqr99H99qmlGbXaseDhes8qDI9ORv4Nhee/uiSJW1e95f6m
         74IQ==
X-Gm-Message-State: APt69E3UBKyA42cIiw2vOyezgZKsgyCiTous/Gx6byENabdCuPQiOO8u
        IKX8JpgLYbrbW3G+Io3UHozmvAf/sls=
X-Google-Smtp-Source: ADUXVKKtmzwZTwjFCtI9H2hv4nyYZLLQJNcuqlRvWJHuAlf94CRNqvMQ3yNyKbaI4e4SC7q7TEWZUA==
X-Received: by 2002:a63:6142:: with SMTP id v63-v6mr261913pgb.390.1528234847571;
        Tue, 05 Jun 2018 14:40:47 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id 76-v6sm27451138pfr.172.2018.06.05.14.40.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 14:40:46 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, bmwill@google.com
Subject: [PATCH v2 0/2] Fix protocol v2 tag following with CLI refspec
Date:   Tue,  5 Jun 2018 14:40:34 -0700
Message-Id: <cover.1528234587.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.768.g1526ddbba1.dirty
In-Reply-To: <cover.1528233146.git.jonathantanmy@google.com>
References: <cover.1528233146.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Test t5702-protocol-v2.sh doesn't pass with this patch.

Good catch - I've fixed that.

> This is difficult...Really I don't think the default should be to follow
> tags.  Mostly because this defeats the purpose of ref filtering when a
> user only requests the master branch.  Now instead of the server only
> sending the master branch, you get the whole tags namespace as well.

It's true that there is now a performance drop. My instinctive reaction
is to be conservative and preserve the existing behavior, but I'll see
what others on this list think.

It's worth nothing that with ref-in-want (for example, in your latest
series [1]) we might be able to restore performance, because the server
can send refs/tags/X with the packfile instead of sending all
refs/tags/X refs initially to the client.

[1] https://public-inbox.org/git/20180605175144.4225-1-bmwill@google.com/

Jonathan Tan (2):
  t5702: test fetch with multiple refspecs at a time
  fetch: send "refs/tags/" prefix upon CLI refspecs

 builtin/fetch.c        |  2 +-
 t/t5702-protocol-v2.sh | 71 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 69 insertions(+), 4 deletions(-)

-- 
2.17.0.768.g1526ddbba1.dirty

