Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB43CC433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 21:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350190AbiDKVtw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 17:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237408AbiDKVtu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 17:49:50 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0DB1A3B8
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 14:47:34 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id lc2so13004929ejb.12
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 14:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=R7fKnfaiqTUd7mY4ll6qUCNsq4mAy4eIDVj5X0UIRCU=;
        b=DMlufUGpXdv1N81UACqbvFIs/jIWfw1DOlZsbzx/Kujvqc53rx11Z+K82RTTlESTx6
         7bqcfFhKFHebnWkUSyqZKAwZ2DAsPwz6UPCcXr1OyidQJ7pnREXOZ4hsbzB9lQ01odCK
         Xfk28FsIA+O+b2HyVxFDcVA6u4fNKvt1yfOB4HKdxkmVrayIy7oJR70BHkSC3WQL2LeF
         ezKUgx5n/S4imr360z9K1IlrIR8JHtsil84xe9A5Z/yOKYzrO9EsH58X4KjcJgsqiZW7
         QkVhffC0VoKIcmsXTwWHiO0nGWi3zi/UiBXhJv6WlgKjoSEKYWKzRHFBB4Kk9CFjBMlv
         Wciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=R7fKnfaiqTUd7mY4ll6qUCNsq4mAy4eIDVj5X0UIRCU=;
        b=i4u5vii9sdDX71CMD0ik7KDXXF54x7pUXL9stD7Hj7k8WjNywhlmQIjCBvebN8wY5f
         JCZ6DgQnS/t6Xcue0dq0FFdUAD7KPGpxIaXYak8d0j4hauDvvIOsOEwOmil8qWNZ6yjr
         wf6YC9/OESII+r4eOmHmzh5KxzUmUFuPyU7y2BYOkJXGMrOEhtQlTv2rwIP8fzNei/iy
         D3RxvEgDOCK2W/JDOO9bCGlhrj8Rl4mfZHCuAPmmX7VBmXWgDQXKGOs+Fr9QFJ3efdAw
         cDOeRfwyvtpHMcsqu7YIMlu3GmvdKxymZqYUrTQThwKi99DrIShxX+BBE4FW5rGQ8RYU
         w/eg==
X-Gm-Message-State: AOAM530VORdRVzPbqlJxs2IDRRJloNg6n3du1y7OQger11N8aqrS96QC
        kCMvZnoVKYE73a3s2BZDgYE=
X-Google-Smtp-Source: ABdhPJxa6FDL0hT+7oC00flEUTpFInZPcwrnwyo8Ig3ImF8ijDqoC1f9exF9hdQzLNOcwpnGjTp0NQ==
X-Received: by 2002:a17:907:3e0d:b0:6e0:daaa:63e0 with SMTP id hp13-20020a1709073e0d00b006e0daaa63e0mr31460857ejc.657.1649713652955;
        Mon, 11 Apr 2022 14:47:32 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qb21-20020a1709077e9500b006e892b4062dsm1783022ejc.215.2022.04.11.14.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 14:47:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ne1sh-004JpP-Dp;
        Mon, 11 Apr 2022 23:47:31 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Makefile: add a prerequisite to the
 coverage-report target
Date:   Mon, 11 Apr 2022 23:27:42 +0200
References: <20220409043033.1288946-1-gitter.spiros@gmail.com>
 <xmqqv8vfiidm.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqv8vfiidm.fsf@gitster.g>
Message-ID: <220411.86fsmji970.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 11 2022, Junio C Hamano wrote:

> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>> Directly invoking make coverage-report as a target results in an error b=
ecause
>> its prerequisites are missing,
>>
>> This patch adds the compile-test prerequisite, which is run only once ea=
ch time
>> the compile-report target is invoked. In practice, the developer may dec=
ide to
>> review the coverage-report results without necessarily rerunning for this
>> coverage-test, if it has already been run.
>>
>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>> ---
>> This is the second version of the patch.
>>
>> With respect to the first version, we tried to eliminate the inefficient
>> coverage-test invocation if the target is coverage-report, introducing a=
 more
>> useful invocation order
>
> Thanks.
>
> I do not see why you want to make the name of coverage-test.file
> customizable.  In our makefiles, it seems that these "stamp" files
> are named with the ".made" suffix
>
>    $ git grep -e '\.made'
>
> so using hardcoded "coverage-test.made" (with something that removes
> *.made when "make clean" is run) may make it in line with the rest
> of the build procedure.
>
> =C3=86var, I had an impression that you had many Makefile patches either
> unsubmitted or work-in-progress in the dependency-tightening area,
> and am wondering if you find the dependencies (or the lack thereof)
> for coverage-report target annoying.  Any good ideas?

I haven't come up with a patch for these coverage targets, but I think
it would be much more useful to:

 * Not have the target itself compile git, i.e. work like SANITIZE=3Dleak,
   there's no reason you shouldn't be able to e.g. combine the two
   easily, it's just a complimentary set of flags.

 * We should be able to run this in parallel, see
   e.g. https://stackoverflow.com/questions/14643589/code-coverage-using-gc=
ov-on-parallel-run
   for a trick for how to do that on gcc 9+, on older gcc GCOV_PREFIX*
   can be used.

   I.e. we'd save these in t/test-results/t0001.coverage or whatever,
   and then "join" them at the end.

I wonder if the issue this patch is trying to address would then just go
away, i.e. isn't it OK that we'd re-run the tests to get the report
then? gcov doesn't add that much runtime overhead.
