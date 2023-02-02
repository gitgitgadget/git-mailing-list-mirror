Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80B9C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 21:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjBBVFP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 16:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjBBVFL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 16:05:11 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE5D84954
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 13:05:06 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id h9so3174468plf.9
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 13:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XI06zs5sdNnhZt5Ou5Jf4B54h0oIl+01OQyVZvJopME=;
        b=LtdVPGzXoo2eM/wg5PDgbzBUdcv+ZXDHVpPSet41myhdq40l4ZjCOHUVCdT3EaP58s
         Nae8ZmpxphDrZrsH/2kbdxUtk52py191PDGIyQVcclIR73+YgoxTA03llxYtULP+H7sR
         EFFYcgHPR+f+EFg3YQMyeCNshCDP8tfKAxki2hnfW7THJMscZOmjlAEZ3QWzrc2+/MJ9
         xquZnZbP4YlD0DKCbT9FE31kNr+fMxKzSFjitXOzfUd1pqSKNcJFNXM98WavMug+JiFI
         9/XdKKoXkH0h9VUdiZNl3DZVaVXqsFJ+z4YfbWIYvpCE9HZ5uGWLSLNkAUDMe9/7fIuT
         mc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XI06zs5sdNnhZt5Ou5Jf4B54h0oIl+01OQyVZvJopME=;
        b=4GxupClELTJDdfF4ZG1am0hc1c6SiCkd21enLqb/1Z05YfkbfIv8mpeoP0raIRCW9E
         n6Bj4v6DPZme0j5F2EhTBDcPU0DUsO9iPG167SoXPCcRIa21QwkUxEdBN2YmofpQTIdj
         USaAWK6LqO/QwUd2AJb1CzVCBTX/vKaApcEotQ3hacs/xDS+Ybsp3XFzzdAXH2hHW8W7
         o8w+yzFTqyKYPLVJuVEqehQte4kScs10yyIIICQJ1x0S0CezhoDOeZPhstNum8+AUxSN
         6e2Jn+d9h+fZC5y8snTwEbjQMB6IOAfhkZB37fcQs2dRN+7qnCvvpqeh8P1SBcOrPdTL
         P7DA==
X-Gm-Message-State: AO0yUKVzEiv+FBu9Y7DXrIxgi4XZkONivzqeg/FqB7zrwIJTkyzzBAMN
        gYSlqXRv2G6pYzc6qIVTfPK7G03HaV4=
X-Google-Smtp-Source: AK7set++5T89qE2fTZ8FPpkUWvxEvedY1Qzacs6wCQNijDDuZjMBv6S1E3Dh/4o/oWCsDsYq1nHptg==
X-Received: by 2002:a17:902:d08b:b0:196:132c:5b7 with SMTP id v11-20020a170902d08b00b00196132c05b7mr6807050plv.1.1675371906397;
        Thu, 02 Feb 2023 13:05:06 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id j3-20020a170903024300b0019667318941sm103076plh.176.2023.02.02.13.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 13:05:05 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] t4113: use "<<-" instead of "<<"
References: <20230131224929.2018546-1-cheskaqiqi@gmail.com>
        <20230202171821.10508-1-cheskaqiqi@gmail.com>
        <20230202171821.10508-4-cheskaqiqi@gmail.com>
Date:   Thu, 02 Feb 2023 13:05:05 -0800
In-Reply-To: <20230202171821.10508-4-cheskaqiqi@gmail.com> (Shuqi Liang's
        message of "Thu, 2 Feb 2023 12:18:20 -0500")
Message-ID: <xmqqwn4zsrr2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> use "<<-" instead of "<<"

You forgot to explain "Why?".  What you did, anybody can see in the
patch text.  Why you did so is what you are expected to explain in
your proposed log message.

> -cat >test-patch <<\EOF
> +cat >test-patch <<-\EOF
>  diff --git a/file b/file
>  --- a/file
>  +++ b/file

There is no need to do this, as the body of the here-doc is not
indented/prefixed with HT at all. 

> @@ -31,7 +31,7 @@ test_expect_success 'apply at the end' '
>  '
>  
>  test_expect_success 'setup for apply at the beginning' '
> -	cat >test-patch <<\EOF
> +	cat >test-patch <<-\EOF
>  	diff a/file b/file
>  	--- a/file
>  	+++ b/file

This is necessary but that is only because [PATCH v2 2/4] broke it.
In general, we frown upon a series where a bug is introduced in an
earlier step, with another patch fixing that bug.  

Let's not introduce such a bug that we need to fix later from the
beginning instead.

Thanks.

