Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A65C1F42D
	for <e@80x24.org>; Sun, 13 May 2018 09:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbeEMJ6w (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 05:58:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54708 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeEMJ6v (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 05:58:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id f6-v6so8782619wmc.4
        for <git@vger.kernel.org>; Sun, 13 May 2018 02:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qZHD3R/LY0jUppx9RWQx2GPgOU37A9r44W7zdSWbnpM=;
        b=rmGTT4evxj09BhWP9X4nUISAf3zG2h5rgXkaynfqxQDiOM5UgqSLrzYb3ORmeFZd13
         C+BsqDe8zilkNdJnw7JU5OgcIzRms7nLak6dNp53vjoU6Hwind3tjDNnh1Z9OXcnxBkN
         HWlGGoNwjFvPa+5qxaWZGB7mQPhnSkUPDkcLAVSuWvPCInWKbhUw2JzbLxGmnMi5arDA
         4yAFpcqlK3bKLW/4oZZLhKXJhFOVznasQyiFnrHqY8M/OIPa/ylnZ1jXycjv5I+KCY0i
         PrA0n8TLdRq154D6ATjiRZ9CqpmtFw3EOBWuhzKksjv9eR3T/9GVjigIKNOgh7kaPZhE
         /eNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qZHD3R/LY0jUppx9RWQx2GPgOU37A9r44W7zdSWbnpM=;
        b=OyGHMEMIzC05yyruIxsaS0aFad0hUwb94ozw3JMokoEDOdMpOMWWH7nxqXacfqnID7
         s8uVhFJ0yzqzLQCkoFFlSA7rhzM9e69iw89jEt70T4L5od43PJs87RSttOZd10LumonJ
         iLMfORKb9kuYZj0aoiXpQGCvrRmsDVTWnlq4Kb+MJX++KpsNwgCw+vdHjQwbbPOq1+/u
         246MH/2X8UWPPaygQdWBCGB+BRuOgMyRwE4xF3KVOrjUdW3iioKRnea5JBzEV/ZHdzFU
         ktstwx762Wi41aWU5tMq2GdMiMniqyOC5UcMYz24hmrWBaPYHjnqAY6cpEMSMrZlsJze
         0pEQ==
X-Gm-Message-State: ALKqPwcsJcZwACAwznLQz1jITGiNu9kRnbLwiSx33ENTNxs0sK4jBdsb
        Q2Q3rvV5/uMTvw59MhflH38=
X-Google-Smtp-Source: AB8JxZrHxkAGywrxAK9cXoeEliKffdBPWQuKsjxgj0jb2cKlPBaTJCo/8soWq6xaIthP63hX6LYYVA==
X-Received: by 2002:a1c:168c:: with SMTP id 134-v6mr2766370wmw.53.1526205530301;
        Sun, 13 May 2018 02:58:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id k28-v6sm9986872wrk.46.2018.05.13.02.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 May 2018 02:58:48 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] config: free resources of `struct config_store_data`
Date:   Sun, 13 May 2018 11:58:36 +0200
Message-Id: <cover.1526204440.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.583.g9a75a153ac
In-Reply-To: <CAPig+cThT3VVw75VF0wuF-yR-xbnfNOxhviYGZLAksF8HFuOGw@mail.gmail.com>
References: <CAPig+cThT3VVw75VF0wuF-yR-xbnfNOxhviYGZLAksF8HFuOGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13 May 2018 at 10:59, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, May 13, 2018 at 4:23 AM Martin Ågren <martin.agren@gmail.com> wrote:
>
>> Introduce and use a small helper function `config_store_data_clear()` to
>> plug these leaks. This should be safe. The memory tracked here is config
>> parser events. Once the users (`git_config_set_multivar_in_file_gently()`
>> and `git_config_copy_or_rename_section_in_file()` at the moment) are
>> done, no-one should be holding on to a pointer into this memory.
>
> A newcomer to this code (such as myself) might legitimately wonder why
> store->key and store->value_regex are not also being cleaned up by this

Good point. I was only concerned by the members that no-one took
responsibility for.

> function. An examination of the relevant code reveals that those structure
> members are manually (and perhaps tediously) freed already by
> git_config_set_multivar_in_file_gently(), however, if
> config_store_data_clear() was responsible for freeing them, then
> git_config_set_multivar_in_file_gently() could be made a bit less noisy.

Yes, that's true.

> On the other hand, if there's actually a good reason for
>   config_store_data_clear() not freeing those members, then perhaps it
> deserves an in-code comment explaining why they are exempt.

Not any good reason that I can think of, other than "history". But to be
clear, a day ago I was as much of a newcomer in this part of the code as
you are. Johannes is the one who might have the most up-to-date
understanding of this.

How about the following two patches as patches 2/3 and 3/3? I would also
need to mention in the commit message of this patch (1/3) that the
function will soon learn to clean up more members.

I could of course squash the three patches into one, but there is some
minor trickery involved, like we can't reuse a pointer in one place, but
need to xstrdup it.

Thank you for your comments. I'd be very interested in your thoughts on
this.

Martin

Martin Ågren (2):
  config: let `config_store_data_clear()` handle `value_regex`
  config: let `config_store_data_clear()` handle `key`

 config.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

-- 
2.17.0.583.g9a75a153ac

