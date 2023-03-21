Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A95C74A5B
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 17:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjCUR1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 13:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCUR1K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 13:27:10 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2D04D291
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 10:27:09 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u5so16775225plq.7
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 10:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679419629;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZmPSPXh9H+FZ1zza1EXeRLXAilKf16Ja4D2MoOEWnc=;
        b=EOAgTJ0hO9vAC/xTkH61FTtUeWRacXa4w/BPfhFEQiafuD7pNGRErQHKsTaq/mKHRF
         Ig8fZcPCciqOkjTJNTHETSL2w4l1UjfLo3VcY17wazLnGCdlPDdC/xqY7Ujln5H2qtVP
         L2TCXgF34jXTIr4aJpB6xBTZbNnNWbgjAdn5OqScS3OijMckznyrqRTdpZFrj6GHloMi
         HZI8218C4+FpVv9jhDpp8no4BXe019ZqA0BN+ADgbyxT7n6CjmYy5+/h3Hv+uRiARz4c
         CDfnWOc5LbYfpPi83V0+vpYWCsJLvxq3iB0kWO4szIpMqFtPfMYH8XTMoY+5w3JSm639
         QXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679419629;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UZmPSPXh9H+FZ1zza1EXeRLXAilKf16Ja4D2MoOEWnc=;
        b=z6a/g3APbvSuNkGi0I3wVHJ00ZLevUZmEttB7MXyXIBwjtDrTJ9Aen2dFfC624hZI+
         qtsWXkSswv1+E4tJYBlt3T64G5/2cb/6jMRuGiIVgX6PraZy3JV8K5YxKKgP9OsFndG4
         iFp0oqCucmFOawjtmZx3lBskmPflAQRNi2NSO3fuCjEmfd4Hld20WMwFr6lecrHv4oZX
         TzoFTqCz2Agv9b9D0d10gulGPWJSS9V3fvuzGQqUihR0yrmpGcNQ3Uug9DiP8U3UjiGv
         /uw90tL/A5U9FsUL4sW1GDEeRXiI8anerGmqj0widv7iWmylSxtCfoJ4UilNMVLjrcdf
         RYyA==
X-Gm-Message-State: AO0yUKUlqAUstvp17CorF/Fb37HVNbuLzpGW3uvm+OLxAosE7LFt3WxK
        umOFnQ32SdVZZyL9r7lJvhiPgkmfTlA=
X-Google-Smtp-Source: AK7set+ovSJVC4t+0Xrp0eIMTBgFM5bpsseg7NLsMyPBOzVbqVxgmZJ8QpCHdYc8AHArROtrimtqyw==
X-Received: by 2002:a05:6a20:4f86:b0:d9:896b:8c0f with SMTP id gh6-20020a056a204f8600b000d9896b8c0fmr4297145pzb.24.1679419628758;
        Tue, 21 Mar 2023 10:27:08 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id c15-20020aa78c0f000000b005a7c892b435sm8527591pfd.25.2023.03.21.10.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 10:27:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kai Grossjohann <kai.grossjohann@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Documentation: "git am" should point to "git format-patch"
References: <CAFmGgWVVdgQj_gzcDw4Lyzt1aBc-7oyt8=JT3GskHegUu+8sTg@mail.gmail.com>
Date:   Tue, 21 Mar 2023 10:27:08 -0700
In-Reply-To: <CAFmGgWVVdgQj_gzcDw4Lyzt1aBc-7oyt8=JT3GskHegUu+8sTg@mail.gmail.com>
        (Kai Grossjohann's message of "Tue, 21 Mar 2023 17:40:32 +0100")
Message-ID: <xmqq1qlij9qr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kai Grossjohann <kai.grossjohann@gmail.com> writes:

> The man page of "git format-patch" already mentions that its output
> can be consumed by "git am".  I suggest to add a similar remark to the
> man page of "git am" to mention that it consumes output from "git
> format-patch".

There were two reasons we didn't do this.  As "git am" is designed
to grok e-mailed patches, not necessarily taken out of a Git
repostiory or even if it came from a Git repository not necessarily
produced with format-patch, we didn't want to single it out as the
"blessed" input producer to the command.  Also, in the original
workflow that "git am" was invented for, the user of "am" was
expected to be a different person than the users of "format-patch".

But I think that it is a very safe change to make in 2023.  Thanks
to the effort by many contributors, Git ended up becoming a bit more
popular than we initially thought it would be, and "format-patch",
which took me a few weeks to pursuade Linus to take in 2005, seems
to have become the de-facto standard tool to produce patch e-mails.

Interestingly, the documentation for "git apply", which is listed in
SEE ALSO section of "git am" documentation, does mention "am" and
"format-patch" as two things that are related but different from
"apply" in an early part.


 Documentation/git-am.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git c/Documentation/git-am.txt w/Documentation/git-am.txt
index 0c1dfb3c98..900be198b1 100644
--- c/Documentation/git-am.txt
+++ w/Documentation/git-am.txt
@@ -24,7 +24,9 @@ DESCRIPTION
 -----------
 Splits mail messages in a mailbox into commit log message,
 authorship information and patches, and applies them to the
-current branch.
+current branch. You could think of it as a reverse operation
+of linkgit:git-format-patch[1] run on a branch with a straight
+history without merges.
 
 OPTIONS
 -------
@@ -273,7 +275,8 @@ include::config/am.txt[]
 
 SEE ALSO
 --------
-linkgit:git-apply[1].
+linkgit:git-apply[1],
+linkgit:git-format-patch[1].
 
 GIT
 ---
