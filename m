Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC27A208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 17:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389700AbeHGTwi (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 15:52:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36673 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389213AbeHGTwi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 15:52:38 -0400
Received: by mail-wm0-f68.google.com with SMTP id w24-v6so18980200wmc.1
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 10:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=luHI1NQ1CIztEwYq/NB9lz13H5f9D+qxH0e6nbOG9vM=;
        b=ZhZkl/FxhQ9rm2bMbq+Jc1x23/M+8h4g+i/sfZaAkpz819T1pelhNnfM8+OgwaDfKe
         17Db4/E7rZY2P4NEiAVuwVUvagxJc44EopP5Iqlpt5isDoJmze/45RP4tS4YAV1fd3j1
         HpfYkg4uoztRoRUog18UTBTq+0b/32ZBNuQGo+qMglZnORhcZy1bL7Zb+GmD/c4o4fWw
         tkxO2lZ40URGTOoJJd5QsFBdNayQos6SILPVTpHWFfX6uSADPKXmD8bCzEZdbh6ULQDp
         qTEFpyp3pM67TV/AI6107i3g0d7eZ29xn7Ecx8Sz+MMpsXHsPfOvt8HabPgmwwPuBGo3
         ZAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=luHI1NQ1CIztEwYq/NB9lz13H5f9D+qxH0e6nbOG9vM=;
        b=tFZzOUT77wLpI2dFop2BG5yq7RBzKWi+4kdGXiHG1uqbU+W8zCXka7zCfAwsF5Us7M
         45j095w3Y6Ibj4FOJKfn6tk8+UgKO5s+pBIFy8VzT0aHCMiR128t0jugw00uwy3DWL3y
         ymT869How5MFW49KQdgW6BoviZ8dGGwmd4gsHagMyeOLvtaeM1cVAck83eG3COZo9J1t
         bzND5yI2WDC8zmT87wbHNLQnGPu/zzs/B4m4EHkPap64VGwMCQnVRvkGGI917FSwuvOP
         o7awBZWusTArpmnF7CiZ+TDCbKbJMPRFxxqs25oV37RhrvMR0CwDenqh43E3GxNVYkHz
         j/TQ==
X-Gm-Message-State: AOUpUlFI0kcrIGzuUvYZKPzIrnTO/8w5h+oOqDPPs/jv7VXmNixEvVe3
        HFjI2qnvzI+zhghT+ZryW9s=
X-Google-Smtp-Source: AA+uWPyCxyehzoomKk1+tZ6KenSmRzR6VtD8Yd/1vmIcpVrDOnB0zJ5UIGVSag9jnNnj39DdEGxPjQ==
X-Received: by 2002:a1c:e409:: with SMTP id b9-v6mr2225917wmh.34.1533663433161;
        Tue, 07 Aug 2018 10:37:13 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v124-v6sm3412828wma.18.2018.08.07.10.37.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 10:37:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: Re: [PATCHv3 5/5] t7406: fix call that was failing for the wrong reason
References: <20180806152524.27516-1-newren@gmail.com>
        <20180807164905.3859-1-newren@gmail.com>
        <20180807164905.3859-6-newren@gmail.com>
Date:   Tue, 07 Aug 2018 10:37:11 -0700
In-Reply-To: <20180807164905.3859-6-newren@gmail.com> (Elijah Newren's message
        of "Tue, 7 Aug 2018 09:49:05 -0700")
Message-ID: <xmqqftzqkri0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> A test making use of test_must_fail was failing like this:
>   fatal: ambiguous argument '|': unknown revision or path not in the working tree.
> when the intent was to verify that a specific string was not found
> in the output of the git diff command, i.e. that grep returned
> non-zero.  Fix the test to do that.

Nice.  All other patches and the final shape of this script look
sensible.

Thanks.

>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t7406-submodule-update.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index 5b42bbe9fa..7dd1c86b02 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -603,7 +603,8 @@ test_expect_success 'submodule update - update=none in .git/config but --checkou
>  	 git diff --name-only >out &&
>  	 grep submodule out &&
>  	 git submodule update --checkout &&
> -	 test_must_fail git diff --name-only \| grep submodule &&
> +	 git diff --name-only >out &&
> +	 ! grep submodule out &&
>  	 (cd submodule &&
>  	  ! compare_head
>  	 ) &&
