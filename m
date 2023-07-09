Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B29EB64DC
	for <git@archiver.kernel.org>; Sun,  9 Jul 2023 05:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjGIFgK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Jul 2023 01:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbjGIFgI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2023 01:36:08 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88364E48
        for <git@vger.kernel.org>; Sat,  8 Jul 2023 22:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688880960; x=1689485760; i=l.s.r@web.de;
 bh=7nNwWToRXW6cT20+mdRjFg8AbVq6d6XnWi5ypxkvsuA=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=DoQAYZEHgydAPMWFDgoy5jxSsR26EKEFHPJglq95KL9q5wn81dYF4v1Fs2yRyRpAAXA9zQx
 P+Al15qcvA4s2cB6YlqYcKSxSqZaDzHgRkeynoOkXnogZLdzEzBybAKFHUwNHmAHoY6cRRUT5
 4MADkYdBprnlzjb4kJWq2qGXRkQ48SRkbkPPo8fhaR29dUTcEZA9rxoqD8CWnWLZwx3AqTizA
 hxXcXaadejVM536pTbjzSEV4W/63LLF4DWgTNTvwH2R9hTY4DSaQP6XNW/aDK72vnC2QqTC9N
 R0/UrUz/RjLn3xhaD95FeVGYwhppBvAhJZyjodk9ndH6d4ovE/+w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.158.134]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MyO0s-1q4AA81ewu-00ycfn; Sun, 09
 Jul 2023 07:36:00 +0200
Message-ID: <39d5e14d-f2e9-e619-c3e8-e63c7547370b@web.de>
Date:   Sun, 9 Jul 2023 07:35:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 2alt/2] dir: match "attr" pathspec magic with correct
 paths
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20230707220457.3655121-1-gitster@pobox.com>
 <20230707220457.3655121-3-gitster@pobox.com> <xmqqttuf70bn.fsf_-_@gitster.g>
 <26f81ed0-8d1f-e0be-9696-25ce3938ae09@web.de> <xmqqh6qe5boa.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqh6qe5boa.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tiXWMEq9bNUciO4+EyG6LOUpPArDv6PqqKnAgkL11ImnCnXCtwv
 HSqLwgKU4z81GXFRFf26V3+lW5ya0cnCG9w+p1YiHI94WQ2jWmsmxxjlFioFGY31OGXe/Ux
 Mz9IQvEE+EJm83oENyuyjUlvQQ1iVrbqCECOYwpocPbcPZNz0pJ8MIwfib92KzxzmBunomT
 vA+1Rl+XpNMvhFnxSIXVw==
