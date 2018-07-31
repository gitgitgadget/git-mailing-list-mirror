Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0F6B1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 20:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbeGaV7B (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 17:59:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52812 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeGaV7B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 17:59:01 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so4418260wmh.2
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 13:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tFS1GUhBf41djdWOgOPd6ks1eqRcbM0wJZ3cha7Jdzk=;
        b=K++8f4ndPxajOv6R9ypg4SNTue8skN2oz0OZ1plu7xY5cGZWXpHcVd40kXtb5Q3wB0
         3ZK6QpU2/r0Rbj+8eefc3/TQIUwSE9PW8zlrFDiNSuMDUSPOdqbfaKIY5ZmfxDmZmhzC
         d7KxHWsiRKRrKXXXiPPvcSkBh44LF6ttE+vdLa3zM266YcocOTH6rZrXlyoWkYdfp18L
         WKYpwBSJ9liILUCOX8uD6vPKhMa9Agl4zHlHPgcv6EHPAdX2ROLZ/iHevQnf2lFl60+F
         4eL/7PydugXRiJyvGss3E8A5b5eJQkHM3lwVCqBKepv9WpqpTYysd/KECAzdB7QfzHCj
         RtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tFS1GUhBf41djdWOgOPd6ks1eqRcbM0wJZ3cha7Jdzk=;
        b=LxWFFVR1VYgkJOUvY+mufoJNCs7A/Afyw5SU4AUJRcEo1ExKXpboh6cvPMFhofPd1z
         txF3JNarXdlQAbc7sFPe0+3IaFbMMylR2M/y8rXW+9x+Je1vZJDmTVPSvcS3dKwnBQ3C
         riQtXS8YOlqephmEdyqf3ylWSUPpsqyyZnnyfOhpncULhl7GNhl+JqQIhJZ8qR14LSyj
         6Yw6tU78dQ29dxBSwder3RlEdXYbaCpbxO974GRk4MdlvQ+vOVVNJq85j19Dt0Zy6Qko
         Mx4ej9Hmd8JCVwv/bcJsKD1VV3FACiJmR6O82no/0LV8R1GG5Hbv2fsqFadm52rUVQ3U
         iugA==
X-Gm-Message-State: AOUpUlHtkO+lxNTuusPFAgOe2De0f0mm6Th0+viefLavy1oPn+XbAZl/
        K16hv23BSANBSuFgV8E3UlY=
X-Google-Smtp-Source: AAOMgpfCxj8IzcHjMvUND21QGd0hHqerRVUAJ0hTiAb6u52+4P9JbtDrwoRK4vALnDWXwyYoaJ0UQg==
X-Received: by 2002:a1c:d702:: with SMTP id o2-v6mr709032wmg.115.1533068219859;
        Tue, 31 Jul 2018 13:16:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 71-v6sm5399459wmq.17.2018.07.31.13.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 13:16:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     johannes.schindelin@gmx.de, bmwill@google.com, git@vger.kernel.org,
        peff@google.com
Subject: Re: [PATCH 2/3] config: fix case sensitive subsection names on writing
References: <nycvar.QRO.7.76.6.1807301438440.10478@tvgsbejvaqbjf.bet>
        <20180730230443.74416-1-sbeller@google.com>
        <20180730230443.74416-3-sbeller@google.com>
Date:   Tue, 31 Jul 2018 13:16:58 -0700
In-Reply-To: <20180730230443.74416-3-sbeller@google.com> (Stefan Beller's
        message of "Mon, 30 Jul 2018 16:04:42 -0700")
Message-ID: <xmqqr2jj9n45.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> A use reported a submodule issue regarding strange case indentation
> issues, but it could be boiled down to the following test case:
>
>   $ git init test  && cd test
>   $ git config foo."Bar".key test
>   $ git config foo."bar".key test
>   $ tail -n 3 .git/config
>   [foo "Bar"]
>         key = test
>         key = test
>
> Sub sections are case sensitive and we have a test for correctly reading
> them. However we do not have a test for writing out config correctly with
> case sensitive subsection names, which is why this went unnoticed in
> 6ae996f2acf (git_config_set: make use of the config parser's event
> stream, 2018-04-09)

Am I correct to understand that this patch is a "FIX" for breakage
introduced by that commit?  The phrasing is not helping me to pick
a good base to queue these patches on.

Thanks.
