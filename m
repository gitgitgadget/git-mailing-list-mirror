Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9592C76196
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 18:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjDFSZC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 14:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239350AbjDFSZB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 14:25:01 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920C06196
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 11:24:59 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-503e712a7c7so4975a12.3
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680805499; x=1683397499;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/yKV+JX+lu9icqVfvx3QcHLJFR5HGlhvbsTSpuqHE8=;
        b=Z9zdBsQfWmc+nE5uZCahW7C6F9WWsCgEIsF+tvtm7JfYaFdb1pL9TcS7S4HjOZvXwo
         Uv7zB/0DS08QlYw4cNHHpENdAHM6NRBuY5BAulEfqa8AbVl1eiLONq7+kMuQlcazEAMg
         VJVznPIBfXClKHd8Qr63R4rVCnxcsjH1mRzd5mhIJMcKcYesNUuASdK2YzcMJ0ZKNsbI
         8zqxxOviJdn9tTdQeZq5L6GVNF0SqbpuAQH1mnhyBJsLtniUbN7291Zm6MB+zCJJ/IP5
         w699kLJYTWJhv32ugsjiFeFxpwPNn+V1A0FCQx9L7fkdCtubc6e5FcrY7nZAgtRpcFDP
         Kpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680805499; x=1683397499;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/yKV+JX+lu9icqVfvx3QcHLJFR5HGlhvbsTSpuqHE8=;
        b=PFs9nfek0Ezixo8oXH907EE0xrImCiW4TMPvPK+bmLMcyT7ri2dQCQj6v/xSNkp5+4
         k6S9Pf9hJodXXK5/3n/0oaa4zDsIj7XBF9DpXCaldorHnRnzQpC/k0kFfEhnCIDq/pYX
         wTan4t3FAc+GTeJsnrtl9yGoimziAenRRwnNEvvEF0p489VQiIksojqquI2GDzPGQyml
         +3B9eK49xKFeIqHPY2Frqsk6N7S+8b+NrlMPHvJXFR0h1H87ux1THYD4mSNGgJJEw6g0
         bPk024/ASIUM1EBYMFpoEnwi04QM2Y2vLB2HlNicccc0UKTMj6lhGr//5sHZzV6KJsR3
         2VJw==
X-Gm-Message-State: AAQBX9eWZqv/zs4sXRtL7u743qDT1oiSaIAXzry6J60XaIbDp4joUTny
        lhpBrCDFOIDa2LtJKXNTA94=
X-Google-Smtp-Source: AKy350b6N5YcUfnUNnn/yjE1nCnY4BJOIMF7XpNWpqqPrlmuKcT3geDJf1YJ4WfMup+ojQ/Z6la6gQ==
X-Received: by 2002:a62:3886:0:b0:626:a9b:94b8 with SMTP id f128-20020a623886000000b006260a9b94b8mr53767pfa.20.1680805498750;
        Thu, 06 Apr 2023 11:24:58 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id fe22-20020a056a002f1600b00625037cf695sm1662040pfb.86.2023.04.06.11.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 11:24:58 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com, peff@peff.net
Subject: Re: [PATCH v2 0/2] branch, for-each-ref: add option to omit empty
 lines
References: <xmqq4jq0hp1i.fsf@gitster.g>
        <20230406170837.10060-1-oystwa@gmail.com>
Date:   Thu, 06 Apr 2023 11:24:58 -0700
In-Reply-To: <20230406170837.10060-1-oystwa@gmail.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
        message of "Thu, 6 Apr 2023 19:08:35 +0200")
Message-ID: <xmqqjzyoq35x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Øystein Walle <oystwa@gmail.com> writes:

> Øystein Walle (2):
>   ref-filter: remove unused ref_format member
>   branch, for-each-ref: add option to omit empty lines
>
>  Documentation/git-branch.txt       |  4 ++++
>  Documentation/git-for-each-ref.txt |  4 ++++
>  ref-filter.h                       |  1 -
>  builtin/branch.c                   |  6 +++++-
>  builtin/for-each-ref.c             |  7 +++++--
>  ref-filter.c                       |  1 -
>  t/t3203-branch-output.sh           | 24 ++++++++++++++++++++++++
>  t/t6300-for-each-ref.sh            |  8 ++++++++
>  8 files changed, 50 insertions(+), 5 deletions(-)

I have always thought that the listing mode of "branch" and "tag"
subcommands is a mere syntax sugar around "for-each-ref", and the
above leaves me puzzled.  Did we decide not to add the same for "git
tag" in the listing mode during the review of the previous round (if
we did, I do not recall the discussion), or would it be just the
matter of adding another 6-line patch to builtin/tag.c?

Thanks.



