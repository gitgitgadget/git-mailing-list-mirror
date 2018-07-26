Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 454391F597
	for <e@80x24.org>; Thu, 26 Jul 2018 19:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbeGZUs6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 16:48:58 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55822 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbeGZUs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 16:48:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id f21-v6so3030635wmc.5
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 12:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=vcd9IqFUB/no21ifKIdFx0TqKr2aqh+QIeI6nIKRE9s=;
        b=a8n7Y6fJQtw+f+a09c5EUD106n7mnm9E3vWPNk2DakkdUpRtXzHyXsYQgWr1IjNX7Q
         EfkbmWxsw3x3tdiOjYp/JtYinkv41G3TkSzcO3qRDq3rnCNY22f1mIUMlqH0eLuWKqEb
         cazPZDagoWfiP2/UVJLRjyqkQ3hlKfSLcOhonBA60YRBI1Ep+9ui85X8tJZbDdgdmP5M
         mghdUOiDOF1dnTbRITR4o8z7fXeXjjnVK2jWdDrze5VadGHVLdlQCYDuj0kL1Vx1kbGL
         UBdS8apQThxHVYZfxB6/ADKk6Y0ZZ8LcZz5GslFj6e8vp5M1ae6e8K1YbIItnixNVtBN
         +KBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=vcd9IqFUB/no21ifKIdFx0TqKr2aqh+QIeI6nIKRE9s=;
        b=Z7oaqIyU7P/JG6gvvJ79e1SmKV91p/twODwMfgKhAcvqGbg2waSMbJOnR0PB8h3v58
         a73LiA89WUFDChia3P1gflMBjLycEOxUo6H5HsKil8OWSE4WZuMGN74VuaR3hKHquMex
         yDUmCPlWR/8pvIrJFSRS4rsjQcvv66eFaq1Jy8tBsUGB2EO8ZVzICNyr6w1UrCExhH6D
         2pYpxWiafWok3F2F9nx6OdEZXRugBiNqE8Ez1iT47gS9I9pvPXplhpD+PILjUbGGRu9g
         igtWt26bOHk8ku6wCTufIMgjfgp4vG2LphGTpp0ls0OUiOBj4nF8nlTI1UlRm1rTTwse
         jhPg==
X-Gm-Message-State: AOUpUlGwD2ez8sl0u7NMKF2YTG50A3wxQVPgnYSEljq7f6rRrx2menNx
        JLyYYxUDK6poZO3dq8s189Q=
X-Google-Smtp-Source: AAOMgpeYrkrI5pdgRowF+Z/Wi0GXVvB3wL0AJcNZdvmwvSFuDRgwyl4bs7ChMr1FXaZ4p0rLTlg2hA==
X-Received: by 2002:a1c:ea53:: with SMTP id i80-v6mr2588920wmh.113.1532633439704;
        Thu, 26 Jul 2018 12:30:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a82-v6sm4640258wmi.37.2018.07.26.12.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 12:30:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH v5 2/4] add -p: select modified lines correctly
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
        <20180726155854.20832-1-phillip.wood@talktalk.net>
        <20180726155854.20832-3-phillip.wood@talktalk.net>
Date:   Thu, 26 Jul 2018 12:30:38 -0700
In-Reply-To: <20180726155854.20832-3-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Thu, 26 Jul 2018 16:58:52 +0100")
Message-ID: <xmqqmuudpzfl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

An interesting problem you are solving ;-)

> For example given the hunk
>       1 -* a longer description of the
>       2 -  first item
>       3 -* second
>       4 -* third
>       5 +* first
>       6 +  second item
>       7 +* the third item
>
> If the user selects 1,2,4–5,7 then we should generate
> 	-* a longer description of the
> 	-  first item
> 	+* first
> 	 * second
> 	-* third
> 	+* the third item

I understood this example as "3 that is removal and 6 that is
addition are excluded---we consider that these two lines (one in the
pre-image and the other in the post-image) are _matching".  As we
are excluding a deletion, it becomes the common context line, and
any removal or addition that appear before that must stay to happen
before the common context line (i.e. removal of 1 and 2, and
addition of 5, both precede common context line "second") and any
removal or addition that appear after that must stay after the
common context (i.e. removal of "third" and addition of "the third
item" come after "second").

But then it is not clear to me what you mean by "group" below.  What
groups does the above example have?  Ones before the retained
"second" (i.e. removal 1, 2, 4 and addition 5) form one group and
ones after it (i.e. removal 4 and addition 7) form another group?

> Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Is this fixing any bug?  I usually see "Reported-by" only for a
bugfix patch but this seems to be adding a new feature (and lack of
feature is usually not a bug).
