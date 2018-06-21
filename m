Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 604071F516
	for <e@80x24.org>; Thu, 21 Jun 2018 17:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932799AbeFURiz (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 13:38:55 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33641 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932695AbeFURiy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 13:38:54 -0400
Received: by mail-wr0-f196.google.com with SMTP id k16-v6so4068601wro.0
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 10:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=P6GzXSaPqhbx4EcYRL51RzRal0y2mdsCc7RVefEHegk=;
        b=C8xJLJsJzobbdR1rloTukLkbUjeUAoQnNkzneU6gN8RVBP6MNgQM5OZCdQ0xjObZz1
         4g3JHn+EkgaqXsXMBnWh65yPo7FVIG0bO/9x4DmG3whqhqes2D2nc7i50tF4XkSsHNj3
         ffjB0h61KYeHC/xrcu7sYb+w9bGxMnxCo0hNdjzZs+E2Wd5TDjI+vajS/uaJG+WZeVZj
         sQfhwejQ+SNl3ZCdx4HXPAr+zcOKuC3EACcpLm7ssuyRoRyBQ4YWhSCdnF1+aTUYFnAS
         ysnI0hqAInJyxgU/aawYD5sBS7M+yeR3HKjokO1N+UwtY0W1Db00QNH9cgSaDe5DGUS/
         tCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=P6GzXSaPqhbx4EcYRL51RzRal0y2mdsCc7RVefEHegk=;
        b=o3bwlwKR+TBxfXZLzvaJ/dgl2yMi58ew/xuO1qO1ewl/4+hhWB1aaccgTFxLhB3d5X
         pokIAbUCEI4ShreYvVoGQIXoJ6UEp4UvCn1B70l0gt/1C3fsrD8cddp0reKMNIl3UBrn
         6Ub3EPU+XtJVOmHF9nhl+v2+ZfdZxLZVjcGFyJu57+cw9wkk7oTbgL9JiBFgrSU563Jg
         c/A+4wCk1BXeEcjXsMEV5DlIAPLPUTqoGt+48vm5XuHpHAgWKOAM0nPZ/Q6zpiFMyUa6
         zV7cAvRYAXtYOlJlkonr1fDXI/+yKCxdTsdDo+UbgeyvZXQTimNWQFdLExI2UpE3UUTS
         Bt4w==
X-Gm-Message-State: APt69E3QX7GqCl4ZXyzP45YuQ8GjtYfEEgYYe5PpeYdEIECHdkBmwV6N
        LP3l3hmnYlPnWiX/6loT2ps=
X-Google-Smtp-Source: ADUXVKLWLd+MB7FlMtoqFofXzOaKM08i0Utc6c4945hkFiKyyrtg+X9hXqQ9ReLuJZcDAFeBbxtJbA==
X-Received: by 2002:adf:ec02:: with SMTP id x2-v6mr20845630wrn.245.1529602733023;
        Thu, 21 Jun 2018 10:38:53 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z7-v6sm4885326wrl.77.2018.06.21.10.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 10:38:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Martin Fick <mfick@codeaurora.org>
Subject: Re: [PATCH 09/23] midx: write pack names in chunk
References: <20180607140338.32440-1-dstolee@microsoft.com>
        <20180607140338.32440-10-dstolee@microsoft.com>
        <CACsJy8ARDLeWaWq1_npZq5ARCVgcETpS--YUVLqZkZA52E7Msw@mail.gmail.com>
        <4082c785-9fb2-7b15-b646-3c658b54abbe@gmail.com>
Date:   Thu, 21 Jun 2018 10:38:49 -0700
In-Reply-To: <4082c785-9fb2-7b15-b646-3c658b54abbe@gmail.com> (Derrick
        Stolee's message of "Thu, 21 Jun 2018 11:25:38 -0400")
Message-ID: <xmqqfu1gt4ye.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 6/7/2018 2:26 PM, Duy Nguyen wrote:
>> On Thu, Jun 7, 2018 at 4:03 PM, Derrick Stolee <stolee@gmail.com> wrote:
>>> @@ -74,6 +80,31 @@ struct midxed_git *load_midxed_git(const char *object_dir)
>>>          m->num_chunks = *(m->data + 6);
>>>          m->num_packs = get_be32(m->data + 8);
>>>
>>> +       for (i = 0; i < m->num_chunks; i++) {
>>> +               uint32_t chunk_id = get_be32(m->data + 12 + MIDX_CHUNKLOOKUP_WIDTH * i);
>>> +               uint64_t chunk_offset = get_be64(m->data + 16 + MIDX_CHUNKLOOKUP_WIDTH * i);
>> Would be good to reduce magic numbers like 12 and 16, I think you have
>> some header length constants for those already.
>>
>>> +               switch (chunk_id) {
>>> +                       case MIDX_CHUNKID_PACKNAMES:
>>> +                               m->chunk_pack_names = m->data + chunk_offset;
>>> +                               break;

(style: aren't these case arms indented one level too deep)?

>>> +                       case 0:
>>> +                               die("terminating MIDX chunk id appears earlier than expected");
>> _()
>
> This die() and others like it are not marked for translation on
> purpose, as they should never be seen by an end-user.

Should never be seen because it indicates a software bug, in which
case this should be BUG() instead of die()?

Or did we just find a file corruption on the filesystem?  If so,
then the error is end-user facing and should tell the user something
that hints what is going on in the language the user understands, I
would guess.

>>> +                       default:
>>> +                               /*
>>> +                                * Do nothing on unrecognized chunks, allowing future
>>> +                                * extensions to add optional chunks.
>>> +                                */
>> I wrote about the chunk term reminding me of PNG format then deleted
>> it. But it may help to do similar to PNG here. The first letter can
>> let us know if the chunk is optional and can be safely ignored. E.g.
>> uppercase first letter cannot be ignored, lowercase go wild.
>
> That's an interesting way to think about it. That way you could add a
> new "required" chunk and earlier versions could die() realizing they
> don't know how to parse that required chunk.

That is how the index extension sections work and may be a good
example to follow.
