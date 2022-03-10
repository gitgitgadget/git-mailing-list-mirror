Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15B4C4332F
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 14:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbiCJOg0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 09:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344066AbiCJObk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 09:31:40 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7927E7DA80
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 06:30:17 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qa43so12367130ejc.12
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 06:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Bxz6ui6ZHOq5sJIalUpMorrj0hVYPzHl2COabfEi2LM=;
        b=YJRBQahzVnDEHdrXhF66vloOAuTZknphZiikx5sW8WPayA7LXzT3dcZXf4YVeoUojv
         VWV7WMcXrAVzicNKi+FtatfdOT9idVdLFxm48UkRDQXV5RqZWPczNSzyB261A5tHrsLH
         mZvoFVFC7R0mjNrNPrwrcLq7+DLqGiaYIDCDboizRDK6OG9ZR5f7Ci99OUZ+Em0XVKUi
         5p4aOKKysSAY4ttKLiE3ymZbHToKWxDq36ZkqPgOC1Ctltwk0aum8LsW864Ptq6NopFe
         23ke926Z5HEab05oPaxKEjW23AqemY67SOrELACKRjH4Ra6oXFQ/e8tWrsOPTDlNuacW
         icgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Bxz6ui6ZHOq5sJIalUpMorrj0hVYPzHl2COabfEi2LM=;
        b=epaEvNe2HcJ7ggeoLRmySbFhYuZJokDjXGs3+Nf86QIJiePJb2U+WmWFr3ROOBhA8g
         A3vIh50lZT75gVxqdGiK7WnbBUKzQCHpjHmYRXZbwaC5FVwWqzN5KzpxH0tXg7hH5tfn
         WGObPBQgIEEpoGoP5jHdnL/vM6+6QdrNhL928c5GI1z0in1Yk9ivt3woBQfXR/iqwqK2
         a+dLdV8wYl73jbAnsZjn34bvVLE79N74GMDwz6DiVUTEHHXkaNJ1ix4G8KU8LROoKTmL
         aax+61WgDkaGcoQo71n/2Ywif9YT9qMSLDJKY9UnJO9g3G/waIrNdWK5LAaj+5BcNO/7
         rdMQ==
X-Gm-Message-State: AOAM532rTyiXIWRwic3mLYA1UA29/Fce/Agp+QKw62+43jX4CP/NAhYG
        OKsfrwzeGoE41hQqQ7o0JFE=
X-Google-Smtp-Source: ABdhPJyDSSmTNZgxAVy4sGPbOihUTqAXlLqORHg6IV0q3hNBECTOvZ1eLAQ2ktDgZbNxU+i+Zu/3JA==
X-Received: by 2002:a17:907:728b:b0:6da:97db:b66d with SMTP id dt11-20020a170907728b00b006da97dbb66dmr4461311ejc.636.1646922615094;
        Thu, 10 Mar 2022 06:30:15 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z11-20020a50e68b000000b00412ec8b2180sm2106951edm.90.2022.03.10.06.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 06:30:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nSJnx-000Wdj-7p;
        Thu, 10 Mar 2022 15:30:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCH v4 04/13] pack-objects: use rev.filter when possible
Date:   Thu, 10 Mar 2022 15:24:05 +0100
References: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
 <pull.1159.v4.git.1646841703.gitgitgadget@gmail.com>
 <ed22a77782bee97ef50fe1ff1a12fa2fa1470805.1646841703.git.gitgitgadget@gmail.com>
 <220310.86zglyj5xz.gmgdl@evledraar.gmail.com>
 <645650c1-7918-6985-a08b-cb47247b08d4@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <645650c1-7918-6985-a08b-cb47247b08d4@github.com>
Message-ID: <220310.86mthxkhhm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 10 2022, Derrick Stolee wrote:

