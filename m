Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 112992047F
	for <e@80x24.org>; Mon,  7 Aug 2017 19:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751933AbdHGTMR (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 15:12:17 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35465 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbdHGTMP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 15:12:15 -0400
Received: by mail-qt0-f194.google.com with SMTP id t37so1395469qtg.2
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 12:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5W36u9UkEa6WiGBqaFxTIeUYudXOmxd9TsxzOIdkic0=;
        b=fMCccRsUu5Eb+Ib4ATBYH7OhdiX50IPvqSLnUcGOIlWsz5AMMAO2a2u2tEtch/R29s
         jYRQtYYDzuRAF3E7XvXVOEsjssGhtNAVoPhvprBlLYC//mtCudC9imXyGeND4sKF5TGb
         d9kkIp5RxoORCqssMjpgQmrrsy+IaGPJ//pjw5T8yXuK5N1BJ+fE02l4QwuTqCm6vVoE
         ODjZ/U5s22a7a7LaX0MUZfgOTDRbLlxwbFEvxAWR385/4cSHhbTFqxSmwKfMXw07Un5u
         im2nMtjD1xw34lq3lb633FFfWj2Ve3PDqubNP2cClWm4ta8Us/MyNt2qx7BNaxCc8+r2
         Ug2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5W36u9UkEa6WiGBqaFxTIeUYudXOmxd9TsxzOIdkic0=;
        b=dOnpL274n7UJZ07c5LVaStGj5FGv78uWkmBQ0oAexm9w7izGWo5MdUTdHu8HI0G1x3
         1YIzr0WTZ1AasMKlkHIolFiDpGREDLMe1CYJha3KfMDuC0ZoJwDmYKXU3eK4G1pBGETV
         3HuWI8ZHlewom8j1QQHCmTwxgSi87iVmC7nasI6iBaYdyXGhyk4B1H1o45mjsrYPW5mr
         EQV6PQpWbEGOjy0tssO1BeZVrjYGdbsIMEa+NmYZtBnbcp9yRQVFDhi8VIGojbRr+dbS
         EhoXZ6ChxosDZD//6XTKnjRy47IW2mW7jrvHCXgnQZAGwbT5sFIAD7YkUNbhuHaNfpwK
         U6DA==
X-Gm-Message-State: AHYfb5hGjQLaaZS9beGcB6fp6vUfI0O8aWzNUjZ1Zqe859CdTbQ2mUdO
        BkYEeM5XyWZMm/JB0i4=
X-Received: by 10.237.39.68 with SMTP id n62mr2203779qtd.218.1502133134355;
        Mon, 07 Aug 2017 12:12:14 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id z199sm5622585qka.94.2017.08.07.12.12.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Aug 2017 12:12:13 -0700 (PDT)
Subject: Re: Partial clone design (with connectivity check for locally-created
 objects)
To:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        christian.couder@gmail.com
References: <20170804145113.5ceafafa@twelve2.svl.corp.google.com>
 <xmqqtw1nrlpf.fsf@gitster.mtv.corp.google.com>
 <20170804172137.42f27653@twelve2.svl.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <0633771f-ce19-6211-fabe-3f7f676e53ab@gmail.com>
Date:   Mon, 7 Aug 2017 15:12:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170804172137.42f27653@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/4/2017 8:21 PM, Jonathan Tan wrote:
> On Fri, 04 Aug 2017 15:51:08 -0700
> Junio C Hamano <gitster@pobox.com> wrote:
> 
>> Jonathan Tan <jonathantanmy@google.com> writes:
>>
>>> "Imported" objects must be in a packfile that has a "<pack name>.remote"
>>> file with arbitrary text (similar to the ".keep" file). They come from
>>> clones, fetches, and the object loader (see below).
>>> ...
>>> A "homegrown" object is valid if each object it references:
>>>   1. is a "homegrown" object,
>>>   2. is an "imported" object, or
>>>   3. is referenced by an "imported" object.
>>
>> Overall it captures what was discussed, and I think it is a good
>> start.

I missed the offline discussion and so am trying to piece together what 
this latest design is trying to do.  Please let me know if I'm not 
understanding something correctly.

 From what I can tell, objects are going to be segmented into two 
"types" - those that were fetched from a remote source that allows 
partial clones/fetches (lazyobject/imported) and those that come from 
"regular" remote sources (homegrown) that requires all objects to exist 
locally.

FWIW, the names here are not making things clearer for me. If I'm 
correct perhaps "partial" and "normal" would be better to indicate the 
type of the source? Anyway...

Once the objects are segmented into the 2 types, the fsck connectivity 
check code is updated to ignore missing objects from "partial" remotes 
but still expect/validate them from "normal" remotes.

This compromise seems reasonable - don't generate errors for missing 
objects for remotes that returned a partial clone but do generate errors 
for missing objects from normal clones as a missing object is always an 
error in this case.

This segmentation is what is driving the need for the object loader to 
build a new local pack file for every command that has to fetch a 
missing object.  For example, we can't just write a tree object from a 
"partial" clone into the loose object store as we have no way for fsck 
to treat them differently and ignore any missing objects referenced by 
that tree object.

My concern with this proposal is the combination of 1) writing a new 
pack file for every git command that ends up bringing down a missing 
object and 2) gc not compressing those pack files into a single pack file.

