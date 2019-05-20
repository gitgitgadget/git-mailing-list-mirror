Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2591F462
	for <e@80x24.org>; Mon, 20 May 2019 17:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392844AbfETRWS (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 13:22:18 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:43930 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390855AbfETRWS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 13:22:18 -0400
Received: by mail-qk1-f175.google.com with SMTP id z6so9282108qkl.10
        for <git@vger.kernel.org>; Mon, 20 May 2019 10:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ItZA+q7Qq7hAuX4NTuK1gMi1tr7ywZIZB5B/9Cf/u8w=;
        b=IXt+qPN3+Yzgpz4keoGinb/h/23rfUKkDzk6tP52UjCqGMP6xsq2Nukh6pKbp4l7aW
         jpwm2aKzTroWOLpdxRZd2zfgbuIf9IpOQ4dp/qM3pE+kaXgZEiHeAISyPbfLEo+lnV4J
         Ph2oTTKMZSUhVyFWRGbPaJbnxUZI9BLiWNMR5b7wIQ487A9gMg6aAw6GRgosRSwoY/NP
         4yMihtnWMR/wzntMzPczMWYV4pF+dyfktOe1MFA9n6J2rYmixDpKCAq6T3W4iN48g2rO
         3YS4gJAbi3ubgJ0coXuX7yweGFTGZNWdK87YPiJliaHjxGiR66sNMn7zt1WyWU1VGk/b
         m9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ItZA+q7Qq7hAuX4NTuK1gMi1tr7ywZIZB5B/9Cf/u8w=;
        b=Dha2jNyrIhNzyfCsWq8jgDJle1RfzbINhI1TaT7TpmIp3pKU/Jfi2tz39ygh+5OVaw
         jXAvmnRVn/6gkwlLY5b4uNA7HdiBssC6b4Oyti0SJBZZ8CZY0sXbWhTivp0dv6B0jcSJ
         leg+aCgLIL+rVb1Yy2w5+4AiGrwv+AUHwunBeEHIrDLZRJOxZo8Mv0otQHFwXZN2ctes
         +riFtaDXU4YTG4ccReJkB890ftXbZfz1imbiGhkOeXxGL9iTd2EeVrSonq6BuqwQfSDP
         w6aawzMPmul0f1EnTXfbLLRzUfOXXwBmVN90RQdXCsCmmgW4NKwmlz6tYZaSsxnBfvzQ
         Tdkg==
X-Gm-Message-State: APjAAAUF3CGVS7RHJsStNRSC1Gdf8FO6vI43zMMFgf9NrziFBPI4HFsn
        sBnxUb23TiBz6aoyMLKnqzVY/udzVjw=
X-Google-Smtp-Source: APXvYqwRQUTEPr0IHa/VRsLZaTybxisDDOzASmOUv8FCNAOjqrYZbEkqXRHAUpmsl8iTOnGgW7jjBQ==
X-Received: by 2002:a37:6394:: with SMTP id x142mr60389307qkb.323.1558372936986;
        Mon, 20 May 2019 10:22:16 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:8824:a533:8b:9681? ([2001:4898:a800:1012:3958:a533:8b:9681])
        by smtp.gmail.com with ESMTPSA id t2sm8405999qkm.11.2019.05.20.10.22.15
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 10:22:16 -0700 (PDT)
Subject: Re: Finer timestamps and serialization in git
To:     esr@thyrsus.com,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
References: <20190515191605.21D394703049@snark.thyrsus.com>
 <ae62476c-1642-0b9c-86a5-c2c8cddf9dfb@gmail.com>
 <023b01d50b5c$cbd3cd90$637b68b0$@pdinc.us>
 <998895a9-cfbb-c458-cc88-fa1aabed4389@gmail.com>
 <20190516002831.GC124956@thyrsus.com>
 <3b8d6a78-bd88-770c-e79b-d732f7e277fd@gmail.com>
 <20190520170518.73ad912b@kitsune.suse.cz>
 <20190520163625.GA99397@thyrsus.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7e88805c-7e08-2631-599d-b47a098f1ce1@gmail.com>
Date:   Mon, 20 May 2019 13:22:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190520163625.GA99397@thyrsus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/20/2019 12:36 PM, Eric S. Raymond wrote:
> Michal Suchánek <msuchanek@suse.de>:
>> On Wed, 15 May 2019 21:25:46 -0400
>> Derrick Stolee <stolee@gmail.com> wrote:
>>
>>> On 5/15/2019 8:28 PM, Eric S. Raymond wrote:
>>>> Derrick Stolee <stolee@gmail.com>:  
>>>>> What problem are you trying to solve where commit date is important?  
>>
>>>> B. Unique canonical form of import-stream representation.
>>>>
>>>> Reposurgeon is a very complex piece of software with subtle failure
>>>> modes.  I have a strong need to be able to regression-test its
>>>> operation.  Right now there are important cases in which I can't do
>>>> that because (a) the order in which it writes commits and (b) how it
>>>> colors branches, are both phase-of-moon dependent.  That is, the
>>>> algorithms may be deterministic but they're not documented and seem to
>>>> be dependent on variables that are hidden from me.
>>>>
>>>> Before import streams can have a canonical output order without hidden
>>>> variables (e.g. depending only on visible metadata) in practice, that
>>>> needs to be possible in principle. I've thought about this a lot and
>>>> not only are unique commit timestamps the most natural way to make
>>>> it possible, they're the only way conistent with the reality that
>>>> commit comments may be altered for various good reasons during
>>>> repository translation.  
>>>
>>> If you are trying to debug or test something, why don't you serialize
>>> the input you are using for your test?
>>
>> And that's the problem. Serialization of a git repository is not stable
>> because there is no total ordering on commits. And for testing you need
>> to serialize some 'before' and 'after' state and they can be totally
>> different. Not because the repository state is totally different but
>> because the serialization of the state is not stable.
> 
> Yes, msuchanek is right - that is exactly the problem.  Very well put.
> 
> git fast-import streams *are* the serialization; they're what reposurgeon
> ingests and emits.  The concrete problem I have is that there is no stable
> correspondence between a repository and one canonical fast-import
> serialization of it.
> 
> That is a bigger pain in the ass than you will be able to imagine unless
> and until you try writing surgical tools yourself and discover that you
> can't write tests for them.

What it sounds like you are doing is piping a 'git fast-import' process into
reposurgeon, and testing that reposurgeon does the same thing every time.
Of course this won't be consistent if 'git fast-import' isn't consistent.

But what you should do instead is store a fixed file from one run of
'git fast-import' and send that file to reposurgeon for the repeated test.
Don't rely on fast-import being consistent and instead use fixed input for
your test.

If reposurgeon is providing the input to _and_ consuming the output from
'git fast-import', then yes you will need to have at least one integration
test that runs the full pipeline. But for regression tests covering complicated
logic in reposurgeon, you're better off splitting the test (or mocking out
'git fast-import' with something that provides consistent output given
fixed input).

-Stolee
 

