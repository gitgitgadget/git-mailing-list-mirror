Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92253C43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 23:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiGMXEd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 19:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiGMXEa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 19:04:30 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFA73E753
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 16:04:30 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 1-20020a17090a190100b001f05565f004so179212pjg.0
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 16:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=rc44Il0ihyu1qeyx/SInMl85XKI4jfxldOTf3D2B+WE=;
        b=m5Eg16yHmQea18XY0zxobTK71dkTyNDt78wvAwWBO4Tq4Pcsa/q95bLhDwIk/inI6c
         GI3CH+rxwae8myHMcwMZZyszRXniKIGpdbi7ptyR3N+YRsO88BoIoHgVMtV9C1strt6r
         6cC+XL7uUgPahxeZ7yHCLArSZbTJh1f9tX6zNqQoL0zsL3YxkyCPaO9gVfjw/RceA4T6
         3f4DN+/2fHXv3WbT7+NLYvzp2L7ad1tR5dP7ohzEmbLG9Wdc2PcldLeL9/R7iAjZsW7q
         8WAs+vasL1Md/2kPGrnsS+HafDkwrWzPcb311k8Q1wRXYn//lj3EAW2kNQvlBTxtlB31
         h+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=rc44Il0ihyu1qeyx/SInMl85XKI4jfxldOTf3D2B+WE=;
        b=X+/h+NWyQe0VnSDH0IZr2bytwTVEgEeeBv6ipsly1ucgBszi7zlgTIpEMe7Kn8BBOL
         PNoBZEjPhbrJSIbsHsd0bE6lNy8PhihuMo6xAjp3cKy9YqX1GSNYx4EB85oNc2NJANkc
         HmD4q0gO6Fz10U0H8S/xHl+9jo977ZRrSdsRfBKOV2a2UzN5MsLtKEVlcH+C9nrEjuXW
         aMUSoTCfKwxxQAPNGgtOwEr6bLh+CMbUMs6U4SeWJ2A6TvsOCb3v53G9tOWHyaiP0WQt
         PF13nxqpLFN9x3AQvrr3/bqDHo3lFdsLysL2bBZcfrjEw8jqEnFmB1X5U2OxGTTdFkAV
         iHHg==
X-Gm-Message-State: AJIora8MvaOoVDj90fjH53yQ7rH75yRoCgTBEajn2t5aq5j3wKYiLRet
        aio0A9PKExklqTyonaTfiNGc7luOg2VGmA==
X-Google-Smtp-Source: AGRyM1vGryO/sCkE59DJEw3IwX/6L5oVgm29QwZ0sF0V7UNybjg0Fz4tpKKfW3M3/kDx1LRNXgbPJzqwd+9k/g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:5d45:0:b0:419:ab8f:c022 with SMTP id
 o5-20020a635d45000000b00419ab8fc022mr1500158pgm.557.1657753469606; Wed, 13
 Jul 2022 16:04:29 -0700 (PDT)