UI-OutboundReport: notjunk:1;M01:P0:WdyjautVwgQ=;3sM2fDfflA69H0kYhiGQN/bxB1w
 TQ8cbLhG4Iz+E4ihfwwXBLEA6I8uRi0sRFQTA4mlH1LIRhAKaJ4WM3GaO308R3RzG2rTr0irN
 clMoqGmDupmIJ2z/JERqHK+fc5CnpmYhbuWzw9OGA2PwiFm7mvt8lkIYCpHez8JjMup4yUs5k
 I/e6J19FfD5t7BXK+piAxcHHCEf+wkFcUvFM3N33ztWatu1zUsTSYyAFL71KXL8iHlu+GdLKj
 +joRkpQGm4uDcK8cX0VevVI9yq7OFuyGBEar2pSeDPtoUVTyzrEl8E1SWylPNRqpsrc6+Sb6n
 zbfKw9BQiYxf3R/ovttRU6TWb2mZj3luvCrjViOu7ab3WMv3VZs/W+chjph+8n6DDRDEQn3Up
 HWQFqBH8yZUlYgbLAR+exR6lNEH5M/1GEA+JNMurfFolZrROCWVG8TThjlmdqws24/mDYqBM5
 vxrjPgQdg1R8+5HxbwEzEVbbzgbHxoZS0CKTh6ZmLvgj+B/QjFc4Utbtw5veU/mHwQ/iOx42M
 OcAsM74dN++FsyxdUyanaY9mLrWdjcXpdD5SRgK9bW5j/QeMQrtBI7cArflt8+zEeu40Vgc7j
 WnxS5KcqO2XMThhtA6Ce0HEZePq/oqdmmqhA4N/nWWIcvSR2lGSY05b3q9ozhpovtGCQSJzEq
 fdIRqCArfg/HIEXDqqdJ1T7ALhyjsW7U1CKHzylbYPtG1sKLRVpZkohg31WrUOk74I4y/1Ppg
 iP9HXX5lTKCEj3zZjJFxz6GtUxK6PQrOS2upETTsm0Z7wHDpbGf0jUpHk16akjtm3nNNiLwyS
 zAqJs6puUelg436/Sf3xa4Ls9dPt6htd3wC6s6jrbBapOXBQPeIUyuC7Mwe60I3JQlns/pZ4t
 txlgH41zXrExlrGR/64lG5LE/chCvgVy4Y0swEvxPfdpfG+gkB4j/zw8AhjKHA4xPSLd8zPRm
 f0phYA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.07.23 um 23:35 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>>  	if (item->attr_match_nr &&
>>> -	    !match_pathspec_attrs(istate, name, namelen, item))
>>> +	    !match_pathspec_attrs(istate, name - prefix, namelen + prefix, i=
tem))
>>
>> match_pathspec_item() has only one caller, and it did the opposite, so
>> this is safe.  And a minimal fix like that is less likely to have side
>> effects.  Removing the trick will surely improve the code, though.  If
>> match_pathspec_item() needs the full name then we should pass it on,
>> and if the "prefix" offset needs to be added then it can happen right
>> there in that function.
>
> Yup.  I am inclined to take this version and then update the
> proposed log message to put less blame on the "common prefix"
> optimization in general.
>
> Thanks.
>
> Just for completeness, this is with an updated log message.
>
> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
> The match_pathspec_item() function takes "prefix" value, allowing a
> caller to chop off the common leading prefix of pathspec pattern
> strings from the path and only use the remainder of the path to
> match the pathspec patterns (after chopping the same leading prefix
> of them, of course).
>
> This "common leading prefix" optimization has two main features:
>
>  * discard the entries in the in-core index that are outside of the
>    common leading prefix; if you are doing "ls-files one/a one/b",
>    we know all matches must be from "one/", so first the code
>    discards all entries outside the "one/" directory from the
>    in-core index.  This allows us to work on a smaller dataset.
>
>  * allow skipping the comparison of the leading bytes when matching
>    pathspec with path.  When "ls-files" finds the path "one/a/1" in
>    the in-core index given "one/a" and "one/b" as the pathspec,
>    knowing that common leading prefix "one/" was found lets the
>    pathspec matchinery not to bother comparing "one/" part, and
>    allows it to feed "a/1" down, as long as the pathspec element
>    "one/a" gets corresponding adjustment to "a".
>
> When the "attr" pathspec magic is in effect, however, the current
> code breaks down.
>
> The attributes, other than the ones that are built-in and the ones
> that come from the $GIT_DIR/info/attributes file and the top-level
> .gitattributes file, are lazily read from the filesystem on-demand,
> as we encounter each path and ask if it matches the pathspec.  For
> example, if you say "git ls-files "(attr:label)sub/" in a repository
> with a file "sub/file" that is given the 'label' attribute in
> "sub/.gitattributes":
>
>  * The common prefix optimization finds that "sub/" is the common
>    prefix and prunes the in-core index so that it has only entries
>    inside that directory.  This is desirable.
>
>  * The code then walks the in-core index, finds "sub/file", and
>    eventually asks do_match_pathspec() if it matches the given
>    pathspec.
>
>  * do_match_pathspec() calls match_pathspec_item() _after_ stripping
>    the common prefix "sub/" from the path, giving it "file", plus
>    the length of the common prefix (4-bytes), so that the pathspec
>    element "(attr:label)sub/" can be treated as if it were "(attr:label)=
".
>
> The last one is what breaks the match in the current code, as the
> pathspec subsystem ends up asking the attribute subsystem to find
> the attribute attached to the path "file".  We need to ask about the
> attributes on "sub/file" when calling match_pathspec_attrs(); this
> can be done by looking at "prefix" bytes before the beginning of
> "name", which is the same trick already used by another piece of the
> code in the same match_pathspec_item() function.
>
> Unfortunately this was not discovered so far because the code works
> with slightly different arguments, e.g.
>
>  $ git ls-files "(attr:label)sub"
>  $ git ls-files "(attr:label)sub/" "no/such/dir/"
>
> would have reported "sub/file" as a path with the 'label' attribute
> just fine, because neither would trigger the common prefix
> optimization.

