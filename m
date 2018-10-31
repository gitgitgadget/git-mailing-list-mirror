Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B5B01F453
	for <e@80x24.org>; Wed, 31 Oct 2018 04:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbeJaNop (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 09:44:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53304 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbeJaNoo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 09:44:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id v24-v6so3948632wmh.3
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 21:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=23JQ8BHKezePazMVPyA1Bg0/gJ9r5xMuhKa84Qpm6bk=;
        b=YSCqNL6PV18yG6LItbKIcDFR9qAcUfl+EFK6sRpwBgy4OM+PDY8vb+yH3mBbEjPoP0
         CMwseAVjkjEqlj48R9x63Bz3t0vSvr04tGRij/fIY1D766O/8quuCOUSxXGW51HNldUE
         LiU+jvnuQm4Desi0A1daxjnur4yMt2tIQ3oZyVqYP6K7Xu2z1+Eyc7HnEK1ZTFwhxqrh
         3X+dAX/gOM9s0u8cTPKJ3i8onBB1AXp9NkGkdnFlXbCIbqyp2wLdeHgcWKG2fSiUe7im
         bRDc1Vj6+lrSStZNrAb0rfBZRDyg76wsMQYAKKaXsd3mFSmbdMP7aBH0YDm9mX42eVf9
         TATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=23JQ8BHKezePazMVPyA1Bg0/gJ9r5xMuhKa84Qpm6bk=;
        b=Sl5+Xy0gtGV3WBpKofiEvcy8s3AVq/3lxXjqWR6BgKIeFZXN4xAQavryPFEhyZvXrk
         CGsTe3Y6kazYBNcZgy3qDUqiLMSpD93EscYTsOQmq4KdsUaFriyqWwjEbm/welJxWPZz
         5UlxzB8DD7Da0ow6E1hRs3gvdbJQZNizoSo//XrzZjZbzzQ1jqfMOPawrw5yCtSQHd1B
         aeTmUXPgrm7Rhb3Y5KgXFIyrKusUT/Iaf23nDJIRrEQyjAHDAFnfzsHw3vx/k3UEJgG0
         PtF26cQSDE7Kop0sfexYFN3/eJAd5tF98s+4/GKuezQGUrPMB5ggFK1jmFBD8u6PVaIV
         L+GQ==
X-Gm-Message-State: AGRZ1gLK16fZHpjKfd8Boxusx2lCB3NCO7eJLgz0SmuTVUaaU50CSqWX
        dxrzZ5ZVFevomwBEWkJhSds=
X-Google-Smtp-Source: AJdET5feb2Jq71mWtkKZ4yXlQW4ydR3TCA3AlxnLbRO5czybz9m664PvvpXq7IK+8hiAJjl1uOdWxw==
X-Received: by 2002:a1c:f4e:: with SMTP id 75-v6mr950943wmp.79.1540961297488;
        Tue, 30 Oct 2018 21:48:17 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b143-v6sm28982187wma.28.2018.10.30.21.48.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 21:48:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     chris via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, chris <chris@webstech.net>
Subject: Re: [PATCH 1/1] Use correct /dev/null for UNIX and Windows
References: <pull.59.git.gitgitgadget@gmail.com>
        <8159cbd1b8025f33fb9d0e254db1a3c2a066f853.1540923993.git.gitgitgadget@gmail.com>
        <20181031035618.GA31247@sigill.intra.peff.net>
Date:   Wed, 31 Oct 2018 13:48:13 +0900
In-Reply-To: <20181031035618.GA31247@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 30 Oct 2018 23:56:18 -0400")
Message-ID: <xmqqy3aewwky.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Oct 30, 2018 at 11:26:36AM -0700, chris via GitGitGadget wrote:
>
>> From: chris <chris@webstech.net>
>
> You might want to adjust your user.name. :)

Yes, absolutely.  We'd want to see that the From: line and one of
the Signed-off-by: lines are idential.

>> Use File::Spec->devnull() for output redirection to avoid messages
>> when Windows version of Perl is first in path.  The message 'The
>> system cannot find the path specified.' is displayed each time git is
>> run to get colors.
>
> Thanks, makes sense, and the patch looks good to me.

Yup, and we already use File::Spec everywhere anyway, so this is not
a new dependency, either.  Which is very good.
