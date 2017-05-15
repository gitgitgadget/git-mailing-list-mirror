Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75627201A7
	for <e@80x24.org>; Mon, 15 May 2017 17:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933405AbdEORqn (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 13:46:43 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35432 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753579AbdEORqm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 13:46:42 -0400
Received: by mail-pf0-f196.google.com with SMTP id u26so16507758pfd.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 10:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c8E3i9ZG58zdGpdFQs90yTcHsRxWTXtyElI0SmGnJIM=;
        b=inl1NO7atYgyr1jQdOv1oZGfY0FgjjIDacBBxPny/0gKzTX3wjf8gOy7aeyS0ETNUN
         rKmlLp0WdWDIaXFW2TRegmEou/cpOAennHR1qcVEK3uev1TIzjP/qmRzYtWShy8zPp2F
         LpuIGvOa/erKaDJ6f6LKWT89Ovx4/MH/93evarU5mF+FP+WbwRGZUZjMzIlAC1rFEbSr
         ccTSrfx/da3XGB0vrJ1AvbGXafph4uUB7ngXR8jLSVhEYO0edXfDvVq99NM7il8H88Ct
         gaV73kKQJYGoGLdCthCpx4L2J5/r/Zed8+uOmeMb6WTx7R48Ss8O7KqwSFa0AhfdSCO/
         7j9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c8E3i9ZG58zdGpdFQs90yTcHsRxWTXtyElI0SmGnJIM=;
        b=EP29cDy0VA7PA9MoORrJWdxMzA795yTWPwFVb5RMssQYU3NfZDoc4BZZl4WPSloWAa
         ztEKtBGvBuxB8DxaEs9ITlWcBUKn7IrJTphmjHYYmKeZ+qnvPkYSqH9latjkCa3y388o
         HFSL/Q4QEFnuusdyeUQWf/XzZVpprOTNcY57Q4Izey0YN7eoSlAjYYrUu9fEeXBFbJYO
         7VAn+m6Twt5InkGZwxmmSPcfKZi6F4A0iqN1L8DosiC3M6c0SNUdgRMBGLoUEKxEbKbl
         lJ0ktqW40ff5oWns0m+o5NVUpwQZtG0vSRUT/hiJtiiHjHjrTWGNEogPPZe9L7OcRgS+
         zfBg==
X-Gm-Message-State: AODbwcDvNhY6Ww0RpLguG7M1PlnfAX2CUySMWhjCPwPWBuPl4on3xR/U
        X4cx3iQN1levew==
X-Received: by 10.84.136.70 with SMTP id 64mr10233817plk.82.1494870401440;
        Mon, 15 May 2017 10:46:41 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:6582:4c54:354a:7413])
        by smtp.gmail.com with ESMTPSA id n65sm23613318pga.8.2017.05.15.10.46.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 10:46:40 -0700 (PDT)
Date:   Mon, 15 May 2017 10:46:38 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v7] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170515174638.GJ27400@aiede.svl.corp.google.com>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170515173220.13103-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170515173220.13103-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> fetch-pack, when fetching a literal SHA-1 from a server that is not
> configured with uploadpack.allowtipsha1inwant (or similar), always
> returns an error message of the form "Server does not allow request for
> unadvertised object %s". However, it is sometimes the case that such
> object is advertised. This situation would occur, for example, if a user
> or a script was provided a SHA-1 instead of a branch or tag name for
> fetching, and wanted to invoke "git fetch" or "git fetch-pack" using
> that SHA-1.
>
> Teach fetch-pack to also check the SHA-1s of the refs in the received
> ref advertisement if a literal SHA-1 was given by the user.
>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c          | 40 ++++++++++++++++++++++++++++++++++++++--
>  t/t5500-fetch-pack.sh | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 73 insertions(+), 2 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

I think we've done enough golf on this one.

Thanks for your patient work.
Jonathan
