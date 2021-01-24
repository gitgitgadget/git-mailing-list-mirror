Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EC6C433E9
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 12:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C500622BF3
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 12:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbhAXMlJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 07:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbhAXMlA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 07:41:00 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473F9C061574
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 04:40:20 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id h11so20824812ioh.11
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 04:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=A8FjhkUd6xGm/0oIyakY76Ea4AbZ1uqIi9HwG3Vnmlc=;
        b=G2XCtTt/Q0Fjjv4OMpvVXthLDGx7Wqke6keJkqaRZf3lM+hjX3q0A/sUco3teDrlfX
         HkJnkQeGd8x5mHXxI/8xV2NB3u3nhMmqNgpyr5N64w67YZNFitcrPVOh+o/MUVWdGtOf
         gsyzizSOnUilJdtELOK1SlxrwuGhGLdjrndxNGQqVB1rogjARWj4lezhKf69AnpoP5ie
         x/WWim6S/QtbNBtuXbynXF+MW55ynhhf0ABwIdr/abWV834iq9eOk2yggFRX3hbPX4ek
         xhVWvl3s/qc/TnjqroVk+pbTDNifN5ciW69d5Md16H8P9hCq56JUwmwTaun+N/CLhEZ+
         /tLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=A8FjhkUd6xGm/0oIyakY76Ea4AbZ1uqIi9HwG3Vnmlc=;
        b=BzgtStnRmFswamaerqsnOtL1ZUckKFV9HCfk8X7LyQVh/6oPVMHrMMtccC/4gDlMsd
         DGjarcNuvHtxklQA85B/TIeG+6wOQnWEVmE4Hz35NRbq1+0ZRXwV1CE1gbtr17EvdwfG
         zaZuKNgOXaeLkGykhaZ8Yb8q+S/aHThgvGs3EA7rEXIZnkTeHh/l9kyq+dU9UWFD0ZCV
         Xp9EPT0iDK3zr2OoDqC4UrKFj+LRLTD+3d01vhEElvvi3sj2eclkYJNVNP7IVHZxTHxH
         UEaFBsHWyfl8/StXF+7xZvPzZRoCgWrbUsvcOLJRSfDuq7wh4cdmClQUU875ixcm6P2t
         TF9Q==
X-Gm-Message-State: AOAM533C29tEu/BW7AOcalUyK9OdaL/CKRLo8FUJxmjRdPt0aWjhy6de
        qiM6cnn9qlG6N4Vk4PtWq11tBOxqLEjm90BMiNa2w5qIE3I=
X-Google-Smtp-Source: ABdhPJzTuiLu5ljHc4p/06joPVhow4H9M9QjhTEOxFEXJBkjyHJeNBlxbZdhrYq+CFG1hSQtrmcXRQnZPJLryEPeo0Q=
X-Received: by 2002:a92:4101:: with SMTP id o1mr523486ila.82.1611492019453;
 Sun, 24 Jan 2021 04:40:19 -0800 (PST)
MIME-Version: 1.0
From:   Christian Schilling <christian.schilling.de@gmail.com>
Date:   Sun, 24 Jan 2021 13:40:08 +0100
Message-ID: <CAJsFKUCuvO7Y7-MJZ-GG9Jv+4-ei=-tvx4PF1PbeU61m+CV9RA@mail.gmail.com>
Subject: ls-refs protocol extension
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi list,
I have been working on a custom git server where the sha values
required to respond to a ls-refs command can occasionally be expensive
to compute.
It would be a great improvement of user experience if it was possible
to show progress to the user while this is happening.
I was hoping that this could be solved by using the already existing
sideband-all capability, but unfortunately it seems that even with
sideband-all the sideband is not available during ls-refs.
So my plan would be to start working on a patch to add sideband
support to ls-refs, unless there is
some other protocol feature that I have overlooked and that would
enable my use case.

Any pointers to either alternative solutions and/or hints to potential
pitfalls in the implementation
of my suggestion would be greatly appreciated.

Best regards,
Christian Schilling
