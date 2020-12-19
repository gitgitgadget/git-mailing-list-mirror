Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82915C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 11:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43B75233A2
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 11:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgLSLPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 06:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgLSLPe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 06:15:34 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867EAC0617B0
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 03:14:54 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id x22so5230687wmc.5
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 03:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oMwRgOws5V5Qy4x5HbXd98WXnPwz75YDILr4Oja2Rws=;
        b=bjeJ0Oq0HzvRn0gRa7zCTojetF0dydh8w9qhDJZzyQtJoXM6YQBW3zSFoGBxacjlNx
         YX5HyMY0bv1bUbe83G8UuXF9zzIxj0LBH0wMtiZNC9uLp2u6oprRvzPFsQ1YhAcPj5TP
         8S7mVwETpaLFNeXASVQxEkWOGEDRVnHr8taLaH+jzRayg+R6BKLj2Cp5FTApFPdfQrcB
         Te5XU2djYmrZMPzyuLzH4eVSDxBJEI9trOlDdPnsSeanZmXl+hiGVZxgMz3MY9+7JrW/
         0zDPFBIw86nDCI781NP81qaRqgi+P5Wf/DiptsHSBx+5pe54pCdcxwZGJBWjA6E5u2+o
         xAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oMwRgOws5V5Qy4x5HbXd98WXnPwz75YDILr4Oja2Rws=;
        b=q3xy20smeRpJPhrGW8zXCPs7WBpbde6Cu68/0BGM5k/3aAoMTOaD2Vxv+CCfWrh06U
         rm4y3s139Mze1Dlne/CNfsvXB4/XXjE0431rjfL3vqlnZcYttJ+66c5hXCS07lxgAguQ
         Oi3mh4F1XZpwzzkIbSPNAZRG0LGBeHpf7FVbqNg30ln/dW8gOC1jKtUBxwps4kpbsZHP
         ThGB3FKzBp4rOEl7ct+DX96gm2LL6+42+nxvjK72SF6IDQEcMBoVgtd7vhEgP0M1EVV7
         T5sJ33H3OIfKIelI8UL36OBfVRx7+nCCw07qocdl8Euug3+UrtbgqIjavfsY//7MPew2
         2vcw==
X-Gm-Message-State: AOAM533+LbEf0DpKxeP3zRWCUTTmGQQ9RPAxOkNYvemsb1/mpjXzTJve
        omWi/fdBpWFbbEGZSL4roGeMewPdClo=
X-Google-Smtp-Source: ABdhPJyR7t9Y7PLpebrDhTKDMZZb8bgLAssaCa/9DUH0rJ6FJ3ekjZRK9jJQoveTSIPEfysYPo/vNw==
X-Received: by 2002:a05:600c:4101:: with SMTP id j1mr7812871wmi.55.1608376493158;
        Sat, 19 Dec 2020 03:14:53 -0800 (PST)
Received: from [192.168.1.201] (108.45.90.146.dyn.plus.net. [146.90.45.108])
        by smtp.googlemail.com with ESMTPSA id 67sm4959654wmb.47.2020.12.19.03.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Dec 2020 03:14:52 -0800 (PST)
Subject: Re: [PATCH v4 1/1] mergetool: add automerge configuration
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Seth House <seth@eseth.com>
References: <20201218124905.1072514-1-felipe.contreras@gmail.com>
 <20201218124905.1072514-2-felipe.contreras@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b338a9f4-6e34-c5c6-16ef-097aadc3f3a8@gmail.com>
Date:   Sat, 19 Dec 2020 11:14:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201218124905.1072514-2-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felipe

On 18/12/2020 12:49, Felipe Contreras wrote:
> It doesn't make sense to display lines without conflicts in the
> different views of all mergetools.
> 
> Only the lines that warrant conflict markers should be displayed.
> 
> Most people would want this behavior on, but in case some don't; add a
> new configuration: mergetool.autoMerge.
> 
> See Seth House's blog post [1] for the idea, and the rationale.
> 
> [1] https://www.eseth.org/2020/mergetools.html

I would be good to have a summary of the idea in this commit message so 
people do not have to go and find a blog post which may well disappear 
in the future

