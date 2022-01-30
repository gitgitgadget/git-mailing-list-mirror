Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D953AC433EF
	for <git@archiver.kernel.org>; Sun, 30 Jan 2022 13:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347045AbiA3NCM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Jan 2022 08:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiA3NCK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jan 2022 08:02:10 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB86C061714
        for <git@vger.kernel.org>; Sun, 30 Jan 2022 05:02:10 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id j12so8855526qtr.2
        for <git@vger.kernel.org>; Sun, 30 Jan 2022 05:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5TRBROS/7X1wfWjGfzQVTT8ypzNS4v2OFhsHEqh4x0w=;
        b=RY3443m6vg9y2kfjkauO3QNma2UCp2tJ+Q+u8RmxuCdBjf63xpFyMDJImWlErL3tXT
         nBYp3CXg0wGqbZgq+YDkQe59NFRZdgwlqFYFXRVGdJqkRxaahJeHZQ1R+GCQ/MBITC42
         pAuYaA05TpMa8g8ySsC/XhGCuXCRCmoj+t2vT72iqTXMTkFtHQRwFJxINMCagLm16/Rj
         8UqNlz2yqKkF/cXue0R8DUMRTlK0uAPweAPy+zsfJGz66+w7f5WifrmubK/4zZvHeVkW
         kjN9QQ0ril5HL17/lvRsDHMqMdmbRtf3H1suEO4yHiB6L8+Dv9MFHHdUwx9CEni5vG7B
         2x4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5TRBROS/7X1wfWjGfzQVTT8ypzNS4v2OFhsHEqh4x0w=;
        b=39mwesLEwXqdXZ2X31qcWIN6zkNrlwEjxOu/OWQOQfNMXg0LHZUyl4ioXae9/JERfh
         7ow1hOD5VElfpXJGsFu/6LxBDV6Jsf71O6cBmHGiSbHHmDMrR7mhiNxZPTVraElJiu6e
         BFEqTjbm0ocsdU0AQOaGA/tzbbZlekuTArbTrvLKOwT2pR3HurB2SOv798iZ2m2DGz+X
         ooQ9RFxAIhiG9Kwrmw15TLw7R1D3rujgAB2ZrxCR0a9S+lJnIav08ZijLdxT+7g43wXb
         LkVzz8lMK+rg8W+/j54q/N0WoB0khP5CC5mJOxScabAxx7EK+5MMVjv9zDW/JM8BXL37
         EH9g==
X-Gm-Message-State: AOAM532TSihDASZEJlqHqjijqMhaKD0f887Fc8d/eRdp6h+6mOmPqC9W
        zHUbexLcH1BYYm7f4f7Cgaw=
X-Google-Smtp-Source: ABdhPJzXgsV//2GKOb2x/XMRgGjpSHDjVt7Q5iswyqKYszwBg/S7M5eV0Mob27tctjOnb16WR/ew6A==
X-Received: by 2002:ac8:5756:: with SMTP id 22mr882491qtx.12.1643547729387;
        Sun, 30 Jan 2022 05:02:09 -0800 (PST)
Received: from [192.168.1.211] (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id u11sm3201908qkp.122.2022.01.30.05.02.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jan 2022 05:02:08 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 2/2] repack: add --filter=<filter-spec> option
Date:   Sun, 30 Jan 2022 08:02:07 -0500
X-Mailer: MailMate Trial (1.14r5852)
Message-ID: <8D4655AA-8D2A-4D4C-A7CD-B79A8A9E66D7@gmail.com>
In-Reply-To: <A4BAD509-FA1F-49C3-87AF-CF4B73C559F1@gmail.com>
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
 <a3166381572481f2ed159740eb8a1d88d4f9dc0f.1643248180.git.gitgitgadget@gmail.com>
 <a62a007f-7c61-68eb-c0e6-548dc9b6f671@gmail.com>
 <A4BAD509-FA1F-49C3-87AF-CF4B73C559F1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry forgot to include the link to Christian's demo. included below