Makes me wonder how important this optimization is, when this flaw went
unnoticed for ten years.

Using the latest main against on an old Chromium repository, because
it has lots of files:

   Benchmark 1: ./git -C ../chromium/src ls-files third_party/blink/web_te=
sts/external third_party/blink/web_tests/platform
     Time (mean =C2=B1 =CF=83):      37.8 ms =C2=B1   0.2 ms    [User: 28.=
3 ms, System: 8.4 ms]
     Range (min =E2=80=A6 max):    37.4 ms =E2=80=A6  38.7 ms    74 runs

   Benchmark 2: ./git -C ../chromium/src ls-files third_party/blink/web_te=
sts/external third_party/blink/web_tests/platform missing
     Time (mean =C2=B1 =CF=83):      48.4 ms =C2=B1   0.5 ms    [User: 38.=
5 ms, System: 8.7 ms]
     Range (min =E2=80=A6 max):    47.8 ms =E2=80=A6  51.9 ms    58 runs

     Warning: Statistical outliers were detected. Consider re-running this=
 benchmark on a quiet system without any interferences from other programs=
. It might help to use the '--warmup' or '--prepare' options.

   Summary
     ./git -C ../chromium/src ls-files third_party/blink/web_tests/externa=
l third_party/blink/web_tests/platform  ran
       1.28 =C2=B1 0.02 times faster than ./git -C ../chromium/src ls-file=
s third_party/blink/web_tests/external third_party/blink/web_tests/platfor=
m missing

We can see that the shared prefix optimization helps noticeably, even
though the measurements are noisy.

With your big patch 2:

   Benchmark 1: ./git -C ../chromium/src ls-files third_party/blink/web_te=
sts/external third_party/blink/web_tests/platform
     Time (mean =C2=B1 =CF=83):      38.0 ms =C2=B1   0.4 ms    [User: 28.=
3 ms, System: 8.5 ms]
     Range (min =E2=80=A6 max):    37.7 ms =E2=80=A6  40.3 ms    72 runs

     Warning: Statistical outliers were detected. Consider re-running this=
 benchmark on a quiet system without any interferences from other programs=
. It might help to use the '--warmup' or '--prepare' options.

   Benchmark 2: ./git -C ../chromium/src ls-files third_party/blink/web_te=
sts/external third_party/blink/web_tests/platform missing
     Time (mean =C2=B1 =CF=83):      48.5 ms =C2=B1   0.4 ms    [User: 38.=
5 ms, System: 8.8 ms]
     Range (min =E2=80=A6 max):    47.9 ms =E2=80=A6  50.6 ms    58 runs

     Warning: Statistical outliers were detected. Consider re-running this=
 benchmark on a quiet system without any interferences from other programs=
. It might help to use the '--warmup' or '--prepare' options.

   Summary
     ./git -C ../chromium/src ls-files third_party/blink/web_tests/externa=
l third_party/blink/web_tests/platform  ran
       1.28 =C2=B1 0.02 times faster than ./git -C ../chromium/src ls-file=
s third_party/blink/web_tests/external third_party/blink/web_tests/platfor=
m missing

The difference to main is small enough to get lost in the noise.

The one-line fix is nice and surgical, but I like the other one more.
Gets rid of crusty underutilized code that doesn't even seem to make
a measurable difference.

Ren=C3=A9
