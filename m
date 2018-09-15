Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E8341F404
	for <e@80x24.org>; Sat, 15 Sep 2018 11:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeIOQ2e (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Sep 2018 12:28:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41849 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeIOQ2e (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Sep 2018 12:28:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id l26-v6so9898864lfc.8
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 04:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ch6IEpmkQi6+ynd0FAF7s2O/K8Pk6/UMBcMvUtGrgew=;
        b=DiKVR3BB4u0bHWb1h5ZWuKRBFz7xMv9ljuTaX+20bIPfgg2Kp4mlT3lCy9D20vy2Uk
         U4NaknTnO4Z+8U5VJBYy6aiJCLkBadBJN2MwPHyUuUfTol3toBgQYpFULJK/i1Pl87Rk
         cC0C2KB4BMADOQQqZnMjagwxJ0WvNN+EBJ8Y2TQMqYMt/+DbpV2HHJ5iJzeHAGttejUb
         +0iiFaCUoFA0YjaA7j6LJkQXap2G1AiJLjm8emt1M3B564MhbpvWr+AgyGNBBzpjCcDg
         8w9e9xhv1Ga/NVmEImeX0cf8KgBBnQ3s7l5zgm/AknxyXKF80XnXFGPjnpuYFOWKdVlU
         PI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ch6IEpmkQi6+ynd0FAF7s2O/K8Pk6/UMBcMvUtGrgew=;
        b=a44aovaVThi+U5qimySCAw6qIYMfXvK2+77ZxOG82pHXNlqDILX3vZs+q5a8VWZIlZ
         cOQUP5joZVoVrSvhqb6orh5WGH/wxjiyZgKjwCpQcJwulwH92A2usOVJWEYKYOhXht/l
         72MevLrAIyuiiL14lwmAE3XMeiIVGIXnrUbPW3N/8lAgZcBbJ1hVBahD1HQl4KqHZlf2
         HpahlJ6wVpx9D5xmQZBX7vZZ0C8KklRNcEAu0IHmfARZoyZIXS56QD8aaiXCBe4Tb4i6
         V2TfH1iU2S30aC2vYZovJb3672OeEeBdJaDvovRGOjXHOAgRZavX5LdziQd05Q8C8x1s
         uUWQ==
X-Gm-Message-State: APzg51Bs8jIIXHJ2DJhRYI+lwGFZ1YmS0MdwfuFdR44+8vio6XyMIDXZ
        lruQLZ+ZU2NFy6sa30YvTi8=
X-Google-Smtp-Source: ANB0VdZO9hvivfEpKb2l8PvUlK7a+iwpAALpEIhRPzSCplAB8v3/wao4VaKp5LTTKj9yJe7ebQfiQg==
X-Received: by 2002:a19:1517:: with SMTP id l23-v6mr11627950lfi.69.1537009795357;
        Sat, 15 Sep 2018 04:09:55 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id q15-v6sm1655510ljh.34.2018.09.15.04.09.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 04:09:54 -0700 (PDT)
Date:   Sat, 15 Sep 2018 13:09:52 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v5 3/5] read-cache: load cache entries on worker threads
Message-ID: <20180915110951.GA17817@duynguyen.home>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180912161832.55324-1-benpeart@microsoft.com>
 <20180912161832.55324-4-benpeart@microsoft.com>
 <CACsJy8CUsOLy_OWdJbx5TqyzPJ5eZ0QcrJniQ82nAiwwtk9iyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8CUsOLy_OWdJbx5TqyzPJ5eZ0QcrJniQ82nAiwwtk9iyA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 15, 2018 at 01:07:46PM +0200, Duy Nguyen wrote:
> 12:50:00.084237 read-cache.c:1721       start loading index
> 12:50:00.119941 read-cache.c:1943       performance: 0.034778758 s: loaded all extensions (1667075 bytes)
> 12:50:00.185352 read-cache.c:2029       performance: 0.100152079 s: loaded 367110 entries
> 12:50:00.189683 read-cache.c:2126       performance: 0.104566615 s: finished scanning all entries
> 12:50:00.217900 read-cache.c:2029       performance: 0.082309193 s: loaded 367110 entries
> 12:50:00.259969 read-cache.c:2029       performance: 0.070257130 s: loaded 367108 entries
> 12:50:00.263662 read-cache.c:2278       performance: 0.179344458 s: read cache .git/index

The previous mail wraps these lines and make it a bit hard to read. Corrected now.

--
Duy
