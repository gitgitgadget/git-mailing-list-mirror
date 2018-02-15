Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D43211F404
	for <e@80x24.org>; Thu, 15 Feb 2018 20:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166340AbeBOUnA (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 15:43:00 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50831 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1166217AbeBOUm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 15:42:57 -0500
Received: by mail-wm0-f66.google.com with SMTP id k87so3222651wmi.0
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 12:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aE4ysoezh++RVI/w12ZKqkM7J/6yC/VcIIVNYX74G80=;
        b=mXLpSpdAkEqWGx/gr2ggc9VJ72Hh6+75fMWZD31VG/o4BLrOww9bCfUop+De6XEHpU
         rqSGtf+sNTecB0huGeIQJ0CM2IhbKCZ/IQPCtG+FdhpTpEqmnw9OFXLjO4CxvBOj8z6e
         yU64R5EAz3AM1lY1he6Kc3vveQOghd6uglwhdOHzdySvynHe1FrCiznXMck5zG0n+cjs
         slYAe9Y+4t/t7F7I+WvlgXtHE4iQOX6b9WO8ERAIVaN/ReaEonfEz22+urbSQkPNg5H6
         mdYdbc+Kz7rlgubSgljRVFUs1kkMGZRqbghgVy7TkTQmMeYIa/crcO6bFkNLbtW379T9
         iWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aE4ysoezh++RVI/w12ZKqkM7J/6yC/VcIIVNYX74G80=;
        b=ayVj5ydSGSnOebV38Bp0yPPlp6d0vcjAWaGL43K6Yh/I8dJ7Iez7OCEI3y/e/WjwF9
         YLrbHnbqfpZM4g8xms2RjcN9PVbzHygpVYHhOWNfG9gLVDIF1U2TBpCk8cnyZZ4D+n5i
         O/QgHrRM1CCKq5UZE3u3TUGtvyyAVp1jcdClnsvtD8SHK1mES5Opk3WN22hnz5JjzsQa
         U7gyui6v9z/GRf82runl+wFlsyi3DmMj+XjXSb5yQlbgPwqIiKnM9cxdtJE/fCQise8i
         jzcZ7LLRMbsJ9kPOwBf3HaNbzqbZQhBko5zghCAYH1PduiyOHx7wOYcJjuoU73gLCmMX
         uMBg==
X-Gm-Message-State: APf1xPDZNRYNu59pJ/v6XcxFIHg3aQjlDTGLz0Gd8p3TEFCHs/XHXmO3
        NWsE+JG//9XmtSEjCjMMhjo=
X-Google-Smtp-Source: AH8x224f0ffB2jlae30bF0WT4RmjzE/seuEOldpb1vF0W20KXHjl8wDIypNPhMy2au4kh6+OUsKejQ==
X-Received: by 10.28.177.7 with SMTP id a7mr3046992wmf.143.1518727375701;
        Thu, 15 Feb 2018 12:42:55 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 56sm25417391wrt.23.2018.02.15.12.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2018 12:42:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 00/26] Moving global state into the repository object (part 1)
References: <20180213012241.187007-1-sbeller@google.com>
Date:   Thu, 15 Feb 2018 12:42:54 -0800
In-Reply-To: <20180213012241.187007-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 12 Feb 2018 17:22:15 -0800")
Message-ID: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This is a real take on the first part of the recent RFC[1].

For the patches remaining in this series, The scope is about right
and the size is more manageable.  With topics already on 'master',
they have some interactions:

 - ot/mru-on-list & gs/retire-mru

   The packed_git MRU has been greatly simplified by using list API
   directly.

 - cc/sha1-file-name

   The function signature of sha1_file_name() has been updated.

I could certainly carry evil merge resolutions going forward (these
changes need to be made to object-store.h that has no mechanical
conflicts), but it may be less distracting for later readers of the
series if we rebase it on top of a more recent master.
