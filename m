Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 322201F453
	for <e@80x24.org>; Tue, 29 Jan 2019 20:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfA2UOF (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 15:14:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35554 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfA2UOE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 15:14:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so19350929wmt.0
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 12:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zCnvrJhDTQjHnn7r/Lcjg6bIazFg7YOUjIAWHQwxfRc=;
        b=JR6MVxrLHWgRzRAlZdWlS5gth2x+aJvsVS5gxUpAlhIgq3vXuzgGxma8ocS6d1EJm1
         EBjACbhxr1DmO+x+7hjnKNCo3SdJEmcltT6/lsb/G0JXx9jnN00art2/FKGGgQAz0IPp
         SOdPKmNsx6yCBtFr+cBaLoZDiQI1hILxCwEs3x/4EOSvbOHbgXxtTUthBI2T7uQeh+6b
         K+kHdCHukINggmcs6Q7hZ7r/ZidANeG5C4/B+kl/hbRbxD1cgLVKH0SUmB5TzglCfTiS
         Pd5iBUPPEpO1h+rX2kqzh2y759DFOa7dTP2G77OBqhbMvPHR3/FjAxpfLmvx2wT+Z2Go
         Hxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zCnvrJhDTQjHnn7r/Lcjg6bIazFg7YOUjIAWHQwxfRc=;
        b=T18nb88r7U1xAyrKxgSfi+CHSpYI32xcXGB1el/dtSlmLh8cZqBaA4EaDKxBAq0TIW
         Ye5wIrBEAO24g+hlulrfo8L0OLaWzjTxNayu7Az1xmTWDxn+mDxJjMym1xWNkYHJwY0f
         nKlgztVVHoJ5N3zR2lpUcrGw5iCxsX+WMa2DTpx2rKRZl6V0XgW1KgwjU4N1Bv/bWfzF
         al2VDFGgdW4WZimgbzOHDHYa9arB3cpDxVzw+/2zr27O3Z/pbOCPUyHfKN3Y1HuUAeL3
         yqoGNOjKZKDqdbfJnkYj0/16hFrY2eJQeykYJodXNDTQgsy4jBhFgSjKQqESp3rIoeXN
         ZWfQ==
X-Gm-Message-State: AJcUukeQ8c2Zp2I+P6zGy9DkI5IVKc1Wg3OddkVg93jRfKRki7YTDULv
        6j9cuJ8oJrsHyS1acUMir+k=
X-Google-Smtp-Source: AHgI3IbY3HL55DAa5Q61OgQYtvPJinw+mSmGuIHOxmGOsIDRI0u/81pevZ9M5jGbfeWEust9ZIlCbg==
X-Received: by 2002:a1c:c282:: with SMTP id s124mr11858291wmf.105.1548792842184;
        Tue, 29 Jan 2019 12:14:02 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o64sm2930059wmo.47.2019.01.29.12.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 12:14:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v6 10/16] sequencer: change complete_action() to use the refactored functions
References: <20190123205821.27459-1-alban.gruin@gmail.com>
        <20190129150159.10588-1-alban.gruin@gmail.com>
        <20190129150159.10588-11-alban.gruin@gmail.com>
Date:   Tue, 29 Jan 2019 12:14:00 -0800
In-Reply-To: <20190129150159.10588-11-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 29 Jan 2019 16:01:53 +0100")
Message-ID: <xmqqo97z6x2v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

>  	if (opts->allow_ff && skip_unnecessary_picks(r, &oid))
>  		return error(_("could not skip unnecessary pick commands"));
>  
>  	if (checkout_onto(opts, onto_name, oid_to_hex(&oid), orig_head))
>  		return -1;
> -;
> +
>  	if (require_clean_work_tree(r, "rebase", "", 1, 1))
>  		return -1;

This hunk was fishy (in my tree, there is no such line with ';'
alone, as I believe that we've already fixed it) and made me spend
some time to figure out why the patch does not apply, but once the
cause was known it was trivial to fix.

I've looked at the difference since the previous version, but in
essence, the only change I saw was that four instances of similar
expressions are replaced with calls to a new todo_item_get_arg()
helper and no other changes.

Thanks, will replace.

