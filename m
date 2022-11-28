Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF0BC43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 15:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiK1PRH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 10:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiK1PRF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 10:17:05 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B441B9C0
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 07:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669648607; bh=TkvWqXPuScPBRKS2avL6WdlGgC0QhppmgJ+W//e5IVU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BGR9FPX/FBDKQRjy/bGFWWtvb3PJBil0YiwG5l05Rz2JyM6bIIvhWw9snQez0BhoO
         VRQNZyqEz6P3ifVrfaLyJm1/pzTt06rdx68SLa8I6KJFKONGLCdrcT5xfKHjjo/xL+
         AWxNZHcEQZt5IAP5yGjnkSCWpjCvIt0jpobe7OreL2V0HrqMAstkGu4/nX2/MI7dC4
         pWZsd1QJIJbOT2irjDr95lgnraoF9e9zsVnRWMhu6Yo3KeJHcB6NaVCZh4JYJznJim
         VmpEspyD7TUDx+EwtgS1MQqysQqKRhX1pEqf/15lfq/sBIShA8YcwrfYi538Umnr+d
         LonRVVRp6WFAA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.35] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Melax-1oPWF00Rnx-00aazR; Mon, 28
 Nov 2022 16:16:47 +0100
Message-ID: <9bea523d-93d1-953b-a136-3f00844c880a@web.de>
Date:   Mon, 28 Nov 2022 16:16:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/3] Revert "pack-objects: lazily set up "struct
 rev_info", don't leak"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
 <f5779e19-813c-cda9-2f84-9fe58f745e89@web.de> <xmqqv8mz5ras.fsf@gitster.g>
 <d10de9b5-e5ff-18d6-d950-1d090d87b113@web.de>
 <221128.864jujmhgp.gmgdl@evledraar.gmail.com>
 <221128.86zgcbl0pe.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221128.86zgcbl0pe.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mpMguJ2V/X/jLxCEmsShZXLm4/Aa6yJWgBRxVMo85SBE3RKm3F7
 qWtIhpR+LQRN6sf1/KGtdpTXlvZspvnVT4aOFpA4bvJiiRv46NarmZVKqNOWoIO/Gkr2fLy
 xZRwJ602wSkiqlQnLmdX0d/HbQP3K5Zg/2LsGpAX5h2w7/69Jr8/hdo85INd2cp1KM/GL1U
 l2M0M/PrHoPSBeDWOQfrA==
UI-OutboundReport: notjunk:1;M01:P0:btOVK5feXnc=;FtqguBvydfyjuspGFtorvssVauD
 dQkxdW/hhkqsUJ0ScOicAvMzfcDMTfRa7ug3XOsENB6LbA33zFzZEZJ+LaYlN18hbvQDjlu7Y
 Onpl1rOAjNmNFRdygQPGaNF7QOje0NgyRG41X8G/ArY8sP6IRAwSMWJ2ODxEjOpir7KTGU/2A
 2YHv20J0lhTPNOZYpM+GhBulGOrHlpQJIbtaKXO3uf2WOQOWHvDobGtTrmI7GHUybwEp8FvQV
 s/7RYBd3BnV9oiP61DLZrEa9IsOrej2HaloSIkgIwV3PU1IbRU6oRbGIvGlIZFG4QoIV+uC9l
 KXylPKXMdBgfMg8+bPHpSpdkERUa/EqdBvOJSGkf4ZPA/HNRWAysWFUfbrbNbsb52GIahAY1T
 anoNaO9gNBuCtc6413bxi+sQwdMMTxfG5srYO+UC1mYxlxmiq4AsLjA7q1ftM4FQFHRrHHHnx
 pPVyfYp6gWwiVIaEwG+KGO3eWzWTnQtnmEnkurMGGj641U9AfTKIvnmLxaIlCxHAdpUl48z2L
 s7UE75YgC8i5zhCcYjC4U3VhoLaGcVIkSlEvzGkIAo05DpgXBJXojinMZu8kVRBAgAK5Uj2sp
 04GstTGbGqJOYFIQX/p8KT0A4EwUqSADEnFN0jEp3nq3IgE/xMJuv0tGYq3g6Ay85P+UI0DiD
 M4qwZae40xXc1hqh/JTXxICoMQBkIzSPf+QW06W0+DVYJXaEoNQmj9jUd9mSKr4+fpAv6yt98
 trlA1zBz2rhtcARqnph5KaY+ROCMhseMlqQWCGb/VgERHRGUaYZtnbzT1oIvTMZ/O46MjriSU
 ecM82IiAKtNi21rkYkdq9oHKUA49A6pZ1CPtbLB4ZJ/dCE7xI+nt3O0Ec8NfJDyuQe5RfYP0a
 ta6Ik6a6iDEixtNPseun6VjRzBkW6uirFuaaKm1ik7yl1TLfw0rNya5U/YfwyIb4PrYOiy+TG
 GlcEGw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.11.2022 um 13:24 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Mon, Nov 28 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> Ren=C3=A9:
