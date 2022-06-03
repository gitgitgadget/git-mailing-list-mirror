Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC4FC433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 15:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245504AbiFCP1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 11:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238749AbiFCP1h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 11:27:37 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AAA2DCD
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 08:27:34 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id c4-20020a170902d48400b001640bfb2b4fso4426068plg.20
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=duDhpI4avgEZKwSJjdXj6GEl26XEtxbEOI3iNjqIVtw=;
        b=ZfPAekqMmgVNhTo7LLR9BAjonixLRt30luDHq8+MVeeQKaAoe2EWN+NafkRNhLDAXo
         c1vhhbt/iRH2hlPa5ZjBnfz5yFjkHjFFnl+pP/TNaEq2h/KKL80VQfiRgZbE7erqvzwP
         zUjWHdcx51BXP0FDa5D0Sx+jTNRDLyL5SJgizDatG/yyEFHvfYnoydDxItqZK8XVHayl
         fDXfz0mkDYXD0+z6IoyDN009XQKLZwrMGvOSKK71twWxyi/UGaTGkpcd6jc45vDtyal+
         AE+qQVohSR3fVzKr9auqOCzbh7812gPFCxPXe7QHUisMkT+tov8Sk5ZbjUuSlYgjlcZD
         LycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=duDhpI4avgEZKwSJjdXj6GEl26XEtxbEOI3iNjqIVtw=;
        b=usWu8xjgztlZe15YH+wUpkjSrK/UjIUwy2bCUjPLB7mahEP8C+CDo9NgYnE/tIGpkG
         hZns4BMEl9Yo3GatpeOC6A/a0bq39108ZBuLEXPp9Y1MibJFAORe03b3IY+li+dUS0WR
         +xnnXj6Csi8zUrorCvl0RNNuQ9Svhby4dCoIONo+ALC9FJ27kNZ2vomDWZAR5Iq9wVu5
         32LphSp/d+m4WuNvPr0I8Fcl/7bkPiUj679buwaZKKb1NwIg0ub6Q6k6/KC04n82TGuF
         8ZJ+9ibYyjqGVlveyQVqF6mA//oEj/7s7wnMwmQ0uUY8JiNcrYJpRIbxQefU+Umfqu5Q
         DBYA==
X-Gm-Message-State: AOAM533bF8yCeaM9nP0wQCREC8N79TJQjVN8ARoSgiH+iY2unbakyl7Q
        sTmaMA43/Oy9/WTaSd0HBm09PnxazTP+tJTApPqB
X-Google-Smtp-Source: ABdhPJzF5Y1pJqgIH9jDR6Iaqos4JQgGc1ubG4smXe0hvT7PQs1z34Rs1Y3VXnNT4MjESVdO+sVxz3qkxY1fEfC4Pq0i
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:544:0:b0:51b:a90d:64d3 with SMTP
 id 65-20020a620544000000b0051ba90d64d3mr10952965pff.40.1654270054228; Fri, 03
 Jun 2022 08:27:34 -0700 (PDT)
Date:   Fri,  3 Jun 2022 08:27:31 -0700
In-Reply-To: <394c054e-e1d2-41a5-a655-2ad3cb7219e0@github.com>
Message-Id: <20220603152731.487338-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: Re: [PATCH v2] commit,shallow: unparse commits if grafts changed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, git@vger.kernel.org, me@ttaylorr.com,
        gitster@pobox.com, bagasdotme@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:
> This looks good. I took a quick inventory of 'struct commit' and
> agree that this is all we need. There is no need to clear the date
> or maybe_tree members. The commit_graph_data slab might have some
> information if there were no grafts before (but are now), but the
> existence of grafts should clear the commit-graph already and stop
> that slab from being used.

Thanks for taking a look.

> Grafts are only on commits. You cannot replace what a tag is pointing
> at with a graft. Replace-objects is a different thing and changes it at
> the OID level (and I don't think this can happen during the process
> without concurrent external changes to the filesystem).

Thanks for the explanation!
