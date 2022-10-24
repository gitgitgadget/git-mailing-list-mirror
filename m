Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BB6C38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 00:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiJYAzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 20:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiJYAyu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 20:54:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A041D3C47
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 16:39:07 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bp11so17814860wrb.9
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 16:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPyGS3mOOWohAsSv59xCNETjS1a4zz3+KKR/XYuajHw=;
        b=U+lDDKX4gnqoWHYuPTIPWPziViecfih8Tk7MeObqybdLZ9Wiz4voOilYVmH/ZPNt2I
         qUIcvHD5Acshio7XiIB1XJJQe7FSWgbfpVoppR1Bq2o5t3+896+HNwqVc2Gr2KsTht5p
         4TUAYmfNCSRCsECSYbTJsb/xRn/v0NCu4uZcnBiehTXOp+DkXkpHN4dttDzbcKgouVTj
         5XXeUy6EagB+kpuanhmtpAuDGOukA7GcGD7AauTqMchqLsXTr8UQ+7xIKBBWU0giZmiZ
         Q9D6Y5kRc4A6BT0VJwVW8vEeB3NEPVmGaRslPWka/SYRtWNqEMxTHtNKTSM0HRvF4I5U
         nbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPyGS3mOOWohAsSv59xCNETjS1a4zz3+KKR/XYuajHw=;
        b=brxcRxR2B75kaAYX/8V0RWvuzzaTQ0EOxO8nXYJghwfwtYPKLH43UL87YNxriWkuqn
         fyvavgUZwsHRKCZPXKeg5T4XC1ulRDAU0DKk3GWrtwa6hfEboC0UuupRqQWRN4ho5eHG
         R2SGNSMsykiDOqXMgvf85PIwLvcaRsFLpfe0c9+Fgi4t/RWQqurOmAC67TX1Oo1FlIqL
         TW4UkNzaOw5yIslSxNYncprALiOH7kreDEvI7P2b6rCnrn0vPBnnFlRQOMZnQatpj1zq
         Q1w2jM6huAPkNcPx1WT451kL/vub3Tw3SwdIoa07tSlrOuPv3r5upA0PIy7fGIq5wfjt
         b0mg==
X-Gm-Message-State: ACrzQf3DzJwt0Up4B3naFwno9rydmL63+iAJcPMy4kh9eHjAgEL1RK5X
        1l09RHxBxLwZL6Mr/zLZ2UtMRARguVQ=
X-Google-Smtp-Source: AMsMyM4KHxdZorTYIvzcA095hJmGcTG7KwQOaw1Sxt5e1Y3pglB4mKIG8b+bGzoSU7I4R0j9hTVuaQ==
X-Received: by 2002:a5d:64a3:0:b0:231:f82e:9a57 with SMTP id m3-20020a5d64a3000000b00231f82e9a57mr23479688wrp.492.1666654745259;
        Mon, 24 Oct 2022 16:39:05 -0700 (PDT)
Received: from [192.168.2.52] (203.85-84-12.dynamic.clientes.euskaltel.es. [85.84.12.203])
        by smtp.gmail.com with ESMTPSA id u6-20020a7bc046000000b003c65c9a36dfsm902952wmc.48.2022.10.24.16.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 16:39:04 -0700 (PDT)
Subject: Re: [PATCH] branch: error and informative messages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <3f63d53d-2e14-ffe0-6263-2a15f83453ad@gmail.com>
 <xmqq5ygaul5k.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <faf7a985-f6ef-f20a-3857-031396124d60@gmail.com>
Date:   Tue, 25 Oct 2022 01:39:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq5ygaul5k.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/10/22 2:20, Junio C Hamano wrote:

