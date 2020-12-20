Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89030C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 05:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5120D22CAF
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 05:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgLUFMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 00:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgLUFMb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 00:12:31 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2FCC0613D3
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 21:11:50 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k10so8721747wmi.3
        for <git@vger.kernel.org>; Sun, 20 Dec 2020 21:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GCFQBlwVyPd5Wefuwqexxxrutk0FNnqQYox3PfZL1pI=;
        b=XvZLKYC2dAaBs4/+FXMSEePjs2T7+B/AgpKtSsYLYNhCmIp5IhA3iRHuTbfEHEswYm
         rrjoiIrOzD+jnJ/EVt7QVoBJ9Cw2uvj9xnUBUddIzWVHmAfuQjwfqm7QgP7tV78gkmhQ
         KQb5yKYjI9dnAvrnLcRIBjPoJXz+sZvV4TxHwNgui03h0K/9+rbPd1ifJZBzoV0bKY0J
         wy/WA2J8d50lW1PsoWP2O8TWql9ZAcm1czQOZPj6tCKDpoR7S5jdRq96YWcM+rpBdGdx
         DDexhKeS+tmzP0hC9wTjdkf7YdKwcu7iLUho3BJSYrWOSm2gUuzfv801xqy4u6IJdku7
         MXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GCFQBlwVyPd5Wefuwqexxxrutk0FNnqQYox3PfZL1pI=;
        b=EIjQUrv/s1N5N23hS+9CAqiG2lGuRU6bSk/2qX/3SXc6q9LtqdHY3yIm5yqAskUIda
         WewKoqUsD2Twkr28msJyjSO1z5mUHu4N6DQNvt6VL3NEEbRdzQsgnok9GB2KoN5RQtS7
         7fPLBfX1BlQZP8Un212fw6FZPQ55GEwYP6exVDYWfmU2zVrW+XMw4Ko+ErsQcAtw9zjU
         LWYJIhVFmK1DtbPdIu2XWzfY33ZT3YzvEG8MUm0UqtdImo7kDCAJV/7mzE/CEbTsBs3i
         6IEqppSdJDV49K+IdYrS9ZjRqPU+dBWP0Ze4Kc9emh59TNB7Vl76M2HjPfQc+TL8iyMk
         /z+w==
X-Gm-Message-State: AOAM530RQW7+ZROQO+HwFXfzcNkn6/xImGBi6KWyBPbli+tuGjg45f+8
        tvbapwB6thtnrSxyzClVGYnxhiciuoc=
X-Google-Smtp-Source: ABdhPJwptGFu5qEqikcmEIhWeLPqGgO4pqsa5Oo+srtU0g0bc9UaFQvMnLDmBP6Wbg234mA2HioCvQ==
X-Received: by 2002:a1c:7218:: with SMTP id n24mr13257514wmc.186.1608492094746;
        Sun, 20 Dec 2020 11:21:34 -0800 (PST)
Received: from [192.168.1.201] (108.45.90.146.dyn.plus.net. [146.90.45.108])
        by smtp.googlemail.com with ESMTPSA id k18sm26255300wrd.45.2020.12.20.11.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Dec 2020 11:21:34 -0800 (PST)
Subject: Re: [PATCH v4 1/1] mergetool: add automerge configuration
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Seth House <seth@eseth.com>
References: <20201218124905.1072514-1-felipe.contreras@gmail.com>
 <20201218124905.1072514-2-felipe.contreras@gmail.com>
 <b338a9f4-6e34-c5c6-16ef-097aadc3f3a8@gmail.com>
 <5fddf7c5650fe_1de0de208a3@natae.notmuch>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <c0e0e600-7adf-966f-620e-ea29c3f76916@gmail.com>
