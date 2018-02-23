Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71D011F404
	for <e@80x24.org>; Fri, 23 Feb 2018 19:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754745AbeBWTsL (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 14:48:11 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35466 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754561AbeBWTsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 14:48:09 -0500
Received: by mail-wr0-f196.google.com with SMTP id l43so15248882wrc.2
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 11:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EwLsp5tmFUGGQwDJMhZbtx6kE/5YCwDLKAw50K4jiZQ=;
        b=r6i33CQMSkJ1BGMgYwySYOrZlE/xe/wpFhZNZ3O8T8vKK1zUjvpbXjR4a7EA6hvPpb
         7AzcOrWwXDJBLWYGiy4hMUKSWT69YZHtWc9ftB5PwnZePUmIxBKow0BHs7PrHkKTHErZ
         lJO/64IneKUE/9A/qmGCheOTQO+frO8iYBvOGlGZabtINgp4trcbXIX1t+kRtJ3D03+f
         SQiKAsGTTDscf77ZxVQ0j9lBqXbsuR9x4juhnLZ4Mjd4RarUAycWxUNScsEX/iqX7nFH
         9KqTZfdQ69ujdNz/nvVNNOhPAwp8DJW3qM/vVHx1H0E9GGo2KejmwlhhLnh7KtsOIsee
         krkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EwLsp5tmFUGGQwDJMhZbtx6kE/5YCwDLKAw50K4jiZQ=;
        b=DFps8FmPautOHP5h4KBUGR4ZvXcN8qg3C/Lcpi09DcCwiR23X9wDQ8H8Gd32hL+F7v
         D52+hgkg2DE2LSlPYzWIpivc/VD1UJSv1AYVs2rqFXzIKOd2i2hGPXenj+3b2Ec5uyFe
         5r+kkNWfYOcOQA555Lmq/okoMaMoQLycYeompwe3Wtlx5fIuS9zbH58j9t4j4IZQst4k
         yHtlL895hV9KVTAxjME+0PUUKt/59UQxZ2ODWzH8Jtoy+o7u9Ug+QDYHi6zHT2E+umGm
         nhlfHcwD/tm/T3YJ7U5zbW2oVz4avhuw8UkUg9YfxGlmT9RfDCiaKybqtuHlFUKVUknQ
         rtNA==
X-Gm-Message-State: APf1xPDkla5NNbjWceXs+fcNCay7dqrIvVuKw2VOlIyBoX+AkgpgWyAa
        2RSQNAelLXoLi+5Z1lxoWqU=
X-Google-Smtp-Source: AH8x224M5Qz7FLG4kzVuGFPbW/0PgwStIfB8WtniJnVSgJmQERsurkxcOCTtQi0i/nPYj6jfq52J5w==
X-Received: by 10.223.173.131 with SMTP id w3mr2797247wrc.195.1519415288376;
        Fri, 23 Feb 2018 11:48:08 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r68sm2335897wmr.14.2018.02.23.11.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 11:48:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 04/13] commit-graph: implement write_commit_graph()
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
        <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
        <1519066406-81663-5-git-send-email-dstolee@microsoft.com>
        <xmqqmv031d7d.fsf@gitster-ct.c.googlers.com>
        <4d453f29-8e5b-2a98-ab11-415f63613be8@gmail.com>
        <xmqqsh9rtsg0.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 23 Feb 2018 11:48:07 -0800
In-Reply-To: <xmqqsh9rtsg0.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 23 Feb 2018 11:30:07 -0800")
Message-ID: <xmqqk1v3trm0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> I think the current name makes the following call very clear:
>
> It is still a strange name nevertheless.

Sorry for simply repeating "strange" without spelling out why in the
previous message.  This certainly is subjective and depends on your
cultural background, but in our codebase, I tried to name functions
after "what" they do and "why", rather than "how" they do so.  In a
way, it's the same kind of uneasiness I feel when I see variables
named in hungarian notation.

You would inspect the object and treat 'data' as a list and add to
the object if it is a commit, and if_packed_commit_add_to_list()
certainly is a name that describes all of that well, but does it
give readers a good answer when they wonder why the function is
doing so?  You described with the name of the function how it
collects commits that are in the pack, without explicitly saying
that you want to collect packed commits and that is why you are
inspecting for type and doing so only for commit (i.e.
"if_packed_commit" part of the name) and why you are adding to a
list.
