Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF30B20136
	for <e@80x24.org>; Fri, 17 Feb 2017 18:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934149AbdBQSgA (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 13:36:00 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33010 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934275AbdBQSf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 13:35:59 -0500
Received: by mail-pg0-f66.google.com with SMTP id 5so5540161pgj.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 10:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=SeH9QmL744CGEL57Y3R7gnjiv0HJy8JrMcq3FhkNIfs=;
        b=l/kmdlxoorr9nb36lV5kefBybinpXazNM/MPYlL4BxHHHIKQiO9MgxhOGb1hjscbs3
         02gr78Ns95g4sq8TZPDTVrWKY30RdilmRYZjTIHT0hlkm+fEzX916jRlGCetdSoKGDtH
         /uJjncWn0PJfCZu/+mRIDEkk3Pje+JOwErp9yqfSyS8C9TmnQjQGhBFk2ryl8FqeCPYZ
         Z6w+j+KsK9R3BDyco7xyhNLrGbOLv4JrCKpxFvdL+istFxZDnVnsK4I/Xjnq/Fa9yjki
         k3qNeeXJmrmHl2vWgP8lx1p1n2tCuL3tqhcQvlC8PNLauhjxgwIbtPrmrp7U7SMPS2MN
         byfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=SeH9QmL744CGEL57Y3R7gnjiv0HJy8JrMcq3FhkNIfs=;
        b=mEx/NDCfuUSI/4qVYs6EhwLjj1Irqv2GtHEEsZQf/KjlLN+1v7OloT8wQs/ciUANfJ
         m7VF5j3msni9JwulQq/toXSJGB4cMXk6NHXVejDnuned7ItnsudB7UQf57Et4hG6iRnx
         Ny1GEPw/E7gXmTfffy9pLE87rC4ALwhiR7sgA22DC6XMsTwSMr5fVJcflTs/gC/C5Qbn
         lOAis9nCoPQvgpycqiP33JlLT65R6J/Wqd5C5CmWZjBenbI/ExPj6zHRxCqHD2nZBWYF
         6B2yJ6NlAF5Q8z1m7suDL/di0AhgRBDVFajB80G2M4SGg5X5pit8vMl5fPYPxo7+4nQo
         pwuQ==
X-Gm-Message-State: AMke39kkcTkzWxY5hv8kgBcz8Mqj1aFtZ8Xe4quHH6v+d3a5ZoXZTOvnUWhelE76tHim6A==
X-Received: by 10.99.101.199 with SMTP id z190mr11567390pgb.219.1487356558759;
        Fri, 17 Feb 2017 10:35:58 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id f3sm21000320pfd.10.2017.02.17.10.35.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 10:35:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org
Subject: Re: [PATCH v2 00/16] Remove submodule from files-backend.c
References: <20170213152011.12050-1-pclouds@gmail.com>
        <20170216114818.6080-1-pclouds@gmail.com>
Date:   Fri, 17 Feb 2017 10:35:57 -0800
In-Reply-To: <20170216114818.6080-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Thu, 16 Feb 2017 18:48:02 +0700")
Message-ID: <xmqqzihksm0i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> I'll be sending two more follow-up series, if you are interested, soon:
>
> 1) v2 of nd/worktree-gc-protection
>
> which kills parse_ref() in worktree.c _and_ set_worktree_head_symref()
> in files-backend.c. Both are bad things that should not have happened.
> (PS. The topic name is misleading as this is mostly about eliminating
> warts, unless Junio intended to combine my second series as well)

Your description sounded that these two are just preparatory step
for the main one that would soon follow, and that was why these two
patches landed on a topic named as such without any of its friends
(which were yet to come).  If you prefer to keep these a separate
preparatory step from the remainder and have them graduate sooner,
let's do so, as that is my preference as well.  

Rename it "nd/worktree-kill-parse-ref" perhaps?

> This series introduces get_worktree_ref_store() and adds two new APIs
> refs_resolve_ref_unsafe() and refs_create_symref(). I'm still not sure
> if the refs_ prefix is good naming, but I had to pick something to get
> things going. Name suggestions are welcome.

> 2) the real worktree-gc-protection
>
> This series adds a bunch of new refs API, enough for revision.c to
> traverses all sorts of refs with a ref store instead of "submodule".
> Many _submodule API are removed as a result because they no longer
> have any callers (yay!). One of them remains though.

Yay indeed.