Date:   Sun, 20 Dec 2020 19:21:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <5fddf7c5650fe_1de0de208a3@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19/12/2020 12:53, Felipe Contreras wrote:
> Phillip Wood wrote:
>> Hi Felipe
>>
>> On 18/12/2020 12:49, Felipe Contreras wrote:
>>> It doesn't make sense to display lines without conflicts in the
>>> different views of all mergetools.
>>>
>>> Only the lines that warrant conflict markers should be displayed.
>>>
>>> Most people would want this behavior on, but in case some don't; add a
>>> new configuration: mergetool.autoMerge.
>>>
>>> See Seth House's blog post [1] for the idea, and the rationale.
>>>
>>> [1] https://www.eseth.org/2020/mergetools.html
>>
>> I would be good to have a summary of the idea in this commit message so
>> people do not have to go and find a blog post which may well disappear
>> in the future
> 
> I thought I did in the paragraphs above. How about adding this > explanation:
> 
> When merging, not all lines with changes are considered conflicts, for
> example:
> 
>    cat >BASE <<EOF
>    Patagraph 1
> 
>    Paragraph 2
>    EOF
> 
>    cat >LOCAL <<EOF
>    Paragraph 1
> 
>    Paragraph 2
>    EOF
> 
>    cat >REMOTE <<EOF
>    Patagraph 1.
> 
>    Paragraph 2.
>    EOF
> 
> In this case the first paragraph does have a conflict because there are
> two changes (in LOCAL and REMOTE), that the user must resolve.
> 
> However, the second paragraph doesn't have a conflict; it's
> straightforward to decide that we want the only change present (in
> REMOTE).
> 
> In fact, if it were not for the first paragraph with a conflict, git
> wouldn't have bothered the user since the automatic merge would have
> succeeded.
> 
> So it doesn't make sense to display these unconflicted lines to the user
> inside the mergetool; it only creates noise.
> 
> We can fix that by propagating the final version of the file with the
> automatic merge to all the panes of the mergetool (BASE, LOCAL, and
> REMOTE), and only make them differ on the places where the are actual
> conflicts (and they are demarcated with conflict markers).
> 
> (this is mostly my explanation though, not Seth's, who used visual
> examples)

I'm not sure we need that much detail, it just needs to explain that the 
merge tools display non-conflicting changes. Maybe something along the 
lines of

Most merge tools ask the user to merge all the changes in the merge 
including changes to just one side which do not create conflicts rather 
than just the conflicting changes. This is inconvenient and a waste of 
the user's time. We can avoid this by passing the tool two files which 
resolve the conflicts in favor of the LOCAL and REMOTE side of the merge 
as the LOCAL and REMOTE merge heads respectively rather than the real 
merge heads.

