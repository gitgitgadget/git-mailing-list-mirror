Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB59C433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 00:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiKXAUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 19:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKXAUm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 19:20:42 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ECF58BC7
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 16:20:41 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id a6-20020a170902ecc600b00186f035ed74so724plh.12
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 16:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7NFwyJF8fTSMwJ5ldXZIHDIjEluNAEYRBSGlHaKXOck=;
        b=cyC0d3C0IevkF9Voe+Il15yGOpRRXJ/iwYWVqiG89JipN7QYQ6mMEHHbxAG+tRk3EU
         71LRnXmAiScLG9YhLi/6G/5Y8DsvDKjfdLY4WOksdlcdj0tzt2P4zV8dS/787rf39Zzk
         SiaYLyRadrqt0Eg5gvcNy4MQhLLQseDNBNmedPASndX8peBuBMlVe2Gtvc3DPmsSbava
         xjEsbpJEJj4Ylu24JwIRmFZpI0b55XQQI5AqjhK1J+ePc3uBJM2Vyhe0v31HqPjDO4UQ
         fJP8FMG2KCjqsF27inaKyxDCjJRJG7h7RQH6Nr+EPfAVWBTjW1SVehGYU/fpcHoy0Hu8
         6+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7NFwyJF8fTSMwJ5ldXZIHDIjEluNAEYRBSGlHaKXOck=;
        b=jWrh3GCsaHh4m7zSydA1SiACDqRHPwrGg0Jhr5v/FyEYuQWrvcM3iaoBZp3k//ft4B
         M78uQeWxvOnCMInqsXT0eD+qH8jI49bpW2p59LsrdSsNNkRQrhrLIyLocOJeE73d65nt
         m39o9N5+OLl7TmgC8JKNBLmnIT8U6/o1OBGLERz8KhP9G7Ze3ZWc31bJlkQNHAKwy/nh
         VWXcxaT4yaOfg/RMflbUuWDrieFGwwYdByxWH8c1z2GVDLAEjGylMkqB30m1uzAfi2Vm
         5s7yIwMoMONdb1M4U3S9vNRgB7zAS7pYBJ/AwTmCJXDIigRyf3vLUkZoPE1SKWMooQgG
         eF0Q==
X-Gm-Message-State: ANoB5pkq3lBa/40xpWBXMmPohqrNKEOdNywPS8nY71Vy/H4fvMRpy71n
        EaBRYiicwjcUz51ZASy9xxkq76bPnskozg==
X-Google-Smtp-Source: AA0mqf7RR5IfxYSds3a5kT0x6gONhKiDw3VscFD4wmeKmTsWmpxRdeuPgz/LAeSHdhU0Iw5NuKO3w/MeIIN9KQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:4205:b0:56b:a7cd:f47a with SMTP
 id cd5-20020a056a00420500b0056ba7cdf47amr32336977pfb.22.1669249240531; Wed,
 23 Nov 2022 16:20:40 -0800 (PST)
Date:   Wed, 23 Nov 2022 16:20:31 -0800
In-Reply-To: <221122.868rk3bxbb.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <pull.1382.git.git.1668706274099.gitgitgadget@gmail.com>
 <pull.1382.v2.git.git.1669074557348.gitgitgadget@gmail.com> <221122.868rk3bxbb.gmgdl@evledraar.gmail.com>
