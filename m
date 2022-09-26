Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B027C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 23:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiIZXf1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 19:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiIZXfS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 19:35:18 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAEC6611B
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 16:35:15 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id iv17so5500909wmb.4
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 16:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date;
        bh=EEX8cm9hHcpgA/0ccVtPvkxtYonebsrXl4v5iJt5XW4=;
        b=CA3UJBfr6PehjYdnxUcknIq1qkwZoAQU6XgafqQnwvs+1QQyHCZ1SQRv5hmKhxPxgj
         mpHDb/D7rC+IbTWNuMsfuj2WhviHU1m6xvvCYM+eMPAOuMCiQeQ68VgdnqX8dISkf95t
         a4xoJW5GKgP1nskmfI+dE8hOofJZguZBlUoKdJOqX2llffcrsXGtvmxIpH7x0APKB38v
         rFXG2AadAoTJkvZGxVxEP/FMG8DeiqjXFAD2pNgetrosHRx3KjdNmt2nZhr1GQyHg//M
         wZuFCsU4G6MN3Jzism2mx6vAvaGlxYxc0mi9nU3DWevIQnApPx3hQBxjQ+TXBa77FFNv
         TZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=EEX8cm9hHcpgA/0ccVtPvkxtYonebsrXl4v5iJt5XW4=;
        b=QzFEH/klBr2BMCC1JPB6GAwcoJSRdP7VI2llf6xvM25+WICLFOxeH4oShuw/4bz0V4
         caZ8JvHnvIJB6GfFKXPD0QfejCrauvM6ucYCTQD8CYnQnnlM4gxbZ6U3Taa1MD/lTDqn
         Qo2lTBrI7K7UHo01NqHByoWQ+VoWn2Td5FWwRy6gPsfCG2VQZv8lBen+UOjcXZ+fta/3
         Wsjbx76ljVNTmzTaPGKcP8Pj+vN5WsEvlbJZ8DiIqNPAu2dw4BgiHZFp5Hbc3DEG7oeo
         g5SXCTgsNoNx5rcWJkN7RnYUjrI4CprovNLlZvFmLINgkmaie4KYjJj+pRMoRDTQcI20
         fX+g==
X-Gm-Message-State: ACrzQf2LJ6MHqWfRUPiGaetvkXzRuz3iiXBOPYTcULFrqqHvtgUxVcCY
        YQKLQI8DQXUx4WZ8rzKzvoBdKkpGiZc=
X-Google-Smtp-Source: AMsMyM46J/xvPpXt5p433LibJT2hhJ63UmhwBXLWIa6/Lsm1EYuu2HBj1vKY2Qn5mSFqK6HiPCsD+Q==
X-Received: by 2002:a05:600c:1c03:b0:3b4:618b:5d14 with SMTP id j3-20020a05600c1c0300b003b4618b5d14mr625325wms.59.1664235314104;
        Mon, 26 Sep 2022 16:35:14 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id i1-20020a5d4381000000b002205cbc1c74sm80465wrq.101.2022.09.26.16.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 16:35:13 -0700 (PDT)
Subject: Re: [PATCH] branch: description for non-existent branch errors
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <c333cc4b-12a1-82b6-0961-1c42080dad15@gmail.com>
 <858edf12-67b1-5e2c-dd2e-3eb476530803@gmail.com> <xmqqleq6ovh4.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <26a5cbe2-d821-e7f6-e56f-4ad90ef2cf2d@gmail.com>
Date:   Tue, 27 Sep 2022 01:35:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqleq6ovh4.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/9/22 20:12, Junio C Hamano wrote:

Thank you for the review. I will do a reroll with your comments, but about..

>> +	if (copy && !ref_exists(oldref.buf)) {
>> +		if (!strcmp(head, oldname))
>> +			die(_("No commit on branch '%s' yet."), oldname);
>> +		else
>> +			die(_("No branch named '%s'."), oldname);
>> +	}
> 
> Let's not make it worse by starting the die() message with capital
> letters, even though the existing "git branch" error messages are
> already mixture that they need to be cleaned up later.
> 

I chose these literals for the errors because they are already translated,
appear below in that same file. I thought that would make the patch easier to
review and apply, for the translators too.

Maybe we can maintain those capitalized literals to have a simpler patch to
merge and leave the "mixtures" for a posterior patch.  I have already 
identified a leak in that command:

	static const char *head;
	...
	int cmd_branch()
	...
		head = resolve_refdup("HEAD", 0, &head_oid, NULL);

"head" is leaked but there is no easy free, because some exists are like:

		if (delete) {
			if (!argc)
				die(_("branch name required"));
			return delete_branches(argc, argv, delete > 1, filter.kind, quiet);

Without entering in this too much, maybe an atexit() approach, as in some
others commands... but maybe a more clear flow.. and that would need some
changes that can carry out the "mixtures".

Anyway, if you think there is no problem with the new literal in that file,
I will add it to the reroll with the rest of the comments in your review.

I pointed out in the first mail of this thread, there is already a patch in
'seen' that touches builtin/branch.c [1].  I would like to keep the patches
separated, but I don't know how to proceed: make the change from 'seen', keep
it from 'master'... Maybe you can give me some guidance in this.

Thank you.

Un saludo.