>> Beside applying this rules, some unneeded messages have been removed and
>> others reworded to normalize and simplify.
>>
>>  - Four similar messages has been merged into the most common, the last
>>    one:
>> 	- "no such branch '%s'"
>> 	- "branch '%s' does not exist"
>> 	- "invalid branch name: '%s'"
>> 	+ "no branch named '%s'"
> 
> The third one could be more appropriate than the fourth one when the
> error is about failing to create a new branch due to invalid name.
> But all the other three seem to refer to a branch that ought to
> exist but doesn't, and the one you picked seems reasonable one among
> the three (and it is also the shortest).

Yes, I had doubts with the third.  The error is referring to the source branch
in the copy/rename operation, so I think it makes sense to say that the branch
doesn't exist, even if it couldn't.

>>  - Two specific messages has been reworded and merged:
>> 	- "could not set upstream of HEAD to %s when
>> 		it does not point to any branch."
>> 	- "could not unset upstream of HEAD when it
>> 		does not point to any branch."
>> 	+ "cannot modify upstream to detached HEAD"
> 
> OK.  I have no strong opinion between "modify" and "set or unset"
> but the latter may be closer to the spirit of the former.  I agree
> that "HEAD when it does not ..." is quite a mouthful and to those
> who understand what a 'detached HEAD' is, the updated phrasing may
> be easier to read.

I prefer a single term like 'modify' as I find it less confuse than 'set or
unset'.

>>  - An error message reworded
>> 	- "options '%s' and '%s' cannot be used together",
>> 		"--column", "--verbose"
>> 	+ "options --column and --verbose used together"
> 
> This is arguably a regression.  The original ensures that l10n/i18n
> folks cannot frob the option names that must be literally spelled,
> but the "reworded" one lacks the protection (it also loses the quotes
> around dashed options).

OK. I didn't think about that, I'll revert to the parametrized form.  About the
quotes, I did that on purpose.  As I said in a comment below, for branches the
quotes are commonly used and make sense as it is a variable value and the
quotes helps to delimit, but with options the literal is well-known and we use
the form with dashes, ie --verbose, so it is easily identifiable.  Also, we do
not use quotes with option literals in other places, like the documentation,
--help,..

>>  - Two error messages not needed, removed:
>> 	- "cannot copy the current branch while not on any."
>> 	- "cannot rename the current branch while not on any."
> 
> OK (assuming that these are unreachable code).
 
It is, you reviewed it below.  I'll comment there.

>>  - A deprecation message has been reworded, note the '\n':
>> 	- "the '--set-upstream' option is no longer supported."
>> 		"Please use '--track' or '--set-upstream-to' instead."
>> 	+ "option --set-upstream is no longer supported\n"
>> 		"Please use --track or --set-upstream-to instead"
> 
> Loss of quotes around option names, and the definite article "the"?
 
The loss of the article, it sounds good to me and in line with the previous
"options --column ...".  Dunno.

>>  - "%s" and "'%s'" was used to format a branch name in different
>>    messages.  "'%s'" has been used to normalize as it's the more
>>    frequently used in this file and very common in the rest of the
>>    codebase.  The opposite has been done for options: "-a" used vs
>>    "'-a'".
> 
> As the way to display the exact literal string, I think it is good
> to have quotes around both of them, the user-chosen names like
> branch names, and the system-chosen names like option names.
 
Same reasoning as above.  It is a system-chosen term, but the message
has not a placeholder to put a value, we're using a literal.

>> A new informative, non-error, message has been introduced for
>> create_branch:
>> 	+ "New branch '%s' created from '%s'\n"
> 
> OK.
> 
>> The tests for the modified messages have been updated and a new test for
>> the create_branch message has been added.
>>
>> Finally, let's change the return code on error for --edit-description,
>> from -1 to 1.
> 
> OK.  That last one may be better to be a separate patch, as these
> wording changes are subject to discussion and bikeshedding.
> 

Mmm, I thought about that.  This change is one that we've been delaying because
it might break something due to a change in the way we report errors.  We're
specifically changing this here and the change is small, so I found appropriate
to do it here.