Message-ID: <kl6lzgchcieo.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2] object-file: use real paths when adding alternates
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>  object-file.c     | 12 ++++++------
>>  t/t7700-repack.sh | 18 ++++++++++++++++++
>>  2 files changed, 24 insertions(+), 6 deletions(-)
>>
>> diff --git a/object-file.c b/object-file.c
>> index 957790098fa..ef2b762234d 100644
>> --- a/object-file.c
>> +++ b/object-file.c
>> @@ -508,6 +508,7 @@ static int link_alt_odb_entry(struct repository *r, =
const struct strbuf *entry,
>>  {
>>  	struct object_directory *ent;
>>  	struct strbuf pathbuf =3D STRBUF_INIT;
>> +	struct strbuf tmp =3D STRBUF_INIT;
>>  	khiter_t pos;
>> =20
>>  	if (!is_absolute_path(entry->buf) && relative_base) {
>> @@ -516,12 +517,14 @@ static int link_alt_odb_entry(struct repository *r=
, const struct strbuf *entry,
>>  	}
>>  	strbuf_addbuf(&pathbuf, entry);
>> =20
>> -	if (strbuf_normalize_path(&pathbuf) < 0 && relative_base) {
>> +	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
>>  		error(_("unable to normalize alternate object path: %s"),
>> -		      pathbuf.buf);
>> +			pathbuf.buf);
>
> This is a mis-indentation, it was OK in the pre-image, not now.

Strange, this came from "make style", and in the GitHub web UI, it shows
the next line as aligned with the opening ". Meh, I'll undo it.

> Doesn't this leak? I've just skimmed strbuf_realpath_1() but e.g. in the
> "REALPATH_MANY_MISSING" case it'll have allocated the "resolved" (the
> &tmp you pass in here) and then "does a "goto error_out".
>
> It then *resets* the strbuf, but doesn't release it, assuming that
> you're going to pass it in again. So in that case we'd leak here, no?
>
> I.e. a NULL return value from strbuf_realpath() doesn't mean that it
> didn't allocate in the scratch area passed to it, so we need to
> strbuf_release(&tmp) here too.

Yeah, you're right. At any rate, it's a lot of cognitive overload to
check if strbuf_realpath() will or won't allocate, so free()-ing in the
caller makes sense.

Separately, Peff mentioned that strbuf_realpath() not free()-ing is a
real bug, but I'll leave that for a future cleanup.

>> +		echo content >file4 &&
>> +		git add file4 &&
>> +		git commit -m commit_file4 &&
>> +		git repack -a &&
>> +		ls .git/objects/pack/*.pack >../expect &&
>> +		ln -s objects .git/alt_objects &&
>> +		echo "$(pwd)/.git/alt_objects" >.git/objects/info/alternates &&
>> +		git repack -a -d -l &&
>> +		ls .git/objects/pack/*.pack >../actual
>> +	) &&
>> +	test_cmp expect actual
>> +'
>> +
>
> I think this is better squashed in:
> =09
> 	diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> 	index ce1954d0977..79eef5b4aa7 100755
> 	--- a/t/t7700-repack.sh
> 	+++ b/t/t7700-repack.sh
> 	@@ -91,13 +91,11 @@ test_expect_success 'loose objects in alternate ODB =
are not repacked' '
> 	 '
> 	=20
> 	 test_expect_success '--local keeps packs when alternate is objectdir ' =
'
> 	-	git init alt_symlink &&
> 	+	test_when_finished "rm -rf repo" &&
> 	+	git init repo &&
> 	+	test_commit -C repo A &&
> 	 	(
> 	-		cd alt_symlink &&
> 	-		git init &&
> 	-		echo content >file4 &&
> 	-		git add file4 &&
> 	-		git commit -m commit_file4 &&
> 	+		cd repo &&
> 	 		git repack -a &&
> 	 		ls .git/objects/pack/*.pack >../expect &&
> 	 		ln -s objects .git/alt_objects &&
>
> Because:
>
>  * If it's not a setup for a later test let's call it "repo" and clean
>    it up at the end.
>
>  * The "file4" you're creating doesn't go with the existing pattern, the
>    file{1..3} are created in the top-level .git, here you're making a
>    file4 in another repo.
>
>    This just calls it "A.t", and makes it with test_commit, since all
>    you need is a dummy commit.
>
>  * I think we typically use "find .. -type f", not "ls", see
>    e.g. t5351-unpack-large-objects.sh, but I left it in-place. I think
>    aside from that test there's some other "let's compare the packed
>    before & after" in the test suite, but I can't remember offhand...

It seems like t7700-repack.sh itself isn't consistent either (which is
probably how I ended up with "ls"). I'll also leave it alone unless
someone has strong opinions.