On 29 Jan 2022, at 14:14, John Cai wrote:

> Hi Stolee,
>
> Thanks for taking the time to review this patch! I added some points of=
 clarification
> down below.
>
> On 27 Jan 2022, at 10:03, Derrick Stolee wrote:
>
>> On 1/26/2022 8:49 PM, John Cai via GitGitGadget wrote:
>>> From: John Cai <johncai86@gmail.com>
>>>
>>> Currently, repack does not work with partial clones. When repack is r=
un
>>> on a partially cloned repository, it grabs all missing objects from
>>> promisor remotes. This also means that when gc is run for repository
>>> maintenance on a partially cloned repository, it will end up getting
>>> missing objects, which is not what we want.
>>
>> This shouldn't be what is happening. Do you have a demonstration of
>> this happening? repack_promisor_objects() should be avoiding following=

>> links outside of promisor packs so we can safely 'git gc' in a partial=

>> clone without downloading all reachable blobs.
>
> You're right, sorry I was mistaken about this detail of how partial clo=
nes work.
>>
>>> In order to make repack work with partial clone, teach repack a new
>>> option --filter, which takes a <filter-spec> argument. repack will sk=
ip
>>> any objects that are matched by <filter-spec> similar to how the clon=
e
>>> command will skip fetching certain objects.
>>
>> This is a bit misleading, since 'git clone' doesn't "skip fetching",
>> but instead requests a filter and the server can choose to write a
>> pack-file using that filter. I'm not sure if it's worth how pedantic
>> I'm being here.
>
> Thanks for the more precise description of the mechanics of partial clo=
ne.
> I'll improve the wording in the next version of this patch series.
>
>>
>> The thing that I find confusing here is that you are adding an option
>> that could be run on a _full_ repository. If I have a set of packs
>> and none of them are promisor (I have every reachable object), then
>> what is the end result after 'git repack -adf --filter=3Dblob:none'?
>> Those existing pack-files shouldn't be deleted because they have
>> objects that are not in the newly-created pack-file.
>>
>> I'd like to see some additional clarity on this before continuing
>> to review this series.
>
> Apologies for the lack of clarity. Indeed, I can see why this is the mo=
st important
> detail of this patch to provide enough context on, as it involves delet=
ing
> objects from a full repository as you said.
>
> To back up a little, the goal is to be able to offload large
> blobs to a separate http server. Christian Couder has a demo [1] that s=
hows
> this in detail.
>
> If we had the following:
> A. an http server to use as a generalized object store
> B. a server update hook that uploads large blobs to 1.
> C. a git server
> D. a regular job that runs `git repack --filter` to remove large
> blobs from C.
>
> Clients would need to configure both C) and A) as promisor remotes to
> be able to get everything. When they push new large blobs, they can
> still push them to C), as B) will upload them to A), and D) will
> regularly remove those large blobs from C).
>
> This way with a little bit of client and server configuration, we can h=
ave
> a native way to support offloading large files without git LFS.
> It would be more flexible as you can easily tweak which blobs are consi=
dered large
> files by tweaking B) and D).
>

[1] https://gitlab.com/chriscool/partial-clone-demo/-/blob/master/http-pr=
omisor/server_demo.txt

>>
>>> The final goal of this feature, is to be able to store objects on a
>>> server other than the regular git server itself.
>>>
>>> There are several scripts added so we can test the process of using a=

