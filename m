Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABFAC433EF
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 13:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377568AbhKZNkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 08:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbhKZNic (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 08:38:32 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EF6C061D65;
        Fri, 26 Nov 2021 04:51:48 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id g14so38523148edb.8;
        Fri, 26 Nov 2021 04:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=v5ubltlmh7HwcaOKk8hcp5eke1SqadASbK2MkSPheCk=;
        b=JRpUQ3lblU8Uct9oRCblrUyDn/9yvOWbry9Ga6VzD9eDDnG4RYpG++iWlk9drpnu6c
         Hsss3QwXi+D3r0e2TWeZGf5GrMdKq2juJGhos8/hzVYversBxmURtgLqF4TaEiVaCO5D
         rhLernDyNgYKtNRbKOYzBaogkVhWGCIsgK3uCd9P4roaama417hFhi5IaQJ9GGXYkpEb
         16rLGfPjOYhDKKfvQo2ww/o1730cc3YxH31ssTxRRRsSFsaPKgbw0gKA0H0Y35NLbrsM
         SAH1RZ6gFBBMkEl+nz8uJcWSiBNO/qcTCxQNZD07tpwVTItg8uV5zT80Tx44fokjdgiB
         DDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=v5ubltlmh7HwcaOKk8hcp5eke1SqadASbK2MkSPheCk=;
        b=BCNeeAwudI9U0QYul2w32Io22UIoCoGgEbnL1flyBo3E/yzVFxgguVxxUDLOQFnRB/
         DwtAb8VyUtsVxUhZg7e9oTaOlg+1j0vpRvIOoYmlnz84/xUkKpJFyH1rcym1WaXmqDkl
         OfEXf7f635uKsOS9iXs9jkgKurxTtngoqtES6KoncLknw6CDrwLCWSxaa7GxhomoyRDO
         vPmRz0rkd9Qsy2iGmWdKzIOhVa4+yh0bnZiZBHseJeDe359peJYbAXXarZQk2mlDD8Nk
         PwO/JY3bT1wbuMsZeCd4FH5QYdr1P66nUO82we95AJQ54T7g3TVToRccaJ/7eTfhtFc2
         Qnrg==
X-Gm-Message-State: AOAM5322oAltrTYTO76GodDMGIIw0dTucQqStkaDbwz7aMienv9+4ZDu
        HDdggbCMANtPjDrEvHMw+8TH/9H0Zggqog==
X-Google-Smtp-Source: ABdhPJy+zxtQa2O5R8OWk6Unjelnq2dHjoOthQ0h7ouHIG6/46sKVD6b+Fmlpkx88/a7fPOsz/NsZg==
X-Received: by 2002:aa7:d58c:: with SMTP id r12mr48004091edq.115.1637931107069;
        Fri, 26 Nov 2021 04:51:47 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d1sm3989202edn.56.2021.11.26.04.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 04:51:46 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mqahd-000PaX-QE;
        Fri, 26 Nov 2021 13:51:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Wong <e@80x24.org>, Thorsten Leemhuis <linux@leemhuis.info>,
        workflows@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, git@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags
 'Reported:' and 'Reviewed:'
Date:   Fri, 26 Nov 2021 13:49:16 +0100
References: <cover.1637566224.git.linux@leemhuis.info>
 <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
 <20211123185237.M476855@dcvr> <xmqq4k825o6r.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqq4k825o6r.fsf@gitster.g>
Message-ID: <211126.86h7bzhyfy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 23 2021, Junio C Hamano wrote:

> Eric Wong <e@80x24.org> writes:
>
>> git send-email's capitalization does annoy me and I've looked
>> into changing it; but there's a bunch of tests and probably
>> dependent code that also need to be updated...
> [...]
> diff --git i/git-send-email.perl w/git-send-email.perl
> index 5262d88ee3..a61134c7d3 100755
> --- i/git-send-email.perl
> +++ w/git-send-email.perl
> @@ -1494,7 +1494,7 @@ sub send_message {
>  To: $to${ccline}
>  Subject: $subject
>  Date: $date
> -Message-Id: $message_id
> +Message-ID: $message_id
>  ";
>  	if ($use_xmailer) {
>  		$header .= "X-Mailer: git-send-email $gitversion\n";

Perhaps one way to split this & make it more readable is to split this,
i.e. the mesage-id's send-email itself generates & tests, usually it
passes along format-patch's.

> @@ -1789,7 +1789,7 @@ sub process_file {
>  				$has_mime_version = 1;
>  				push @xh, $_;
>  			}
> -			elsif (/^Message-Id: (.*)/i) {
> +			elsif (/^Message-ID: (.*)/i) {
>  				$message_id = $1;
>  			}
>  			elsif (/^Content-Transfer-Encoding: (.*)/i) {

Not strictly needed due to the /i, maybe splitting out cosmetic changes
would be better?

I also notice we have various hits for "git grep message-id", including
regex checks you didn't update here.
