Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0163C636CC
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 22:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBOWWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 17:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBOWWB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 17:22:01 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7129E2ED74
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 14:21:59 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id h4so145884pll.9
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 14:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8PGMwddVvwjXIwMH9qKINE/WblqyQumRQzE8zXVeWUc=;
        b=bGTT0W91WIsr3IcRbMWsT+PnvvRCaGiPonqYRz3sjg+1VhaU7pxQQLlA02SrqmL9oF
         AYLb+7hdZdrpx1hXA/f9Fiwvalh6oWuvMc+JUzNxM6STwlS9mHgikcfMKu4ujgG1e3pI
         7+qNV6HMrvsZ3uiF0wA/KyHK29KSygGPoW7GW1HWkWg6zbP8tCvRt+pvtkXclBNS6OAi
         7JyVKgEtMuzIa04mlUIye4butIEO3ldVXMJxECNZAKPIkETD+5W002fzw1lrd+HApeYA
         CB8YCbi3XUDYOyaYPT9s2yqbm4Riyu3ccUYwpL0+vtjYO0P93NCAB460R85WKbxzmYNv
         1Jhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8PGMwddVvwjXIwMH9qKINE/WblqyQumRQzE8zXVeWUc=;
        b=FIk2hFUVlhfXtRRHelwZ8sbzy4fSdwJGx4RY6pfO3sc/qzjNzgzmj8WaXEvQgAIzuS
         UXsxxIUePFa6I72g5N4Pl6uhCDBU6Zioo6buZQQr/n9rmaRF5awl3M/1/GrPLb7U/jcB
         ic4tSyz+ul28RtcqH3Bq5FUDrP+U2Dz0BtFmnq0oS57704+Olo2zynQhACmgnijUQj6/
         25e8bjB6wnEy5IWDEZpMkawsdH43o/+rv4oivhZ4BD3S603IKnuPdQjYBg+6GKW0ioVR
         Fqg6nY0+UziwsIVzVelfZJeSBb5Gr3WKW+bJBl2ik4UNkB/hK8XqEn5aUOp7HmBvkZL0
         dsHw==
X-Gm-Message-State: AO0yUKWjUKH1ZXvF+ofy3RREfTVzp+d5edi7bIYYyacbDkeQXcMTHQmQ
        sV1Sfp9wDlpqV2+HUpaSaOir63gdb50=
X-Google-Smtp-Source: AK7set9s46FsXasQRYlV8X8JA82jq+LNphLyykgJk+ddkfcYb6OI2z9A0491c4X9RPczLZGweVTScA==
X-Received: by 2002:a17:902:fa8c:b0:19a:8284:83a2 with SMTP id lc12-20020a170902fa8c00b0019a828483a2mr2939739plb.10.1676499718835;
        Wed, 15 Feb 2023 14:21:58 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id w2-20020a170902a70200b001965f761e6dsm12606712plq.182.2023.02.15.14.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 14:21:58 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Brian Inglis <Brian.Inglis@Shaw.ca>
Cc:     git@vger.kernel.org
Subject: Re: manual option --inline --no-attach override required for
 format.attach
References: <20230215215112.62559-1-Brian.Inglis@Shaw.ca>
Date:   Wed, 15 Feb 2023 14:21:58 -0800
In-Reply-To: <20230215215112.62559-1-Brian.Inglis@Shaw.ca> (Brian Inglis's
        message of "Wed, 15 Feb 2023 14:51:13 -0700")
Message-ID: <xmqqr0uqwovt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brian Inglis <Brian.Inglis@Shaw.ca> writes:

> What did you do before the bug happened? (Steps to reproduce your issue)
> git format-patch --inline ... --to=linux-man@vger.kernel.org

This is documented to use multipart/mixed attachement with
"Content-Disposition: inline".

> git format-patch --no-attach ... --to=linux-man@vger.kernel.org

This should be the default, text/plain patch contained inline in the
message.

> git send-email ... --to=linux-man@vger.kernel.org

It is unclera what ... hides on this command line, but if you sent
output from both of the above two format-patch invocations, then the
output from the first invocation of format-patch with --inline would
be MIME multipart messages, so it is understandable if the recipient
sees such messages.