>
>> On Mon, Nov 28 2022, Ren=C3=A9 Scharfe wrote:
>>
>>> Am 28.11.2022 um 11:03 schrieb Junio C Hamano:
>>>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>>>
>>>>> This reverts commit 5cb28270a1ff94a0a23e67b479bbbec3bc993518.
>>>>>
>>>>> 5cb28270a1 (pack-objects: lazily set up "struct rev_info", don't lea=
k,
>>>>> 2022-03-28) avoided leaking rev_info allocations in many cases by
>>>>> calling repo_init_revisions() only when the .filter member was actua=
lly
>>>>> needed, but then still leaking it.  That was fixed later by 2108fe4a=
19
>>>>> (revisions API users: add straightforward release_revisions(),
>>>>> 2022-04-13), making the reverted commit unnecessary.
>>>>
>>>> Hmph, with this merged, 'seen' breaks linux-leaks job in a strange
>>>> way.
>>>>
>>>> https://github.com/git/git/actions/runs/3563546608/jobs/5986458300#st=
ep:5:3917
>>>>
>>>> Does anybody want to help looking into it?
>>
>> [I see we crossed E-Mails]:
>> https://lore.kernel.org/git/221128.868rjvmi3l.gmgdl@evledraar.gmail.com=
/
>>
>>> The patch exposes that release_revisions() leaks the diffopt allocatio=
ns
>>> as we're yet to address the TODO added by 54c8a7c379 (revisions API: a=
dd
>>> a TODO for diff_free(&revs->diffopt), 2022-04-14).
>>
>> That's correct, and we have that leak in various places in our codebase=
,
>> but per the above side-thread I think this is primarily exposing that
>> we're setting up the "struct rev_info" with your change when we don't
>> need to. Why can't we just skip it?
>>
>> Yeah, if we do set it up we'll run into an outstanding leak, and that
>> should also be fixed (I have some local patches...), but the other case=
s
>> I know of where we'll leak that data is where we're actually using the
>> "struct rev_info".
>>
>> I haven't tried tearing your change apart to poke at it myself, and
>> maybe there's some really good reason for why you can't separate gettin=
g
>> rid of the J.5.7 dependency and removing the lazy-init.
>>
>>> The patch below plugs it locally.
>>>
>>> --- >8 ---
>>> Subject: [PATCH 4/3] fixup! revision: free diffopt in release_revision=
s()
>>>
>>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>>> ---
>>>  builtin/pack-objects.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>>> index 3e74fbb0cd..a47a3f0fba 100644
>>> --- a/builtin/pack-objects.c
>>> +++ b/builtin/pack-objects.c
>>> @@ -4462,6 +4462,7 @@ int cmd_pack_objects(int argc, const char **argv=
, const char *prefix)
>>>  	} else {
>>>  		get_object_list(&revs, rp.nr, rp.v);
>>>  	}
>>> +	diff_free(&revs.diffopt);
>>>  	release_revisions(&revs);
>>>  	cleanup_preferred_base();
>>>  	if (include_tag && nr_result)
>>
>> So, the main motivation for the change was paranoia that a compiler or
>> platform might show up without J.5.7 support and that would bite us, bu=
t
>> we're now adding a double-free-in-waiting?
>>
>> I think we're both a bit paranoid, but clearly have different
>> paranoia-priorities :)
>>
>> If we do end up with some hack like this instead of fixing the
>> underlying problem I'd much prefer that such a hack just be an UNLEAK()
>> here.
>>
>> I.e. we have a destructor for "revs.*" already, let's not bypass it and
>> start freeing things from under it, which will result in a double-free
>> if we forget this callsite once the TODO in 54c8a7c379 is addressed.
>>
>> As you'd see if you made release_revisions() simply call
>> diff_free(&revs.diffopt) doing so would reveal some really gnarly edge
>> cases.
>>
>> I haven't dug into this one, but offhand I'm not confident in saying
>> that this isn't exposing us to some aspect of that gnarlyness (maybe
>> not, it's been a while since I looked).
>>
>> (IIRC some of the most gnarly edge cases will only show up as CI
>> failures on Windows, to do with the ordering of when we'll fclose()
>> files hanging off that "diffopt").
>
> This squashed into 3/3 seems to me to be a proper fix to a change that
> wants to refactor the code for non-J.5.7 compatibility. I.e. this just
> does the data<->fp casting part of the change, without refactoring the
> "lazy init".

That works, but lazy code is more complicated and there is no benefit
here -- eager allocations are not noticably slow or big.  Laziness
hides leaks in corners, i.e. requiring invocations with uncommon
options to trigger them.

>
> But I think you should check this a bit more carefully. Your 3/3 says
> that your change "mak[es] the reverted commit unnecessary"

No, it says that _your_ change 2108fe4a19 (revisions API users: add
straightforward release_revisions(), 2022-04-13) made it unnecessary.

