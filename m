Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B655AC433F5
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 23:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240583AbhLEXKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 18:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhLEXKt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 18:10:49 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E61C061714
        for <git@vger.kernel.org>; Sun,  5 Dec 2021 15:07:22 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id z6so8470287pfe.7
        for <git@vger.kernel.org>; Sun, 05 Dec 2021 15:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version;
        bh=ZIGdshnyPK4D64zY6EgYIxDLyeLUn+JHN9OxfkuSSJM=;
        b=Rn/XZtEuBvrBKMorcBe5GMiuBGjBCX0NYmQ4DOLJ6Qap5eX+WUhZ2P8VRJNY1UEyTi
         XORfXmIyeI16+Mz53wsv7mqw3X2dHuOmuXXsgcRClffZq4NRWx4MWPx3kFs1sUOc3CQx
         PbqYrzAUduAEdvBpsrBEB2Zv7HgDM905pp2IYug6EKQyqQCnBLA5+UlwoY/w3YQn9Nww
         h02R2b6//KDny4Rvqpz+rmDw3IPmmaj7ziIJ1BJnc5gRGzB2VpYCBdUkKXlqYWBB0crw
         UvgP2C5DpNKswILanwMLVCclprwh6xRIA55jHnIRY6V1jNWGlykEpRrbJqixd3+JmVa1
         JANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version;
        bh=ZIGdshnyPK4D64zY6EgYIxDLyeLUn+JHN9OxfkuSSJM=;
        b=57Bp8sRv8J8FqWcGVoZA0ugCNDTICvXO8PDZK4i+xcdsPlQkYwo0tGjbGXC3m/93cN
         2XfvBls/ONK66auF3wH5qFw0MlQ60hTpHK3BOpqyvpdTQBAAgoJ4Sfjp+kzBK2bwHtHr
         unsEmYeIJhv6OoEY4b7LGkxjLCm6tfjtER7kNMTcuVoVVjiCMrvCEXMglVuUeKcQP11b
         VqV30m0XxXDakM0T+oOYVIXhytS8WCK43gt3HBMm4bDh7s5SUWBJgn1RvPrZtUgEeMXF
         VQwSDf84TFe9FOQHteCs0yx8PI0+KGI+/N0AGSl7oZG0Eu7gz0/UAbKw0zG5zgBGRzL9
         pS3g==
X-Gm-Message-State: AOAM530a8ya1tgMQQmOnlXiZB7/Wxs9J3nmcJ+002HnepadMPEZZMksb
        Ub27Iooe+AzSrNXyhySfezQ=
X-Google-Smtp-Source: ABdhPJxttwoerjLKtlkHerularXoHLS/Oqd1LnG2zwcfVW0Oafq4CYBAg9xk7b0BbDwSziFNofaY8g==
X-Received: by 2002:a63:5f02:: with SMTP id t2mr3699926pgb.453.1638745641307;
        Sun, 05 Dec 2021 15:07:21 -0800 (PST)
Received: from localhost ([2620:15c:289:200:33cd:af64:d2cc:36ad])
        by smtp.gmail.com with ESMTPSA id y28sm9800153pfa.208.2021.12.05.15.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 15:07:20 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] http-backend: give a hint that web browser access is
 not supported
In-Reply-To: <xmqq7dcilsig.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        05 Dec 2021 12:13:27 -0800")
References: <xmqqee6vwj67.fsf@gitster.g>
        <20211202102855.23907-1-jengelh@inai.de> <xmqqee6spz9s.fsf@gitster.g>
        <7r23s082-o3q0-479o-srqn-r45q778s5nq7@vanv.qr>
        <xmqqtufnonor.fsf@gitster.g>
        <34pqs81o-36p6-s416-s791-1onsqo1734oo@vanv.qr>
        <xmqq7dcilsig.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Sun, 05 Dec 2021 15:07:19 -0800
Message-ID: <xmqqwnkiirbs.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jan Engelhardt <jengelh@inai.de> writes:
>
>>>Also, will the real Git clients, which are the primary intended
>>>audiences this program is trying to talk to, be OK if we suddenly
>>>start giving a non-empty 404 page?
>>
>> I am confident enough to say yes. It's not like git-http-backend
>> returned anything previously in the 404 case (like JSON or so),
>> therefore clients could not possibly depend on content.
>>
>>>If any implementations of Git HTTP client this program is serving
>>>(1) uses a 404 response as a cue to decide its next request
>>>(e.g. there may be some "try this URL and if it fails, do another
>>>one" fallback logic)
>>
>> Not sure if they heed Location: headers, but I am not changing
>> that :-)
>
> I was more worried about clients barfing because they depend on
> *not* having content.  They parse the status (404) out, and then
> leave the message part untouched---they may not even read the
> message in full, and that did not matter because there wasn't
> anything to read and discard.  Now we are sending more.
>
> As long as the leftover bytes would not cause problem with the
> action they take after that step, we would be OK.

