Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABC7C47247
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 18:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE2AE20836
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 18:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TDHnh7sz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgD3SXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 14:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725844AbgD3SXH (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Apr 2020 14:23:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F13CC035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 11:23:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w15so8722607ybp.16
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vT1PQZ2FAUuzihbBeWcS/QOhUbhXQ5E0EPre4f4wwvg=;
        b=TDHnh7sz97vg/xI6uAJfcmk6yACx3tzyUq2ZOwmf6+vFP9sOKWkcf0VRH99+k39Elb
         xU+5NdJRX3YNwiEeFivlE6lbCr+/i0pYrUfrLIBSohjSQ/MMeXWziJ0uRLJMFzVMGJEh
         tgnnmnupt9vKeiwNHQySfed+MIFI7+86231+7+9WCKLGVzA6RaqSE95Nv7WxroPVCcXD
         Q3uJf/oUZzfXW0vc+AtZxmCV6VcA8tD29p8uKiOnScKGbheU0MbFNWhxuIdCfk0chIVv
         E8WZAkqTUkQGEYChIHZwEKGPEiP8T2fz3JYbPvreuRKInXUsFJBavjZYdAnCuvHnnMU8
         r5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vT1PQZ2FAUuzihbBeWcS/QOhUbhXQ5E0EPre4f4wwvg=;
        b=CLkmCnCy9+q7PefSuuJjU3Tb3IfCY0Eo62Z75iQgIXl5piENrsNWDUvuAXg1wgv0f3
         5K3gHxNec192SX2WfAWzWovxSPNqnuzOP6HFcV9uTk51jFT+c5ekb6G0bW3Y/zupsIDf
         znFwV5FiqVQwxM7HNyBE2QUub6BUzxH9utJQ6wIAk7nyq1evAYGoDs6P+gfNUs2x4RrN
         sQFGduLNBqfGAKEH96wVzlWFpRHntqVq+nttjTB9IRnipSLnwJeQRzI2sbPL5tGZtgB7
         s4Z6eYEeU7nYmvueprgOp9wHuy/TQtQBjk3sVPrOCP4r2oIpODnvW5uKbIn1tv1nZecs
         sXdQ==
X-Gm-Message-State: AGi0PuZZ3iqgcpC2jvz9MXxLySwKrgLCwTMQzF2y3VcQCwkMh28foL5u
        LG2cjevq5hrHDTRg8hJFwnRo+fkZB/v8dK7+uK4G
X-Google-Smtp-Source: APiQypIe8fcD1Z3TNnS3NbOg84kenC8E3ZwXwZ96W0ujQpg4x/lxfKbvjrw3CDKaR7LXejBwhXaNq07RQ51aHWoTLpap
X-Received: by 2002:a25:e54a:: with SMTP id c71mr8123399ybh.139.1588270985536;
 Thu, 30 Apr 2020 11:23:05 -0700 (PDT)
Date:   Thu, 30 Apr 2020 11:23:02 -0700
In-Reply-To: <20200430005945.GA23090@syl.local>
Message-Id: <20200430182302.1969-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200430005945.GA23090@syl.local>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: Re: [PATCH 2/5] shallow: extract a header file for shallow-related functions
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Yes, I should have mentioned in the cover letter that this is based on
> 'tb/reset-shallow' which is should be part of Junio's next push to
> master. I didn't mention it because I figured that it would be on master
> by the time anyone wanted to look at these patches ;).
> 
> Anyhow, apologies. It should apply cleanly on any branch that has
> 'tb/reset-shallow' already.

Thanks. Now that I'm able to apply the patches, I see that the prototype
for unregister_shallow() was removed with no corresponding addition.
This causes a compile error when running "make" with DEVELOPER=1. Other
than that, things look fine.
