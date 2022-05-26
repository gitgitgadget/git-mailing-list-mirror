Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52B7C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 09:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346835AbiEZJJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 05:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239996AbiEZJJp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 05:09:45 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE111FCC0
        for <git@vger.kernel.org>; Thu, 26 May 2022 02:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1653556157;
        bh=63HbYwbaiYE7eEjEXLzqOp0J76EIVn025mRXs/z6IDQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=j5MvL4011wKnc6h3uyXHCIr+ZK+p14E1ZiO+3+6JpmPo5gyG0E9WcP8YPWcJzjfrC
         lGxvDVYs74Ldjf/DW9wKw6hV3Bu2phToZmR188F+KF4SU6htmbI+V6ZHmzOdDAqPGs
         6Ge1OD9JUk3H6Ue8SNQ5cOLrW8VDd5ezLqcjrbMs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N79NA-1nmaLh2JBM-017J0G; Thu, 26
 May 2022 11:09:17 +0200
Message-ID: <7815a07a-da2f-d348-4179-6dc5b1d5fee6@web.de>
Date:   Thu, 26 May 2022 11:09:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v6 1/7] archive: optionally add "virtual" files
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>, rsbecker@nexbridge.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
 <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
 <0005cfae31d52a157d4df5ba3db9f9f5b2167ddc.1653145696.git.gitgitgadget@gmail.com>
 <xmqqfskx5ndd.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqfskx5ndd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ADdXO4uJrmwpV6aojqE8GViOyJxYJHi32PDZzVb/7sR1OYC/cYa
 R0xXiv47tznAJrF3Ejg1TrJPUMCX6MIivxwQ+rjt0uciihHJC1WdAEfvzVXEeEJntdm9QF+
 pDayQiWIrXXPH5kJioTijhthKop1tHgqX03ibrydtwtZfhIAE3fb9ipFiZQApoqbhzRaNOR
 i0oxpwqPUuwiDjDP9s3Qg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:44ZjoqnEjJ4=:IVDIazG6W+gV3o7T4eDN2Y
 0VlKC93rvIduQTEGxrQpADn+iT5m1SrxnE+Pk63aarT6nMd1cELaO82RAShPuiv3jK+mvYvPP
 2kCCHtcNJBQJ9DxaHl2pKTruCijD2LIVEKBcOPAC8py/8Y96XBT5uD1Eh6mLdZLKPc1xWYf9B
 r8a8wV1h69O4LfFZzKywhp3/lH790uJzBttg2Y6OSMOh81RT6NVt+DjDYr7vrGPAAJMKUOIlG
 XGfre4H1me640cLM+06To35A+Luer/V8G+mmiwqtRuMR8GLD4xwjEM709MixwHpfhLKoCPmXn
 20uBdll8ixQzrHbVRMdwPHrAnGhXv2fub0ajdPE0N+ZHbYiszfxQBtbWQ62OD3HZMM3kXMdM2
 ccnXSDAvlcG8gIpMo9DZRFfyFnsaoD2oqFuwKqvmLnInfgR2O+Y6/9L0H5Cu7yb6jB0+Xkjca
 Ec6NrPT3BsLPFa/G2CUXe3yZ2yjlSQCe8U+EGRxKF+KYaTU8h5vOsPCRUnXSp88Kkci6Tv+aQ
 g/X4ujDoE4Ump9N1UE5uSFr3nuxDP0CjkqcU7lvs5kK9jDmjPjOkDqaj8ToarTMVCvwDqv7XB
 PLfCh3K2ZSs60jCGQS+XpJZ2uMsGERrzwD1Wm/gBNy/VnYs9HqdcYrtIx7WMW2YJQcC1DLBUi
 l9LV5lQ3Y5irJBomwx+nDHFi4EOpEcQj4SPoG8NzZJJR30/6IGk3E1id6bqqlXAnRxMWAybtQ
 TPisM2lK2TIwigUqB0JtCVPbdcz2qt04yPDavo0cnvs7x9MXXG2rRxcbqUmHBNzgPK1cIHpbq
 OhGx/b5eMGJAanMsLsOgXgbNyixHz5tOwYloPE4ZbkSaBLBM8Unaudkt7R3vQV7gpI3m3lrCt
 rQGE6ayzLRIVWiRZaF7WFHQC0CIpFjGUTKQ4+RxNupJYQ1ezgvwjlbFxxJ9P79JLHm9i7E4y7
 pgo13SGOYp9mr+s+Klz7XmAvhXlIssuFqbVDSs7T6ssvhj2DW+4ks8JupRDqpP/o0JQRMbCoR
 qnhaHkVZGDBLEmuiScHZMwCEhp1OqV+OqmyWsz4a/tyDWyE59Mu1SB2xmSOv2cEsJda/IbvLn
 VXFz/WkaGXHs1C4OXuZqdSQMqe32GiYx5aX
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.05.22 um 23:11 schrieb Junio C Hamano:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> @@ -61,6 +61,17 @@ OPTIONS
>>  	by concatenating the value for `--prefix` (if any) and the
>>  	basename of <file>.
>>
>> +--add-virtual-file=3D<path>:<content>::
>> +	Add the specified contents to the archive.  Can be repeated to add
>> +	multiple files.  The path of the file in the archive is built
>> +	by concatenating the value for `--prefix` (if any) and the
>> +	basename of <file>.
>
> This sentence was copy-pasted from --add-file without adjusting.
> There is no <file>; this new feature gives <path>.
>
> Also, I suspect that the feature is losing end-user supplied
> information without a good reason.  --add-file=3D<file> may have
> prepared an input in a randomly named temporary directory and it
> would make quite a lot of sense to strip the leading directory
> components from <file> and use only the basename part.  But the
> <path> given to "--add-virtual-file" does not refer to anything on
> the filesystem.  Its ONLY use is to be used as the path in the
> archive to store the content.  There is no justification why we
> would discard the leading path components from it.

Good point.

>  I am not
> decided, but I am inclined to say that we should not honor
> "--prefix".
>
>    $ git archive --prefix=3D2.36.0 v2.36.0
>
> would be a way to create a single directory and put everything in
> the tree-ish in there, but there probably are cases where the user
> of an "extra file" feature wants to add untracked cruft _in_ that
> directory, and there are other cases where an extra file wants to go
> to the top-level next to the 2.36.0 directory.  A user can use the
> same string as --prefix=3D<base> in front of <path> if the extra file
> should go next to the top-level of the tree-ish, or without such
> prefixing to place the extra file at the top-level.

If the prefix is applied then a prefix-less extra file can by had by
using --prefix=3D or --no-prefix for it and --prefix=3D... for the tree,
e.g.:

   $ git archive --add-file=3Dextra --prefix=3Ddir/ v2.36.0

puts "extra" at the root and the rest under "dir".  The order of
arguments matters here, and the default prefix is the empty string.

So extra files can be put anywhere even if --prefix is honored.

Keeping the whole path from --add-virtual-file makes sense to me; I
slightly prefer applying --prefix on top of that for consistency.

Ren=C3=A9
