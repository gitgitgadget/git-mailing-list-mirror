Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C61B91F461
	for <e@80x24.org>; Tue, 20 Aug 2019 08:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfHTIw6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 04:52:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38601 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbfHTIw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 04:52:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id m125so1892385wmm.3
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 01:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d/sMqQNqJQzV17ZC/7IKGgLkjzh7llkU7/DLzSeaI1E=;
        b=O8KrqoMyXBYbckEMsG5Sjy347hOlMhPDdqk/qVkpsDYvmszVBbeWaK/PDsyN3SCP1W
         DsWsdDF8HmES1AxeQQrYk7N9PZmvR3hj/LEABJ4GedrFb8YurI/FFL3qTtzWCNe4+RtJ
         uQpEkuU82B0dIqn0abGR9vu1/IaLOOoAvaSZ6OHN8xQt2LDEeZyt+T4Bs3QPsJNSx6Mk
         WUfDezHN5dKOJ5OwvJl97PxPXwKYAH2mi9bVA+UdpHn5Qtwz1pFbIS9AiVkKi4ubYl7h
         WK/D/uBCiMfCWNKJIeW0B2iT1egJU0y2VdjKWEN0wTp9zSeJVdWMufE5vimtoG7g7DAl
         lLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d/sMqQNqJQzV17ZC/7IKGgLkjzh7llkU7/DLzSeaI1E=;
        b=p0MmR4F9khfPI1H02BgnASVbcwqdmADm4aTL+VMvnnQX36uUkfJ2pjwog4gfkblO2I
         cr4XiP8/fzsxMdyhPH+wrYdorZ6W4XGGruMwubQmgppDC13RKels5v8Jck33GsOiu53M
         G9B+RVj1e5AUQ+kLZQedVrXHshaMRmLKrwVY9nzNokH54EA3kOr8mLLj5gl0rD0wDoNg
         j8B9bzQG5QOVzx2zb7eZJb69r8J/Tt2tNHyzD8bfa0R7SDJhnkmx5VMn5dhC4DR4dTzu
         xYg+WMuTH8BgQhIKEw/XiIVNDJtHX+kRruIyVOBXhfIhDRIvL67qV44CFxb5w55/4fRP
         opbw==
X-Gm-Message-State: APjAAAUaE6ZQA3JBJ/X4Y+Xk6h89bsjPzecG1DbGj0FVElLDTTqk1JPb
        EPCalukMx+OgsfqXciZHBTw=
X-Google-Smtp-Source: APXvYqxNmzM9y90DQlZBzl56Z63biBpEAY74XHBoMbJncirJ4K+bzUTUO7YqF/JBqkMNkLvgiQl+FQ==
X-Received: by 2002:a1c:c909:: with SMTP id f9mr12200131wmb.52.1566291175633;
        Tue, 20 Aug 2019 01:52:55 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-12-34.as13285.net. [92.22.12.34])
        by smtp.gmail.com with ESMTPSA id 6sm15282191wmf.23.2019.08.20.01.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 01:52:54 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] apply: reload .gitattributes after patching it
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
 <20190818184403.861907-1-sandals@crustytoothpaste.net>
 <20190818184403.861907-3-sandals@crustytoothpaste.net>
 <9b940950-666a-0c4c-58c0-1e61ac9e654c@gmail.com>
 <20190820024505.GH365197@genre.crustytoothpaste.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <18fcc7db-7c09-3fbf-1e3f-81be99f4bb17@gmail.com>
Date:   Tue, 20 Aug 2019 09:52:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820024505.GH365197@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian

On 20/08/2019 03:45, brian m. carlson wrote:
> On 2019-08-19 at 09:41:42, Phillip Wood wrote:
>> Hi Brian
>>
>> On 18/08/2019 19:44, brian m. carlson wrote:
>>> When applying multiple patches with git am, or when rebasing using the
>>> am backend, it's possible that one of our patches has updated a
>>> gitattributes file. Currently, we cache this information, so if a
>>> file in a subsequent patch has attributes applied, the file will be
>>> written out with the attributes in place as of the time we started the
>>> rebase or am operation, not with the attributes applied by the previous
>>> patch. This problem does not occur when using the -m or -i flags to
>>> rebase.
>>
>> Do you know why -m and -i aren't affected?
> 
> I had to look, but I believe the answer is because they use the
> sequencer, and the sequencer calls git merge-recursive as a separate
> process, and so the writing of the tree is only done in a subprocess,
> which can't persist state.

The sequencer has been running in a single process for a while now. We 
do fork for 'git merge' sometimes when processing 'merge' commands but 
'pick' commands are all done in a single process by calling 
do_recursive_merge().

Best Wishes

Phillip

> Should we move the merge-recursive code into the main process, we'll
> likely have the same problem there.
> 
>>> diff --git a/apply.c b/apply.c
>>> index cde95369bb..d57bc635e4 100644
>>> --- a/apply.c
>>> +++ b/apply.c
>>> @@ -4643,6 +4643,7 @@ static int apply_patch(struct apply_state *state,
>>>    	struct patch *list = NULL, **listp = &list;
>>>    	int skipped_patch = 0;
>>>    	int res = 0;
>>> +	int flush_attributes = 0;
>>>    	state->patch_input_file = filename;
>>>    	if (read_patch_file(&buf, fd) < 0)
>>> @@ -4670,6 +4671,10 @@ static int apply_patch(struct apply_state *state,
>>>    			patch_stats(state, patch);
>>>    			*listp = patch;
>>>    			listp = &patch->next;
>>> +
>>> +			if ((patch->new_name && ends_with_path_components(patch->new_name, GITATTRIBUTES_FILE)) ||
>>> +			    (patch->old_name && ends_with_path_components(patch->old_name, GITATTRIBUTES_FILE)))
>>> +				flush_attributes = 1;
>>
>> style nit - these lines are very long compared to 80 characters
> 
> They are.  They aren't two different from other lines in the file, and I
> thought that leaving them that way would preserve the similarities, but
> I can also wrap them.  I'll send out a v5 with wrapped lines.
> 
>>> diff --git a/convert.c b/convert.c
>>> index 94ff837649..030e9b81b9 100644
>>> --- a/convert.c
>>> +++ b/convert.c
>>> @@ -1293,10 +1293,11 @@ struct conv_attrs {
>>>    	const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
>>>    };
>>> +static struct attr_check *check;
>>
>> I was concerned about the impact adding a file global if we ever want to
>> multi-thread this for submodules, but looking through the file there are a
>> couple of others already so this isn't creating a new problem.
>>> +
>>>    static void convert_attrs(const struct index_state *istate,
>>>    			  struct conv_attrs *ca, const char *path)
>>>    {
>>> -	static struct attr_check *check;
>>>    	struct attr_check_item *ccheck = NULL;
>>>    	if (!check) {
>>> @@ -1339,6 +1340,12 @@ static void convert_attrs(const struct index_state *istate,
>>>    		ca->crlf_action = CRLF_AUTO_INPUT;
>>>    }
> 
> The portion I've included above demonstrates that this was already a
> static variable, just one hidden in a function.  So yeah, this is no
> worse than it already was.
> 
