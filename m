Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C24C77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 09:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjEQJYB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 05:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjEQJX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 05:23:59 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C9EE67
        for <git@vger.kernel.org>; Wed, 17 May 2023 02:23:58 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f42b984405so3388145e9.3
        for <git@vger.kernel.org>; Wed, 17 May 2023 02:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684315436; x=1686907436;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zgDPcLL5qKa4PzYrakB0KknDdrbDjbAKgFtWQbUSO34=;
        b=r9xYS9Wh73qqFWq3VaSpIjmcRVDgKNpvCrOiODk7jh1DDeEPcZXyZjtP+bbkNXDg5R
         o1LoyH+I9WLhWxhmlTpNMEOQ+3lTdCugY2vhkrel85egk0TUnxE/bqDyRMgO/pasputw
         WIZi+njSHJSaNxbKxJ5X3HcruB+enOfFVFp+WoPsLyDnaKAccQKbQb5J7kQXW3tdI8D6
         QkRgkRVubTM8nqC1WSt/r5GdatKOT85im94iaJu1XyARfJptta4hi8KhDmlYwl+DM1Te
         NVE+MULXueqHt1lOaJo0K3Eg17Gw+WqF8inMntx4ESgdExDVip2uNcI+XPVDEs8juwMI
         CjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684315436; x=1686907436;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgDPcLL5qKa4PzYrakB0KknDdrbDjbAKgFtWQbUSO34=;
        b=Z9TAZ72hV2no20135DHrQu5aBrYVQT6xtZlYiHnMqj2PhRh5J9f7BPhk5XNsu+eaCC
         HYqjrkp0HLqN0tLB+ePGLmxLGWqXIg2RT+hhdrRGfirLf7ADiGWDRiC6uHz0rXtUUUJt
         OYSWpRX9o1ldUp14jRW2C0uaXUldO+fGZV8nKC/pPfVp4fHQia0cFzr0GF+svYPh5ziy
         dZ1ZUDrQiFu7fnxkyVDUEqPHHUtdqt7337KyzOXnfDS4n+0pR/YdvtRxohmemGG1zHQZ
         Gq7Rrk/wkvwyObHJjp8UeFVBeXjsGBKKhZHcjb/JzVvM93g65v2ls+QdI0INumHEvI8k
         jtvw==
X-Gm-Message-State: AC+VfDzLYtLgn23gnCMcfdjINCyLC6OBZ4QgXwIVbDkrZFe4IgjhjIqE
        +oSpFcquNaYy2G2aEyeN16I=
X-Google-Smtp-Source: ACHHUZ61YSdtPO5N/zRXeLW6Og8w2ZsPU7yDfUNUKqbrVNlFZC540XCMBGUYNNNcetU8mkN0SRkSZQ==
X-Received: by 2002:a1c:f718:0:b0:3f5:18f2:8557 with SMTP id v24-20020a1cf718000000b003f518f28557mr2742360wmh.33.1684315436331;
        Wed, 17 May 2023 02:23:56 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bcb93000000b003f4247fbb5fsm1578922wmi.10.2023.05.17.02.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 02:23:55 -0700 (PDT)
Message-ID: <a803e1ad-1025-164a-f7ca-cc1a41e4f12b@gmail.com>
Date:   Wed, 17 May 2023 10:23:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] t/lib-rebase: (mostly) cosmetic improvements to
 set_fake_editor()
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
References: <20230323162234.995450-1-oswald.buddenhagen@gmx.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230323162234.995450-1-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald

On 23/03/2023 16:22, Oswald Buddenhagen wrote:

This project avoids commit messages that are a list of changes instead 
preferring the commit message to explain _why_ the changes are being 
made. The reason for this is that it makes it much easier for a future 
contributor to understand the reasoning behind a particular change. 
Having a list of changes is often a symptom that the commit is trying to 
do more than one thing at once and should be split up. Here there are 
three separate changes all mixed into the same commit.

> - Make the documentation reflect better what actually happens, and add
>    some missing info

Having read the proposed changes to the documentation I'm not sure what 
it is in the original you're objecting to. The script may well process 
each token separately but as far as the user is concerned it appears to 
take either "<cmd> <lineno>" or "<lineno>"

> - Fix recognition of reset's short command in FAKE_LINES

This fix is definitely needed and should be in its own commit in a 
separate series to any of the other changes here so it can be applied 
without being held up by discussions on those other changes. Presumably 
we don't have any users of the short reset command name as it has been 
broken ever since it was introduced in 5dcdd7409a (t/lib-rebase: prepare 
for testing `git rebase --rebase-merges`, 2019-07-31)

> - Default next action after 'fakesha' to preserving the command instead
>    of forcing 'pick'. This is consistent with other "instant-effect"
>    keywords.

I'm not sure what the motivation for this change is. What does it 
facilitate that we cannot do now and why do we want to do whatever that is?

Best Wishes

Phillip

> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> ---
>   t/lib-rebase.sh | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
> index 7ca5b918f0..184b25b427 100644
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
> +#       "drop", "merge[_-{c|C}_<SHA1>]", or "bad" for an invalid command.
>   #
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
>   #
>   #   "#" -- Add a comment line.
>   #
> @@ -49,7 +52,7 @@ set_fake_editor () {
>   	action=\&
>   	for line in $FAKE_LINES; do
>   		case $line in
> -		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d|label|l|reset|r|merge|m)
> +		pick|p|squash|s|fixup|f|edit|e|reword|r|drop|d|label|l|reset|t|merge|m)
>   			action="$line";;
>   		exec_*|x_*|break|b)
>   			echo "$line" | sed 's/_/ /g' >> "$1";;
> @@ -64,7 +67,7 @@ set_fake_editor () {
>   		fakesha)
>   			test \& != "$action" || action=pick
>   			echo "$action XXXXXXX False commit" >> "$1"
> -			action=pick;;
> +			action=\&;;
>   		*)
>   			sed -n "${line}s/^[a-z][a-z]*/$action/p" < "$1".tmp >> "$1"
>   			action=\&;;
