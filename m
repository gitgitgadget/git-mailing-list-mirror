Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D1741F42D
	for <e@80x24.org>; Fri, 25 May 2018 01:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972095AbeEYBU2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 21:20:28 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33841 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965211AbeEYBU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 21:20:27 -0400
Received: by mail-wr0-f195.google.com with SMTP id j1-v6so6314565wrm.1
        for <git@vger.kernel.org>; Thu, 24 May 2018 18:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ob/nmXqfqc8PNz6lYN+CWFmeLb9EmLVdyEUEVluWt6w=;
        b=J3qNKNl1cGi0d0tmxPWtenCsDurwj/pZD6618YnUM0tT1q8poXzYK/syDiAUA5PhnD
         R3yJgJ5LzZkteGaeQAYVHaCKxNE5qG5FFUrDhuFTI4aJmIL+Z+f65TIpPThI0p1PRkBE
         8SXkmWUef22nY6lXeU/QRks+9GGs/gQ7wohkoZ8+5Fo4+RXhj/Zg8IJYuAXJLNPCQ2en
         VA7BXqYbUAWtv1GiqTEYNQ0aZ+NjQU3QkZq6C0T9xZvfo4E0rCPOVVQSGjMzh5S2m+Vy
         +q1f/l8JP1BdJH33UvTuCPvyn+HsO9gfKPlX1BPnCHjrvxAPcFOWe5VwzgLTJCFCnSk2
         o24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ob/nmXqfqc8PNz6lYN+CWFmeLb9EmLVdyEUEVluWt6w=;
        b=rltADSI1ANlMxboceXdPVYDbUgXxxSIgJBmlP7fugcb1VutDCtq6sTFHSuMCyMW3jV
         HUZYTSsPAR79OcybNN84ERQDuP7ejI0G1cOJf30MAdqORCy3XJyb+RZONpxeisPNoHi7
         4/LZ6CK4CoooacMkg2k1rQmRSRkHLcTzUP7J83+9bZV9zW9SsVF0tmmGZbAAO5JTor9C
         EkfvYrrH5HLFSmbicnThTir4S934nXH+azG1E/jVGk1s3huMfPHczSnjpFVC0wL4TpNm
         FbvdsC/NlDJXXjKIsgJtCDGJVLA5RvROVaUvdndY0R8YgU0SMofsVV/3n1T3nGO2VJTF
         4NRw==
X-Gm-Message-State: ALKqPweNj0I8VOtzZaS8cHf4Juv6MFbcf70N6I0OYqbRLqR4Dno6rl6P
        nfCdflYy/o2lwJY9kPqX8mY=
X-Google-Smtp-Source: AB8JxZrADmiON/9HdgvLqnd1IKMppKYaEdAtUBdrMP87v/dDjvdqjldbxPKLoSERSf+ox2j4MDrVSw==
X-Received: by 2002:adf:9125:: with SMTP id j34-v6mr270188wrj.156.1527211225798;
        Thu, 24 May 2018 18:20:25 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u37-v6sm23010890wrb.53.2018.05.24.18.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 18:20:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH 4/7] rerere: fix crash when conflict goes unresolved
References: <20180520211210.1248-1-t.gummerer@gmail.com>
        <20180520211210.1248-5-t.gummerer@gmail.com>
        <xmqqmuwpqt9s.fsf@gitster-ct.c.googlers.com>
        <20180524185425.GB18193@hank.intra.tgummerer.com>
Date:   Fri, 25 May 2018 10:20:24 +0900
In-Reply-To: <20180524185425.GB18193@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Thu, 24 May 2018 19:54:25 +0100")
Message-ID: <xmqqtvqwpm3r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Sorry I botched the description here, and failed to describe what the
> code is actually doing.  We're actually only removing the variant in
> the MERGE_RR file, whose path we are now no longer able to handle.

Oh, that's absolutely fine, then.  Thanks for a prompt update.
