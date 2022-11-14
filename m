Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E21EC433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 19:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbiKNTUu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 14:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbiKNTUt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 14:20:49 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B244C21260
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 11:20:47 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s5so2544719edc.12
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 11:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HPp8nZvl/hJxuBb3+8E+imM6Es4b4hK+ILEKrIoTwgc=;
        b=XDHaj5gpERIWNQ/g84sev81gqJ5xJQYhugcXlACi9HxzUGQktqpaB5a/68N4UUuMIj
         ASUlOi1uivBDeeoX2pjMc4/wphJtjJqG4sLFCfnQG0ZQeclKoL5TL1Mi4s9rvz7/J8+S
         XT+8CA441/WLA2yWdUVGIUXNvZq5QY+pIsCF8zUec35SCOB1rzrnag42GpygA7EhkUCx
         SHQVUNOhUvcgp4W590O5MnSQbQVPounDrTneAJSxnK+B0xSyWo0ZkzzUkiLGClksmVY7
         ez6GKKrgnp/bMZNSJmpaKIfa1jiOVqKznP4R3dm5ERj69o3ljPlLjMtl+LL0oQNuXyDn
         hzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HPp8nZvl/hJxuBb3+8E+imM6Es4b4hK+ILEKrIoTwgc=;
        b=37BfxzP+YUWXlZeC6Rq7qlsg1qeHpsLPwYgx6oTKc5AL3K6C9nsW6BVYnFGdAXy4RD
         RJt4G7jt209OgtC5JpujgS7mjqDAVa1CgPVsCMiM0IAZHTRqKp5+Oq+9uO1Az5RIxLU0
         iObhrpXU3JtkiEwfQuwoCNprFuG2a+DlTk0QdGfsamIQA7DGZrj6cvqmmv6tiAsVW5Tk
         a5Z1NFCPtSrpuYoOYIo7Qpkry7Nb59Z8M47E4yeruOidbmBMAfEIs+WeH8jr4/EE6uEI
         rw0Iav45kVDQdlvyVesEjS7UdMNBJL/HRMAG6gX5hVadLj0bI3U3vwMdmGRxzAOsDOnK
         IVrA==
X-Gm-Message-State: ANoB5pnnqPaxZfxwANOs35wCif+zCdl5gEM26hrCb9bkle0lBahhTV1Q
        p4rNs+X5m1lFijcvO+9OCJp+BVkwBRwtaA==
X-Google-Smtp-Source: AA0mqf7fR0jk+sOGrTZujuD3araPXJmmJaY6/jou6254MekK3CPG+rsN0sh+6nmB6yGnYHR/dDIBeA==
X-Received: by 2002:a05:6402:43ce:b0:461:5d0a:78e1 with SMTP id p14-20020a05640243ce00b004615d0a78e1mr12356987edc.425.1668453646142;
        Mon, 14 Nov 2022 11:20:46 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id r10-20020a17090609ca00b0077077c62cadsm4582784eje.31.2022.11.14.11.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:20:45 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ouf0e-003KXo-3A;
        Mon, 14 Nov 2022 20:20:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v2 01/10] read-tree + fetch tests: test failing
 "--super-prefix" interaction
Date:   Mon, 14 Nov 2022 20:14:55 +0100
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
 <patch-v2-01.10-1114a4ff666-20221114T100803Z-avarab@gmail.com>
 <kl6lo7t91hvd.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <kl6lo7t91hvd.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <221114.86cz9pl4vn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 14 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> From: Glen Choo <chooglen@google.com>
>>
>> Ever since "git fetch --refetch" was introduced in 0f5e8851737 (Merge
>> branch 'rc/fetch-refetch', 2022-04-04) the test being added here would
>> fail. This is because "restore" will "read-tree .. --reset <hash>",
>> which will in turn invoke "fetch". The "fetch" will then die with:
>>
>> 	fatal: fetch doesn't support --super-prefix
>>
>> This edge case and other "--super-prefix" bugs will be fixed in
>> subsequent commits, but let's first add a "test_expect_failure" test
>> for it. It passes until the very last command in the test.
>>
>> Signed-off-by: Glen Choo <chooglen@google.com>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  t/t5616-partial-clone.sh | 43 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>
>> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
>> index 037941b95d2..e56466580cf 100755
>> --- a/t/t5616-partial-clone.sh
>> +++ b/t/t5616-partial-clone.sh
>> @@ -644,6 +644,49 @@ test_expect_success 'repack does not loosen promiso=
r objects' '
>>  	grep "loosen_unused_packed_objects/loosened:0" trace
>>  '
>>=20=20
>> +test_expect_failure 'lazy-fetch in submodule succeeds' '
>> +	# setup
>> +	test_config_global protocol.file.allow always &&
>> +
>> +	git init src-sub &&
>> +	git -C src-sub config uploadpack.allowfilter 1 &&
>> +	git -C src-sub config uploadpack.allowanysha1inwant 1 &&
>> +
>> +	# This blob must be missing in the subsequent commit.
>> +	echo foo >src-sub/file &&
>> +	git -C src-sub add file &&
>> +	git -C src-sub commit -m "submodule one" &&
>> +	SUB_ONE=3D$(git -C src-sub rev-parse HEAD) &&
>> +
>> +	echo bar >src-sub/file &&
>> +	git -C src-sub add file &&
>> +	git -C src-sub commit -m "submodule two" &&
>> +	SUB_TWO=3D$(git -C src-sub rev-parse HEAD) &&
>> +
>> +	git init src-super &&
>> +	git -C src-super config uploadpack.allowfilter 1 &&
>> +	git -C src-super config uploadpack.allowanysha1inwant 1 &&
>> +	git -C src-super submodule add ../src-sub src-sub &&
>> +
>> +	git -C src-super/src-sub checkout $SUB_ONE &&
>> +	git -C src-super add src-sub &&
>> +	git -C src-super commit -m "superproject one" &&
>> +
>> +	git -C src-super/src-sub checkout $SUB_TWO &&
>> +	git -C src-super add src-sub &&
>> +	git -C src-super commit -m "superproject two" &&
>> +
>> +	# the fetch
>> +	test_when_finished "rm -rf src-super src-sub client" &&
>
> (Genuinely curious) are we okay with test_when_finished in the middle of
> the test body instead of at the top?

Yeah, and it's not just supported, but preferred, usually we do:

	test_when_finished "rm -rf repo" &&
	git init repo &&

So at the top makes sense, but if there's a bunch of stuff we might fail
on first it makes sense not to attempt the cleanup.

But I see in this case the "src-super" part of it should be earlier, and
"src-sub", but the "client" should be just before the clone below, don't
know how I missed that. Will fix.

>> +
>> +	test_config_global protocol.file.allow always &&
>
> We have this exact same test_config_global line at the top of this test,
> so we can drop this one.

Ditto, thanks, I'll fix that. A mistake when combining the tests.

You had these as two tests, but one was mandatory setup for the other,
and when making it test_expect_failure I wanted to have it atomic..