Date:   Wed, 13 Jul 2022 16:04:27 -0700
In-Reply-To: <220713.86o7xs3g76.gmgdl@evledraar.gmail.com>
Message-Id: <kl6l8row62dg.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
 <patch-03.11-e5ec6945409-20220713T131601Z-avarab@gmail.com>
 <kl6lmtdc6hhp.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lilo06g82.fsf@chooglen-macbookpro.roam.corp.google.com> <220713.86o7xs3g76.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH 03/11] submodule--helper: fix "module_clone_data" memory leaks
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Jul 13 2022, Glen Choo wrote:
>
>> Glen Choo <chooglen@google.com> writes:
>>
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>
>>>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>>>> index 73717be957c..23ab9c7e349 100644
>>>> --- a/builtin/submodule--helper.c
>>>> +++ b/builtin/submodule--helper.c
>>>> @@ -1511,6 +1511,7 @@ static int module_deinit(int argc, const char **=
argv, const char *prefix)
>>>>  struct module_clone_data {
>>>>  	const char *prefix;
>>>>  	const char *path;
>>>> +	char *path_free;
>>>>  	const char *name;
>>>>  	const char *url;
>>>>  	const char *depth;
>>>> @@ -1527,6 +1528,11 @@ struct module_clone_data {
>>>>  	.single_branch =3D -1, \
>>>>  }
>>>> =20
>>>> +static void module_clone_data_release(struct module_clone_data *cd)
>>>> +{
>>>> +	free(cd->path_free);
>>>> +}
>>>> +
>>>>  struct submodule_alternate_setup {
>>>>  	const char *submodule_name;
>>>>  	enum SUBMODULE_ALTERNATE_ERROR_MODE {
>>>> @@ -1651,9 +1657,9 @@ static int clone_submodule(struct module_clone_d=
ata *clone_data)
>>>> =20
>>>>  	if (!is_absolute_path(clone_data->path)) {
>>>>  		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
>>>> -		clone_data->path =3D strbuf_detach(&sb, NULL);
>>>> +		clone_data->path =3D clone_data->path_free =3D strbuf_detach(&sb, N=
ULL);
>>>>  	} else {
>>>> -		clone_data->path =3D xstrdup(clone_data->path);
>>>> +		clone_data->path =3D clone_data->path_free =3D xstrdup(clone_data->=
path);
>>>>  	}
>>>
>>> Hm, having .path_free doesn't seem necessary. If I'm reading the code
>>> correctly,
>>>
>>> - in module_clone() we set clone_data.path from argv
>>> - then we unconditionally call clone_submodule(), which does all of the
>>>   hard work
>>> - in clone_submodule(), we always hit this conditional, which means tha=
t
>>>   past this point, clone_data.path is always free()-able.
>>>
>>> which suggests that we don't need clone_data.path_free at all. I suspec=
t
>>> that just this
>>>
>>>    static void module_clone_data_release(struct module_clone_data *cd)
>>>    {
>>>    	free(cd->path);
>>>    }
>>>
>>> is enough to plug the leak (though admittedly, I haven't properly teste=
d
>>> the leak because it's been a PITA to set up locally).
>>>
>>> That's a pretty hacky suggestion though, since we're still using the
>>> same member to hold free()-able and non-free()-able memory....
>>
>> Ah, here's a wacky idea (whose feasibility I haven't thought about at
>> all) that would make things a lot cleaner. If we had something like
>> OPT_STRING_DUP, that xstrdup()-s the value from argv when we parse it,
>> then we could drop the "const" from clone_data.path and just free() it.
>
> I suppose so, it might make some things simpler, of course at the cost
> of needlessly duplicating things.
>
> But we also have various common patterns such as string_lists where some
> elements are dup'd, some aren't, and need to deal with that. I think
> just having common idioms for tracking the dupe is usually better,
> e.g. in the case of a string list stick the pointer to free in "util".

Hm, sounds fair. "Sometimes dup and sometimes not" sounds like an
inevitability. I'm not experienced enough to know better, and folks
whose opinion I sought seem to agree with you.

> I think in this case the patch as-is is better than your suggestions,
> because it's a less fragile pattern, we explicitly mark when we dup
> something that's sometimes a dup, and sometimes not.
>
> Whereas if we do it with the xstrdup() at the start it requires more
> moving things around, and if we have a new user who parses the same
> argument we'll bug out on that free().
>
> What do you think?

Frankly I'm ok with moving things around; I think the code could use
a little cleaning up :) But yeah, I think my suggestion isn't so great -
it's a bit weird to keep around an auto variable that exists only to be
dup-ed to the thing we care about. We can forget about that.

I do think that it's worth avoiding the "sometimes dup, sometimes not"
pattern if we can, though (of course these are just my non-C instincts
talking), and we can do that here if we just choose not to assign back
to .path. Something like:

  struct module_clone_data {
    const char *prefix;
  -	const char *path;
  +	char *path;
  +	const char *path_argv;

  ...

   	if (!is_absolute_path(clone_data->path)) {
  -		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
  +		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path_argv);
  +		clone_data->path =3D strbuf_detach(&sb, NULL);
   	} else {
  -		clone_data->path =3D xstrdup(clone_data->path);
  +		clone_data->path =3D xstrdup(clone_data->path_argv);
   	}

would be clearer to me since the const pointer never points to something
that the struct actually owns.

But if the "=3D .to_free =3D " idiom is well-understood and accepted to the
point that we don't need to actively avoid "sometimes dup, sometimes
not", then we should drop my suggestion and just go with your patch :)
