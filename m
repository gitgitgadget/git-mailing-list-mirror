Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19F6F20248
	for <e@80x24.org>; Thu, 14 Mar 2019 01:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCNBO1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 21:14:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37107 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfCNBO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 21:14:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id y15so4026257wro.4
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 18:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=C0RkP3MmmTOVCwS2++GjxhbHcFu1Jz5LvJIkGZLCCMk=;
        b=MNVPz0cakCePU/6WzaMg4i9TXJypul+VTfnBz52tgYKoQR7GLlIZ+4lHOF8cO99XwH
         gl9dDTODefDSQ5g7R6QcFsVufIXXhXI2ezioNqBfyDJP1AclYw62QGIMbqO9iwAvnZde
         twCILsVfWfKOnPggFzVsBHXidTrjaipvNxOrqpCkx0+yO4bn/5oYY9AfUtDPYsKCWitY
         zkuQIzT5MztcAyh/km+RgXDAq9p9X7a24WTp5B1vXXqTqBykX7rlKNVS9zoM4pOosf3A
         fkqR/nK/gzo92LcX6a5sEOW3rqmoDOWAv2vXzNb4ouRpkdKJTipN5owmKaoTbuX/Ls9q
         Px2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=C0RkP3MmmTOVCwS2++GjxhbHcFu1Jz5LvJIkGZLCCMk=;
        b=AuJ/bG6DK/7QWHzzQ9nkpoRJ2JOfvmht0HibiaP5/s2nSdAYyCagkij2JZvlfCgLbm
         EoBDU8qR0euwoVrGBgyWZzi34QOHk1q2YG8dJ/Nh9z1ay77Z/9mzn7MIOQYnTko/sF5T
         0SLJM2TfixPlf7ggf6tOaESr79DiGfBvqyt+9kY4o/ag5NU4bD1TntP+Srb23lz/vfxF
         F02Jyjjc/CgGAjqMGXbSxctpHbUwqODSCmm/U/rYqFxYBw8y8QM/PIJdVJcyTVCyk2fF
         1hSgQNyJdaoi+sPIfzVLkxKDIDJA9REijbgRSfYdTLXlXZn8Ay3hMut/8N5iTBWz0VK5
         RCfw==
X-Gm-Message-State: APjAAAVfy9YDtyvZ+oFMK8UWFif3iDae0goy7zY02dDWiyEjDWxhTN4p
        95/s/tVgz7BMQdj7z7jJdyE2c3Du95A=
X-Google-Smtp-Source: APXvYqwXlMMZiy7N/oKzQy4DLJqWFCfLYiAyLbv9MG/Sspm0RthSeOGaY0PjaFQ8nJLY89L6M8hNfg==
X-Received: by 2002:a5d:4608:: with SMTP id t8mr31198458wrq.186.1552526064742;
        Wed, 13 Mar 2019 18:14:24 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o8sm884570wma.1.2019.03.13.18.14.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 18:14:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/4] sequencer: improve error message when an OID could not be parsed
References: <pull.161.git.gitgitgadget@gmail.com>
        <d8c4a3dde5bed492bcdb6399fd8a73ebf4798320.1552472189.git.gitgitgadget@gmail.com>
Date:   Thu, 14 Mar 2019 10:14:23 +0900
In-Reply-To: <d8c4a3dde5bed492bcdb6399fd8a73ebf4798320.1552472189.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 13 Mar 2019
        03:16:32 -0700 (PDT)")
Message-ID: <xmqqef7acl5c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The interactive rebase simply complains about an "invalid line" when the
> object hash of, say, a `pick` line could not be parsed.
>
> Let's tell the user what happened in a little more detail.

Makes sense.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 95dda23eee..f91062718d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2137,7 +2137,8 @@ static int parse_insn_line(struct repository *r, struct todo_item *item,
>  	item->arg_len = (int)(eol - item->arg);
>  
>  	if (status < 0)
> -		return -1;
> +		return error(_("could not parse '%.*s'"),
> +			     (int)(end_of_object_name - bol), bol);
>  
>  	item->commit = lookup_commit_reference(r, &commit_oid);
>  	return !item->commit;
