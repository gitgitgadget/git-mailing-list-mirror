Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F8BCE79B1
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 06:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjITGsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 02:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjITGs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 02:48:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429B0AD
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 23:48:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c081a44afso65467847b3.3
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 23:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695192502; x=1695797302; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6TEtiKULcQMZc5sjExeuqPB+4f4S2JYexUr12w57l7U=;
        b=HduCfNeWSc3KHm2itIvsCEaGYwJ9z8zL0ZS1qp9a/xNzpGl2P/L69cirgODviT9ufi
         FN3KTXM3JLbHYybCwKbKVO53taz1yT2RIuOVEkl9rAxDEdgMvOJpktL9Y7i0XNPmStY8
         6RCwf2BSnDm7+NavvIOEqbO20MeoxEX1sbgP9E06c+jyI2ZpR8PN7qqD3yV527GJaP4H
         WmbM6VMlCRlhSc7m/9Uo492AQHhkCagD4RQEhXesn7aYSvpQwDSgYvA39Jvs09RfoHAb
         0PwJEY64cTIwYj4MUkzChH1T/Ab6srX7okHiMsj7asJyUivuy8/GlUQ/pxZ958Jzyncj
         xlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695192502; x=1695797302;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6TEtiKULcQMZc5sjExeuqPB+4f4S2JYexUr12w57l7U=;
        b=kiQU+FEMCnbtE1MIT3Kh8DU5ltcIDniiB0kBZlaTh5+kRyEmnuGSW5kRBy53ddaQ4k
         EDcjrmw69mCGLQGs4zBf2+8ZdUpH9+lyzBof1bnGVpVGOu3ByC9q0/jcwOVvI9tXTQ9F
         InHLnu1xRz2VV/vhQ4gyKD/hRT3KkSoIQc8xnO2Z9dSS+IxTCHNSImvSc5HxI4qZaMbc
         Cwg2pwVOemcUJp2v7aqUuV4Wspy9Pi3L8ZOHJ0S+LGg1ehGpXtZuuCXi/rdJ9ih55+vW
         ozsedAeMdvlIFfyC0NINQSflDyCZnmCkByThD+GAhkKB9bNXdpHzq0N43VK2yaM/gDCY
         KVSw==
X-Gm-Message-State: AOJu0Yxrt13rbBp+NnExCcEIhyXB9l+5c3Cmwv9urWQ3RNm7K2oxqaTg
        VXUswkxYXON4wkAOklCIq4hmU5egDMo=
X-Google-Smtp-Source: AGHT+IHpuHiVaHwtHBThJ4JManoWY64xlpOyUtvKkI4fRjIhsm+baNiK2Ydrw4TtBnbsSWT9sS5gMXNR4kk=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:690c:2d81:b0:59e:fb27:2a93 with SMTP id
 er1-20020a05690c2d8100b0059efb272a93mr2571ywb.2.1695192502447; Tue, 19 Sep
 2023 23:48:22 -0700 (PDT)
Date:   Tue, 19 Sep 2023 23:48:20 -0700
In-Reply-To: <20230919225926.2189091-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20230919225926.2189091-1-jonathantanmy@google.com>
Message-ID: <owlyy1h1ibm3.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 13/13] trailer doc: <token> is a <key> or <keyAlias>,
 not both
From:   Linus Arver <linusa@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> @@ -248,34 +258,40 @@ With `add`, a new trailer will be added.
>>  +
>>  With `doNothing`, nothing will be done.
>>  
>> -trailer.<token>.key::
>> -	This `key` will be used instead of <token> in the trailer. At
>> -	the end of this key, a separator can appear and then some
>> -	space characters. By default the only valid separator is ':',
>> -	but this can be changed using the `trailer.separators` config
>> -	variable.
>> +trailer.<keyAlias>.key::
>> +	Defines a <keyAlias> for the <key>. The <keyAlias> must be a
>> +	prefix (case does not matter) of the <key>. For example, in `git
>> +	config trailer.ack.key "Acked-by"` the "Acked-by" is the <key> and
>> +	the "ack" is the <keyAlias>. This configuration allows the shorter
>> +	`--trailer "ack:..."` invocation on the command line using the "ack"
>> +	<keyAlias> instead of the longer `--trailer "Acked-by:..."`.
>> ++
>> +At the end of the <key>, a separator can appear and then some
>> +space characters. By default the only valid separator is ':',
>> +but this can be changed using the `trailer.separators` config
>> +variable.
>
> I think all the other patches will be a great help to the user, but I'm
> on the fence about this one.

Ack. I'm OK with dropping this patch (I assume I don't need to reroll
this series for that?).

> Someone who knows these trailer components
> by their old names might be confused upon seeing tne new ones, so I'm
> inclined to minimize such changes.

True, I had some inclination to do the same kind of change but for the
trailer.c code also (that code uses the "token" language also,
furthering the ambiguity, sadly) but wanted to just do the user-facing
part first because I thought the users shouldn't need to know about the
internals anyway.

If I did revise this patch to include the same changes in trailer.c and
not just the docs, would you be more willing to support the (new) patch?
I'm mainly curious about what will make you more comfortable to accept
this change.

> I do think that the new names make
> more sense, though.

Thanks!

> The documentation doesn't seem to say what happens when trailer.ack.cmd
> and trailer.Acked-by.cmd (replace "cmd" with whatever) are defined, but
> that was true previously too (and knowing this does not really enable
> the user to be able to do something they previously couldn't, so this
> is fine).

Ah interesting point. I'll try to remember this when I revisit this
patch again in the (near?) future.
