Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23555C04A6A
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 13:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjHINEL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 09:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjHINEK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 09:04:10 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E37C2101
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 06:04:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-317e14b0935so539731f8f.0
        for <git@vger.kernel.org>; Wed, 09 Aug 2023 06:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691586248; x=1692191048;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SpCKtqS0GKn/wmzfdqott9saeBKi7ch22W9qtw4HT7M=;
        b=HchQ4m83KtaCw49M+IlbGqSOZ73ywJ2bpChY6YnR9GTeYlVrIOUWr2pBZBWAs8kUqJ
         JmeZnm7ZaV1tqwmvSkTlDudK+3aFrU2jVaZAuz56dVRBdKsMgBpiLwg6FkuI1Dzm6QVp
         PwaAuLXtm3eZoNh2Q1RY5AdsC+wOLtmSQVU1fhe6nLllnxVvidsQIbjNl+1RjptPs3kv
         AWZz1atC1ss85F8kiD4GqYLEnK9ucHdgd8jt4KxHUg4338gsCGxrT9O8d8NPQpbaeIxI
         y21QfVG0JZuCeVGbBqF/eb3BC8M3pHznt4qUYJrw0INmYcZ9XbCJWn27jeAYGmPorPLk
         Uq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691586248; x=1692191048;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SpCKtqS0GKn/wmzfdqott9saeBKi7ch22W9qtw4HT7M=;
        b=L0w3vmsE1GldwpdieP9U6Qe2cX1ahpiQKxNMIG3afMEUPT7Km6oBXw63HxPJEcO14D
         4MBRl3cv/GedmWFit09ufa2LY1fjwIGRmE++LZtJ3rxb4QjpR7S37+RYyQcmTghyU5kM
         trwGaM67B3Vq44TVhoSYdpXoPN4imFhjvJXSzlkGN22+j7G+P8DfyvIjw0bD+fzkE9BV
         up0nYLvTIE4GmCD3RS6/O1LXoqSSvWgq1nkwZbwWM4e3ClLe4Vs2HbkYxUN2pADOeg6D
         VvQFfybmJ25+PxSGF3izLDAx48QyRxuQnu9iQW91PaZAosrPo+KQZ67ziTQG569+7yVj
         A7tA==
X-Gm-Message-State: AOJu0YxIC8wTFc6aoKM6E0lg39FHwBL2KT93TD6msLXQfUXTYFOsvvDF
        dC36WG8dT6HX814WVLC/s34=
X-Google-Smtp-Source: AGHT+IFKo94posfsIVF1tnFsiOCEL265vqB93tSfKoyU/n9PHB61gRxbgTQ9doNiJY6+pPBo5nx7ug==
X-Received: by 2002:adf:f2cd:0:b0:314:c6b:b9a2 with SMTP id d13-20020adff2cd000000b003140c6bb9a2mr2538705wrp.13.1691586247585;
        Wed, 09 Aug 2023 06:04:07 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id s18-20020adfeb12000000b0031779a6b451sm16763213wrn.83.2023.08.09.06.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 06:04:07 -0700 (PDT)
Message-ID: <8ce40f48-f36f-9e81-1a3f-9d8b170c4a0f@gmail.com>
Date:   Wed, 9 Aug 2023 14:04:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] t/lib-rebase: improve documentation of
 set_fake_editor()
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
References: <a803e1ad-1025-164a-f7ca-cc1a41e4f12b@gmail.com>
 <20230807170935.2336663-1-oswald.buddenhagen@gmx.de>
 <20230807170935.2336663-4-oswald.buddenhagen@gmx.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230807170935.2336663-4-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald

Thanks for splitting these patches up. We generally prefer commits 
message to be prose explaining the reason for the change rather than 
bullet points.

On 07/08/2023 18:09, Oswald Buddenhagen wrote:
> - Make it reflect better what actually happens.

> This makes it easier to
>    fully exploit the possibilities and to modify the code.

I don't really see how this follows from the first sentence.

> - Improve the structure, putting more general info further up.

Good idea

> - Document `fakesha` and `break`.

Great

> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> ---
> Cc: Phillip Wood <phillip.wood123@gmail.com>
> ---
>   t/lib-rebase.sh | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> index 9ed87ca7ab..184b25b427 100644
> --- a/t/lib-rebase.sh
> +++ b/t/lib-rebase.sh
> @@ -8,18 +8,21 @@
>   # - check that non-commit messages have a certain line count with $EXPECT_COUNT
>   # - check the commit count in the commit message header with $EXPECT_HEADER_COUNT
>   # - rewrite a rebase -i script as directed by $FAKE_LINES.
> -#   $FAKE_LINES consists of a sequence of words separated by spaces.
> -#   The following word combinations are possible:
> +#   $FAKE_LINES consists of a sequence of words separated by spaces;
> +#   spaces inside the words are encoded as underscores.
> +#   The following words are possible:
>   #
> -#   "<lineno>" -- add a "pick" line with the SHA1 taken from the
> -#       specified line.
> +#   "<cmd>" -- override the command for the next line specification. Can be
> +#       "pick", "squash", "fixup"|"fixup_-C"|"fixup_-c", "edit", "reword",
> +#       "drop", "merge[_-{c|C}_<SHA1>]", 

There is an inconsistency here in how we document fixup and merge. The 
former explicitly lists all possibilities and the latter uses a more 
compact notation. Note that we use docopt style descriptions for options 
so "{c|C}" would be written as "(c|C)". Also "merge -c/C" takes a 
commitish (which we could write as <rev>" rather than a hex object ID.

 > or "bad" for an invalid command.

This is a useful addition

> -#   "<cmd> <lineno>" -- add a line with the specified command
> -#       ("pick", "squash", "fixup"|"fixup_-C"|"fixup_-c", "edit", "reword" or "drop")
> -#       and the SHA1 taken from the specified line.
> +#   "<lineno>" -- add a command, using the specified line as a template.
> +#       If the command has not been overridden, the line will be copied
> +#       verbatim, usually resulting in a "pick" line.
>   #
> -#   "_" -- add a space, like "fixup_-C" implies "fixup -C" and
> -#       "exec_cmd_with_args" add an "exec cmd with args" line.
> +#   "fakesha" -- add a command ("pick" by default), using a fake SHA1.
> +#
> +#   "exec_[...]", "break" -- add the specified command.

Something like
	exec[_<command ...>]

would be more accurate I think

I think with a couple of tweaks this would be worthwhile improvement to 
the documentation. Having comprehensive coverage of all the commands is 
very welcome.

Thanks

Phillip