We all know that git doesn't scale well with a lot of pack files as it 
has to do a linear search through all the pack files when attempting to 
find an object.  I can see that very quickly, there would be a lot of 
pack files generated and with gc ignoring "partial" pack files, this 
would never get corrected.

In our usage scenarios, _all_ of the objects come from "partial" clones 
so all of our objects would end up in a series of "partial" pack files 
and would have pretty poor performance as a result.

I wondered if it is possible to flag a specific remote as "partial" and 
have fsck be able to track any given object back to the remote and then 
properly handle the fact that it was missing based on that. I couldn't 
think of a good way to do that without some additional data structure 
that would have to be build/maintained (ie promises).

That thinking did lead me back to wondering again if we could live with 
a repo specific flag.  If any clone/fetch was "partial" the flag is set 
and fsck ignore missing objects whether they came from a "partial" 
remote or not.

I'll admit it isn't as robust if someone is mixing and matching remotes 
from different servers some of which are partial and some of which are 
not.  I'm not sure how often that would actually happen but I _am_ 
certain a single repo specific flag is a _much_ simpler model than 
anything else we've come up with so far.

>>
>> I doubt you want to treat all fetches/clones the same way as the
>> "lazy object" loading, though.  You may be critically rely on the
>> corporate central server that will give the objects it "promised"
>> when you cloned from it lazily (i.e. it may have given you a commit,
>> but not its parents or objects contained in its tree--you still know
>> that the parents and the tree and its contents will later be
>> available and rely on that fact).  You trust that and build on top,
>> so the packfile you obtained when you cloned from such a server
>> should count as "imported".  But if you exchanged wip changes with
>> your colleages by fetching or pushing peer-to-peer, without the
>> corporate central server knowing, you would want to treat objects in
>> packs (or loose objects) you obtained that way as "not imported".
> 
> That's true. I discussed this with a teammate and we might need to make
> extensions.lazyObject be the name of the "corporate central server"
> remote instead, and have a "loader" setting within that remote, so that
> we can distinguish that objects from this server are "imported" but
> objects from other servers are not.
> 
> The connectivity check shouldn't be slow in this case because fetches
> are usually onto tips that we have (so we don't hit case 3).
> 
>> Also I think "imported" vs "homegrown" may be a bit misnomer; the
>> idea to split objects into two camps sounds like a good idea, and
>> "imported" probably is an OK name to use for the category that is a
>> group of objects to which you know/trust are backed by your lazy
>> loader.  But the other one does not have to be "home"-grown.
>>
>> Well, the names are not that important, but I think the line between
>> the two classes should not be "everything that came from clone and
>> fetch is imported", which is a more important point I am trying to
>> make.
>>
>> Thanks.
> 
> Maybe "imported" vs "non-imported" would be better. I agree that the
> objects in the non-"imported" group could still be obtained from
> elsewhere.
> 
> Thanks for your comments.
> 
