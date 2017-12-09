Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 205681F406
	for <e@80x24.org>; Sat,  9 Dec 2017 19:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbdLITFU (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 14:05:20 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:51739 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbdLITFT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 14:05:19 -0500
Received: from [192.168.2.201] ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id NkR3eDImmNSVVNkR3edWu7; Sat, 09 Dec 2017 19:05:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1512846318;
        bh=xElswQqZa3CcU5NtKQmLGTLr0fXDRh+wxKXnUXuP+5k=;
        h=Reply-To:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=HD0KF35V955s09mMaaQEgc9tuz9ube2rSd0mDWTICxDBDfH5lTGYK6UA6TIfJkzWU
         pazJYJSl48PnXOvxmWzB3q6v3sAGwvwHdxwFRK+wXA4a+w+DstLwuXij5pFNSL8rV6
         6TL0bBSvuQ+XLAuExF0HiyFxHMtxjL0cRZKT4xjA=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=NYGW7yL4 c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=qW0lVXeJEwKzah38JQEA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 7/9] sequencer: load commit related config
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171124110758.9406-1-phillip.wood@talktalk.net>
 <20171124110758.9406-8-phillip.wood@talktalk.net>
 <xmqqd13umjl7.fsf@gitster.mtv.corp.google.com>
 <632c35d3-46ca-e0bc-5b14-244647df9b19@talktalk.net>
Message-ID: <e0952566-cc19-ec35-2677-10e490f2034d@talktalk.net>
Date:   Sat, 9 Dec 2017 19:05:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <632c35d3-46ca-e0bc-5b14-244647df9b19@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFsmrw20MEMEOvPH/qRiKtKIVE1AWQlOyd3326yBkSBDVDI9fuQ+AXHXmW2V4vJnGzNtC6K5gzhNZVSTEiNWU+KOYgzgwbjZ6/zPggR71ztfrSy4uTAp
 Wg/Gqu0ohouuU2mtn6R49f231CRiALekmF1xOePK3FoLTNSDFzXFydLvGJkgp66w+fohFks0jVXhn381hBvPMrgVacQ0O41t9vsWRzc3ywfw/Yo5uVVr1XB9
 oZEhGDGJbJitVAoDz2zq9ABc2q89FfcJOF801UWzdI+iToV4YqvgrVh1xUizoWp6Jj7AvsWxmZjPkYbHnxXC9GoDLoEk32fpCRtTt1UixH4cxSYXcTq2vYu7
 WuD9e8JPW98yUjL0yDqpJAPHlLdTtw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/12/17 11:21, Phillip Wood wrote:
> On 04/12/17 18:30, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood@talktalk.net> writes:
>>
>>> --- a/builtin/rebase--helper.c
>>> +++ b/builtin/rebase--helper.c
>>> @@ -9,6 +9,17 @@ static const char * const builtin_rebase_helper_usage[] = {
>>>  	NULL
>>>  };
>>>  
>>> +static int git_rebase_helper_config(const char *k, const char *v, void *cb)
>>> +{
>>> +	int status;
>>> +
>>> +	status = git_sequencer_config(k, v, NULL);
>>> +	if (status)
>>> +		return status;
>>> +
>>> +	return git_default_config(k, v, NULL);
>>> +}
>>> +
>>
>> Sorry for spotting the problem this late, but this code is
>> unfortunate and we will need to revisit it later; we may want to do
>> so sooner rather than later.
> 
> If it needs fixing then doing it before it hits next makes sense.
> 
>> When k,v is a valid configuration that is handled by
>> sequencer_config() successfully, this code still needs to call into
>> default_config() with the same k,v, only to get it ignored.
> 
> I'm a bit confused by this sentence. Do you mean that when k,v is a
> valid configuration that is successfully handled by sequencer_config()
> this code unnecessarily calls default_config() as there is no need to
> call default_config() if k,v have already been handled?
> 
>> The problem lies in the (mis)design of git_sequencer_config().  The
>> function should either allow the caller to notice that (k,v) has
>> already been handled, or be the last one in the callback by making a
>> call to default_config() itself.
> 
> The problem is that git_gpg_config() provides no indication if it has
> handled k,v so there's no way to avoid the call to default_config() in
> that case. builtin/am.c and builtin/commit.c both do something like
> 
> static int git_am_config(const char *k, const char *v, void *cb)
> {
> 	int status;
> 
> 	status = git_gpg_config(k, v, NULL);
> 	if (status)
> 		return status;
> 
> 	return git_default_config(k, v, NULL);
> }
> 
> 
> Looking more generally at sequencer_config() I wonder if we should be
> providing a warning or an error if the config contains an invalid
> cleanup mode. Also should it be calling git_diff_ui_config() to set
> things up for print_commit_summary()? (I'm not sure if anything in that
> function is affected by diff config settings)

I think the answer maybe yes so that it loads the setting for external
diff commands and textconv filters but I'm not sure, perhaps someone
more familiar with the diff code would know? Also I think we should be
loading the basic diff config for creating the patch when we stop with
conflicts?

If anyone has any thought on this, please share them!

Best Wishes

Phillip
> 
> Let me know what you think. I should have time to update this patch set
> later in the week.
> 
> Best Wishes
> 
> Phillip
> 
>> For the former, because this helper does not have to be called
>> directly as a git_config() callback, but instead it is always meant
>> to be called indirectly from another git_config() callback (like
>> git_rebase_helper_config() here, and common_config() in
>> builtin/revert.c like we see below), it does *not* have to be
>> constrained by the function signature required for it to be a config
>> callback.  It could take a pointer to an int that stores if 'k' was
>> handled inside the function,
>>
>>     int git_sequencer_config_helper(char *k, char *v, int *handled);
>>
>> for example.
>>
> 

