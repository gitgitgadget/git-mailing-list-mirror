Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55FCB1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 17:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752992AbcJKR5b (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 13:57:31 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34691 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753225AbcJKR4T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 13:56:19 -0400
Received: by mail-qk0-f173.google.com with SMTP id f128so1937514qkb.1
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 10:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=58hC82e6qv14d5c89MuW3+DuEA2o3Pljwgxmqa2aUSA=;
        b=PoWU/Gx2nynEtKARVTs+Z+yzFjDZ6N5I785+gcnwgp2EkKr6K44tOSb/HGgBSq0c6b
         HheReVEBm4qMXw8hQYs/shJGjCvdHg1oCtPdmsGjh9l18HkIH5Y9ydGuZ399Ps0l4pvq
         /6kmWo8USdYa5Mm6+cdSKzKbWXVW1RvfXsofQg9gtwpEXZazSTfKNlKDH0dGy4XxC3jS
         Y9XdpnJTyxj43L+HHWzJ8oHY8/Inm+VglLoG1d8VuNdj5lSqYQ6TI11oQs85tAw92gNU
         ua/JmnzOvqG1pj0n3wWyowrRObu3sivirt9Zw/yID+8dFhOWPbkr7TGxHF8CZQZbn8mk
         AI3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=58hC82e6qv14d5c89MuW3+DuEA2o3Pljwgxmqa2aUSA=;
        b=ktaugkRWQwTpBsh4SDQfWQpa0CA5mns4ZbLmWuVRH8dYDohPrrQalf7kvwdS2vMTlD
         FR6Ti/jVKvzWWhK3tYyqMLOvuKzPtSCJkgRna2V/soo+C3xFV7z0x5t5r26q8dHqbNqn
         zOT9pnpQTLpXN39THw4NLg5h4oiaM/EFhBqEDpiY4qFGbpdS0vJukJfwWZernKJqcDYL
         mlRNgBSED9UYdrnvIPSG3vNN7/IsGPs1yxLGfzMhM6E4F2LHku8iXbxDLz+p+eC7fIi/
         lvcu5lBr9qMa2b4GAR5+toEhOcgpy7J1iQmhzJGvTwaL2XvBmZgEVSLPKafFgE9r4jAq
         lI0g==
X-Gm-Message-State: AA6/9RmoEF5DVmJilLTedoTKWJzwBYWDkGCmUEFPMOCGGU0LO6sMzJKPNxwOGc3eV/VV1LuF+h66UNLNaeAkBr8T
X-Received: by 10.55.64.80 with SMTP id n77mr5065678qka.173.1476208577849;
 Tue, 11 Oct 2016 10:56:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 11 Oct 2016 10:56:17 -0700 (PDT)
In-Reply-To: <xmqqmviaaina.fsf@gitster.mtv.corp.google.com>
References: <20161011002115.23312-1-sbeller@google.com> <20161011002115.23312-29-sbeller@google.com>
 <xmqqmviaaina.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Oct 2016 10:56:17 -0700
Message-ID: <CAGZ79kaQKDdJfMOjDKEK_dZJhgj+R7rByQS++B3OOBy6uO1x2w@mail.gmail.com>
Subject: Re: [PATCH 28/28] attr: convert to new threadsafe API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 10:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This revamps the API of the attr subsystem to be thread safe.
>> Before we had the question and its results in one struct type.
>> The typical usage of the API was
>>
>>     static struct git_attr_check;
>
> I think you meant "*check" at the end, perhaps?
>
>>
>>     if (!check)
>>         check = git_attr_check_initl("text", NULL);
>>
>>     git_check_attr(path, check);
>>     act_on(check->value[0]);
>>
>> * While the check for attributes to be questioned only need to
>>   be initalized once as that part will be read only after its
>>   initialisation, the answer may be different for each path.
>>   Because of that we need to decouple the check and the answer,
>>   such that each thread can obtain an answer for the path it
>>   is currently processing.
>
> Yes, it is good to separate questions and answers.  I think answers
> should be owned by the caller, though.  I do not think of a good
> reason why you want to make it impossible to do something like this:
>
>         struct git_attr_check_result *result_1 = ...allocate...;
>         struct git_attr_check_result *result_2 = ...allocate...;
>
>         loop {
>                 struct strbuf path = next_path();
>                 git_check_attr(result_1, path.buf, check_1);
>                 if (strbuf_strip_suffix(&path, ".c")) {
>                         strbuf_addstr(&path, ".h");
>                         git_check_attr(result_2, path.buf, check_2);
>                         do something using result_1[] and result_2[];
>                 } else {
>                         do something using result_1[];
>                 }
>         }
>
> Do we already have a design of the "result" thing that is concrete
> enough to require us to declare that the result is owned by the
> implementation and asking another question has to destroy the answer
> to the previous question?  Otherwise, I'd rather not to see us make
> the API unnecessarily hard to use.  While I do want us to avoid
> overengineering for excessive flexibility, I somehow feel "you
> cannot control the lifetime of the result, it is owned by the
> subsystem" falls the other side of the line.

True, we had that issue for other APIs (IIRC path related things,
with 4 static buffers that round robin). I did not like that design decision,
but I felt it was okay, as the above did not occur to me.

In the case above, we could just copy the result_1->values and
then re-use the result_1, but I agree that this may be somewhat error prone
if you're not familiar with the decisions in this series.

So in case of the caller owning the result, we could pull the static
trick for now
and only use a different approach when we use it in actual threaded code, i.e.
the code in convert.c could become:

    static struct git_attr_check *check;
    static struct git_attr_result *result;

    if (!check) {
        check = git_attr_check_initl("crlf", "ident",
            "filter", "eol", "text", NULL);
        result = git_attr_result_alloc(5);
        user_convert_tail = &user_convert;
        git_config(read_convert_config, NULL);
    }

    if (!git_check_attr(path, check, result)) {
        ...

>> +  empty `struct git_attr_check` as alloced by git_attr_check_alloc()
>
> "allocated", not "alloced".

ok.

>
>> +  can be prepared by calling `git_attr_check_alloc()` function and
>> +  then attributes you want to ask about can be added to it with
>> +  `git_attr_check_append()` function.
>> +  git_attr_check_initl is thread safe, i.e. you can call it
>
> Spell it `git_attr_check_initl()` for consistency.

ok.

>
>> +  from different threads at the same time; internally however only one
>> +  call at a time is processed. If the calls from different threads have
>> +  the same arguments, the returned `git_attr_check` may be the same.
>
> I find this description a bit confusing.  At least the way I
> envisioned was that when this piece of code is run by multiple
> people at the same time,
>
>         static struct git_attr_check *check = NULL;
>         git_attr_check_initl(&check, ...);
>
> we won't waste the "check" by allocated by the first one by
> overwriting it with another one allocated by the second one.  So
> "the same arguments" does not come into the picture.  A single
> variable is either
>
>  * already allocated and initialised by the an earlier call to
>    initl() by somebody else, or
>
>  * originally NULL when you call initl(), and the implementation
>    makes sure that other people wait while you allocate, initialise
>    and assign it to the variable, or
>
>  * originally NULL when you call initl(), but the implementation
>    notices that somebody else is doing the second bullet point
>    above, and you wait until that somebody else finishes and then
>    you return without doing anything (because by that time, "check"
>    is filled by that other party doing the second bullet point
>    above).
>
> There is no need to check for "the same arguments".
>

I see. So we assume that there are no different arguments at the same time,
i.e. all threads run the same code when it comes to attrs.

Brandon wrote:
> On 10/10, Stefan Beller wrote:
>>   be initalized once as that part will be read only after its
>>       initialized
>>   initialisation, the answer may be different for each path.
> should this be the US spelling 'initialization'?

Yes, we'd want to be consistent, indeed. Sometimes the British spelling
slips through as that's what I learned in high school.

Specifically for initialise:

$ git grep initialise
contrib/examples/git-notes.sh:                  die "Will not
initialise with empty tree"
object.h: * it can return "yes we have, and here is a half-initialised object"
object.h: * half-initialised objects, the caller is expected to initialize them
revision.c:static struct treesame_state *initialise_treesame(struct
rev_info *revs, struct commit *commit)
revision.c:                             ts = initialise_treesame(revs, commit);
+ a lot of french translations.

The American spelling is found a lot more.

Thanks,
Stefan
