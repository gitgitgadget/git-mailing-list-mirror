Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78291C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 21:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241851AbiF0V6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 17:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241335AbiF0V41 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 17:56:27 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7501193C1
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 14:55:34 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA0641304B0;
        Mon, 27 Jun 2022 17:55:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HvKUEXJp0ZmclYUDroYO/w9NwBZMLoiUf1YhTF
        IgHe4=; b=ArWlf1EzJ4Wn5fA1spwaAKX69daX6PfVKNmz45A/pZinNORLyb6rWC
        fO36mx86gZCemzH+eZY7IiL6TvwQoVPW41j6zZi85a3r7ACYYbD3q+q4O4dM7AM4
        gStuAJW6G58LdD7Ckhk+N2etq3BNTGd54qXYw72ys08uvTdldJSKU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 980D61304A9;
        Mon, 27 Jun 2022 17:55:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2547A130493;
        Mon, 27 Jun 2022 17:55:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, chakrabortyabhradeep79@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] vscode: improve tab size and wrapping
References: <pull.1271.git.1656354587496.gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 14:55:31 -0700
In-Reply-To: <pull.1271.git.1656354587496.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Mon, 27 Jun 2022 18:29:47
        +0000")
Message-ID: <xmqq8rphojos.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD9A6D4A-F663-11EC-80A4-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The contrib/vscode/init.sh script initializes the .vscode directory with
> some helpful metadata so VS Code handles Git code better.
>
> One big issue that VS Code has is detecting the tab width based on file
> type. ".txt" files were not covered by this script before, so add them
> with the appropriate tab widths. This prevents inserting spaces instead
> of tabs and keeps the tab width to eight instead of four or two.
>
> While we are here, remove the "editor.wordWrap" settings. The editor's
> word wrap is only cosmetic: it does not actually insert newlines when
> your typing goes over the column limit. This can make it appear like you
> have properly wrapped code, but it is incorrect. Further, existing code
> that is over the column limit is wrapped even if your editor window is
> wider than the limit. This can make reading such code more difficult.
> Without these lines, VS Code renders the lines accurately, without
> "ghost" newlines.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---

Nicely described and I found it very easy to understand the
reasoning behind every change, even though I am not a regular user
of the VS Code environment.

>     Abhradeep was having similar issues, which drove me to actually submit
>     the change.
>     
>     Thanks, -Stolee

Thanks, both.

>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1271%2Fderrickstolee%2Fvscode-improvements-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1271/derrickstolee/vscode-improvements-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1271
>
>  contrib/vscode/init.sh | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/vscode/init.sh b/contrib/vscode/init.sh
> index f139fd86444..521d3037225 100755
> --- a/contrib/vscode/init.sh
> +++ b/contrib/vscode/init.sh
> @@ -25,8 +25,12 @@ cat >.vscode/settings.json.new <<\EOF ||
>          "editor.detectIndentation": false,
>          "editor.insertSpaces": false,
>          "editor.tabSize": 8,
> -        "editor.wordWrap": "wordWrapColumn",
> -        "editor.wordWrapColumn": 80,
> +        "files.trimTrailingWhitespace": true
> +    },
> +    "[txt]": {
> +        "editor.detectIndentation": false,
> +        "editor.insertSpaces": false,
> +        "editor.tabSize": 8,
>          "files.trimTrailingWhitespace": true
>      },
>      "files.associations": {
>
> base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