> , but as I
> noted if you'd run the command that commit shows, you'd have seen you're
> re-introducing the leak it fixed. So I wonder what else has been missed
> here.

5cb28270a1 (pack-objects: lazily set up "struct rev_info", don't leak,
2022-03-28) did not plug the leak.  It only moved it to the corner that
handles the --filter option.

That leak is only interesting to Git developers and harmless for users.
But if the goal is to become free of trivial leaks in order to allow
using tools like LeakSanitizer to find real ones then pushing them into
the shadows not yet reached by our test coverage won't help for long.

> I vaguely recall that one reason I ended up with that J.5.7 dependency
> was because there was an objection to mocking up the "struct option" as
> I'm doing here. I.e. here we assume that the
> opt_parse_list_objects_filter() is only ever going to care about the
> "value" member.

It's probably fine, but unnecessarily complicated compared to calling
repo_init_revisions() eagerly.

>
> I think that's probably fine, but I may be misrecalling, or missing some
> crucial detail. I'll leave digging that up & convincing us that it's
> fine to the person pushing for refactoring all of this :)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 3e74fbb0cd5..faf210bfe8c 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -4149,6 +4149,27 @@ static int option_parse_cruft_expiration(const st=
ruct option *opt,
>  	return 0;
>  }
>
> +struct po_filter_data {
> +	unsigned have_revs:1;
> +	struct rev_info revs;
> +};
> +
> +static int opt_parse_list_objects_filter_init(const struct option *opt,
> +					      const char *arg, int unset)
> +{
> +	struct po_filter_data *data =3D opt->value;
> +	struct rev_info *revs =3D &data->revs;
> +	const struct option opt_rev =3D {
> +		.value =3D (void *)&revs->filter,
> +	};
> +
> +	if (!data->have_revs)
> +		repo_init_revisions(the_repository, revs, NULL);
> +	data->have_revs =3D 1;
> +
> +	return opt_parse_list_objects_filter(&opt_rev, arg, unset);
> +}
> +
>  int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  {
>  	int use_internal_rev_list =3D 0;
> @@ -4159,7 +4180,7 @@ int cmd_pack_objects(int argc, const char **argv, =
const char *prefix)
>  	int rev_list_index =3D 0;
>  	int stdin_packs =3D 0;
>  	struct string_list keep_pack_list =3D STRING_LIST_INIT_NODUP;
> -	struct rev_info revs;
> +	struct po_filter_data pfd =3D { .have_revs =3D 0 };
>
>  	struct option pack_objects_options[] =3D {
>  		OPT_SET_INT('q', "quiet", &progress,
> @@ -4250,7 +4271,8 @@ int cmd_pack_objects(int argc, const char **argv, =
const char *prefix)
>  			      &write_bitmap_index,
>  			      N_("write a bitmap index if possible"),
>  			      WRITE_BITMAP_QUIET, PARSE_OPT_HIDDEN),
> -		OPT_PARSE_LIST_OBJECTS_FILTER(&revs.filter),
> +		OPT_CALLBACK(0, "filter", &pfd, N_("args"), N_("object filtering"),
> +			     opt_parse_list_objects_filter_init),
>  		OPT_CALLBACK_F(0, "missing", NULL, N_("action"),
>  		  N_("handling for missing objects"), PARSE_OPT_NONEG,
>  		  option_parse_missing_action),
> @@ -4269,8 +4291,6 @@ int cmd_pack_objects(int argc, const char **argv, =
const char *prefix)
>
>  	read_replace_refs =3D 0;
>
> -	repo_init_revisions(the_repository, &revs, NULL);
> -
>  	sparse =3D git_env_bool("GIT_TEST_PACK_SPARSE", -1);
>  	if (the_repository->gitdir) {
>  		prepare_repo_settings(the_repository);
> @@ -4372,7 +4392,7 @@ int cmd_pack_objects(int argc, const char **argv, =
const char *prefix)
>  	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
>  		unpack_unreachable_expiration =3D 0;
>
> -	if (revs.filter.choice) {
> +	if (pfd.have_revs && pfd.revs.filter.choice) {
>  		if (!pack_to_stdout)
>  			die(_("cannot use --filter without --stdout"));
>  		if (stdin_packs)
> @@ -4459,10 +4479,16 @@ int cmd_pack_objects(int argc, const char **argv=
, const char *prefix)
>  		read_cruft_objects();
>  	} else if (!use_internal_rev_list) {
>  		read_object_list_from_stdin();
> +	} else if (pfd.have_revs) {
> +		get_object_list(&pfd.revs, rp.nr, rp.v);
> +		release_revisions(&pfd.revs);
>  	} else {
> +		struct rev_info revs;
> +
> +		repo_init_revisions(the_repository, &revs, NULL);
>  		get_object_list(&revs, rp.nr, rp.v);
> +		release_revisions(&revs);
>  	}
> -	release_revisions(&revs);
>  	cleanup_preferred_base();
>  	if (include_tag && nr_result)
>  		for_each_tag_ref(add_ref_tag, NULL);
