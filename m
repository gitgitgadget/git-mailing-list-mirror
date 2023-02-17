Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5674FC61DA4
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 02:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBQCEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 21:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBQCEl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 21:04:41 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF23498AC
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 18:04:40 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id 19so25652plo.7
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 18:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPAk+Acfi7OYYkDyLJz1Ah++g3pCBkVPhj8CXTTJG0g=;
        b=FPMMCNHmanQv/TFWXn1ooI0Puw81WcpF+0t2WJWzhzB4lhaOhYrSmIxs/9qjxXAK+1
         MI9fKQpgfpme8Dxc/XmE+9z/BsYWVhJw/zXCOpYE5wQTiGiprf3j1OzYI2Gwkuz3Nwd+
         jKFdqiZJVqeozhEJgTs/gOBW2OXUv+cZfS9b6i8yqQH/mmm4PjBjNo2Q7hdvCra8sEFO
         kO1ZfZirAUU1iO+gNtgmkSb2o/rDp+IW1WkE9naW+zhQVKvBqDTAAuoTUYhSNuGO3bQD
         IvEqJKKo61MFD3u1uGOZ2SQ3kuwDlvniPBFexQrjtK2uYvW2CzK+gcCTOXIWCYosEgiY
         Q1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gPAk+Acfi7OYYkDyLJz1Ah++g3pCBkVPhj8CXTTJG0g=;
        b=sq7vx0imRtVI7crNmLov4V5h1OVD/E3R8yI5nEvtpSY0eUFvDTNJh1i1+vmuf+nxtE
         +4S7AXa+ERTOkG/PmKChYZ3rV944ptWDQAwJjIKwU9YdXQuenOR48sjbHYwD1IGVbQZw
         HzChxYU+QdInnAtuScwhjdhpkajSA5jyvVvyDH5sU/5BwQuFcVNpkHOO53BL45wqdF26
         7VRewaWb9cI4yDFucOMGrvWfQHnq76jRuQyHbH0+6+rNLV04ri73Jv/tpO+RZkQYdHVq
         POOoe6db9MkJAQEmrfzDDeKsnqzTgzVyVv8C8+TST/WsxwrVefs27ChDRDzZgBqBt6+C
         pwZg==
X-Gm-Message-State: AO0yUKUGzfEwC/QF8Tg6TCyU/mlFwJqplbs2SwofF4qBdpOZSx07PvwL
        DVG0GwMTb20j3iIz3dNAUFI=
X-Google-Smtp-Source: AK7set+rYKzLtNXpj/wzTTfcADKq6ReJ27EttDDxfA0wxM4bt6MWyAMS+4Cia8hqxt5ZEnAHJkh00A==
X-Received: by 2002:a05:6a21:7894:b0:c7:519b:3ee9 with SMTP id bf20-20020a056a21789400b000c7519b3ee9mr3173885pzc.56.1676599479654;
        Thu, 16 Feb 2023 18:04:39 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id bu26-20020a63295a000000b004fbdfdffa40sm1781603pgb.87.2023.02.16.18.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 18:04:39 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Raul E Rangel <rrangel@chromium.org>, git@vger.kernel.org
Subject: Re: Feature request: Add --mtime option to git archive
References: <Y+6G9n6cWRT9EKyl@google.com>
        <Y+6akicTFG9n0eZy@coredump.intra.peff.net>
        <xmqq5yc1p7yn.fsf@gitster.g>
        <Y+7PcqpYhF5ZuApG@coredump.intra.peff.net>
Date:   Thu, 16 Feb 2023 18:04:38 -0800
In-Reply-To: <Y+7PcqpYhF5ZuApG@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 16 Feb 2023 19:50:58 -0500")
Message-ID: <xmqqpma9m4i1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> A similar option in is to simply start using "0" in the meantime, like:
>
> diff --git a/archive.c b/archive.c
> index 81ff76fce9..48d89785c3 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -470,7 +470,7 @@ static void parse_treeish_arg(const char **argv,
>  		archive_time = commit->date;
>  	} else {
>  		commit_oid = NULL;
> -		archive_time = time(NULL);
> +		archive_time = 0;
>  	}
>  
>  	tree = parse_tree_indirect(&oid);
>
> Nobody will complain about changing the byte-for-byte format, since by definition it
> was already changing once per second (cue somebody complaining that they
> have been using LD_PRELOAD tricks to simulate --mtime).
>
> I do wonder if people would complain (both with the patch above and with
> brian's proposal) that the resulting tarballs extract everything with a
> date in 1970. That's not functionally a problem, but it looks kind of
> weird in "ls -l".

And owned by root:root ;-)

I am sure people would complain.  What matters is if these
complaints have merit, and in this case, I doubt it.  I especially
like your "it has been already changing once per second" reasoning
for this change.
