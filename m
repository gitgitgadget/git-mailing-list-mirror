Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165B6C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 05:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84D2611C5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 05:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhKIFWs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 00:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhKIFWr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 00:22:47 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA129C061764
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 21:20:01 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id y1so18799661plk.10
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 21:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JTuenkAFUbQKlmGdCQAYPpRAstlE12ijtCGbq14UD3o=;
        b=cpf3SitumiBtDQsEOGVxOyGFsa6NDg06NtYHYOEIa9MA5AZ9ZC37Xq2wYyAKl/oqBd
         xCv/QE2QuztZnzZcsmZBAOLdD3emgwtG/LjznWkiyHiPLltuEImLPnX8LpT7p9mcliT8
         v8AZKqvB58S+o8zIrUKqfXqj0s9czzFCMJp2MMwo1yVkr4Z8TjsVxw5RjHGuJ02YWtT7
         EO29YmpeVowzICpD48dTBUZ0spuRa9vCQ/ZN8nYxjQzmn+e9PUovGh8fQgr925WLYzch
         74uwwjErNu1wcYQLUB/wqyTiH5EkT5JNzEuahlM3yQz/1c8YTWZYkPqOYzZ8lE3nRjve
         IFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JTuenkAFUbQKlmGdCQAYPpRAstlE12ijtCGbq14UD3o=;
        b=mB7skpty++0BHkpOQv5pM+zP5QrUk42ZvykuRP8s+w2Xn5iPaBrFOWrQD2HX8WXMwF
         NaAwQRAuHhAX6JeqYYT5U540MPpQrebm+v9yBsgMNCUfayvwn2Iu/HxAphQlZePbxHLN
         OWH1w5GHfSBpn7z9omiucxFdRxzat7r8yplrOxDefGRW4pcYWAuplBgx9totXmdbI5UV
         yD+chqj7yVU/JUv/U/5zEEikSkJUXgyRllxmrRck34Fqiy6oHgQUfkCHoesDGCzN/duv
         KThZ+2OYJ6wEmTV047rS6Bc9KNAxayrRGQIzZKukxAz7Tl+Wcx9duw8heQo/Zxiq6klQ
         KHjA==
X-Gm-Message-State: AOAM530PpFHnzXxqlbd8wNwzDhImh3CwMaETrbKSJcMib+cl3WxurUBD
        4cgaLuPSHG/5TIJBfKz5Gek=
X-Google-Smtp-Source: ABdhPJyna4mvKl3m8mUAiwT7Q8QLJp6k9uxhN+B6Rt0Pg3JV+Tt/bFF4oHFeaFV8KVlmHlJ3AumtcQ==
X-Received: by 2002:a17:90a:df97:: with SMTP id p23mr4270970pjv.3.1636435201410;
        Mon, 08 Nov 2021 21:20:01 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-88.three.co.id. [180.214.233.88])
        by smtp.gmail.com with ESMTPSA id t16sm1024339pja.10.2021.11.08.21.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 21:20:01 -0800 (PST)
Message-ID: <a1acda2b-7cd0-0c1a-8c60-681d79418872@gmail.com>
Date:   Tue, 9 Nov 2021 12:19:36 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3 1/2] fetch: Protect branches checked out in all
 worktrees
Content-Language: en-US
To:     Anders Kaseorg <andersk@mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
References: <alpine.DEB.2.21.999.2111081514460.100671@scrubbing-bubbles.mit.edu>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <alpine.DEB.2.21.999.2111081514460.100671@scrubbing-bubbles.mit.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/11/21 03.15, Anders Kaseorg wrote:
> As a side effect of using find_shared_symref, we’ll also refuse the
> fetch when we’re on a detached HEAD because we’re rebasing or bisecting
> on the branch in question. This seems like a sensible change.
> 

We can say "we'll also refuse fetching when we're on a detached HEAD (for 
example if we're rebasing on the branch in question or bisecting)."

-- 
An old man doll... just what I always wanted! - Clara
