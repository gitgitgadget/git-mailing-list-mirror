Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D1BC433F5
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 22:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355779AbiDZWra (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 18:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245546AbiDZWr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 18:47:28 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8FB187465
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 15:44:18 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id g21so451223iom.13
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 15:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=zM6n5Bung/E13YzEIHznYnr1KMPe//yCig3MQKTzwkU=;
        b=amhHST5h/OBxWmKHRErzz3A0jWVrqE2ju9XEZUEgd2ftSYqXqMtaIhPONz3eazwjv+
         qqjPiABUr9lL6+mAOQGLXa3XsonGUkbF3Do6ygEy/3PSYObQVzQVObq/VygknmECiLVL
         V3TnZ4bziFz3EjtIL9iBjEJhdgLXgR2s2K8UfdMMJaZGZRPEF+czcET439U5GMKzoe+k
         gI26cCzXmHw8uRmrDDHLaeeefvVCjbwHBrNY1cDyIOMULIhMhEt3E0eOq5NKW2jwiUHN
         55JpjpOhCKgR5F1eWW4SWvaL8ZN/9eiLswHPN5W+q3VMl2pbaghGZQ7AG+vihSAnY8hD
         YVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zM6n5Bung/E13YzEIHznYnr1KMPe//yCig3MQKTzwkU=;
        b=Clibp96119Li2637CSP7NvL0hxkmjZSli1nhqRnQKoloBNY8A/nG5yqdpsX/g2KTza
         n04/mSwVJcQxTqucJ/mpSSdc0wHwGK5IMj250ZSuwSDfrfMKjsQvvmIm/XHPOSY0O9o/
         SSo8qGfM8RXip4Pv6BoGOptyvbU8NHWvnl5OoecWjrB/t6wCcQLA8p25m7Wgfkl9CUSy
         2BeV1OCNRrOfgBJuvnFUebmnIcDY+/SvL77tpNDd8aGsaYlqg/MXJHQ+ac50/2bA4LG9
         J1xIuHjAEjud/PZYxQJl+WPTvWpCP3D+Zw3oR9FIvlKb8I/8EIUguHs9lfBf7Za/mcPn
         w2yQ==
X-Gm-Message-State: AOAM531CULXqHD0JFajTOyhpMwFRWj6FuqCLvK6BULLwVrzjD1BjvTvh
        +e/v/PdXmhNwwNKIhSCuyPpeHMgpwkmYwKmeViXXoUip0aI=
X-Google-Smtp-Source: ABdhPJx3UfAVtxwopNexNNgVlTr9elKOZps6oxLRD6vthmO36//B3hGPZAR+iMSljUL0RihqMKGfITCUu8NaqYamVsw=
X-Received: by 2002:a05:6638:2588:b0:32a:beec:a5cc with SMTP id
 s8-20020a056638258800b0032abeeca5ccmr10306612jat.191.1651013057181; Tue, 26
 Apr 2022 15:44:17 -0700 (PDT)
MIME-Version: 1.0
From:   David Calkins <david.s.calkins@gmail.com>
Date:   Tue, 26 Apr 2022 18:43:39 -0400
Message-ID: <CAMTWFOGU1ojFLE0v6cyyOh3tRRNmT8Nc9aWW=RLS4aHwJ5QDmw@mail.gmail.com>
Subject: use core.fsmonitor instead
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I installed Git v2.36.0 for Windows (64-bit) and when running commands
I get the following output.

hint: core.useBuiltinFSMonitor will be deprecated soon; use
core.fsmonitor instead
hint: Disable this message with "git config advice.useCoreFSMonitorConfig false"

I opened the system Git config file and updated it to have the below.

 useBuiltinFSMonitor = false

After this change I no longer get that output.  However, the hint
indicated that I should "use core.fsmonitor instead".  Is there
something else I should be doing besides just telling it not to
useBuildtinFSMonitor?  How do I tell it to "use core.fsmonitor
instead"?