> Original-idea-by: Seth House <seth@eseth.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>   Documentation/config/mergetool.txt |  3 +++
>   git-mergetool.sh                   | 17 +++++++++++++++++
>   t/t7610-mergetool.sh               | 18 ++++++++++++++++++
>   3 files changed, 38 insertions(+)
> 
> diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
> index 16a27443a3..7ce6d0d3ac 100644
> --- a/Documentation/config/mergetool.txt
> +++ b/Documentation/config/mergetool.txt
> @@ -61,3 +61,6 @@ mergetool.writeToTemp::
>   
>   mergetool.prompt::
>   	Prompt before each invocation of the merge resolution program.
> +
> +mergetool.autoMerge::
> +	Remove lines without conflicts from all the files. Defaults to `true`.
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index e3f6d543fb..f4db0cac8d 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -239,6 +239,17 @@ checkout_staged_file () {
>   	fi
>   }
>   
> +auto_merge () {
> +	git merge-file --diff3 --marker-size=7 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"

I've been wondering if we want to recreate the merge or just get the 
merged BASE LOCAL and REMOTE from the merged file in the working tree. 
If the user wants to resolve the conflicts in stages, or opens the file 
in a editor and fixes some conflicts and then realizes they want to use 
a merge tool that work is thrown away if we recreate the merge. They can 
always use `checkout --merge` to throw away their changes and start 
again with a mergetool. It would mean checking the size of the conflict 
markers and using 
'/^<{$conflict_marker_size}/,^|{$conflict_marker_size}/' for sed. 
Getting the merged BASE would be tricky if the user does not have diff3 
conflicts enabled, I'm not sure if we can safely get BASE from `git 
merge-file ...` and LOCAL and REMOTE from the working tree.

> +	if test -s "$DIFF3"
> +	then
> +		sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======\r\?$/,/^>>>>>>> /d' "$DIFF3" >"$BASE"
> +		sed -e '/^||||||| /,/^>>>>>>> /d' -e '/^<<<<<<< /d' "$DIFF3" >"$LOCAL"
> +		sed -e '/^<<<<<<< /,/^=======\r\?$/d' -e '/^>>>>>>> /d' "$DIFF3" >"$REMOTE"
> +	fi
> +	rm -- "$DIFF3"
> +}
> +
>   merge_file () {
>   	MERGED="$1"
>   
> @@ -274,6 +285,7 @@ merge_file () {
>   		BASE=${BASE##*/}
>   	fi
>   
> +	DIFF3="$MERGETOOL_TMPDIR/${BASE}_DIFF3_$$$ext"
>   	BACKUP="$MERGETOOL_TMPDIR/${BASE}_BACKUP_$$$ext"
>   	LOCAL="$MERGETOOL_TMPDIR/${BASE}_LOCAL_$$$ext"
>   	REMOTE="$MERGETOOL_TMPDIR/${BASE}_REMOTE_$$$ext"
> @@ -322,6 +334,11 @@ merge_file () {
>   	checkout_staged_file 2 "$MERGED" "$LOCAL"
>   	checkout_staged_file 3 "$MERGED" "$REMOTE"
>   
> +	if test "$(git config --bool mergetool.autoMerge)" != "false"

If I run `git config --bool mergetool.autoMerge` it returns an empty 
string so I think you need to test it is actually equal to "true".

I also share the view that this should be per tool. Your demand that 
someone comes up with an example that breaks assumes that we have access 
to all the tools that users are using. Seth has done a great job of 
surveying the popular tools but given the size of git's user-base and 
the diversity of uses it is very likely that there will be people using 
in-house or proprietary tools that no one on the list has access to. I 
would much prefer to avoid breaking them rather than waiting for a bug 
report before implementing a per-tool setting. It is quite possible 
people are using different tools for different files in the same way as 
they use different merge drivers for different files and want the 
setting disabled for a tool that does semantic merging but enabled 
textual merges.

Best Wishes

Phillip

> +	then
> +		auto_merge
> +	fi
> +
>   	if test -z "$local_mode" || test -z "$remote_mode"
>   	then
>   		echo "Deleted merge conflict for '$MERGED':"
> diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
> index 70afdd06fa..ccabd04823 100755
> --- a/t/t7610-mergetool.sh
> +++ b/t/t7610-mergetool.sh
> @@ -828,4 +828,22 @@ test_expect_success 'mergetool -Oorder-file is honored' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'mergetool automerge' '
> +	test_config mergetool.automerge true &&
> +	test_when_finished "git reset --hard" &&
> +	git checkout -b test${test_count}_b master &&
> +	test_write_lines >file1 base "" a &&
> +	git commit -a -m "base" &&
> +	test_write_lines >file1 base "" c &&
> +	git commit -a -m "remote update" &&
> +	git checkout -b test${test_count}_a HEAD~ &&
> +	test_write_lines >file1 local "" b &&
> +	git commit -a -m "local update" &&
> +	test_must_fail git merge test${test_count}_b &&
> +	yes "" | git mergetool file1 &&
> +	test_write_lines >expect local "" c &&
> +	test_cmp expect file1 &&
> +	git commit -m "test resolved with mergetool"
> +'
> +
>   test_done
> 