>>> Original-idea-by: Seth House <seth@eseth.com>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>>>    Documentation/config/mergetool.txt |  3 +++
>>>    git-mergetool.sh                   | 17 +++++++++++++++++
>>>    t/t7610-mergetool.sh               | 18 ++++++++++++++++++
>>>    3 files changed, 38 insertions(+)
>>>
>>> diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
>>> index 16a27443a3..7ce6d0d3ac 100644
>>> --- a/Documentation/config/mergetool.txt
>>> +++ b/Documentation/config/mergetool.txt
>>> @@ -61,3 +61,6 @@ mergetool.writeToTemp::
>>>    
>>>    mergetool.prompt::
>>>    	Prompt before each invocation of the merge resolution program.
>>> +
>>> +mergetool.autoMerge::
>>> +	Remove lines without conflicts from all the files. Defaults to `true`.
>>> diff --git a/git-mergetool.sh b/git-mergetool.sh
>>> index e3f6d543fb..f4db0cac8d 100755
>>> --- a/git-mergetool.sh
>>> +++ b/git-mergetool.sh
>>> @@ -239,6 +239,17 @@ checkout_staged_file () {
>>>    	fi
>>>    }
>>>    
>>> +auto_merge () {
>>> +	git merge-file --diff3 --marker-size=7 -q -p "$LOCAL" "$BASE" "$REMOTE" >"$DIFF3"
>>
>> I've been wondering if we want to recreate the merge or just get the
>> merged BASE LOCAL and REMOTE from the merged file in the working tree.
>> If the user wants to resolve the conflicts in stages, or opens the file
>> in a editor and fixes some conflicts and then realizes they want to use
>> a merge tool that work is thrown away if we recreate the merge. They can
>> always use `checkout --merge` to throw away their changes and start
>> again with a mergetool. It would mean checking the size of the conflict
>> markers and using
>> '/^<{$conflict_marker_size}/,^|{$conflict_marker_size}/' for sed.
>> Getting the merged BASE would be tricky if the user does not have diff3
>> conflicts enabled, I'm not sure if we can safely get BASE from `git
>> merge-file ...` and LOCAL and REMOTE from the working tree.
> 
> That's a good point.
> 
> However, their work is not thrown away; MERGED is not touched by this.

I wasn't sure whether the tools would overwrite MERGED with a new file 
or if they started with that and just edited it. If it is the latter 
then I agree the users changes are safe

> It's only for visualization purposes that some already-fixed conflicts
> would be shown in the mergetool, which yeah; it's not ideal.
> 
> That's an improvement that can be done later, on top of this patch. The
> bulk of improvements are already enabled by this, and the marginal
> gains can be added later.

There's also the issue of what happens when the user has set merge 
driver for a file. If we use the file from the working tree we are using 
the result of that driver, if we re-merge with `git merge-file` then the 
files passed to the mergetool will not match the output of the merge 
driver set for that file.

>>> +	if test -s "$DIFF3"
>>> +	then
>>> +		sed -e '/^<<<<<<< /,/^||||||| /d' -e '/^=======\r\?$/,/^>>>>>>> /d' "$DIFF3" >"$BASE"
>>> +		sed -e '/^||||||| /,/^>>>>>>> /d' -e '/^<<<<<<< /d' "$DIFF3" >"$LOCAL"
>>> +		sed -e '/^<<<<<<< /,/^=======\r\?$/d' -e '/^>>>>>>> /d' "$DIFF3" >"$REMOTE"
>>> +	fi
>>> +	rm -- "$DIFF3"
>>> +}
>>> +
>>>    merge_file () {
>>>    	MERGED="$1"
>>>    
>>> @@ -274,6 +285,7 @@ merge_file () {
>>>    		BASE=${BASE##*/}
>>>    	fi
>>>    
>>> +	DIFF3="$MERGETOOL_TMPDIR/${BASE}_DIFF3_$$$ext"
>>>    	BACKUP="$MERGETOOL_TMPDIR/${BASE}_BACKUP_$$$ext"
>>>    	LOCAL="$MERGETOOL_TMPDIR/${BASE}_LOCAL_$$$ext"
>>>    	REMOTE="$MERGETOOL_TMPDIR/${BASE}_REMOTE_$$$ext"
>>> @@ -322,6 +334,11 @@ merge_file () {
>>>    	checkout_staged_file 2 "$MERGED" "$LOCAL"
>>>    	checkout_staged_file 3 "$MERGED" "$REMOTE"
>>>    
>>> +	if test "$(git config --bool mergetool.autoMerge)" != "false"
>>
>> If I run `git config --bool mergetool.autoMerge` it returns an empty
>> string so I think you need to test it is actually equal to "true".
> 
> Yeah, this would evaluate to positive:
> 
>    test "" != "false"
> 
> It's enabled by default since I heard Junio mention it would make sense.

I think it probably does make sense in which case it would be good to 
make that explicit in the commit message. Maybe

As most people will want the new behavior we enable it by default. 
Users that do not want the new behavior can set mergetool.autoMerge to 
false.

>> I also share the view that this should be per tool. Your demand that
>> someone comes up with an example that breaks assumes that we have access
>> to all the tools that users are using.
> 
> It's not a demand. It's a fact that unless we have an example (even if
> hypothetical), the burden of proof has not been met.
> 
> The default position is that we don't know if such configuration would
> make sense or not.
> 
>> Seth has done a great job of
>> surveying the popular tools but given the size of git's user-base and
>> the diversity of uses it is very likely that there will be people using
>> in-house or proprietary tools that no one on the list has access to.
> 
> Yes, they can just turn off the flag.
> 
>> I would much prefer to avoid breaking them rather than waiting for a
>> bug report before implementing a per-tool setting.
> 
> Even with a per-tool configuration they would be broken (until the user
> configures otherwise).
> 
>> It is quite possible people are using different tools for different
>> files in the same way as they use different merge drivers for
>> different files and want the setting disabled for a tool that does
>> semantic merging but enabled textual merges.
> 
> I think your definition of what's possible and mine are very different.

All I'm saying is that if a user has different tools for different 
file-types they may want this on for one tool but not another.

> But this is actually what I was asking: an example. You are bringing a
> hypothetical "semantic mergetool" that would somehow benefit from having
> unconflicted lines. Can you explain how it would benefit?

Because the result of the merge depends on the diff and a semantic tool 
(there was a talk about one for C# a few years ago at git merge I think) 
will diff the file based on it's semantics rather than matching lines.

> Also, neither Seth nor Junio responded to my example, can you?
> 
> Do you agree there is no conflict here?
> 
>    echo Hello > BASE
>    echo Hello > LOCAL
>    echo Hello. > REMOTE
>    git merge-file -p LOCAL BASE REMOTE

There is no conflict but I don't see what point you're making by that. 
I've been thinking about a different example

BASE    LOCAL   REMOTE
A	A	A
A	A	A
A	A	A
	B	A

Is there a conflict or not? I think it depends on the diff algorithm. 
These are both valid diffs of BASE and LOCAL but only the first one will 
lead to conflicts

  A	+A
  A	 A
  A	 A
+A	 A

If a tool implements a different diff algorithm to git then it may want 
to do the whole merge itself.

I'm going to be off the list for the next couple of weeks

Best Wishes

Phillip

> Cheers.
> 

