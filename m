Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70F4C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 18:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiF1SPW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 14:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiF1SPU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 14:15:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624A21CB37
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 11:15:19 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-317765eb7ccso110814187b3.13
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 11:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=idU2eXBxXE2R8LFnHN6JFl8qg6mQhv2kqBytprh79X8=;
        b=ShCXnJ/CWNr0SBU5oLhHOXWZJi+W+CjeqA4yLLRdkPk7od7KPdfoyvQo2qyiwe4E2F
         dsDqVp91Cll3vATrMZ1eMvMo4sIeDofqAGCLJd+HP2La4MKu7n9TB7/ioXezniwddN+n
         BW1544lxzTTsJEA8SkF2zDyne1rDsi+x8mxuvgz1eXg5UUAdIGDCFp85ZqrmNx5rO3F7
         u0qXNamBINg+OKQ3G2dT+NjfNh1mH1URhwUZN1NGJvdrmKt7CL8HmP9iBYqDqGUUQQ3s
         fYX6XjrwKJlPGjCOZ52t5boUJ27A4OzA3nfbHRVlldx+rqGtcLXtR1pIx+mS12l/nTHW
         yETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=idU2eXBxXE2R8LFnHN6JFl8qg6mQhv2kqBytprh79X8=;
        b=VyphpX5eq3DI4JoEXOI+Ar2HcBUtvZWzXANrq+V6cNRXbaeYHwWGnZ7SGOCoxF58G2
         aEMVxY7vbzdxU17U8pi+O//7nDY4IAAK1q7hY+jdxgSizawnWHZk/DJsCGGTrmo1yYiM
         GK5b9o0k/17gWwSLcxMkTpW9N7viLLGjQImXPABtjF6/GWn54qf3eMX3uwlK+xAK5ays
         wO8pa4A+UsEE4jrK+LSMHu4UEFIoqLloGs9VdVvnQg9SPOATa0GkKjlOh5iavRswbYaO
         D6YMNEj83i7ReA1UCrs6bcJUNV230MXIx8BkSdJQMjchSyNTitGm66UsrxVCXdyE7IZx
         O9pQ==
X-Gm-Message-State: AJIora8G0eVgiqbTwf/Ec51ij8M7GGuTuUqgeKrKU4G0XshaQJh66fVY
        4aznYQSFpNZFzwyUGCmaxcNUgZfZE+5OTQ==
X-Google-Smtp-Source: AGRyM1v74a4r9BjKxyUPSB2IY1S+hheVMBI350RMiqtadZ60KgRsHV77jYl/gKLVWtlsvsZ6gMu+yzRlJfUVTw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a81:468b:0:b0:318:4cac:6576 with SMTP id
 t133-20020a81468b000000b003184cac6576mr22309585ywa.277.1656440118648; Tue, 28
 Jun 2022 11:15:18 -0700 (PDT)
Date:   Tue, 28 Jun 2022 11:15:11 -0700
In-Reply-To: <220628.86wnd1f9t1.gmgdl@evledraar.gmail.com>
Message-Id: <kl6lv8skhcy8.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
 <57988287fc01a8baf5c4fd7326772c80bc015f3c.1656372017.git.gitgitgadget@gmail.com>
 <220628.86wnd1f9t1.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH 4/5] submodule--helper update: use --super-prefix
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Atharva Raykar <raykar.ath@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Jun 27 2022, Glen Choo via GitGitGadget wrote:
>
>> From: Glen Choo <chooglen@google.com>
>>
>> Unlike the other subcommands, "git submodule--helper update" uses the
>> "--recursive-prefix" flag instead of "--super-prefix". The two flags are
>> otherwise identical (they only serve to compute the 'display path' of a
>> submodule), except that there is a dedicated helper function to get the
>> value of "--super-prefix".
>
> This is a good change, it was slightly confusing that --recursive-prefix
> is left in git-submodule.sh after this, but then I remembered that I
> removed it in my ab/submodule-cleanup, and you were presumably trying to
> avoid the conflict.
>
> Still, I think it's probably better to either base this on my series
> (re-roll incoming), or take make this truly stand-alone, and have Junio
> sort out the minor conflict.

Ah good point. This was an oversight actually; I initially based this
off ab/submodule-cleanup, but decided to make it standalone. Thanks for
spotting the mistake.

