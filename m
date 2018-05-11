Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 879CC1F406
	for <e@80x24.org>; Fri, 11 May 2018 15:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750879AbeEKPRT (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 11:17:19 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38149 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeEKPRS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 11:17:18 -0400
Received: by mail-qt0-f193.google.com with SMTP id m9-v6so7504402qtb.5
        for <git@vger.kernel.org>; Fri, 11 May 2018 08:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Kq0J9J4Ic8IWduNFrEqigTuuwAKbF4A8SGHamU48+Wg=;
        b=OhlBMhLzDePbkw76EkE4o+B6nSNKPA5ZZ2G6qWqWF9JqDQDodkxQqOCnKnZ8mKIDWy
         LQDiICfnFTGj83QIKrnQR+LS7c1kFes4FAk/W02IPc4Cg6jbmwh5Wsf1JqbzBK5GNY6K
         ZpYal+zU+pk7hW7qXibWpd5dzIaNLfF6BV/bk5Lqz6axEvCSHNtGkI7o/PpdXEq3kWwl
         0Y7v9P6WpvlmmE010+CBH8uegQzRg2D/lyZ94iXWdRhqnPS26UEIwOOZxaPo9BTgkmcz
         uHhXGUJ65Jrs8SKu37/DFYrT1eZE+/mB4IbDY2XqVCCbMWt5hTRFfynBVqkzzLXSA50p
         uGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Kq0J9J4Ic8IWduNFrEqigTuuwAKbF4A8SGHamU48+Wg=;
        b=eEDpWutcWuV1uZsgtyx6sHGG7QAElpVxWqdu6c6Cl8nJEeMQhTpAukVRiDjnOWiXxC
         wpWNxRDmTs3wSILYg7lLmEAV2De/QpThvWkv3vMsvhkQF6hvVCvW8S9dpjxGgkQoG8BX
         HiH/aAwPwp+/wq4ynVEuHWTyvq18YAdjsXc/vGybjsunnImZ01EjE6xbMkJKj5yOf6do
         hotYiTfs4OhCBGHLBSH4wYNLDyHFSBd9KMyxPxNYenJ7ytg5f1CIhUJU0vN3umgH0MML
         Z8fCUXYVKADKHRHoId8/79buac5JvT2UVZo6cUhxSTq/E7djZMtyVNmMZJB9gQTYpBBi
         3VGw==
X-Gm-Message-State: ALKqPwelXghf7I4eaSlpVo2VH0rRlSiNuDIAxWbTbBk4uDOA4Bg2b55W
        TAPjj7Q9bozvRpVsx9TfRqw=
X-Google-Smtp-Source: AB8JxZpfCPxzUzKnAy6q/MlCZ5nvodEoj4pabG3k0h+Mxj0WksaVFDORnRUlU5R6M/Ou+PUTSE5JLQ==
X-Received: by 2002:a0c:d49b:: with SMTP id u27-v6mr5550430qvh.204.1526051837387;
        Fri, 11 May 2018 08:17:17 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id u42-v6sm2671188qtb.54.2018.05.11.08.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 08:17:16 -0700 (PDT)
Subject: Re: [PATCH 04/12] commit-graph: verify fanout and lookup table
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
 <20180510173345.40577-1-dstolee@microsoft.com>
 <20180510173345.40577-5-dstolee@microsoft.com>
 <CAN0heSoaTdkb5xcrEE4dY7aUpcTGCROyUbZ-HUUKFBHJ9zTGew@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <62c7d8c3-87e3-f8e3-a83a-fb53f956f89d@gmail.com>
Date:   Fri, 11 May 2018 11:17:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSoaTdkb5xcrEE4dY7aUpcTGCROyUbZ-HUUKFBHJ9zTGew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/10/2018 2:29 PM, Martin Ågren wrote:
> On 10 May 2018 at 19:34, Derrick Stolee <dstolee@microsoft.com> wrote:
>> While running 'git commit-graph verify', verify that the object IDs
>> are listed in lexicographic order and that the fanout table correctly
>> navigates into that list of object IDs.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   commit-graph.c | 33 +++++++++++++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>
>> diff --git a/commit-graph.c b/commit-graph.c
>> index ce11af1d20..b4c146c423 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -839,6 +839,9 @@ static int verify_commit_graph_error;
>>
>>   int verify_commit_graph(struct commit_graph *g)
>>   {
>> +       uint32_t i, cur_fanout_pos = 0;
>> +       struct object_id prev_oid, cur_oid;
>> +
>>          if (!g) {
>>                  graph_report(_("no commit-graph file loaded"));
>>                  return 1;
>> @@ -853,5 +856,35 @@ int verify_commit_graph(struct commit_graph *g)
>>          if (!g->chunk_commit_data)
>>                  graph_report(_("commit-graph is missing the Commit Data chunk"));
>>
>> +       for (i = 0; i < g->num_commits; i++) {
>> +               hashcpy(cur_oid.hash, g->chunk_oid_lookup + g->hash_len * i);
>> +
>> +               if (i > 0 && oidcmp(&prev_oid, &cur_oid) >= 0)
>> +                       graph_report(_("commit-graph has incorrect oid order: %s then %s"),
> Minor: I think our style would prefer s/i > 0/i/.
>
> I suppose the second check should be s/>=/>/, but it's not like it
> should matter. ;-)

It shouldn't, but a duplicate commit is still an incorrect oid order.

> I wonder if this is a message that would virtually never make sense to a
> user, but more to a developer. Leave it untranslated to make sure any
> bug reports to the list are readable to us?

Yeah, I'll make all of the errors untranslated since they are for 
developer debugging, not end-user information.

>> +
>> +               oid_to_hex(&prev_oid),
>> +               oid_to_hex(&cur_oid));
> Hmm, these two lines do not actually achieve anything?

It's a formatting bug: They complete the statement starting with 
'graph_report(' above.

>
>> +               oidcpy(&prev_oid, &cur_oid);
>> +
>> +               while (cur_oid.hash[0] > cur_fanout_pos) {
>> +                       uint32_t fanout_value = get_be32(g->chunk_oid_fanout + cur_fanout_pos);
>> +                       if (i != fanout_value)
>> +                               graph_report(_("commit-graph has incorrect fanout value: fanout[%d] = %u != %u"),
>> +                                            cur_fanout_pos, fanout_value, i);
> Same though re `_()`, even more so because of the more technical
> notation.
>
>> +
>> +                       cur_fanout_pos++;
>> +               }
>> +       }
>> +
>> +       while (cur_fanout_pos < 256) {
>> +               uint32_t fanout_value = get_be32(g->chunk_oid_fanout + cur_fanout_pos);
>> +
>> +               if (g->num_commits != fanout_value)
>> +                       graph_report(_("commit-graph has incorrect fanout value: fanout[%d] = %u != %u"),
>> +                                    cur_fanout_pos, fanout_value, i);
> Same here. Or maybe these should just give a translated user-readable
> basic idea of what is wrong and skip the details?

As someone who is responsible for probably inserting these problems, I 
think the details are important.

Thanks,
-Stolee
