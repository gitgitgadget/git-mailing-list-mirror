Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CF4C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 19:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC02261153
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 19:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238438AbhD0T3y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 15:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbhD0T3y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 15:29:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEC8C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 12:29:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id mu3so32244ejc.6
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 12:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uyi0PWzSVCsw1dHASrjzKOwkPo9Qan5oFffs3oUAqwY=;
        b=ljO24UUg1QYOwkYqNPR/rZd1UmGCHqEhfcwLcnjqkmDtbCF29piGp8BnwRF3ALmO0d
         RJn5TJm+09e/mPzgs4TrIRO7m7FAeGrIXfvkXR6PWWejYIpfuxyYpPllwIp076RCx/+D
         WkQSSyvmqYFAcTx4iI00F//MA5ZwNsYclcBADKuhtd8YNQB9Y+W4GGBTemjcZCPpnt3y
         IWHkuRN4QH501T729jbbfOYuwN3Rr75SQ8KqP3FXV0dbgdtDEN7W/GnRzyzT0iGL/2iN
         sx3JDD/cLnCZL91IcW45f5zj70t/Sp6IBjmOHSSfARwGfiZAhTsB2NH0eHDDtkVEiYgM
         kRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uyi0PWzSVCsw1dHASrjzKOwkPo9Qan5oFffs3oUAqwY=;
        b=atCg+wKIh61fBDB0ZoWv3NTr8YVuizboVZReu7wMC0L9E7u8lOrnk2F9ESpkJi+/F6
         NTZ91kJJmFEElQkIkhfh2UnGRBKFmtJWUT9NIQUgaEseu0J0+KsytDinsG8qcAgYVXY5
         4pxfMJrITm37lE5CPaMCRUoOFFgJ1u5PuuTTyuFstQ4yk4FNp1ql9FyAk6NoPTziuQJO
         oRvdhWHy+VbF9Xz/gQLYluz889vATyc33qXOsXHPI72lXC9Tk5h+kPrJHtfkh10XtT16
         Ps7Y/a9jIeQ1BUsCXJG60WZQ4iK2UzchZsARKJpL+ycKh/SDngSgnxSG8eL6plf1wmRx
         q1ZA==
X-Gm-Message-State: AOAM530FpS2jI9wak+LZmv/FDs4oAX4YhHS7ybl5vIbZoTtxLw8A1gJ0
        eaNY85euxhsLoxHnR2/1ZiSV9T4OFl4=
X-Google-Smtp-Source: ABdhPJxkgoUgiPWb5b9Vz6l8HG8NN5Aae23ysrasRDjr4N3PEalKWS9z5rlgpY7LZM69Ic+iznS5vw==
X-Received: by 2002:a17:906:5203:: with SMTP id g3mr24277854ejm.95.1619551749301;
        Tue, 27 Apr 2021 12:29:09 -0700 (PDT)
Received: from gmail.com (193-81-60-66.adsl.highway.telekom.at. [193.81.60.66])
        by smtp.gmail.com with ESMTPSA id h15sm2958593edb.74.2021.04.27.12.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 12:29:08 -0700 (PDT)
Date:   Tue, 27 Apr 2021 21:29:06 +0200
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Robin Moussu <moussu.robin@pm.me>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Request: `git restore $commit $file` =?utf-8?Q?shouldn?=
 =?utf-8?B?4oCZdA==?= override uncommited changes
Message-ID: <20210427192906.7obdkopxwajqnv53@gmail.com>
References: <pYZzGPZTHnJjYBKrUAVGcso74I_xJgfzNpSwDN94fhYcDoOamp62-IFvxVrU056uw0txy3MTHYSwny_II0XY4trSY5_E25q7EXwhNHjy3VY=@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pYZzGPZTHnJjYBKrUAVGcso74I_xJgfzNpSwDN94fhYcDoOamp62-IFvxVrU056uw0txy3MTHYSwny_II0XY4trSY5_E25q7EXwhNHjy3VY=@pm.me>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I would have expected that `git restore $commit $file` would copy the
> content of said file from another revision only if your don’t have
> uncommitted changes or to get an error.

The positional arguments to "git restore" are files.  So that command will
error unless a file called $commit exists.
(You shell's tab completion should guide you here.)
You can use the --source option to specify the commit.

> If it was really what I wanted to do, I would have expected to either do
> `git restore $file && git restore $commit $file`, directly `git restore
> --force $commit $file` or something similar.

Is your question that you expect a command like

	git restore --source=some-commit some-file

to error if you have uncommitted changes (to "some-file")?
And instead you would run

	git restore some-file
	git restore --source=some-commit some-file
