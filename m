Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0FE51F403
	for <e@80x24.org>; Tue,  5 Jun 2018 07:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeFEHOS (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 03:14:18 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:34044 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbeFEHOP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 03:14:15 -0400
Received: by mail-ua0-f195.google.com with SMTP id 74-v6so879955uav.1
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 00:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kdF3JMP+23pkEc3uLS5FTVf/DVelHzKH+lvgmJ+h1l8=;
        b=IYJ6txOZZYmDmkIrjg5dIXNyQwGcZhcFdyz8Kl8Fj9ROexJjzT52/Uk9McRu8Ci/bn
         vdXKlDrj27fcJwmU4uRRqRJx3uctc6Fo6EZqyaCF5reb4i+GiXdocm1nz/L3xIvxCojc
         Ygt4pm3LfSNlK/dsoGmE83WAgQd4y7M1UYzkCVGlADZF4cgYLtU30GV42fsU+7WzJDev
         FDE+j7lfJlAHAgX3o/vyMCRVcxCqqZUcevdnBOhLI7F6U2oaJEelwU2b59v4Cz7wLo4f
         6QTYdyXmzZEiAnimmiyoozsFvUeBrIjtTFHSVDWiFv7VoSWvfIP+r0a4BGHFAo9jiliP
         +8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kdF3JMP+23pkEc3uLS5FTVf/DVelHzKH+lvgmJ+h1l8=;
        b=Z0xiopatmy2n3DVejdDCXkz6LRvkGhnuMqkn3Zpx70tQJIM6GadMcNu9KL3z3k3QE3
         vAQtEMwziH45sVn65q8D0DTTXx85rpYr3hEsQw21JV3Rf2d6JayidRnzqf9sXP3/s19m
         mqR8l0RObmTgkWqybbP/ZLZvpg/SdgHhlWEuvlDXioyhKHMPXRp2pLksKgb8OC0DKJL6
         FbqEEaNGz/f+DZXFukLEfXColoMnGPh/4Ay/trkFZ1klLbWEhfr0lwyOimpt2qY95bel
         5BdhUszlMtjot/sy9DvZ2IxXAKbpwYrXgGGIT9KPLk4cmjMR8iVoigBR0rIWsOVh3e1q
         nVCw==
X-Gm-Message-State: APt69E3tM8DAiP2uwu+eatMq0TMqYHAE/hSf1Ewh/gmgGIxA4iw3R5d/
        TD+6rhSt2eonYfvMU0YqdWoBLoLq+yUVWgzVVA0=
X-Google-Smtp-Source: ADUXVKKTEND8T6h+68MdKKqMqlWj6KzPl+fIKhObuO70WQnn6S8q+5vTEKzrwTzr/n+v4lsiCFPBvv0UrEk7z4cbWUc=
X-Received: by 2002:ab0:84b:: with SMTP id b11-v6mr3149302uaf.79.1528182853990;
 Tue, 05 Jun 2018 00:14:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Tue, 5 Jun 2018 00:14:13 -0700 (PDT)
In-Reply-To: <xmqqvaaz5jcv.fsf@gitster-ct.c.googlers.com>
References: <20180603065810.23841-1-newren@gmail.com> <20180603065810.23841-5-newren@gmail.com>
 <xmqqvaaz5jcv.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 5 Jun 2018 00:14:13 -0700
Message-ID: <CABPp-BERW3VtKxwKZ=-K6=pdVZydHRRKKGce2S=sttqfcDeRDA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] merge-recursive: fix assumption that head tree
 being merged is HEAD
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 3, 2018 at 8:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> `git merge-recursive` does a three-way merge between user-specified trees
>> base, head, and remote.  Since the user is allowed to specify head, we can
>> not necesarily assume that head == HEAD.
>>
>> We modify index_has_changes() to take an extra argument specifying the
>> tree to compare the index to.  If NULL, it will compare to HEAD.  We then
>> use this from merge-recursive to make sure we compare to the
>> user-specified head.
>>
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>>
>> I'm really unsure where the index_has_changes() declaration should go;
>> I stuck it in tree.h, but is there a better spot?
>
> I think I saw you tried to lift an assumption that we're always
> working on the_index in a separate patch recently.  Should that
> logic apply also to this part of the codebase?  IOW, shouldn't
> index_has_changes() take a pointer to istate (as opposed to a
> function that uses the implicit the_index that should be named as
> "cache_has_changes()" or something?)
>
> I tend to think this function as part of the larger read-cache.c
> family whose definitions are in cache.h and accompanied by macros
> that are protected by NO_THE_INDEX_COMPATIBILITY_MACROS so if we
> were to move it elsewhere, I'd keep the header part as-is and
> implementation to read-cache.c to keep it together with the family,
> but I do not see a huge issue with the current placement, either.

That's good point; the goal to lift assumptions on the_index should
probably also apply here.  I'll make the change.
(And it was actually Duy's patch that I was reviewing, but close
enough.)   I'll take a look at moving it to read-cache.c as well.