At any rate, I'm quite sure that ab/submodule-cleanup v5 is ready for
'next', so I'll rebase this.

>>  static void update_data_to_args(struct update_data *update_data, struct=
 strvec *args)
>>  {
>> -	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL)=
;
>> -	strvec_pushf(args, "--jobs=3D%d", update_data->max_jobs);
>>  	if (update_data->displaypath)
>> -		strvec_pushf(args, "--recursive-prefix=3D%s/",
>> +		strvec_pushf(args, "--super-prefix=3D%s/",
>>  			     update_data->displaypath);
>> +	strvec_pushl(args, "submodule--helper", "update", "--recursive", NULL)=
;
>> +	strvec_pushf(args, "--jobs=3D%d", update_data->max_jobs);
>
> I did a double-take at this, but it's just one of these cases where
> "diff" is being overly helpful in trying to find us the most minimal
> diff possible :)

Yes. Sigh..

It looks like "--histogram" produces the diff I'd want:

          enum submodule_update_type update_type =3D update_data->update_de=
fault;

  +       if (update_data->displaypath)
  +               strvec_pushf(args, "--super-prefix=3D%s/",
  +                            update_data->displaypath);
          strvec_pushl(args, "submodule--helper", "update", "--recursive", =
NULL);
          strvec_pushf(args, "--jobs=3D%d", update_data->max_jobs);
  -       if (update_data->displaypath)
  -               strvec_pushf(args, "--recursive-prefix=3D%s/",
  -                            update_data->displaypath);

but that probably means I'd need to give up on GGG :/ (which I've grown
to like despite its shortcomings).

>> @@ -3352,9 +3342,9 @@ struct cmd_struct {
>>  static struct cmd_struct commands[] =3D {
>>  	{"list", module_list, 0},
>>  	{"name", module_name, 0},
>> -	{"clone", module_clone, 0},
>> +	{"clone", module_clone, SUPPORT_SUPER_PREFIX},
>>  	{"add", module_add, SUPPORT_SUPER_PREFIX},
>> -	{"update", module_update, 0},
>> +	{"update", module_update, SUPPORT_SUPER_PREFIX},
>>  	{"resolve-relative-url-test", resolve_relative_url_test, 0},
>>  	{"foreach", module_foreach, SUPPORT_SUPER_PREFIX},
>>  	{"init", module_init, SUPPORT_SUPER_PREFIX},
>
> I did my own spelunking into --super-prefix recently, and went a bit
> overboard, I don't think I'll ever submit all of these, but they're in
> my avar/git github fork:
>
> 	f445c57490d (submodule--helper: remove unused SUPPORT_SUPER_PREFIX flags=
, 2022-06-27)
> 	bac3def78e9 (submodule--helper.c: remove unnecessary ", 0" in init, 2022=
-06-27)
> 	af03aa2ad40 (submodule--helper.c: create a command dispatch helper, 2022=
-06-27)
> 	952fdec4cc0 (submodule--helper.c: make "support super prefix" a bitfield=
, not a flag, 2022-06-09)
> 	2d30186e633 (cocci: don't use strvec_pushl() if strvec_push() will do, 2=
022-06-27)
> 	8aa7e049360 (git.c: die earlier on bad "--super-prefix" combined with "-=
h", 2022-06-27)
> 	b0d324e9ad2 (git: make --super-prefix truly internal-only, BUG() on misu=
se, 2022-06-27)
>
> So, this is a digressio, but after doing those I figured we could
> eventually get rid of --super-prefix, but it'll require some more
> make-things-a-built-in, or make-things-a-library.
>
> But I think out of those perhaps you'd be interested in cherry-picking
> f445c57490d (submodule--helper: remove unused SUPPORT_SUPER_PREFIX
> flags, 2022-06-27) before this 4/5? I.e. before adding a new
> SUPPORT_SUPER_PREFIX flag we can remove it from those commands that
> don't use it, which clears things up a bit.
>
> The others are all mostly unrelated cleanup, and I'm only noting them in
> case you're overly curious. A web view for f445c57490d is at:
> https://github.com/avar/git/commit/f445c57490d

Very interesting, thanks for sharing :) I'll take your suggestion to
cherry-pick f445c57490d.
