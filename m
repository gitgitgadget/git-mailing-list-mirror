Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65B41F403
	for <e@80x24.org>; Fri, 15 Jun 2018 18:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756557AbeFOS2J (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 14:28:09 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35435 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753541AbeFOS2I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 14:28:08 -0400
Received: by mail-wr0-f193.google.com with SMTP id l10-v6so10818927wrn.2
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 11:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=XmfRYNU5l52s22zvwMcoWdegq38FvId5t2Jee/fxMxE=;
        b=eL3i8J/VHJOqqCatB+4mMgHMeqFHFyjYZvjX9eObbgtApgqR+pfERRVEaD/5647dYW
         EMYS6wVp0zvf8s9nL+8VtJ1lKBJTYgdLgvteCshhY2ho8DRQRM/KJtKlhTxs9wTcRVO9
         X+9bE/aINYV5MSRFhEw+5bAN489Z+ZxOhvvXWShe8vIZAlBhf/5hAJ7Dh8tcFUyOvdfN
         dHHfXE5orhS63w+J0yXZLHaYeuvo8LA1juZeFyXeMdp3f6fYfOV/7bu/COtiMMCfdX4e
         89y3ifqIWAVHKWzwmQ659mgrBc/PEClNdbcDuqkUCG2aAjUpr+4h0uEbjuRlagSMn7WT
         1VTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=XmfRYNU5l52s22zvwMcoWdegq38FvId5t2Jee/fxMxE=;
        b=Ivwj/Ay9J6tZ7vMdlTfga+les7dT/FsC/859+Vl06pn2ZEQ6afEqVTVR4ZOkbB8dFa
         GcldctVec5Y5NCnpA2pVuPRp5kI30b23rxQsOCOu98HQNL92FLMuqnwA3llvGV32KARA
         56kq7DZLqqvepSLnqDzPtTneQa1S2H2Q2l6sBhOazl3Fw5jp8Hsm/ZL3PWKdjEbpxy9d
         yvMzpVVfpKQW/UctpdpL8LDwQczbT1sW5w/75rZIPjVwopo+twHF7d39AGeBeAS9M8Rj
         pWERB517D3eRfXT7lzo6pMVSpAKUzJjOiCtuLHJos4SQ4q34dD0SnO+39l/1YuICTlrK
         9Y6A==
X-Gm-Message-State: APt69E2SGysQlEeHDcglQl9zcpJIck9df0pqHX7ZhvYgGzCUQfXx4tjp
        SxplvglMAOAv5XQM2YJL+ps=
X-Google-Smtp-Source: ADUXVKKKr9B+WIfdXOlyCuC40CXhf9fJ7KtkXYP6C3FTKdFAPkOdd0QL97jWNdxA6ATuyXhaE3K3Mg==
X-Received: by 2002:adf:ab10:: with SMTP id q16-v6mr2505332wrc.239.1529087286708;
        Fri, 15 Jun 2018 11:28:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k82-v6sm3087359wmg.10.2018.06.15.11.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 11:28:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Isabella Stephens <istephens@atlassian.com>
Cc:     git@vger.kernel.org, szeder.dev@gmail.com, peff@peff.net,
        bturner@atlassian.com, jacob.keller@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v6 1/2] blame: prevent error if range ends past end of file
References: <20180531050030.43364-1-istephens@atlassian.com>
        <xmqqh8mnb8j2.fsf@gitster-ct.c.googlers.com>
        <db426610-90e3-e936-b630-a3d83e345e79@atlassian.com>
Date:   Fri, 15 Jun 2018 11:28:04 -0700
In-Reply-To: <db426610-90e3-e936-b630-a3d83e345e79@atlassian.com> (Isabella
        Stephens's message of "Fri, 15 Jun 2018 16:36:13 +1000")
Message-ID: <xmqqefh729cb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Isabella Stephens <istephens@atlassian.com> writes:

>> Don't t800[12]-*.sh need adjustment for this change, too?
>
> Apologies. I will make sure I've run the whole test suite against
> my patches in future. I've sent through a 7th (and hopefully
> final) version.
>  

Thanks.  Will queue and hopefully we can carry this in 'pu' (and
later down to 'next' and to 'master').

