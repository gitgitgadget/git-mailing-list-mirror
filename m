Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0A8C7EE2E
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 00:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjB1AXC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 19:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjB1AXA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 19:23:00 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED1C72B5
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 16:22:58 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso4871493wmp.4
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 16:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677543777;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWijmcwKW5p0bt50FwhKoHNRE4dKZmpRM6G5rSZOClE=;
        b=RIwJ4X4EIHLTGU3muPsGWWMXdG8Z9wE0pjqTb3qOA06m7joVJQmt89KxzifJzJ2fPS
         9qNf7IRrqzfZCEjWlsYkxixCwkQS4PlonfZ74stgtXguAvEnj8qIFDFilXIOSba+YHhj
         QcqSa60+N1Z3hrcvnAYFCo8OwhKBkgvuZ3BcoaBMB2MNVsOcfJIwHeDr19oM/Q4usXJY
         qM+E94pLYUE7LVJMEEBzdJX2gu3RAM9Xu+wZMPgqe2ooY/6L+zwVnYzYT+9xHoDNsTSr
         Yy8EsgNTV0m+meZTynogeIGvYiE5ES4LznSnHAJeJzg3XENIe5ZxlOQXLCprQKhl+tqv
         bRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677543777;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWijmcwKW5p0bt50FwhKoHNRE4dKZmpRM6G5rSZOClE=;
        b=fPmrtLw4TYgo3QtlxfYVvg+LyqxuNA+I9BeQuzC5yMlv3DiHL6onMMKvQ2gI6g90rr
         YGb32/ewbwMldffe7o0o5pm8iGOklarCNyWQ/EwDgdxsWfoRcZN3s/3Rre5rZzFDgpx8
         ht5f51JDmuKfCUrwqu3pIDyIu/VYWH/AmggVq9dX5Rnpq4O7zlP7VxfzW9U5W6JCVr7p
         8M35AgZXtCifnprWt5Ijgss6q5a0AQVhKJGH41SqJ4Vbz53+dqAxPTMVgPUInV7q3JCi
         jc9Ae8Qd0Dz/nriVUIKQ3yAy10c7/azqOkFoyCWen0NQkAOtBw2rBxcSsZWBUdqpD55y
         MeeA==
X-Gm-Message-State: AO0yUKViA/ZNbXE8UMdkjLk3WWrnB4kfTKzIK9GfCDoeDiUvbPnHuqeW
        9EdFM2Fck0jUICKYfIzZ4+I=
X-Google-Smtp-Source: AK7set+KREO31sSQUryleRXx+25HnqgN+VyZv+/2pd6mz8veeOW1OLMrJVMTMnAX2cwr331J41bMEA==
X-Received: by 2002:a05:600c:4fc3:b0:3ea:ed4d:38ee with SMTP id o3-20020a05600c4fc300b003eaed4d38eemr710340wmq.4.1677543777185;
        Mon, 27 Feb 2023 16:22:57 -0800 (PST)
Received: from [192.168.2.52] (59.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.59])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c219100b003e7f1086660sm14231755wme.15.2023.02.27.16.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 16:22:56 -0800 (PST)
Subject: Re: [PATCH v4 2/3] branch: description for orphan branch errors
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20230227193839.2416545-1-jonathantanmy@google.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <d29bb653-7d3e-1753-8805-aa48b35320d9@gmail.com>
Date:   Tue, 28 Feb 2023 01:22:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20230227193839.2416545-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your review!

On 27/2/23 20:38, Jonathan Tan wrote:
> Firstly, the subject could be more precise. Maybe "branch: check all
> worktrees for orphan branches" (47 characters) or something like that.

The main intention in this series is to stop giving the user a confusing
error "No branch named..." for a branch he may have just created.  I
think the current subject states that better.  But I'm open to change it
in that direction.

> Rubén Justo <rjusto@gmail.com> writes:
>> In bcfc82bd48 (branch: description for non-existent branch errors,
>> 2022-10-08) we checked the current HEAD
> 
> Probably clearer to say "HEAD in the current worktree" instead of
> "current HEAD".

OK. I'll reword with that.

>> to detect if the branch to
>> operate with is an orphan branch, so as to avoid the confusing error:
>> "No branch named...".
>>
>> If we are asked to operate with an orphan branch in a different working
>> tree than the current one, we need to check the HEAD in that different
>> working tree.
> 
> Probably clearer to just say "But there might be orphan branches in
> other worktrees".

That loses important details IMHO, the intention: "avoid the
confusing..", and the reasoning on why we need to check HEAD in all
worktrees.

>> Let's extend the check we did in bcfc82bd48, to all HEADs in the
>> repository, using the helper introduced in 31ad6b61bd (branch: add
>> branch_checked_out() helper, 2022-06-15)
> 
> s/HEADs/worktrees/

I understand your suggestion, but my intention along the message is to
maintain the reasoning on the "HEAD", due to an orphan branch is a HEAD
pointing to a non-existing ref.  Maybe "the HEADs in all worktrees"
could be better?

>> @@ -493,8 +496,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>>  	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
>>  	const char *interpreted_oldname = NULL;
>>  	const char *interpreted_newname = NULL;
>> -	int recovery = 0;
>> +	int recovery = 0, oldref_usage = 0;
>>  	struct worktree **worktrees = get_worktrees();
>> +	struct worktree *oldref_wt = NULL;
> 
> Better to have 2 variables (one for rebased, and one for bisected) to
> avoid the situation in which the last problematic worktree seen was a
> bisected one, but a prior one was a rebased one.

Well seen.  Thanks for reading carefully.

I'll re-roll with that.

>> @@ -818,7 +835,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>>  
>>  		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
>>  		if (!ref_exists(branch_ref.buf))
>> -			error((!argc || !strcmp(head, branch_name))
>> +			error((!argc || branch_checked_out(branch_ref.buf))
>>  			      ? _("No commit on branch '%s' yet.")
>>  			      : _("No branch named '%s'."),
>>  			      branch_name);
>> @@ -863,7 +880,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>>  		}
>>  
>>  		if (!ref_exists(branch->refname)) {
>> -			if (!argc || !strcmp(head, branch->name))
>> +			if (!argc || branch_checked_out(branch->refname))
>>  				die(_("No commit on branch '%s' yet."), branch->name);
>>  			die(_("branch '%s' does not exist"), branch->name);
>>  		}
> 
> What is the relevance of these changes?
> 

This is the main intention in the patch: not showing the confusing error
"No branch named..." for orphan branches.  I'm not sure if I understand
your question...