>>> remote helper to upload blobs to an http server:
>>>
>>> - t/lib-httpd/list.sh lists blobs uploaded to the http server.
>>> - t/lib-httpd/upload.sh uploads blobs to the http server.
>>> - t/t0410/git-remote-testhttpgit a remote helper that can access blob=
s
>>>   onto from an http server. Copied over from t/t5801/git-remote-testh=
ttpgit
>>>   and modified to upload blobs to an http server.
>>> - t/t0410/lib-http-promisor.sh convenience functions for uploading
>>>   blobs
>>
>> I think these changes to the tests should be extracted to a new
>> patch where this can be discussed in more detail. I didn't look
>> too closely at them because I want to focus on whether this
>> --filter option is a good direction for 'git repack'.
>>
>>>  		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
>>> @@ -819,6 +824,11 @@ int cmd_repack(int argc, const char **argv, cons=
t char *prefix)
>>>  		if (line.len !=3D the_hash_algo->hexsz)
>>>  			die(_("repack: Expecting full hex object ID lines only from pack-=
objects."));
>>>  		string_list_append(&names, line.buf);
>>> +		if (po_args.filter) {
>>> +			char *promisor_name =3D mkpathdup("%s-%s.promisor", packtmp,
>>> +							line.buf);
>>> +			write_promisor_file(promisor_name, NULL, 0);
>>
>> This code is duplicated in repack_promisor_objects(), so it would be
>> good to extract that logic into a helper method called by both places.=

>
> Thanks for pointing this out. I'll incorporate this into the next versi=
on.
>>
>>> +		}
>>>  	}
>>>  	fclose(out);
>>>  	ret =3D finish_command(&cmd);
>>
>>> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
>>> index e489869dd94..78cc1858cb6 100755
>>> --- a/t/t7700-repack.sh
>>> +++ b/t/t7700-repack.sh
>>> @@ -237,6 +237,26 @@ test_expect_success 'auto-bitmaps do not complai=
n if unavailable' '
>>>  	test_must_be_empty actual
>>>  '
>>>
>>> +test_expect_success 'repack with filter does not fetch from remote' =
'
>>> +	rm -rf server client &&
>>> +	test_create_repo server &&
>>> +	git -C server config uploadpack.allowFilter true &&
>>> +	git -C server config uploadpack.allowAnySHA1InWant true &&
>>> +	echo content1 >server/file1 &&
>>> +	git -C server add file1 &&
>>> +	git -C server commit -m initial_commit &&
>>> +	expected=3D"?$(git -C server rev-parse :file1)" &&
>>> +	git clone --bare --no-local server client &&
>>
>> You could use "file:://$(pwd)/server" here instead of "server".
>
> good point, thanks
>
>>
>>> +	git -C client config remote.origin.promisor true &&
>>> +	git -C client -c repack.writebitmaps=3Dfalse repack -a -d --filter=3D=
blob:none &&
>> This isn't testing what you want it to test, because your initial
>> clone doesn't use --filter=3Dblob:none, so you already have all of
>> the objects in the client. You would never trigger a need for a
>> fetch from the remote.
>
> right, so this test is actually testing that repack --filter would shed=
 objects to show
> that it can be used as D) as a regular cleanup job for git servers that=
 utilize another
> http server to host large blobs.
>
>>
>>> +	git -C client rev-list --objects --all --missing=3Dprint >objects &=
&
>>> +	grep "$expected" objects &&
>>> +	git -C client repack -a -d &&
>>> +	expected=3D"$(git -C server rev-parse :file1)" &&
>>
>> This is signalling to me that you are looking for a remote fetch
>> now that you are repacking everything, and that can only happen
>> if you deleted objects from the client during your first repack.
>> That seems incorrect.
>>
>>> +	git -C client rev-list --objects --all --missing=3Dprint >objects &=
&
>>> +	grep "$expected" objects
>>> +'
>>
>> Based on my current understanding, this patch seems unnecessary (repac=
ks
>> should already be doing the right thing when in the presence of a part=
ial
>> clone) and incorrect (we should not delete existing reachable objects
>> when repacking with a filter).
>>
>> I look forward to hearing more about your intended use of this feature=
 so
>> we can land on a better way to solve the problems you are having.
>
> Thanks for the callouts on the big picture of this proposed change. Loo=
king
> forward to getting your thoughts on this!
>>
>> Thanks,
>> -Stolee
