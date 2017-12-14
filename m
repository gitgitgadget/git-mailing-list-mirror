Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DB681F404
	for <e@80x24.org>; Thu, 14 Dec 2017 22:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754203AbdLNWwv (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 17:52:51 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:41538 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754069AbdLNWwu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 17:52:50 -0500
Received: by mail-it0-f65.google.com with SMTP id x28so15309803ita.0
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 14:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WxtYFVyqtdHF8xQOmPIvh6kBKtRcKvnVwYaHIS7e4/4=;
        b=SOUE5PRAIbo3U3gwqvxXJHllDhHwawNQ9zcGbffcictY3CEZ8QXmH6/XH78z0VVuuf
         CIIyliMC6mLHr03+iQmZp0DDqFyac51sr7mQZ+kRUeMvjdlIChnFpkn69pFcPD6YbIiy
         3rFsfQPPYZBaSkZ29Oia61lO2LlJ5jMcSjunjYOewDO3zKQyR1uqYOkO0vjzLNTEiVCq
         7F5YbpQO9OvsDwruzno2lDuKlslNXOPeMrI2M2Kgog+Rpokd0diT5HUWqmP72Szhpx7J
         tOrA9r/eDsGBeREnD6Aw3yc7iCbSH/XclOCZssrmkzzPmz+4Q6J08VOxd8mhea34cVyt
         bOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WxtYFVyqtdHF8xQOmPIvh6kBKtRcKvnVwYaHIS7e4/4=;
        b=uSI+CqdeL/y4KSFqQjVN2e491N2U8Ld+W4l64Yh0agoIhJLsBje0Ti4ELzZKMH/DA4
         uGpjQoI5932obeoS+1Pn8AQFyEhwZeG1azuXoMFb2Hhzm5w11i0eV7EY3we1P0iWx5oC
         Ld2zWo6X/HVGcKJc01X4R6cAJtSRosWScay2Fksq+geCDWj0GsTJ6QhG6FnbGv3wn783
         bS2kFuIuE6cm/2PeCKq/NgAg3rIIrURgJybPGtPJOmGvZQKHCaZqmA/fkl1yy//F4wEL
         z0lnF9robVYNom7YaU3taO9PGqCpyr7ISrCBQZU1dpz1Ke/Vk/fO+uCoqM40HAYa+9fX
         cEfA==
X-Gm-Message-State: AKGB3mIN4GnrGfQrlhMxt6CKiJWnEHU/jy0tRSNsossWKvG9BXIYJ9Id
        I9Du3sNiMfoaVCce7dzN83KLgwJg
X-Google-Smtp-Source: ACJfBou4hWEUgs8W2q7Yd/xibamrUUo4uiRudNZQuyv0HIJZVrZXEGzFe6DtZFPRNDs5MzKKkM4IMA==
X-Received: by 10.107.198.67 with SMTP id w64mr9198955iof.264.1513291969396;
        Thu, 14 Dec 2017 14:52:49 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a132sm2803048ioe.40.2017.12.14.14.52.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Dec 2017 14:52:48 -0800 (PST)
Date:   Thu, 14 Dec 2017 14:52:00 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] diffcore: add a filter to find a specific blob
Message-ID: <20171214225200.GA44616@aiede.mtv.corp.google.com>
References: <CAGZ79kaJgCchQKcRMkW-cjRmx_7eYQDqLs5GgDOgLEb1H=w-0g@mail.gmail.com>
 <20171212012422.123332-1-sbeller@google.com>
 <20171214212234.GC32842@aiede.mtv.corp.google.com>
 <CAGZ79kZdUuoM79n09ziG0F7WCWNLpZ2AiFA6fb_qgND1b3_F9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZdUuoM79n09ziG0F7WCWNLpZ2AiFA6fb_qgND1b3_F9A@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:
> On Thu, Dec 14, 2017 at 1:22 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> - what about mode changes?  If the file became executable but the
>>   blob content didn't change, does that commit match?
>
> ./git log --find-object=$(git rev-parse ba67504f:t/perf/p3400-rebase.sh)
>
> claims it does find the mode change (commit ba67504f is just a mode
> change)

Thanks.  Reminder to self to add a test + docs about that (as a followup
change; this isn't a complaint about the patch).

>> - are copies and renames shown (if I am passing -M -C)?
>
> It restricts the commits shown, not the renamed files. But I assume
> you mean it the same way as with mode changes.
> I did not find a good commit in gits history to demonstrate, but as
> it is orthogonal to the object id restrictions, I would think it works

Ok, will add test + doc.

>> Nit, not related to this change: it would be nice to have a long
>> option to go along with the short name '-t' --- e.g. --include-trees.
>
> follow up patches welcome. :)

Will think more and try to send a patch if it still seems like a good
idea in a day or so. ;)

>> Another nit: s/gitlink entry/submodule commit/, perhaps.  The commit
>> object is not a gitlink entry: it is pointed to by a gitlink entry.
>
> Well, what if the user doesn't have a submodule, but uses gitlinks
> for other purposes? We do inspect the gitlink, so it is correct IMHO.

It's a language nit.  The argument to --find-object is a commit object
name, not a gitlink entry.  A gitlink entry looks like

 160000 <path> <object>

>> Another documentation idea: it may be nice to point out that this
>> is only about the preimage and postimage submodule commit and that
>> it doesn't look at the history in between.
>
> That is sensible. One might be tempted to ask: "Which superproject
> commit contains a submodule pointer, that has commit $X in the
> submodule history?", but this new option is totally not answering this.

Ok, will try to come up with wording.

>>>                                                          The
>>> reason why these commits both occur prior to v2.0.0 are evil
>>> merges that are not found using this new mechanism.
>>
>> Would it be worth the doc mentioning that this doesn't look at merges
>> unless you use one of the -m/-c/--cc options, or does that go without
>> saying?
>
> I assumed it goes without saying, just like the lacking -t could mean
> to ignore trees. ;)

I suspect it's worth a mention, based on the discussion in this thread
(i.e. without such docs it was non-obvious and took some time to
diagnose).

[...]
>>> +--find-object=<object-id>::
>>> +     Restrict the output such that one side of the diff
>>> +     matches the given object id. The object can be a blob,
>>> +     gitlink entry or tree (when `-t` is given).
>>
>> I like this name --find-object more than --blobfind!  I am not sure it
>> quite matches what the user is looking for, though.  We are not
>> looking for all occurences of the object; we only care about when the
>> object appears (was added or removed) in the diff.
>
> Thanks! Yes, but the 'edges' are so few commits that a further walk
> will reveal all you need to know?

Sorry for the lack of clarity: I actually like this behavior *more*
than a "find trees pointing to object" behavior.  I'm just saying the
name sets an unclear expectation.

[...]
> Regarding finding a better name, I would want to hear from others,
> I am happy with --find-object, though I can see --pickaxe-object
> or --object--filter to be a good narrative as well.

Drat, I was hoping for an opinion.

Based on the answers above about mode changes and renames, at the
moment --object-filter seems clearest to me.

Thanks,
Jonathan
