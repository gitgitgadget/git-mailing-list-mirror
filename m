Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24999C07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 19:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiI0TcT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 15:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiI0TcR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 15:32:17 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D993057B
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 12:32:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v2so13667144edc.7
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 12:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=qgx/3tyU15xQ+bxaFEW8g7f7AerRsg1+jE2K9cjXCzA=;
        b=b6wr7UisV3h5XTqNM9KJc4YJ+jqfd9e0GvbO48uOIFGMpFgomzAkiMi566tR3nlV4j
         CK4PPIU8Nciv6p2oKO448aZ5XZDlOGEkZmQZdtFYyTQd2Dy1lIRwd33+ue4Hp/xKqr0O
         WU7+WlQ6IPAE7Lj+FyUir+LOBq9IeJ3NU/15GOp39SSwqRdUzepANLRmTa/QgtLT4gVx
         U91Iao3dbfbliryKlfWC6HDWpGQ3Tm9HTiK9+sVp6fRYSKDNLf9O7taBOLgthyZRYmQo
         sB/IYLOWZJIo4z7TE1IPOehd5r+7e0229888ZH2TkududO6ET0Q/Q72dL7TE3JyzQyPT
         aAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=qgx/3tyU15xQ+bxaFEW8g7f7AerRsg1+jE2K9cjXCzA=;
        b=kptGdABnE0TjWYDm5wRISXQ+KlQQeyftajucjVvRB2GNYXPmjCjTn9sOUGdA/I4Hbf
         NyIPGfalIVFNgjxrz7x74LvZYIX35nzYUJlVXTahbHDLMVG58++KYLq8kJJgFlvdCxxd
         M3XEd+cE6gxDBfh7JGibneFT7uAfO8xAdk88mJEZcu29YRCd9gZIT0vE5byCggM9DHps
         nXvjTwcIwr41U3FKPmg35P9L8xHGJ4EnUus6AurmQjPAOcesXVmdulEP6KyPa2zGKJgP
         oJgN53YMDYXnUzGrjNj7ULcXMw7VXWU+jVtFlDnmaQlzxnJwbnOp+s7NwSxEINgWv6VG
         eVSQ==
X-Gm-Message-State: ACrzQf26nVYOscmFCqNs3jZOyalY8sk15cW+utis10hAH6y8NmKwlyPn
        yHhntKMdc6v8xC/spQbGwtY=
X-Google-Smtp-Source: AMsMyM4kXEsLQG+d7TIsk9P15fLrBRaEZaFLEh4TYWywk//cby8a707kTiwC/DlBhQomsDW6DP3szA==
X-Received: by 2002:a05:6402:493:b0:445:b5f0:7a0f with SMTP id k19-20020a056402049300b00445b5f07a0fmr28845202edv.120.1664307135082;
        Tue, 27 Sep 2022 12:32:15 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id y4-20020aa7d504000000b00456d2721d93sm1759079edq.64.2022.09.27.12.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:32:14 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1odGJR-000X2h-2K;
        Tue, 27 Sep 2022 21:32:13 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/5] config: return an empty list, not NULL
Date:   Tue, 27 Sep 2022 21:18:48 +0200
References: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
 <396343ce7dd17f86bbbc66197c6f0b4012caf445.1664287711.git.gitgitgadget@gmail.com>
 <220927.86sfkcyebf.gmgdl@evledraar.gmail.com>
 <b85d8a43-6640-aa9c-3103-0c3d43c2a479@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <b85d8a43-6640-aa9c-3103-0c3d43c2a479@github.com>
Message-ID: <220927.86k05oy5oi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 27 2022, Derrick Stolee wrote:

> On 9/27/2022 12:21 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Tue, Sep 27 2022, Derrick Stolee via GitGitGadget wrote:
>
>>>  /**
>>>   * Finds and returns the value list, sorted in order of increasing pri=
ority
>>>   * for the configuration variable `key`. When the configuration variab=
le
>>> - * `key` is not found, returns NULL. The caller should not free or mod=
ify
>>> - * the returned pointer, as it is owned by the cache.
>>> + * `key` is not found, returns an empty list. The caller should not fr=
ee or
>>> + * modify the returned pointer, as it is owned by the cache.
>>>   */
>>>  const struct string_list *git_config_get_value_multi(const char *key);
>>=20
>> Aside from the "DWIM API" aspect of this (which I don't mind) I think
>> this is really taking the low-level function in the wrong direction, and
>> that we should just add a new simple wrapper instead.
>>=20
>> I.e. both the pre-image API docs & this series gloss over the fact that
>> we'd not just return NULL here if the config wasn't there, but also if
>> git_config_parse_key() failed.
>>=20
>> So it seems to me that a better direction would be starting with
>> something like the WIP below (which doesn't compile the whole code, I
>> stopped at config.[ch] and pack-bitmap.c). I.e. the same "int" return
>> and "dest" pattern that most other things in the config API have.
>
> Do you have an example where a caller would benefit from this
> distinction? Without such an example, I don't think it is worth
> creating such a huge change for purity's sake alone.

Not initially, I started poking at this because the CL/series/commits
says that we don't care about the case of non-existing keys, without
being clear as to why we want to conflate that with other errors we
might get from this API.

But after some digging I found:

	$ for k in a a.b. "'x.y"; do ./git for-each-repo --config=3D$k;  echo $?; =
done
	error: key does not contain a section: a
	0
	error: key does not contain variable name: a.b.
	0
	error: invalid key: 'x.y
	0
=09
I.e. the repo_config_get_value_multi() you added in for-each-repo
doesn't distinguish between bad keys and non-existing keys, and returns
0 even though it printed an "error".

> I'm pretty happy that the diff for this series is an overall
> reduction in code, while also not being too large in the interim:
>
>  12 files changed, 39 insertions(+), 57 deletions(-)
>
> If all callers that use the *_multi() methods would only use the
> wrapper, then what is the point of doing the low-level manipulations?

I hacked up something that's at least RFC-quality based on this
approach, but CI is running etc., so not submitting it
now:

	https://github.com/git/git/compare/master...avar:git:avar/have-git_configs=
et_get_value-use-dest-and-int-pattern

I think the resulting diff is more idiomatic API use, i.e. you ended up
with:

	        /* submodule.active is set */
	        sl =3D repo_config_get_value_multi(repo, "submodule.active");
	-       if (sl) {
	+       if (sl && sl->nr) {

But I ended up doing:

	        /* submodule.active is set */
	-       sl =3D repo_config_get_value_multi(repo, "submodule.active");
	-       if (sl) {
	+       if (!repo_config_get_const_value_multi(repo, "submodule.active", &=
sl)) {

Note the "const" in the function name, i.e. there's wrappers that handle
the case where we have a hardcoded key name, in which case we can BUG()
out if we'd return < 0, so all we have left is just "does key exist".

In any case, I'm all for having some simple wrapper for the common cases.

But I didn't find a single case where we actually needed this "never
give me a non-NULL list" behavior, it could just be generalized to
"let's have the API tell us if the key exist".

If you use the non-"const" API you can distinguish the err < 0 case, so
for-each-repo can now error out appropriately:

	$ ./git for-each-repo --config=3Da; echo $?
	error: key does not contain a section: a
	fatal: got bad config --config=3Da
=09
	usage: git for-each-repo --config=3D<config> <command-args>
=09
	    --config <config>     config key storing a list of repository paths
=09
	129