In any case, the patch in question seems to fail t5561.

$ cd t && sh t5561-http-backend.sh -i -v
Initialized empty Git repository in /home/jch/git/t/trash directory.t5561-http-backend/.git/
checking prerequisite: NOT_ROOT

...
ok 13 - http.receivepack false

expecting success of 5561.14 'server request log matches test results': 
	check_access_log exp

--- exp.sorted	2021-12-05 23:05:09.418684299 +0000
+++ access.log.sorted	2021-12-05 23:05:09.422684296 +0000
@@ -1,33 +1,33 @@
 GET  /smart/repo.git/HEAD HTTP/1.1 200
 GET  /smart/repo.git/HEAD HTTP/1.1 200
-GET  /smart/repo.git/HEAD HTTP/1.1 403
+GET  /smart/repo.git/HEAD HTTP/1.1 403 -
 GET  /smart/repo.git/info/refs HTTP/1.1 200
 GET  /smart/repo.git/info/refs HTTP/1.1 200
-GET  /smart/repo.git/info/refs HTTP/1.1 403
+GET  /smart/repo.git/info/refs HTTP/1.1 403 -
 GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403
-GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403
+GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
+GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
 GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
-GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 403
+GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 403 -
 GET  /smart/repo.git/objects/01/494420155a3f7587b6c26d06a55b1a8bbef2f4 HTTP/1.1 200
 GET  /smart/repo.git/objects/01/494420155a3f7587b6c26d06a55b1a8bbef2f4 HTTP/1.1 200
-GET  /smart/repo.git/objects/01/494420155a3f7587b6c26d06a55b1a8bbef2f4 HTTP/1.1 403
+GET  /smart/repo.git/objects/01/494420155a3f7587b6c26d06a55b1a8bbef2f4 HTTP/1.1 403 -
 GET  /smart/repo.git/objects/info/alternates HTTP/1.1 200 -
 GET  /smart/repo.git/objects/info/alternates HTTP/1.1 200 -
-GET  /smart/repo.git/objects/info/alternates HTTP/1.1 403
+GET  /smart/repo.git/objects/info/alternates HTTP/1.1 403 -
 GET  /smart/repo.git/objects/info/http-alternates HTTP/1.1 200 -
 GET  /smart/repo.git/objects/info/http-alternates HTTP/1.1 200 -
-GET  /smart/repo.git/objects/info/http-alternates HTTP/1.1 403
+GET  /smart/repo.git/objects/info/http-alternates HTTP/1.1 403 -
 GET  /smart/repo.git/objects/info/packs HTTP/1.1 200
 GET  /smart/repo.git/objects/info/packs HTTP/1.1 200
-GET  /smart/repo.git/objects/info/packs HTTP/1.1 403
+GET  /smart/repo.git/objects/info/packs HTTP/1.1 403 -
 GET  /smart/repo.git/objects/pack/pack-977dd2d10981235a806ccc52cc769a44e75c889e.idx HTTP/1.1 200
 GET  /smart/repo.git/objects/pack/pack-977dd2d10981235a806ccc52cc769a44e75c889e.idx HTTP/1.1 200
-GET  /smart/repo.git/objects/pack/pack-977dd2d10981235a806ccc52cc769a44e75c889e.idx HTTP/1.1 403
+GET  /smart/repo.git/objects/pack/pack-977dd2d10981235a806ccc52cc769a44e75c889e.idx HTTP/1.1 403 -
 GET  /smart/repo.git/objects/pack/pack-977dd2d10981235a806ccc52cc769a44e75c889e.pack HTTP/1.1 200
 GET  /smart/repo.git/objects/pack/pack-977dd2d10981235a806ccc52cc769a44e75c889e.pack HTTP/1.1 200
