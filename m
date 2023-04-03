Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA46FC76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 15:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjDCPUg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 11:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjDCPUf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 11:20:35 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E441BF
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 08:20:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l27so29754127wrb.2
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 08:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680535232;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nUKLcEVN3zzJiRE4wFylw+U32CDsdg3SSOELTsqEzCE=;
        b=T8eDLu9ywYgZYIKG+RCUYyEx255BECQK5aL9JxtjL2oCZKGJzhHvogSVUOdGHqo5Ic
         K5Z4byjy5zrbYnEBU6UAzX5zPSCN0ZKSBLnt1DyiN4VblQ4RzYHjJtnfqmN1BqqSNPPA
         4RdbZ2JUWqo2vvPv31uSohgz0rJ6OHNMV0ulZpbYg79qpiOK5FOB51uzmuvI7IvXnDYc
         uVT7F6J5Aavu0OmkkAjA2WDpsrmbcearuk0sGM40hS3G0afntI8rhuM1ZEA59NMgjTzh
         U4KEB/5bNHiGBoduNoT1iitbsciv9BOgvbU873xwV4mqVQpGL9WuqBwyrAlZFyxJBtwM
         XoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680535232;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUKLcEVN3zzJiRE4wFylw+U32CDsdg3SSOELTsqEzCE=;
        b=bkAWb/Zf/nMnJg3kiIPSJlf0S0iNDyzMWiwWOhq1qWoE5tnPjj5NjQdLv5vzf8DV/I
         Sz6nZHmqVFoMGvYnWgtl/4/AS9YyJdJxlVwERV3AtfQ8j9Ixq00BYejNj05LDzp2AaFP
         BDRJy2DtYE1+E/fjdZbVutcHMyokvWDrhpCcdEv640O/mTO3j8oTVtV2gplCv4Lg7VVL
         NebavvXfK3b0JE04PqqdNtePrRAIuIjDCnP3FQZeoZMsKSmKi+7eB20tDwgbXKWyNor6
         9mlvwLdTXCJ+34KhJs57DYnhm9qHEagbPmW54haVR/tCwFaiKnu2m8oEfICa6N1+omUS
         jSSQ==
X-Gm-Message-State: AAQBX9dDh0X0gXvtA14fUkXSTAYE7RTrgpN+Pj+fjHUp/9iaXxCWt8mp
        Ddz1trXJuSGa/9OW2qvax1A=
X-Google-Smtp-Source: AKy350Yjt2IqpshOwrG9etzmc7R0SWSFdvqHVrC32cGpyR5KjS5o+uW4Mep+q24al+L9XFZXATpYdw==
X-Received: by 2002:adf:f14c:0:b0:2d0:776:b766 with SMTP id y12-20020adff14c000000b002d00776b766mr27762592wro.8.1680535232508;
        Mon, 03 Apr 2023 08:20:32 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.53.152])
        by smtp.gmail.com with ESMTPSA id f9-20020adfe909000000b002c7163660a9sm9897748wrm.105.2023.04.03.08.20.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 08:20:32 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <9429a246-4921-c9f6-0318-834c86b35898@dunelm.org.uk>
Date:   Mon, 3 Apr 2023 16:20:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH RESEND] hooks: add sendemail-validate-series
Content-Language: en-US
To:     Robin Jarry <robin@jarry.cc>, git@vger.kernel.org
Cc:     Tim Culverhouse <tim@timculverhouse.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20230402185635.302653-1-robin@jarry.cc>
 <66099367-4ea0-7d2a-a089-7a88e27f695e@dunelm.org.uk>
 <CRN7096DENCQ.1HF4OQ0ZD4HFP@ringo>
In-Reply-To: <CRN7096DENCQ.1HF4OQ0ZD4HFP@ringo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robin

On 03/04/2023 15:32, Robin Jarry wrote:
> Hi Phillip,
> 
> Phillip Wood, Apr 03, 2023 at 16:09:
>>> +  <patch-file> LF
>>
>> Usually git commands that produce or consume paths either use quoted
>> paths terminated by LF or unquoted paths terminated by NUL. That way
>> there is no ambiguity when a path contains LF.
> 
> I had never imagined that some twisted mind would insert LF in path
> names but since nothing will forbid it, I agree that it is
> a possibility.
> 
> I'm not sure what you mean by quoted paths, you mean adding literal
> double quotes before printing them to the hook stdin? That means the
> hook needs to handle de-quoting after reading, right?

I meant quoted in the same way that diff and ls-files etc quote paths 
that contain control characters - see quote_c_style() in quote.c if 
you're interested in the details. It looks like Git.pm can unquote paths 
but has no code to quote them. It is probably easiest to use NUL 
termination here - bash and zsh can read NUL terminated lines and so can 
any scripting language.

>>> diff --git a/git-send-email.perl b/git-send-email.perl
>>> index 07f2a0cbeaad..bec4d0f4ab47 100755
>>> --- a/git-send-email.perl
>>> +++ b/git-send-email.perl
>>> @@ -800,6 +800,7 @@ sub is_format_patch_arg {
>>>    			validate_patch($f, $target_xfer_encoding);
>>>    		}
>>>    	}
>>> +	validate_patch_series(@files)
>>
>> This happens fairly early, before the user has had a chance to edit the
>> patches and before we have added all the recipient and in-reply-to
>> headers to the patch files. Would it be more useful to validate what
>> will actually be sent?
> 
> I agree that it would be better. I added the check here to be in line
> with the existing sendemail-validate hook. I could move it after edition
> and header finalization but then we would need to move
> sendemail-validate as well for consistency. What do you think?

That would be my inclination but I'm only an occasional send-email user. 
The downside is that the user may edit a patch only for it to be 
rejected but we could offer for them to edit it again rather than just 
throwing their work away.

>>> +	# The hook needs a correct cwd and GIT_DIR.
>>> +	require Cwd;
>>> +	my $cwd_save = Cwd::getcwd();
>>> +	chdir($repo->wc_path() or $repo->repo_path()) or die("chdir: $!");
>>> +	local $ENV{"GIT_DIR"} = $repo->repo_path();
>>
>> This looks like it is copied from the existing code but why do we need
>> to do this? I'm struggling to come up with a scenario where "git
>> send-email" can find the repository but the hook cannot.
> 
> Again, for consistency I assumed it would be best to keep the code
> similar in both hooks. If you think it is safe to skip that check, I'll
> remove it gladly.

I suspect it is safe, hopefully someone will speak up if I'm mistaken. A 
while ago rebase stopped setting these variables when running an "exec" 
command as they were causing problems (see 434e0636db (sequencer: do not 
export GIT_DIR and GIT_WORK_TREE for 'exec', 2021-12-04))

>>> +	# cannot use git hook run, it closes stdin before forking the hook
>>> +	open(my $stdin, "|-", $validate_hook) or die("fork: $!");
>>
>> This passes $validate_hook to the shell to execute which is not what we
>> want as it will split the hook path on whitespace etc. I think it would
>> be better to use "git hook run --to-stdin" (see 0414b3891c (hook:
>> support a --to-stdin=<path> option, 2023-02-08))
> 
> Ah that's a nice addition. I'll add that in v2.

That's great, Best Wishes

Phillip

> Thanks for reviewing!
