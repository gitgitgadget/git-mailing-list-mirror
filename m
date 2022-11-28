Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2842DC43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 23:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiK1XaF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 18:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbiK1XaD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 18:30:03 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0E9317F0
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 15:30:02 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id d14so3294609ilq.11
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 15:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7nzT0DsJSUVKCS+qQ3Dmo/stMCVUSlFCcQ6YzJXhcXA=;
        b=0ynSbujlRgIf0UbXImC3kz1YlbLrFDCDs1jY3c132I9dtW5GFH9UnTfBS4qnXnptDI
         o/vtqDK9OrsJ25acQd/NpnlTkkUH0V9kAzO4TrQjvPXDiSgteBjRAQXSkUrpZZToVHSf
         aWY9R3Z4ExakTotT8g/i8i3hiyf/hAOfIC09sblIQVTA7Ed6tyR40gZWf10AK4mZm/Xi
         zPG+aDrOe3rLgb/QADIiMFcZ78I3X9V3pFLiHIw2l2OUtIReIWhldsVCqpdRZUF8MLZ7
         Il4uIw7hj3lN4Mh5tSO7pJ8R7DgiL1nFPJG1yT7CvSoM0W7xwGUglgW7YnDr3uNJA/bO
         AElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nzT0DsJSUVKCS+qQ3Dmo/stMCVUSlFCcQ6YzJXhcXA=;
        b=mUZcvmfUWpaJ0KihmB53lApWpoPFDEyBQw/4xIa0sKy9nX907LVptQ5Lx39tSWMLca
         xkOmoCYIWocS8wLFjrQqopU44bzbR66lvIFrB7LtqIxAR9SH+uYDJq0Q6oQQNQvqEuyD
         3IbLUJTKxjG/RtL/O0MQjyIAFNzEXXk504+M9J0k2puTnCbnKIWQM0zgt1zuxAS7ux1P
         TwY5JAZY9l8/7YUZF/bkxzMjppQT55FFBhVMxXss0d/j7zKl8LDqOzKQvPR6Ztb3+Guy
         nwBfsTwHAaw+l6euXj4xYUJevo6K2LRn73ff56ZJazmEX6xOhSARA6yMxGn2lcCX0qA4
         BL5g==
X-Gm-Message-State: ANoB5pmIs0RuNVrR+/kzF+n3zNfJHVT/Kd4muaflfZeXtN5y3TAyms6Q
        ug454ncBN92fsW1VkUpIulbqTA==
X-Google-Smtp-Source: AA0mqf4cKtenUsyOVPTpRub5WSup+tGcjc+VmzEbs1Z9Jf6JgmVVMMyuykUe/GPcWBd5/4F5pARa0g==
X-Received: by 2002:a92:2c03:0:b0:302:a769:f7b6 with SMTP id t3-20020a922c03000000b00302a769f7b6mr15396595ile.120.1669678202321;
        Mon, 28 Nov 2022 15:30:02 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c18-20020a92d3d2000000b00302e177985fsm4188484ilh.25.2022.11.28.15.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 15:30:01 -0800 (PST)
Date:   Mon, 28 Nov 2022 18:30:00 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v5 0/4] pack-bitmap.c: avoid exposing absolute paths
Message-ID: <Y4VEeIC+iInY4MuB@nand.local>
References: <cover.1669032425.git.dyroneteng@gmail.com>
 <cover.1669644101.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1669644101.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2022 at 10:09:49PM +0800, Teng Long wrote:
> From: Teng Long <dyroneteng@gmail.com>
>
> Changes since v4:
>
> * [3/4] Reroll the commit message.
> * [4/4] Reroll the commit message and remove the initialization of 'found'.
>
> Besides of 3/4 and 4/4, the 1/4 and 2/4 seem already in 'next' as
> 8ddc06631b184e6f43051f7ea8ac9bbc86817127 and
> 2aa84d5f3ea1966a81477ad31bee0136e39d3917 , but I send again here just for
> the completeness of the patchset, I think it will be nice to merge Peff's
> commits of there are no new suggestions.

As you note, the first couple of patches are already in 'next', so those
do not need to be queued again.

But the latter two patches look good, and are ready to go.

Thanks for continuing to work on this :-)..

Thanks,
Taylor