-GET  /smart/repo.git/objects/pack/pack-977dd2d10981235a806ccc52cc769a44e75c889e.pack HTTP/1.1 403
+GET  /smart/repo.git/objects/pack/pack-977dd2d10981235a806ccc52cc769a44e75c889e.pack HTTP/1.1 403 -
 GET  /smart/repo.git/refs/heads/main HTTP/1.1 404
 GET  /smart_noexport/repo.git/HEAD HTTP/1.1 200
 GET  /smart_noexport/repo.git/HEAD HTTP/1.1 404
@@ -46,8 +46,8 @@
 GET  /smart_noexport/repo.git/objects/pack/pack-977dd2d10981235a806ccc52cc769a44e75c889e.pack HTTP/1.1 200
 GET  /smart_noexport/repo.git/objects/pack/pack-977dd2d10981235a806ccc52cc769a44e75c889e.pack HTTP/1.1 404
 POST /smart/repo.git/git-receive-pack HTTP/1.1 200 -
-POST /smart/repo.git/git-receive-pack HTTP/1.1 403
-POST /smart/repo.git/git-receive-pack HTTP/1.1 403
+POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
+POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
 POST /smart/repo.git/git-upload-pack HTTP/1.1 200 -
 POST /smart/repo.git/git-upload-pack HTTP/1.1 200 -
-POST /smart/repo.git/git-upload-pack HTTP/1.1 403
+POST /smart/repo.git/git-upload-pack HTTP/1.1 403 -
--- exp	2021-12-05 23:05:09.410684305 +0000
+++ access.log.stripped	2021-12-05 23:05:09.422684296 +0000
@@ -31,23 +31,23 @@
 GET  /smart/repo.git/objects/01/494420155a3f7587b6c26d06a55b1a8bbef2f4 HTTP/1.1 200
 GET  /smart/repo.git/objects/pack/pack-977dd2d10981235a806ccc52cc769a44e75c889e.pack HTTP/1.1 200
 GET  /smart/repo.git/objects/pack/pack-977dd2d10981235a806ccc52cc769a44e75c889e.idx HTTP/1.1 200
-GET  /smart/repo.git/HEAD HTTP/1.1 403
-GET  /smart/repo.git/info/refs HTTP/1.1 403
-GET  /smart/repo.git/objects/info/packs HTTP/1.1 403
-GET  /smart/repo.git/objects/info/alternates HTTP/1.1 403
-GET  /smart/repo.git/objects/info/http-alternates HTTP/1.1 403
-GET  /smart/repo.git/objects/01/494420155a3f7587b6c26d06a55b1a8bbef2f4 HTTP/1.1 403
-GET  /smart/repo.git/objects/pack/pack-977dd2d10981235a806ccc52cc769a44e75c889e.pack HTTP/1.1 403
-GET  /smart/repo.git/objects/pack/pack-977dd2d10981235a806ccc52cc769a44e75c889e.idx HTTP/1.1 403
+GET  /smart/repo.git/HEAD HTTP/1.1 403 -
+GET  /smart/repo.git/info/refs HTTP/1.1 403 -
+GET  /smart/repo.git/objects/info/packs HTTP/1.1 403 -
+GET  /smart/repo.git/objects/info/alternates HTTP/1.1 403 -
+GET  /smart/repo.git/objects/info/http-alternates HTTP/1.1 403 -
+GET  /smart/repo.git/objects/01/494420155a3f7587b6c26d06a55b1a8bbef2f4 HTTP/1.1 403 -
+GET  /smart/repo.git/objects/pack/pack-977dd2d10981235a806ccc52cc769a44e75c889e.pack HTTP/1.1 403 -
+GET  /smart/repo.git/objects/pack/pack-977dd2d10981235a806ccc52cc769a44e75c889e.idx HTTP/1.1 403 -
 GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 POST /smart/repo.git/git-upload-pack HTTP/1.1 200 -
 GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 POST /smart/repo.git/git-upload-pack HTTP/1.1 200 -
-GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 403
-POST /smart/repo.git/git-upload-pack HTTP/1.1 403
-GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403
-POST /smart/repo.git/git-receive-pack HTTP/1.1 403
+GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 403 -
+POST /smart/repo.git/git-upload-pack HTTP/1.1 403 -
+GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
+POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
 GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
 POST /smart/repo.git/git-receive-pack HTTP/1.1 200 -
-GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403
-POST /smart/repo.git/git-receive-pack HTTP/1.1 403
+GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
+POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
not ok 14 - server request log matches test results
#	
#		check_access_log exp
#	
