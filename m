Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0998D20248
	for <e@80x24.org>; Mon, 11 Mar 2019 01:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfCKBt5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 21:49:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45405 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfCKBt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 21:49:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id o7so3241350wrp.12
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 18:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HxrzJhx70wWxfHgLSnWVAbJBBKVyawfPwjd2wdEuETk=;
        b=i86ljPhvzicDUxJls22MUjOTbJOFTqfDftivZDf8eqkAVHlzP5+BzuLLMOh9Fp3y1s
         St3V7LTj/kcPOqfvOVJgLMTrrChOiCRYGtwrKSyMaTlqQDd0MWQJyZhZEiPO6x/khjpP
         b7dDo9mPEe4Tuxh0m+J5wzfZz7fWb/aGMB9wy8a2N24n5MXmKm+MbgYDIsn1S5p2kevr
         yiWmBK/rQImupQsEHGhrKEP+/Bg81HNXXbfByyZnWAzLA80VsWtceUSnTdpdz306DzvH
         CRx8dOrDTNgV5p2bQw5KKV8kztTZrhdvgsvRXbdcRgbKv5CTOQqaoIilQGeC48QecCSZ
         /+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HxrzJhx70wWxfHgLSnWVAbJBBKVyawfPwjd2wdEuETk=;
        b=J/C2B8SYv0IIeaIDm+DVUJ4JyrRdN6UK1UPjgAuPHvYR4ULCXZ365iiMBHH43oXdfG
         v6GJYTHl7TAWVgFO+JTS1DDATXKM4C/dDXSBfRa/BgDZCn/U1lyYYv9RV5TSIxPB6oM3
         WIpNFFQ6mJJw0c6geyGPotbdULlXj83UmhPd7zYQxgWYIYJS6pbqLmpmqHetvvziEdDA
         dct9JYLvMn6nyftuj6VohuHi2ekyiH/eOJPvWB+IUPltMTJBBptRgohPgM6c+38PFIWT
         V6oLMlFaEu0h5TsKG7OeApxVuA5bZb+Z/KPtQII6ooFKeX73O46aw1R6VRwe2YIF1Mvh
         dRZg==
X-Gm-Message-State: APjAAAVTAIh42YH7cXU7zDaDtmgMeMXB680/kEiBZBIpxuDqytPAqngk
        Q+a3FqFvFf1YMN2qLmlHuM8=
X-Google-Smtp-Source: APXvYqwBiDIvkI8ae9h0diowtr1LzD4rpMhAApex1dFzLT05Mxd6/7ZvldU0oszjECMM+UD7bR5N3w==
X-Received: by 2002:a05:6000:10ce:: with SMTP id b14mr19526948wrx.221.1552268994717;
        Sun, 10 Mar 2019 18:49:54 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id v1sm5185537wrt.88.2019.03.10.18.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 18:49:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] line-log: suppress diff output with "-s"
References: <20190307194514.GA29260@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1903081636350.41@tvgsbejvaqbjf.bet>
        <20190308162031.GA17326@sigill.intra.peff.net>
Date:   Mon, 11 Mar 2019 10:49:53 +0900
In-Reply-To: <20190308162031.GA17326@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 8 Mar 2019 11:20:32 -0500")
Message-ID: <xmqqef7emb7i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Mar 08, 2019 at 04:38:44PM +0100, Johannes Schindelin wrote:
>
>> On Thu, 7 Mar 2019, Jeff King wrote:
>> 
>> > When "-L" is in use, we ignore any diff output format that the user
>> > provides to us, and just always print a patch (with extra context lines
>> > covering the whole area of interest). It's not entirely clear what we
>> > should do with all formats (e.g., should "--stat" show just the diffstat
>> > of the touched lines, or the stat for the whole file?).
>> > 
>> > But "-s" is pretty clear: the user probably wants to see just the
>> > commits that touched those lines, without any diff at all. Let's at
>> > least make that work.
>> 
>> Agree. The patch looks obviously good.
>
> Thanks. This leaves the other formats as silently ignored. Do we want to
> do something like this:

It probably would make sense to do this if only to avoid surprises.

>
> diff --git a/revision.c b/revision.c
> index eb8e51bc63..a1b4fe2aa6 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2689,6 +2689,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  	if (revs->first_parent_only && revs->bisect)
>  		die(_("--first-parent is incompatible with --bisect"));
>  
> +	if (revs->line_level_traverse &&
> +	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH|DIFF_FORMAT_NO_OUTPUT)))
> +		die(_("-L does not yet support diff formats besides -p and -s"));
> +
>  	if (revs->expand_tabs_in_log < 0)
>  		revs->expand_tabs_in_log = revs->expand_tabs_in_log_default;
>  
>
> ?
>
> -Peff
