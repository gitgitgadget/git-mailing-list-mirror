Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C08C05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 16:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjBHQlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 11:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjBHQkh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 11:40:37 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A99F4DE16
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 08:40:33 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v10so21248705edi.8
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 08:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pcdn8LwWM1jNcZQjW5HxaSh77h/a6SA8ZMEaVj11/I0=;
        b=Dheokah2JvHDcXifKo6P8l2+vVEgFKnbg0EOQyUQXf6Pnw8StHy3ZJeKYhg6mOUGB7
         QIafoMTIcNrVCWm//rn0RI7F7Pc1yCjrFuPIHeV0It4nBNkeOLq99aSM8Zf4mRyKJrMr
         s7Tkkg+MYwfwEZdWGDuR3+1kMuE8yasRbbQ2/7hfPtk4YKY4MWx9UJNC0VqX6crn7ZP9
         vyTPKvNCuAf8yqqbAf0Lg55IblRZ6z3KvZZKaGqVS4SBBQLxrDJ5BmccFrijD45qvWjm
         AWw2JuaFUcODm76hxnLHzPyggwzau1UFIOT3Tybt6LUVElAaIaivhbSbVW1ffjc1+vpd
         QO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pcdn8LwWM1jNcZQjW5HxaSh77h/a6SA8ZMEaVj11/I0=;
        b=4v4OwM/sfaOCbx6Reo7gwwD0wBr6MfeavRaxYRHKcFDgaaWz+g2SQ4FZSJOat9zoWx
         kHPuZrAJB1CSC/rPe7w+aY8IANcSM9NK/m1vQNGFrUN7DCth9AtVFcWBJ9I2KonNiyBM
         hIkYOpKWiurGTzPB057iKTWAGW23MwMt0tKqQ7aXEVkuYq8OUHZhx2fKbI7WXJg44loK
         mXAnNMt81evuYYd3JHRWL1UUqFRBP3iacD0zl0f1JplX0yFo1/PqyE87h6lEMqs+unOP
         Dk/STsR+FoYE+wevBdsIG1XD/aoQRUdtjQcI19Ne/Jo1slVK3FzBUqHYQECzvFZsAZv/
         Xy4g==
X-Gm-Message-State: AO0yUKWLcA//gSySYx+bskMo6X+OjY/zm9fuKyy0nLQamQXtmfqyMJT+
        qimZHmXyouhxKUrCKRoXZwCk7o+/M0I=
X-Google-Smtp-Source: AK7set8vEhtSDQ9bEuyWnVcYpyUtta0IVzBHdl8gP21au3X3XYxdQTadbrfoNa0I25tFOYGrSNQr+Q==
X-Received: by 2002:a50:d61b:0:b0:4aa:a6a9:3736 with SMTP id x27-20020a50d61b000000b004aaa6a93736mr8801388edi.18.1675874431830;
        Wed, 08 Feb 2023 08:40:31 -0800 (PST)
Received: from [193.171.177.145] (miladpc.ai.meduniwien.ac.at. [193.171.177.145])
        by smtp.gmail.com with ESMTPSA id h23-20020aa7c957000000b00487fc51c532sm8103416edt.33.2023.02.08.08.40.30
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 08:40:31 -0800 (PST)
Message-ID: <8b445d23-245d-d6c4-b4a2-d6f3de9051a7@gmail.com>
Date:   Wed, 8 Feb 2023 17:40:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     git@vger.kernel.org
From:   Konstantin Hebenstreit <konstantin.hebenstreit@gmail.com>
Subject: Bug Report git worktree
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git developer community!

I'll just do a very simple small bug report.

I tried to use the git worktree command in vscode today.
vscode version: updated
git version 2.34.1

I created a worktree inside vscode, inside the extension gitlens by 
right clicking on another brach and selecting worktree.
This was not working immideately, so I first created a new folder 
(../new_folder) where I then linked the worktree to.
This was working fine. git worktree list showed both locations with 
their respective two branches.

Then I switched to the new_folder, using 'pushd'.

Bug 1)
In the Explorer field of vscode I did still see the files as they were 
before changing directory. Even if I reloaded it.
But in the shell of vscode I saw the files as they should be (as they 
are on the branch which is tied to the new_folder).

Bug 2) more problematic
worktree overwrote my settings.json file.
file:  .vscode/settings.json (not tracked by git)
Could be because the Extension 'cSpell' overwrote it. I was adding two 
new words to its dictionary, which is saved inside the settings json.
What I am left now is a settings.json that contains only the 
cSpell.words dict with two words in it. My original settings.json is gone...

Not that much of a problem, but inconvenient, as a cannot get it back, 
since git did not track it...

Hope this helps in some way!

Best,
Konstantin

