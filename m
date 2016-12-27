Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30425200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 18:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755327AbcL0S0k (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 13:26:40 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:33409 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754973AbcL0S0j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 13:26:39 -0500
Received: by mail-qt0-f171.google.com with SMTP id p16so330528940qta.0
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 10:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kOW52bgdoxWU6tev5zz+iRIOZnBLt8qVNpDaaaRYzkw=;
        b=lggBNf6kM/UtxDhLNaqR0jxTRNiXKQwp3bZrRRyr6PvLrLFLMl20tuCZH3xnc/QoqM
         aGG0pHsxiWLgEuStsXwgBmaTI6ESizvzHjb+H6sP6OayXEfoXfzarSmiMOuBz3B3+VJi
         c2yQpxv5PyVEvx3GlVTQIiHQQeGHQFt3kZUAveotroBma1dH1U3va6JS/2+mm5oYDO5C
         djGj3Uzcc0eDdVPSZ8ocDhItXWtINZAN/3ZR41XNb+/2LVm1cvx5/IIW9AGxvreWRriv
         Vz+Dj25HBttY99yonQKAFzoNz+OmXbV5A9vvg0L5RFeoEChtfNqij5b3gLymHqJJ+Fbq
         ER6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kOW52bgdoxWU6tev5zz+iRIOZnBLt8qVNpDaaaRYzkw=;
        b=PK0LN6sDmbLHpHjIuNok8pbPcrBp/ps6UrzMao4PKbqqg6BzZLkfp9mjrMmM2u1PbZ
         1t42n3Pb01KpzlehuPEimILlJgJ/7/Ha+gZDJ3koa6tEzUPxbc3IwPNoM3WlrPo6XEfO
         Llh6YL716a1umOWOzOKYlK7z//MgiX51ifuAh4+7M/cTdzgb9zqj7yrnmRap6PetIsRC
         eQF9g3hJzOpQ480SG+2wvlu/RG330AQU3XTZ1+PWkEN9pcOVlnmNhTfQPVlMZASnERn1
         aVyGqCrn5N3qzPg7KyTpvZ8rFniMBEgXgPeNEDkSfju4QW/iSVqzgRR0AKZS9VPIJVus
         2u5w==
X-Gm-Message-State: AIkVDXKNk3+aZjDjAoDd6jkBsppcYzdEozphqviHYChz0iBNIstypyxKucizrB8HOYZjn5aWQQK/Mdf7UMXZkivL
X-Received: by 10.200.49.235 with SMTP id i40mr33378731qte.170.1482863198363;
 Tue, 27 Dec 2016 10:26:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Tue, 27 Dec 2016 10:26:37 -0800 (PST)
In-Reply-To: <CAGZ79kaRY0x+31-UiiBU1iBXGKAgeTRSSjvN0isd7jdg-Y7_rQ@mail.gmail.com>
References: <20161220232012.15997-1-sbeller@google.com> <20161220232012.15997-5-sbeller@google.com>
 <xmqqmvfich2e.fsf@gitster.mtv.corp.google.com> <CAGZ79kaRY0x+31-UiiBU1iBXGKAgeTRSSjvN0isd7jdg-Y7_rQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Dec 2016 10:26:37 -0800
Message-ID: <CAGZ79kZLk2bNj2Z_PFfo9KzODn8nSihDLdLuKvpSPodR9Eg-4w@mail.gmail.com>
Subject: Re: [PATCHv5 4/4] rm: absorb a submodules git dir before deletion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        David Turner <David.Turner@twosigma.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 27, 2016 at 10:17 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, Dec 26, 2016 at 5:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> @@ -342,6 +313,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>>>                       exit(0);
>>>       }
>>>
>>> +     submodules_absorb_gitdir_if_needed(prefix);
>>> +
>>>       /*
>>>        * If not forced, the file, the index and the HEAD (if exists)
>>>        * must match; but the file can already been removed, since
>>> @@ -358,9 +331,6 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>>>                       oidclr(&oid);
>>>               if (check_local_mod(&oid, index_only))
>>>                       exit(1);
>>> -     } else if (!index_only) {
>>> -             if (check_submodules_use_gitfiles())
>>> -                     exit(1);
>>>       }
>>>
>>
>> Hmph.  It may be a bit strange to see an "index-only" remove to
>> touch working tree, no?  Yet submodules_absorb_gitdir_if_needed() is
>> unconditionally called above, which feels somewhat unexpected.
>
> I agree. In a reroll I'll protect the call with
>
>     if (!index_only)
>         submodules_absorb_gitdir_if_needed(prefix);
>
>>
>>> @@ -389,32 +359,20 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>>>        */
>>>       if (!index_only) {
>>>               int removed = 0, gitmodules_modified = 0;
>>>               for (i = 0; i < list.nr; i++) {
>>>                       const char *path = list.entry[i].name;
>>>                       if (list.entry[i].is_submodule) {
>>> +                             struct strbuf buf = STRBUF_INIT;
>>> +
>>> +                             strbuf_addstr(&buf, path);
>>> +                             if (remove_dir_recursively(&buf, 0))
>>> +                                     die(_("could not remove '%s'"), path);
>>> +                             strbuf_release(&buf);
>>> +
>>> +                             removed = 1;
>>> +                             if (!remove_path_from_gitmodules(path))
>>> +                                     gitmodules_modified = 1;
>>> +                             continue;
>>>                       }
>>
>> I do not see any behaviour change from the original (not quoted
>> here), but it is somewhat surprising that "git rm ./submodule" does
>> not really check if the submodule has local modifications and files
>> that are not even added before remove_dir_recursively() is called.
>>
>> Or perhaps I am reading the code incorrectly and such a check is
>> done elsewhere?
>
> When determining if the entry is a submodule (i.e. setting
> the is_submodule bit) we have
>
>     list.entry[list.nr].is_submodule = S_ISGITLINK(ce->ce_mode);
>     if (list.entry[list.nr++].is_submodule &&
>       !is_staging_gitmodules_ok())
>         die (_("Please stage ..."));
>

Well scratch that.
is_staging_gitmodules_ok only checks for the .gitmodules file and not
for the submodule itself (the submodule is not an argument to that function)

The actual answer is found in check_local_mod called via

    if (!force) {
        struct object_id oid;
        if (get_oid("HEAD", &oid))
            oidclr(&oid);
        if (check_local_mod(&oid, index_only))
            exit(1);
    }

check_local_mod was touched in the previous patch as it has:

    /*
    * Is the index different from the file in the work tree?
    * If it's a submodule, is its work tree modified?
    */
    if (ce_match_stat(ce, &st, 0) ||
      (S_ISGITLINK(ce->ce_mode) &&
       bad_to_remove_submodule(ce->name,
            SUBMODULE_REMOVAL_DIE_ON_ERROR |
            SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED)))
                local_changes = 1;
