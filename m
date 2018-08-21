Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E0451F954
	for <e@80x24.org>; Tue, 21 Aug 2018 21:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeHVBBY (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Aug 2018 21:01:24 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38727 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeHVBBY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Aug 2018 21:01:24 -0400
Received: by mail-wm0-f48.google.com with SMTP id t25-v6so216625wmi.3
        for <git@vger.kernel.org>; Tue, 21 Aug 2018 14:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IJ/VAr9x+0DkXgWfnWc72WoyK1jtsT8aAIv73+rh1+M=;
        b=tuhWz4WqG9IZtJfQLLN+C8747Aaun54qjVo8sz2tgIffwAhyfWtEOzGiy+Sy2rX/Qx
         1kcMJjcA4mlgUTRisVike2Ih2UBR2i+0byKB+SOTmkJN0ME3EfATnQF/BzAh6ixOqZYG
         VKtwR2x6a/l1Ra0c+6Y0pFjsP9jsd4xncc6wTGmNibcSJpQ79HJ3EEzWEUH9X0FVTSWg
         DS564xy1EqyuOzM6OpWBXvt4A0IbHp4XfF6Kl7uk+Wme8aZ0BTDXm9WfKk5fxCapbEUS
         Fcny8UdIGMIE7ORovo2Kb2RjuX116ky6sTC1fW2CKAtAAoMs3mUDrodXnwpkDip3fUAZ
         Q9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IJ/VAr9x+0DkXgWfnWc72WoyK1jtsT8aAIv73+rh1+M=;
        b=YZTxfUVaVR8dnbllNRcUbpqzWe4LnFdkNf8V1V6zGHqExU78QaEpigh21KaXt5qPF8
         tO6svkhekbD/0zRLMnlhy+d9WzLMsCOuBrbUVX7Ym2EytpOazmjjJT5oXdBSQJwtMlg5
         KD8Lby4G7u6xYRvZ31WAmYGRoot7bG6CJlUObWPXJvMW2wTZNUARti48BJS9OpDh/mpv
         sBxqPHH/Hh5zgHtt+yh4OJtOEt/jr2bA8zQKQXAJH3WcU6rkonowCnQcCg6nUoFuozkj
         BJMxDKthdWw0Ul6ZqC0179dd7V9JtKfiea3nKY5fGQuEz+ymHjYqJCTTubXjWXVeajhW
         h7aQ==
X-Gm-Message-State: APzg51BZw/taCl7322ovspvTN09HSwb6mjjON7pxpAB5d0DTKz61eAk8
        FWi9iwe4/TDMbu9KAM/zvAg=
X-Google-Smtp-Source: ANB0VdZQMurdUEGek4QF+/o0S4IRgiZTvMCy+jToO7Q1NgmY9466etXtL31gi0uDoK6Y6l4YNTBbPg==
X-Received: by 2002:a1c:b756:: with SMTP id h83-v6mr751416wmf.8.1534887570588;
        Tue, 21 Aug 2018 14:39:30 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t15-v6sm15528142wrn.34.2018.08.21.14.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 14:39:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/7] submodule: is_submodule_active to differentiate between new and old mode
References: <20180816023100.161626-1-sbeller@google.com>
        <20180816023100.161626-4-sbeller@google.com>
        <xmqq600afc1e.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kb-_7PTqe_9i4=FQQE7EmQsKN8+iB4snLetPD+r2UgpBQ@mail.gmail.com>
Date:   Tue, 21 Aug 2018 14:39:28 -0700
In-Reply-To: <CAGZ79kb-_7PTqe_9i4=FQQE7EmQsKN8+iB4snLetPD+r2UgpBQ@mail.gmail.com>
        (Stefan Beller's message of "Mon, 20 Aug 2018 12:50:48 -0700")
Message-ID: <xmqqpnyb7627.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> So I think this patch is insufficient, and needs to at least change
>> the "submodule.active" codepath to return !!ret; otherwise, a caller
>> that now expects 0 (not active), 1 (active but can lose URL) and 2
>> (active and the presence of URL makes it so) will be confused when
>> one of the MATCHED_* constants from dir.h comes back.
>
> Yes.
>
> I'll resend when appropriately.

Thanks.