> On 3/10/2022 8:11 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Wed, Mar 09 2022, Derrick Stolee via GitGitGadget wrote:
>>=20
>>> From: Derrick Stolee <derrickstolee@github.com>
>>>
>>> In builtin/pack-objects.c, we use a 'filter_options' global to populate
>>> the --filter=3D<X> argument. The previous change created a pointer to a
>>> filter option in 'struct rev_info', so we can use that pointer here as a
>>> start to simplifying some usage of object filters.
>>>
>>> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>>> ---
>>>  builtin/pack-objects.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>>> index ba2006f2212..e5b7d015d7d 100644
>>> --- a/builtin/pack-objects.c
>>> +++ b/builtin/pack-objects.c
>>> @@ -3651,7 +3651,7 @@ static int pack_options_allow_reuse(void)
>>>=20=20
>>>  static int get_object_list_from_bitmap(struct rev_info *revs)
>>>  {
>>> -	if (!(bitmap_git =3D prepare_bitmap_walk(revs, &filter_options, 0)))
>>> +	if (!(bitmap_git =3D prepare_bitmap_walk(revs, &revs->filter, 0)))
>>>  		return -1;
>>>=20=20
>>>  	if (pack_options_allow_reuse() &&
>>> @@ -3727,6 +3727,7 @@ static void get_object_list(int ac, const char **=
av)
>>>  	repo_init_revisions(the_repository, &revs, NULL);
>>>  	save_commit_buffer =3D 0;
>>>  	setup_revisions(ac, av, &revs, &s_r_opt);
>>> +	list_objects_filter_copy(&revs.filter, &filter_options);
>>>=20=20
>>>  	/* make sure shallows are read */
>>>  	is_repository_shallow(the_repository);
>>> @@ -3777,7 +3778,7 @@ static void get_object_list(int ac, const char **=
av)
>>>=20=20
>>>  	if (!fn_show_object)
>>>  		fn_show_object =3D show_object;
>>> -	traverse_commit_list_filtered(&filter_options, &revs,
>>> +	traverse_commit_list_filtered(&revs.filter, &revs,
>>>  				      show_commit, fn_show_object, NULL,
>>>  				      NULL);
>>=20
>> Re your
>> https://lore.kernel.org/git/77c8ef4b-5dce-401b-e703-cfa32e18c853@github.=
com/
>> I was looking at how to handle the interaction between this and my
>> revisions_release() series.
>>=20
>> This adds a new memory leak, which can be seen with:
>>=20
>>     make SANITIZE=3Dleak
>>     (cd t && ./t5532-fetch-proxy.sh -vixd)
>>=20
>> I.e. this part is new:
>>=20=20=20=20=20
>>     remote: Direct leak of 1 byte(s) in 1 object(s) allocated from:
>>     remote:     #0 0x4552f8 in __interceptor_malloc (git+0x4552f8)
>>     remote:     #1 0x75a089 in do_xmalloc wrapper.c:41:8
>>     remote:     #2 0x75a046 in xmalloc wrapper.c:62:9
>>     remote:     #3 0x62c692 in list_objects_filter_copy list-objects-fil=
ter-options.c:433:2
>>     remote:     #4 0x4f70bf in get_object_list builtin/pack-objects.c:37=
30:2
>>     remote:     #5 0x4f5e0e in cmd_pack_objects builtin/pack-objects.c:4=
157:3
>>     remote:     #6 0x4592ba in run_builtin git.c:465:11
>>     remote:     #7 0x457d71 in handle_builtin git.c:718:3
>>     remote:     #8 0x458ca5 in run_argv git.c:785:4
>>     remote:     #9 0x457b30 in cmd_main git.c:916:19
>>     remote:     #10 0x563179 in main common-main.c:56:11
>>     remote:     #11 0x7fddd2da67ec in __libc_start_main csu/../csu/libc-=
start.c:332:16
>>     remote:     #12 0x4300e9 in _start (git+0x4300e9)
>>=20=20=20=20=20
>> Of course it's not "new" in the sense that we in effect leaked this
>> before, but it was still reachable, you're just changing it so that
>> instead of being stored in the static "filter_options" variable in
>> pack-objects.c we're storing it in "struct rev_info", which has a
>> different lifetime.
>
> True, and 'struct rev_info' is not being release in any way, either,
> right?

Yes, sorry to not be clear there. There's 2x other leaks just in that
one test on "master", my series addresses those, but then the 3rd
"added" here will be left behind.

>> I think instead of me rebasing my series on top of yours and tangling
>> the two up a better option is to just add a change to this, so after
>> list_objects_filter_copy() do:
>>=20
>>     UNLEAK(revs.filter);
>>=20
>> Or, alternatively adding this to the end of the function (in which case
>> Junio will need to deal with a minor textual conflict):
>>=20
>>     list_objects_filter_release(&revs.filter);
>>=20
>> Both of those make my series merged with "seen" (which has this change)
>> pass with SANITIZE=3Dleak + GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue again.
>>=20
>> You could do the same in your later change adding
>> list_objects_filter_copy() to verify_bundle(), that one also adds a new
>> leak, but happens not to cause test failures since the bundle.c code
>> isn't otherwise marked as passing with SANITIZE=3Dleak, it fails in
>> various other ways.
>>=20
>> Obviously we should do something about the actual leak eventually, but
>> that can be done in some follow-up work to finish up the missing bits of
>> release_revisions(), i.e. adding list_objects_filter_release() etc. to
>> release_revisions().
>
> I understand that you like to "show your work" by marking tests as
> safe for leak-check by making the smallest changes possible, but your
> series has a lot of small patches that do nothing but add a free() or
> release_*() call instead of implementing the "right" release_revisions()
> from the start.

Yes, another way to do it would be to add the end-state
release_revisions() I have and incrementally add it everywhere.

The way I opted to do it admittedly results in a bit more churn, but was
(and still is) very useful to bisect and debug any changes.

I.e. I can easily pinpoint for any failures what exact rev.* member
being released caused a failure, which I couldn't do if I added the
end-state release_revisions() and then started adding it to code in
various places.

Then a failure due to adding it to say pack-objects wouldn't be easily
distinguishable from a failure due to releasing rev.SOMETHING in
pack-objects.

But in any case, the interaction with tips of these two sets of patches
(this series & mine) would be the same whatever the intra-series
progression I opted for is.

>> So I think just adding UNLEAK() here (and optionally, also to the
>> bundle.c code) is the least invasive thing, if you & Junio are OK with
>> that approach.
>
> Could you send a patch that does just that, so we are sure to cover
> the warnings you are seeing in your tests?

I'm suggesting fixing the following up into this series, the first hunk
is needed for the interaction with the release_revisions() series, the
second is there for completeness, but isn't required currently:

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1a0b0950a28..ffe6197729c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3987,6 +3987,7 @@ static void get_object_list(int ac, const char **av)
 	save_commit_buffer =3D 0;
 	setup_revisions(ac, av, &revs, &s_r_opt);
 	list_objects_filter_copy(&revs.filter, &filter_options);
+	UNLEAK(revs.filter);
=20
 	/* make sure shallows are read */
 	is_repository_shallow(the_repository);
diff --git a/bundle.c b/bundle.c
index e359370cfcd..90cfea0c984 100644
--- a/bundle.c
+++ b/bundle.c
@@ -226,6 +226,7 @@ int verify_bundle(struct repository *r,
 	setup_revisions(2, argv, &revs, NULL);
=20
 	list_objects_filter_copy(&revs.filter, &header->filter);
+	UNLEAK(revs.filter);
=20
 	if (prepare_revision_walk(&revs))
 		die(_("revision walk setup failed"));
