Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA076201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 18:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751055AbdCNSQc (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 14:16:32 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35032 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbdCNSQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 14:16:31 -0400
Received: by mail-pf0-f178.google.com with SMTP id j5so73822091pfb.2
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 11:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rnxOxCZ2jWb5Q4tG7/MJQYkleu48oERPa1BYLkL72yg=;
        b=QHAKFRJJG9Mk3C3DItj+tur4Te+RI6F8MF/2Gfc6stQMh2+I2GjhjFmUoxm+AdGbEj
         WgzMH8q3GmWhQGqMbdm5JjDc5zEaceoiqXFE+CcYjisKTSlwIHjEnhSp4Se/8BV2NPzO
         H2wMda3bqOy7wFYGKP7UuI5N+ELQNMmtaTPBKAE9bjdxF1PqWyWSY1KAdiEsibbD/rex
         gZWH4afGUnfjh3l8hEWreyrL9E1j9UWHKwGS6p8fU2i7aYUFcCXHYeOXvoDz7iNn7A+H
         A6U9W4n2GDRr4E97SGamHC26Y/7uAF8ztjoNBwV6r8d2rUQZ4Opg3qc1wNgBG0kv4xS7
         Nsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rnxOxCZ2jWb5Q4tG7/MJQYkleu48oERPa1BYLkL72yg=;
        b=XaYx2WKQPvkeseHEuCCs+vNbiBSGlT0yMecmMhqJHwCKgV4meXOk2ncMByPdJzkvgV
         z5nQIW20P1Tm8CCsNE2yW8fHcVvsL+PLKzGaEygrr3vjAP7jF2/MJojfGz2gqM1N+RLO
         D8tfyCds9g0r9JLbW8IapZCUsc1TWop7jxKf0pdZniQiM+2QRIlNuRuisAY7q5b8gSZc
         k0ZYqvfqXJ2jTTb4mf+ePtVddSwnryDTFponOJmYVRmGvdGR5g4eeGYL39xdi2BGtc0U
         68xtN8miAgiXLv/dyDgpyJsm2ECKAbR30iNHWQm09wZWEPWnfExLck3iJq5fXlrqybGK
         QSeg==
X-Gm-Message-State: AMke39k2rx3Jenfoa7GiLMDbpqAq9e8Z5ImNJw1bvSlriwwnDz6rA1XEqq9OZ0nzzbrEKQTiRXZH2920fVrTz+Cd
X-Received: by 10.99.98.6 with SMTP id w6mr44711985pgb.223.1489515389991; Tue,
 14 Mar 2017 11:16:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Tue, 14 Mar 2017 11:16:29 -0700 (PDT)
In-Reply-To: <xmqqd1djkay4.fsf@gitster.mtv.corp.google.com>
References: <20170309012345.180702-1-bmwill@google.com> <20170313214341.172676-1-bmwill@google.com>
 <20170313214341.172676-3-bmwill@google.com> <xmqqd1djkay4.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Mar 2017 11:16:29 -0700
Message-ID: <CAGZ79kZ6noz7RGbmNwg=NhuWYH=KbNPYUWL7We9YjbHn6uf2Jg@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] submodule status: use submodule--helper is-active
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 14, 2017 at 10:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Williams <bmwill@google.com> writes:
>
>> Signed-off-by: Brandon Williams <bmwill@google.com>
>> ---
>>  git-submodule.sh | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 136e26a2c..ab233712d 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -1010,14 +1010,13 @@ cmd_status()
>>       do
>>               die_if_unmatched "$mode" "$sha1"
>>               name=$(git submodule--helper name "$sm_path") || exit
>> -             url=$(git config submodule."$name".url)
>>               displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")
>>               if test "$stage" = U
>>               then
>>                       say "U$sha1 $displaypath"
>>                       continue
>>               fi
>> -             if test -z "$url" ||
>> +             if ! git submodule--helper is-active "$sm_path" ||
>>               {
>>                       ! test -d "$sm_path"/.git &&
>>                       ! test -f "$sm_path"/.git
>
> The $name is no longer used after this step in cmd_status function,
> as the sole purpose of learning the name from the path was so that
> we can ask if the submodule has .URL defined and the query is done
> by name, not path.
>
> This actually raises a question.
>
> Shouldn't "submodule--helper is-active" ask about submodule while
> identifying the submodule in question by name?  Or do all (or most
> of) the callers start from path and ask is-active on them so that it
> is handier to let them ask by path?

A similar observation can be made, when looking at
submodule_from_name and submodule_from_path
(both defined in submodule-config.h)

submodule_from_name has only one real world use case in code,
which I suspect is even a bug.

That line was last touched with 851e18c3859a (submodule: use new config
API for worktree configurations). but the original mechanism comes
from 7dce19d374 (fetch/pull: Add the --recurse-submodules option).

There we take the path as name and if a real name exists, the name
is overwritten with the real name, i.e.

    name = name_for_path(path) ? name_for_path(path) : path;

which IMHO is overly accepting and we should just die in case of
!name_for_path.

So to answer your original question, I think the codebase currently
thinks by_path is handier, the name is a mere internal field in
"struct submodule", useful for looking up its git dir.

Thanks,
Stefan
