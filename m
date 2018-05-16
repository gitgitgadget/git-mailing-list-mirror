Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C799B1F406
	for <e@80x24.org>; Wed, 16 May 2018 01:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752272AbeEPBm3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:42:29 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38265 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbeEPBm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 21:42:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id m129-v6so4444620wmb.3
        for <git@vger.kernel.org>; Tue, 15 May 2018 18:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hp25cAlk9jbs8UuhnXuzYgxwEuC2b1jZ2vKDdsbhNuA=;
        b=I+pTtYbbXc8Y3UJ5zCT/DNJg2lncrpKXDcJVes+T9ajNfv0z+eW23AlSd8MLq7lZkT
         QxskSfAR9WXjlD8OC3ORc9IrFy5Jz1hUC4uY7f/DX6wI7FBVhbrZ6gepd71iYkZ2h/vB
         WTewvGEHP2+lHngSbZW/xcfvUVCM5vpX4N5UU8HYKaOCrM3+hqltzUpxiRODE6z2R3YH
         mt4chhB1b7zwrW5k09ix+V7SU85+7eowrtOtNfQO8nA5Es4aJ+27Ke1T7Fg6Pi00Cx/9
         kOTK24EBkyfwmXqNu/zOS8PM9bEoTERZXvU7eU3k9jMnSg9pAqB8/sdjg6olArpKsvcD
         WklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hp25cAlk9jbs8UuhnXuzYgxwEuC2b1jZ2vKDdsbhNuA=;
        b=jE1GUYw6c2+087PkfZfGgYQS8gmmw+kkMCpA9Cd3Cdfhjaf+NfnmKJppJFYi1KuLwP
         Dwq7cdzegJ3/XMsODbXgrI/g/lMcKVTn4Uc0MrewYsJLbOCi3et7N7D8vYUw2mgTlbxF
         R+ECo7/7u03evQEtPNSIhrscCyzlME0MD/t3iOm8fSVG06GWzJ+YCnxpPkGm2d0m3rFz
         m8RbChrOqhqDYJ//IcCDPWrkScPUKzLqUNMiP4/31VXevKu9x/mKMCVDLE3RvkITqzqW
         guM3sn+do4sQv1XKMV/b9x3Gtloed2BU2rQssb2N9u4EzFyEhnJmvFZ0ssUVtqKOUCqX
         C03g==
X-Gm-Message-State: ALKqPwfeWNFfIwenO9PjBiudJWNUtXbvNIbE2wKAyko5+VRNiHmlOyPd
        mqST//tnyWQkj0o9NOkdCeGWoda3
X-Google-Smtp-Source: AB8JxZo7izBD1ipMnf+A2YqEr91oTuZzEtFLsYz30FQTD0iD5jgQ2M6ynLA+oeErG/LxrxiHpSprkQ==
X-Received: by 2002:a1c:9991:: with SMTP id b139-v6mr179167wme.160.1526434947319;
        Tue, 15 May 2018 18:42:27 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l53-v6sm2293500wrc.80.2018.05.15.18.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 18:42:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, leif.middelschulte@gmail.com, newren@gmail.com
Subject: Re: [PATCH 3/3] Inform about fast-forwarding of submodules during merge
References: <20180515200030.88731-1-sbeller@google.com>
        <20180515200030.88731-6-sbeller@google.com>
Date:   Wed, 16 May 2018 10:42:26 +0900
In-Reply-To: <20180515200030.88731-6-sbeller@google.com> (Stefan Beller's
        message of "Tue, 15 May 2018 13:00:30 -0700")
Message-ID: <xmqqk1s474vx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> From: Leif Middelschulte <Leif.Middelschulte@gmail.com>
>
> Inform the user about an automatically fast-forwarded submodule. The
> silent merge behavior was introduced by commit 68d03e4a6e44 ("Implement
> automatic fast-forward merge for submodules", 2010-07-07)).

Oh, another thing I forgot to mention.

These three lines do not convey much useful information.  The first
sentence can be read from the patch text, and the rest can be read
from "git blame" and "git log" output.

It is correct that the silent behaviour was introduced long time
ago.  The proposed log message does not even say if that silent
behaviour is bad in any way, let alone why it is bad and need to be
changed.

Perhaps Leif can elaborate why this change is a good idea in the
first place?

Thanks.
