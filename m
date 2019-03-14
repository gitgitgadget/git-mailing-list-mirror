Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7139620248
	for <e@80x24.org>; Thu, 14 Mar 2019 04:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfCNEjw (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 00:39:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45694 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfCNEjw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 00:39:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id h99so4287756wrh.12
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 21:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+ooXCv/SYQx/o3y0u/jvtVJ0v7Y7bTrwjjNZA7eMzPo=;
        b=HmpjBpYZE9Js1AAm3vqXbTNp/UbKxP9cTpEMoeEOBSz3LVwH20sdX/Y1Lr/4rdhba7
         Ij7PW6kQfmrqEmb60LxWiuYSVVvTBvA5u9v+B+QkVzmyZLpvUz+jGkplZSXBYn1HI/2G
         Y7bZZ1yi2mdKL+QBkp2L5b4ckLRDBJeXNb53e1gLUQNIhJRnZTLRURpNzw8TSGoVYO14
         yAuW66q/4gRt3vB5o3w92ODLjAG1UFyAuTxEMHdsUm74eB3dmwlGC6HtHUGgpNeTdRtT
         q7TnDVMH/3zb48kZ5l5cAtX/U1hFRXnhaOzQTQnXk/oMtr8XBt/+r9OKt7XGQUc+zj+P
         IVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+ooXCv/SYQx/o3y0u/jvtVJ0v7Y7bTrwjjNZA7eMzPo=;
        b=fK57ZeGOlYBbFIBqVhVTGiDTnuaTbIB39cji9NTWXmyFP1e9aqQIOzKWkfFAOY7OpF
         WDvJ7lTwIqySVRM3f3r8j9AHbhY+yKepZijg9IOnHRb3fL9rZqefQbQXa3twHX+dRIf3
         ZolCoFYQet+f14BhSJ/79QBm0KEVi+M43Uor92XwwJ67QcWB/Y+PJRkE5TUBjoNv/bdZ
         W77N0EGwxiFlHPcIvxEmPrtD2qIoJ3ExLglGuhfMCVw+wUmRcJlo+4AfJ3qgduPoQa8u
         rvPgHDOCKCJB6tlijSAxTLy7DmyNdx13Q47LwDJFe2PA588Chgq1KNVT6vBLCrViOdyL
         iPrQ==
X-Gm-Message-State: APjAAAX3AriuWuJ+UR3Dbs4aelLWWQACVNLrsIhGZpFRsOUfBucbWoqX
        L9PBDY4Qkt+TWOUDZwTEMR5ontO0pYA=
X-Google-Smtp-Source: APXvYqxSYhSfTalmZN9QAtaSumkQCIriEinXyYdNcjkidQGJz1fLI96WLZwmmikwGDAs0bQGc/iX1A==
X-Received: by 2002:a5d:410a:: with SMTP id l10mr4582615wrp.182.1552538390104;
        Wed, 13 Mar 2019 21:39:50 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id u13sm1464963wmf.3.2019.03.13.21.39.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 21:39:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, sunshine@sunshineco.com, szeder.dev@gmail.com,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
References: <20190208090401.14793-1-pclouds@gmail.com>
        <20190308095752.8574-1-pclouds@gmail.com>
        <20190308095752.8574-11-pclouds@gmail.com>
        <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
Date:   Thu, 14 Mar 2019 13:39:48 +0900
In-Reply-To: <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com> (Phillip Wood's
        message of "Mon, 11 Mar 2019 11:16:02 +0000")
Message-ID: <xmqqr2ba9ii3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>> +-m::
>> +--merge::
>> +	If you have local modifications to one or more files that are
>> +	different between the current branch and the branch to which
>> +	you are switching, the command refuses to switch branches in
>> +	order to preserve your modifications in context.  However,
>> +	with this option, a three-way merge between the current
>> +	branch, your working tree contents, and the new branch is
>> +	done, and you will be on the new branch.
>
> I was wondering what people felt about making this the default for the
> new command.

Even its inventor (me) never runs "-m" without first seeing checkout
without "-m" fail, and seeing how much can potentially be lost if
the branch switch conflicts by asking "git diff" (no other
options).  It is very unadvisable to make it the default.
