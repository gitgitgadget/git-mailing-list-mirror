Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86126C6FA8E
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 18:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCBSoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 13:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCBSoX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 13:44:23 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7CB21291
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 10:44:19 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p6so315782plf.0
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 10:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EFZoLt56/W2iIIcutYriSZWCgxCvj1On+F7YdpCm/fQ=;
        b=YF5GUHHVxd200wmJ/mshOQ8U5YTnmeCSmpKvijxKCVFsdDEJApQPHvOl7+BaGGKGFt
         O4GS2NPlVbaoPrRuQ/F6JVqv8POFiVQYGKrb3eem0JJAf/FXFLCq2327Nv5cvVlQB0rz
         xyQLuImlA4BzrAM79LCFXHx30KwO1jQOqIBYPMyL4lOyBhJYRbNWeqQp0afe2BhF9oLd
         WEtxd/ZBe7T6mtupZ5mc7v2/jciajgl6q+MbkimuZjoLfsfcyz5ACIvEaf5KT432Skjl
         ZUCY9AfrVV6r4kt9Wbxs2wJmXLeJ8vbMn41mMOdulG10Kziuvi10KmuLs/+SveL6BJ2A
         aXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EFZoLt56/W2iIIcutYriSZWCgxCvj1On+F7YdpCm/fQ=;
        b=5S6eMXrX+vw66RMsNURKKM3Qpq6pVWob/HW9C6Gv9+Qb5jbQIHX89Sg5LNBW271kFI
         EZBGOVsznkx8Kue28G7yT0iZ4U70ZlIxJmylnP6lEBHpKb/dWxltzpW2saIiz/pk2r7T
         0vl9sdXIjsvEpIXA8JeJ0sAh9Cq/+PCxZNM98p/0Fnv+uhHwj3oSkkwTt7MVAYFMIlcM
         a1vR38t3e6Gqi4OffYHZCcVEXnto9bH7SKVNKrWgq3hKeq7+2DFg6qPGu8W+ORpQ9HPa
         yiOgOhjf9mQpyWFazxkHl5w4Qm1pA50XER6kKGlqWoNhzr7g5/A/D2FNvxiWB/qxMUlV
         VoEw==
X-Gm-Message-State: AO0yUKWDuO3qmRWgTT3FlxmDyiWU8PE1nCYG+/WDCywolSGbzp2zmLCB
        p4qxtqFz94iAHvlzIgWkgmY=
X-Google-Smtp-Source: AK7set8cQIRcyaHFUog+7kk0vk4X0bbeOuIeKpcLm571X0R4uGG1sbbDQyITEl6fUgqfq2zfyjoV8A==
X-Received: by 2002:a05:6a20:3949:b0:c7:1bae:876e with SMTP id r9-20020a056a20394900b000c71bae876emr13592956pzg.36.1677782658924;
        Thu, 02 Mar 2023 10:44:18 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7820f000000b005d4360ed2bbsm8506pfi.197.2023.03.02.10.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 10:44:18 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Git List'" <git@vger.kernel.org>
Subject: Re: [Failure] Re: git 2.40.0-rc1
References: <000001d94d26$1e52a910$5af7fb30$@nexbridge.com>
Date:   Thu, 02 Mar 2023 10:44:18 -0800
In-Reply-To: <000001d94d26$1e52a910$5af7fb30$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Thu, 2 Mar 2023 11:43:23 -0500")
Message-ID: <xmqqh6v3j8n1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> Git 2.40.0-rc2 was a regression from rc1. The following new tests failed:
>
> t3206 - virtually all subtests failed. An example of this failure is a
> results comparison in subtest 1 (seemingly relating to abbreviation):
> + test_cmp expect actual
> --- expect      2023-03-02 16:39:23 +0000
> +++ actual      2023-03-02 16:39:23 +0000
> @@ -1,4 +1,4 @@
> -1:  4de457d = 1:  35b9b25 s/5/A/
> -2:  fccce22 = 2:  de345ab s/4/A/
> -3:  147e64e = 3:  9af6654 s/11/B/
> -4:  a63e992 = 4:  2901f77 s/12/B/
> +1:  4de457d2c0d218f48d66f45f9b30f3aa62562105 = 1:
> 35b9b25f76d404d09a23e6c8efa96c3ce19e19aa s/5/A/

Are any big endian machines involved?

cf. https://lore.kernel.org/git/Y%2F+paI8WGSmEbv%2Fw@pobox.com/
