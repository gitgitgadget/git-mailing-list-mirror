Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24E3C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 22:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiKIW1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 17:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiKIW1s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 17:27:48 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F04A19C1F
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 14:27:47 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id q21so12229255iod.4
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 14:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=izQmRC6fTY1ZZl+U3Yl8j/5kIXxdJ/RZGmYQCG6r75Q=;
        b=rZAB91A0Bo2BSyiTM/WWNHyVI7lrHTTF+oeatQXqWc9fgTgeReeIHyMQmFz2wWFLgh
         OLu4Szl6xDLLEJr0jLd5tirUQUNks09D4GKajaa4Yx+X+y1kAVMMds6CMf674N2YYhf4
         weRYmv0qWyhpwo3PQn3iv2wiSztO7FfwMldaKUndUByr7W3GQnEBnnew4JDgm7TKMSq5
         EJ0nZRuSQ5DGW9ptX9fs9IB9jR5SnrPpLnx/KfJT3YJDVPuS+ZtdEFJbBHGlz9bPzp9Z
         /kxS7n4GfhoxOcbdD9rVTHIY03Gao8ZAnYW0sIOItXfRmHkVI5sEEsPF/fiTsGFmEFx1
         vTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izQmRC6fTY1ZZl+U3Yl8j/5kIXxdJ/RZGmYQCG6r75Q=;
        b=56dSuhtuxymRy9+A4ex+uh8xqGVzzKFa2giRQj9x4UKHHEYaY2PCVQrcoQd0LHUCZn
         i1kEL2QNDaEHWJSfQ6uMPGYZPE+w2YhWjVEteHayYOeV9JE6qOS3j56V7OZpIMw1vuHj
         SrSD9+9H0z4ZBSsnF2y1YpSWddt6O8b2TNrEV5sl/C45wnoflnypQvNMbfFdVptg2uf+
         Mp4Ta+s5vNgKMWAy9GYDDZFeoKlCAw95eQ0Al4YqrQnw75WJiYGZLsHRT3ZCyJa3SneU
         cYO2B6Avxv8eeJNeVxxH3E35/bmoY85joU5beEjebifoCkq7+j1OuyeooWijnZTfTCyZ
         ElHg==
X-Gm-Message-State: ACrzQf2CPjmdb42d0FGoZT+GP+g38nVea1VhlZRyTMg+ACB60VZYZcun
        SVOfsLuzbD2zb+eebDK5J8IXhw==
X-Google-Smtp-Source: AMsMyM7nYKW6cUi7vw7EGvkkWZ4cs78gpxKts8TdvZFFZEfR3CvuFjDO/71AUbHur1XyldXjKk1q3A==
X-Received: by 2002:a02:7414:0:b0:375:9ff6:3c8a with SMTP id o20-20020a027414000000b003759ff63c8amr2174510jac.306.1668032866536;
        Wed, 09 Nov 2022 14:27:46 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i10-20020a056638380a00b003709af661b8sm5054629jav.51.2022.11.09.14.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:27:46 -0800 (PST)
Date:   Wed, 9 Nov 2022 17:27:45 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [RFC PATCH 0/8] Get rid of "git --super-prefix"
Message-ID: <Y2wpYQ2x1Ghybqjo@nand.local>
References: <20221109004708.97668-1-chooglen@google.com>
 <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <Y2wZw3eYO4ykwtA8@nand.local>
 <221109.86h6z7pzdg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221109.86h6z7pzdg.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2022 at 10:47:40PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Wed, Nov 09 2022, Taylor Blau wrote:
>
> > On Wed, Nov 09, 2022 at 08:34:28PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> An RFC alternative to Glen's [1], and what I *thought* he might be be
> >> going for in the earlier discussion[2].
> >
> > I am a little puzzled with what to do with this series. For one, it
> > doesn't seem to apply cleanly on top of 'ab/remove--super-prefix':
> >
> >     $ git log --oneline -1
> >     04e36effde (HEAD -> ab/remove--super-prefix) Merge branch 'ab/submodule-helper-prep-only' into ab/remove--super-prefix
> >
> >     $ git am -sc3 ~/patch
> >     Applying: submodule--helper: don't use global --super-prefix in "absorbgitdirs"
> >     error: sha1 information is lacking or useless (submodule.c).
> >     error: could not build fake ancestor
> >     Patch failed at 0001 submodule--helper: don't use global --super-prefix in "absorbgitdirs"
> >     hint: Use 'git am --show-current-patch=diff' to see the failed patch
> >     When you have resolved this problem, run "git am --continue".
> >     If you prefer to skip this patch, run "git am --skip" instead.
> >     To restore the original branch and stop patching, run "git am --abort".
>
> My bad, the CL says:
>
> 	and can make use of (but doesn't need) the better test coverage
> 	for "absorbgitdirs" that I submitted in [3]
> 	(https://lore.kernel.org/git/patch-1.1-34b54fdd9bb-20221109T020347Z-avarab@gmail.com/)".
>
> But it actually *does* need that, sorry. But with that, this works for me:
>
> 	git checkout master
> 	git reset --hard @{u}
> 	git merge --no-edit ttaylorr/ab/submodule-helper-prep-only
> 	(apply https://lore.kernel.org/git/patch-1.1-34b54fdd9bb-20221109T020347Z-avarab@gmail.com/)
>
> Then apply this series. I've also got it at
> https://github.com/avar/git/tree/avar/nuke-global-super-prefix-use-local;
> but that's a locally rebased version of ab/submodule-helper-prep-only,
> then that [3], and finally this series.

Yes, that works for me. I hadn't quite gotten to the later patch yet,
but I queued it as 'ab/remove--super-prefix' and then merged it into the
new branch (along with 'ab/submodule-helper-prep-only').

Then everything applied as expected, so that is good.

> I figured I was just kicking ideas back & forth with Glen, so I didn't
> go through my usual sanity checking :)

No worries, I figured. It's helpful to know whether you intended to
supersede, build on top of, or propose an alternative direction for
Glen's patch.

For what it's worth, I think it's totally fine to say: "I have this
alternative approach in a series, and here it is", but it is also
helpful to add "let's figure out a way to build these together instead
of queuing this alternative approach as-is".

> > But it would be nice to have a clearer path forward between this and
> > Glen's series. I understand that they are both still RFCs, but I am
> > counting on you two working together to find a path forward that is
> > satisfactory to you both.
>
> *nod*, I'm sure we can manage that.

Thanks very much.

Thanks,
Taylor
