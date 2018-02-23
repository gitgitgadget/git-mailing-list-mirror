Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8378B1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 19:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754658AbeBWTdm (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 14:33:42 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40376 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754612AbeBWTdk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 14:33:40 -0500
Received: by mail-wr0-f195.google.com with SMTP id o76so15210361wrb.7
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 11:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=b/z/eZwtpshBRzAmS3YNqPzVvEWZgFZebKMN3MdKlXI=;
        b=D/IBfEyKCqkquCmdVYu4lR+UnJ7tRTBM+LHR3dUcDzKBHgdiEONNK9m8VHREQLq6pL
         N6PbaFfmdo+5MUY10FPW2/I7aSWx+DfmWSdTgVoam441mvUnytmuyYHPgKjDERU1HTiX
         bIw8YWdTsUcYoJEkPVoMLZXlm+s75/fGanEzn9DUxhnAfVNPyORX35tQGlVOjA669JJs
         QH+u1w4pMw1B88oAXGyV1S8Xdv+3em9he/qFJBPmzhMDaaULqXDAcO8uv/7JXHKjrtln
         4pvVr5PrKs9B+163cS5JBU58DSKqLYOS4JAtvynvLidvOVlbu9d2vf/6pvOKe5CSBXCB
         yONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=b/z/eZwtpshBRzAmS3YNqPzVvEWZgFZebKMN3MdKlXI=;
        b=PC7Dkj0GA9AxFsO5xM4NiGoFzAWepPNSi9Xu+4HjWwqSnxS6oxPmWkH4/RhsiEp0p1
         dEseNzoJT/nd4/XfARgZp1ebJIKVkZhVQENy+CEiDzlC5vrMrtPDsB3lgzUkzK2G0nUL
         vFPWtBgNzZQbh0reNH4v3NOeGWbGatB2d7AjUva7IctotPOYnjQxjez6X8eLrHHQbznD
         F3Ioy8CMvJDOqFTIEuvnUvb+kJviKkveblUFtwOsPMuXskuPaCzGkA3Z6qD5XYt20fUd
         Kd4PJZh/wFOxLb+RrVtarXFBLWrVdp7cYun8tEtmBPV48sJrGiMmFgQGZ6FhY/awXmKy
         jLog==
X-Gm-Message-State: APf1xPBdbLZTiEd8Oez/8ngfa86dnxCaaQ9qK9XDc8oIl2VtkAVVVjSI
        KD4VTJUzE6oaSuz5LdOgNZE=
X-Google-Smtp-Source: AH8x225XpPQQS93EOEWhLlPUs0b7jLQeHwMunD4sShJbYd0ER9P9HWcD7ljDLwZhPgnclYGh0jMqsA==
X-Received: by 10.223.169.161 with SMTP id b30mr2915666wrd.232.1519414419144;
        Fri, 23 Feb 2018 11:33:39 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s2sm5272029wmf.0.2018.02.23.11.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 11:33:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 08/13] commit-graph: implement --delete-expired
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
        <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
        <1519066406-81663-9-git-send-email-dstolee@microsoft.com>
        <xmqqfu5sx3md.fsf@gitster-ct.c.googlers.com>
        <67871288-ea70-69d4-9c3d-5cc946d8dbe2@gmail.com>
Date:   Fri, 23 Feb 2018 11:33:38 -0800
In-Reply-To: <67871288-ea70-69d4-9c3d-5cc946d8dbe2@gmail.com> (Derrick
        Stolee's message of "Fri, 23 Feb 2018 12:59:00 -0500")
Message-ID: <xmqqo9kftsa5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> The (unlikely, but possible) race condition involves two processes (P1
> and P2):
>
> 1. P1 reads from graph-latest to see commit graph file F1.
> 2. P2 updates graph-latest to point to F2 and deletes F1.
> 3. P1 tries to read F1 and fails.
>
> I could explicitly mention this condition in the message, or we can
> just let P2 fail by deleting all files other than the one referenced
> by 'graph-latest'. Thoughts?

The established way we do this is not to have -latest pointer, I
would think, and instead, make -latest be the actual thing.  That is
how $GIT_DIR/index is updated, for example, by first writing into a
temporary file and then moving it to the final destination.  Is
there a reason why the same pattern cannot be used?
