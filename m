Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5DFC05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 22:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjBNW3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 17:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjBNW3d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 17:29:33 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF412CC6B
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 14:29:24 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so258460pjq.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 14:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmVp45hORN02+xTimqOWptfu90ugM83uHoWzsPS75HM=;
        b=P7N07Qkd82szdiD03EnVdwzP32PHJOJn+4g77nsexUl078KBlakuwdoGebrBvyFPss
         lL8dDjEDbQYhpRKUEX9LwTs1o2zI5nfG3ZUNzqDYtBI3rD+0l8/GEFoKSCMAzz8oR4V0
         U0YFBJI/3Mf1h6RQMAXaMKx1guMlE7xaPdsNg2dIzzkGXLKwQYKoKj2tkrucx6PY7q4I
         zVt7gZbIHqGDwSLXQzA6jqP7Gfv6Bbjur+WUd+5xQZcy+n8viNK6ij2zHD+ijPE7s3xZ
         idJaBdKrBncO/AWm1c7mNjpWq9Capqnu3WrZnvq0yaC4sP1Brgx6oy5Ssgu63NAJd3tP
         x64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rmVp45hORN02+xTimqOWptfu90ugM83uHoWzsPS75HM=;
        b=aRrhJLV7Sn0OGO6ZWxL7h4tcDJ8uNbbw/ueKpvfc7+Rp3FW9VIhNPC0lsm5SVzMLAs
         gU+Sh2jJESWysURYkQXsUx9KjwRE9sqFnxCPXpsdcTtK5vt8Syg8VAkCDG6XtWXAOPkf
         PYtTZrt7VDUn9JiDV4nm4w8qbbzVjC9moXoC9bHa/7rf43gc30Y5IUpJTf2bPackdSPP
         mEAzSrwrxuwe8nbb6cDSZsyjndr1wZoCgwF6qt9/EgeKORt5csVrH2oaSwY6jO49pYKc
         k6P1iOQOefuAagt0DJpr1M/I/fbzC7ao6WIfgCupDJexwP8gxXFsj+ggtZYFv0sV3MPk
         CVJQ==
X-Gm-Message-State: AO0yUKW9IbBnCFj2RzIudC/2kydL+MRuGppVc5XyDIedc+M0L1OtSllE
        ynfQOlEY8KmZiqTDHmQ2lE99F312f7k=
X-Google-Smtp-Source: AK7set/QeZ6ZebCH40SC8NkMjhj5QRp6iDzRctwjKwCFz/i/u0sDM0PsqLbp4Qx/FbE4lIFHGaNp9w==
X-Received: by 2002:a17:902:f68b:b0:196:64bf:ed86 with SMTP id l11-20020a170902f68b00b0019664bfed86mr260390plg.62.1676413764276;
        Tue, 14 Feb 2023 14:29:24 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id iz17-20020a170902ef9100b00196025a34b9sm1869597plb.159.2023.02.14.14.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 14:29:23 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 3/3] t4113: put executable lines to test_expect_success
References: <20230205145245.11078-1-cheskaqiqi@gmail.com>
        <20230206211823.8651-1-cheskaqiqi@gmail.com>
        <20230206211823.8651-4-cheskaqiqi@gmail.com>
        <xmqqlela2z3p.fsf@gitster.g>
        <CAMO4yUHqogcHaQa8=LCFyze=dZTtrPPKdcscQHMvaNRX8w7i2w@mail.gmail.com>
Date:   Tue, 14 Feb 2023 14:29:23 -0800
In-Reply-To: <CAMO4yUHqogcHaQa8=LCFyze=dZTtrPPKdcscQHMvaNRX8w7i2w@mail.gmail.com>
        (Shuqi Liang's message of "Tue, 14 Feb 2023 17:17:36 -0500")
Message-ID: <xmqq1qmr51a4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> I didn't see this change in " What's cooking in git.git". I'm not sure
> if the V5 patch is overlooked. I didn't receive any review after V5.
> Is there anything wrong in V5 that needs to be corrected?

I dunno (yet).  These days a day did not have enough time to be
looking at all the patches on the list, and patches that are more
about practice than fixing real bugs or adding real features tend to
be placed on the back burner.

THanks for pinging.