>> -	if ((head_rev != reference_rev) &&
>> -	    in_merge_bases(rev, head_rev) != merged) {
>> -		if (merged)
>> -			warning(_("deleting branch '%s' that has been merged to\n"
>> -				"         '%s', but not yet merged to HEAD."),
>> -				name, reference_name);
>> -		else
>> -			warning(_("not deleting branch '%s' that is not yet merged to\n"
>> +	if ((head_rev != reference_rev) && in_merge_bases(rev, head_rev) != merged)
>> +		warning(merged
>> +			? _("deleting branch '%s' that has been merged to\n"
>> +				"         '%s', but not yet merged to HEAD.")
>> +			: _("not deleting branch '%s' that is not yet merged to\n"
>>  				"         '%s', even though it is merged to HEAD."),
>>  				name, reference_name);
>> -	}
> 
> This does not fall into any of the categories the proposed log
> message discussed.  Rather, it looks more like "the code
> subjectively looks better this way".  It happens to much my
> subjective taste, but that does not change the fact that we
> shouldn't distract reviewers with such an unrelated change in the
> same patch.
 
It certainly looks subjectively better, and in less lines :).  That ternary
form is already used in the file,  this patch is an opportunity to uniformize
that in the file.  I did this change in two commits, a preparatory one with the
switch to the ternary op and other changes, and then the rewording.  Finally I
squased into one.  I can go back to the two patches and/or revert to the
if/else, but my preference is to keep the ternary.

In fact, I missed there the removal of two '.',  I'll fix that.

>> @@ -520,13 +512,6 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
>>  	const char *interpreted_newname = NULL;
>>  	int recovery = 0;
>>  
>> -	if (!oldname) {
>> -		if (copy)
>> -			die(_("cannot copy the current branch while not on any."));
>> -		else
>> -			die(_("cannot rename the current branch while not on any."));
>> -	}
>> -
> 
> Something like
> 
>     copy_or_rename_branch() never gets NULL in oldname, because its
>     only callers in cmd_branch() calls it with either the end-user's
>     command line argument or the result of resolve_refdup("HEAD"),
>     and neither can ever be NULL because ...
> 
> needs to go into the proposed log message to explain why it is safe
> to remove these two messages.
> 
> Having said that, the messages may actually be correct and it is the
> logic that makes it unreachable that is wrong in this case, I think.
> It looks like the code expects that oldname is NULL when we are on
> detached HEAD (it could be the old caller did have NULL in head when
> this code was written, and it is possible that we regressed over the
> course of history).  I.e. Isn't it trying to protect us against
> 
>    $ git checkout --detach HEAD^0
>    $ git branch -m foo		;# rename .git/HEAD to .git/foo???
> 
> (or "-c" for copy)?  The current code happens to catch it a bit
> later in this function, when it notices "HEAD" is not a refname in
> "refs/heads/" hierarchy, but the user never attempted to rename
> refs/heads/HEAD to refs/heads/foo, and "Invalid branch name: 'HEAD'"
> is us being wrong, insulting and confusing to the users.
> 
> I suspect that this needs to be fixed at the caller's level, just
> like the caller reacts to "edit_description" by checking the
> filter.detached bit and rejects the request, the caller should
> notice that we are on a detached HEAD and die with one of the above
> two messages without calling this function.
> 
> And that should be a separate patch, that can be reviewed and
> applied regardless of the rest of "error messages cleanup" topic.

Good point.  I didn't think about that and it also goes in the line of
the previous patches in this file.  I'll review that.  Also gives a good
opportunity to fix that repeated code /... if (copy) ... else if
(rename)/.

> The hunks before this point that I omitted from quoting and
> commenting looked all OK.
> 
> The remainder of the patch I didn't look at.  There may be similar
> issues like this "oops, the messages are dead for a wrong reason and
> code needs to be fixed" or "let's leave subjective improvements out
> of this topic that has clearly described rules" to be discovered, so
> I may come back to them later, or others may find them before I do.

I'll prepare a reroll.

Thank you for you review.
