Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E39C2D0A3
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 00:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B88F520754
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 00:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V24BRSEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439618AbgJ0AOc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 20:14:32 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53733 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411058AbgJ0AOa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 20:14:30 -0400
Received: by mail-pj1-f68.google.com with SMTP id g16so4099738pjv.3
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 17:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vglOqTAowjAXnI+4dGv5aZ6ZrD0bzQtFxs19QEsmyk8=;
        b=V24BRSECpP7sUhkLGu9sTaSO5DT0E8cdbhIcyD5E46QqrczBDdvpzsn5pZy60tc9E9
         ToziE0eVnBtCoj6QkCf06K9NufzULE+0atjLGeODqvGdKMqd2CyElHiOMq2oBzz/lYqZ
         PT+wsIoEO5kPVSJELOQJBQbfs8bSooJ1rVFQhNZnHqIuR+Ibi9v6I9HrbTQDmly+/vBa
         Dl2h4U77d6Ib00LNW3UbNdNLF0aXocHvkOoH5QOnWH7yt+BdOivWTF9u4FQyeIjES+vs
         jspchnLU3G/VPMPePCa2S6tiIy6Vq4R3xkqR+cWR+sa8sJV8rPfY9uI3OWHAUMklTu6D
         hJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vglOqTAowjAXnI+4dGv5aZ6ZrD0bzQtFxs19QEsmyk8=;
        b=T54IWAKoNvEBssT+npZIvaeI/L+SG7++BxbOOqqY7yJCsNmQtVVXjzBtAD+X27N0Wn
         7zj0CX3FYwqYLPszug6o9xH+wtD+EIK0QL9lCzGjbRL+c7VfXt2mBIjy06uGuqFeYDRo
         gHmlKhQvlGovloSuONkwvqWQxWAwPG2K461iQ/uuXanF/L0XNbZPduC197WcOR2FSVJF
         3YwbxjCa1V+WE17n2cw2gvOPrKRy8d+PnoXg2U4DE8H3aPHtXOfXJxf6aIw7wb+4BiLW
         m3zAYg7cOPJ9mQDBx/sESbT+DDfVrdxHn7Y0SgoaflqyClMuE87AteCyHPfQUkufbW50
         1reg==
X-Gm-Message-State: AOAM533WdZXHO890ThiDMDkTLSpyIqeM3BSfmQJpBAoPDyUsckN03tWh
        Vp7/rD1mMf4ajGXp8yrTJSHaNQYv284=
X-Google-Smtp-Source: ABdhPJx37GFX8jcnF3IJrB/JFXxiyHuRaA7nkO84p4ISac3Lva7dGPKEuPvCWtOf4VMfm715CUg1Jw==
X-Received: by 2002:a17:90a:cb91:: with SMTP id a17mr18386060pju.220.1603757670396;
        Mon, 26 Oct 2020 17:14:30 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id 5sm2111769pfn.83.2020.10.26.17.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 17:14:29 -0700 (PDT)
Date:   Mon, 26 Oct 2020 17:14:27 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Joey Salazar <jgsal@protonmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [OUTREACHY][PATCH v2] t7006: Use test_path_is_* functions in
 test script
Message-ID: <20201027001427.GG2645313@google.com>
References: <KHJW7elqEfVsIp1V0WKPRVAB5xqCDJjjqLv8flthlDiSsSWjND-VVGG2zL-xOYMstk-q0JR3OiSggcMlFgzkIKm2podjzAyamb0pW-wx1ZY=@protonmail.com>
 <20201026205028.GC2645313@google.com>
 <xmqqwnzcd6jf.fsf@gitster.c.googlers.com>
 <Bgt8H4Cev0hu-OKtYHazhsRRIFO_6bAoBqdc4tep09T98tL426R9WXIAMjm7aO4b0uPrZGldPhZ1mV3f9pbS3PDN4bOlb9JkUvvXKtnUFHA=@protonmail.com>
 <20201026220228.GD2645313@google.com>
 <AwF-WVCPGK9qyy3lWQ-aYXuvw7HTPjjGuvT4rbPjgoWZE0czToIU-aACj2oyRnkOevGWLQbDgtndt9dkMSGF-SFkNanPgao9yLuVYU1VURI=@protonmail.com>
 <XDwhHkxbkjL46BTp1WCJ5gJ3UbrMxRGwR2VgeRxehZh0-G07JlxCHrBGCpruqk-OegVspO6LJ0Y3yW9izl97pufYDwOhGaS885_xaVK63vs=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XDwhHkxbkjL46BTp1WCJ5gJ3UbrMxRGwR2VgeRxehZh0-G07JlxCHrBGCpruqk-OegVspO6LJ0Y3yW9izl97pufYDwOhGaS885_xaVK63vs=@protonmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joey Salazar wrote:
> On Monday, October 26, 2020 5:00 PM, Joey Salazar <jgsal@protonmail.com> wrote:

>> Modernize the test by replacing `test -e` instances with
>> `test_path_is_file` helper functions, and `! test -e` with
>> `test_path_is_missing`, for better readability and diagnostic messages.
>> For instances when `${if_local_config}` is either '' or '! ' then
>> `test_path_is_file` will diagnose the directory and print a message if
>> and only if the result `is false` goes away.
>
> If `if test -n '$pager_wanted'` is checking if pager_wanted=true
> before diagnosing core.pager_used, then would;
>
> For other instances when '$pager_wanted' is not empty then `test_path_is_file`
> will diagnose the directory and print a message.
>
> be more accurate?

Yes, but because it restates what the patch says instead of describing
the "why", it's at the wrong level of abstraction.

Starting from

    t7006: Use test_path_is_* functions in test script

    Modernize the test by replacing `test -e` instances with
    `test_path_is_file` helper functions, and `! test -e` with
    `test_path_is_missing`, for better readability and diagnostic messages.

I think what would make sense is to add a second paragraph describing
why the existing code uses ${if_local_config} and why what the new
code is doing is better.

Thanks,
Jonathan
