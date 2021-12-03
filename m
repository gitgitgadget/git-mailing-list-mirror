Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F6BC433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 14:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381601AbhLCO7z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 09:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381558AbhLCO7y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 09:59:54 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B25C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 06:56:30 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id de30so3701725qkb.0
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 06:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=O6nzp3caQGeXld6ZFzzm5GMCZiFpTejFZMiloMBzmvA=;
        b=n62yv+lrNBTCqt0mJlJKVj3LQBFG0e4Pmr2loQIrgg3mqta4Le4COR1AIHKeO9rPz1
         tY9URTo1b5OzH15tsHgHUC8FvKHiaJlogDAkw3rGQIDwxTwWjLQ74jJbv43GVLzG8u0n
         pS3msC3L3hpAMO/uGjDnoOuIt1EY/d/DXTzCl+YU/3AAHUWdXsR6LAakBS1lyiWS+ov0
         VHVli8brlX8YyazDp3OeCiMaEyK0AmWF9n36e1MOKVM7crPx7oMOURjwXsEpDWSfV2hQ
         W7tggz1UiMfPxWYAK0X8fBTmwqE9i2eXLUmw2MdcB748C5nZZSGErjBMO1fDsz7OVDx3
         tqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=O6nzp3caQGeXld6ZFzzm5GMCZiFpTejFZMiloMBzmvA=;
        b=E0N49Os7qip8b6h2cm51cU+zVh5Yu/aNnaJC34CTqt7k4mQZCQKmPmXsKX/YtGgBdx
         ZjYfTdjYNfvVI/XIMRWs0s9znOHkbBKts1niCnHPBaJeb/5ysJr/jJMBTIw805h70wBO
         cQV+r5ONj0sT/I3Iyh0qqhkcFL82YlB15/dNTJQEaAp1fp6/out9PnSIVUD9n9bLJbzS
         IGGIuraiPuC7HWc1c3X3EAtP3QINAt+bsE8fhNUhuJr7XmjjbGH6QG+txFnK+rEpBL1m
         2jUhbfNJ+zg0pRq+1W4u+6xFbgp3LWv6VbjQuHRjrxHmJksoS2DeRe+MrQKvSPRSWlqw
         c9nQ==
X-Gm-Message-State: AOAM533xB2EjsiFegf/wHP5aEITaGiCRmx8mDyMuSDeBhqCIlnoSj3f1
        AjSqkm32BnjRPWkRepcWtgE=
X-Google-Smtp-Source: ABdhPJyqrzMeZcEIyGhDWc2/BHdQLHtCiyIOgo73RPOEpdWSqYyB6SXy7OBIes1ZI17VaNTUJZl6Ag==
X-Received: by 2002:a37:9d53:: with SMTP id g80mr18167240qke.12.1638543389757;
        Fri, 03 Dec 2021 06:56:29 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id u11sm2067626qko.119.2021.12.03.06.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 06:56:29 -0800 (PST)
To:     Git mailing list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Subject: t7900 failures when $HOME is symlinked
Message-ID: <4cf14040-c8e1-0f75-0ec4-fd8cf6bed0a5@gmail.com>
Date:   Fri, 3 Dec 2021 09:56:28 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

I noticed two failures, t7900.32 and t7900.36, on a system where
$HOME is symlinked, i.e.

     $ cd $HOME && pwd
     /home/me
     $ pwd -P
     /some/other/path/me

These two tests use 'pfx = $(cd $HOME && pwd)', so $pfx is '/home/me',
but the actual path that gets written by Git is canonicalized, i.e.
'/some/other/path/me'. I think a simple fix would be to use 'pwd -P'
instead, which fixes it for me.

Cheers,

Philippe.
