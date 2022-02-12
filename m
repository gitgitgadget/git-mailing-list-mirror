Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C9CC433EF
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 09:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbiBLJMm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 04:12:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiBLJMm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 04:12:42 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E845126562
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 01:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1644657151;
        bh=NAYHWVAhoN9H69IgcRX9a0CprZtFzHzVvG7A1W4pFYA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=JzrOA0uk5T2WI3Tv6h0uYowIV4k4kfjadqnxZXVIZ84TuwUZ5yoGGFEKxbZeR5p+S
         ou+qiGLCkT6Bl+NmyJBCIYKBA8pTPPgwaHtFxXhz7E7ntGKCDe90H54Rqwqm242G+C
         ufLXtjfuSUtgMUiUtM3/mNn2bpIAqjqiqgIdznlo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.158]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTvw0-1niYlZ2ndy-00R460; Sat, 12
 Feb 2022 10:12:31 +0100
Message-ID: <b05f916c-4b04-4db6-d203-10be0a8eb615@web.de>
Date:   Sat, 12 Feb 2022 10:12:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v2 1/6] archive: optionally add "virtual" files
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1128.git.1643186507.gitgitgadget@gmail.com>
 <pull.1128.v2.git.1644187146.gitgitgadget@gmail.com>
 <49ff3c1f2b32b16df2b4216aa016d715b6de46bc.1644187146.git.gitgitgadget@gmail.com>
 <d1e333b6-3ec1-8569-6ea9-4abd3dee1947@web.de> <xmqqbkzigspr.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2202081406520.347@tvgsbejvaqbjf.bet>
 <xmqqbkzhdzib.fsf@gitster.g> <b49d396d-a433-51a4-2d19-55e175af571a@web.de>
 <xmqqk0e364h7.fsf@gitster.g> <6f3d288a-8c2f-0d63-ea17-f6c038a9fa3e@web.de>
 <xmqqk0e2frux.fsf@gitster.g> <f83ed995-6dff-bc41-8782-48ac9f1a2651@web.de>
 <xmqqk0e19jrp.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqk0e19jrp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vqQ8vBSp4c16GnwnBr8QDE8hiMMHLyDj/t49J8EElK2rMHBozzp
 hcDibZ4IfDA7VDHQ3H8wM5vCDgSoceR4VTQMAuasPwqMM8e2/O3f1k2F410K5nHo4Uc6B4M
 sjlPiuDrQOccgVq60RRGEUwpscbj6g49ioc4+r8V9hHGHV9Nd7iHIrgJkCUa1IFLdYYIOQL
 9y1t62gteIG884IxfJMHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/ouHIeEIkUw=:b/wMhIf3PpotitT5FLntAR
 NoECrwY38S405OCB0TlnTaf9cEpfUxxfwA9aW1A8YMBe8/9/j9tS3Q9/w0v4msBYTvoInav0e
 2+YHKN4y2TQGN6iJvuCC739DQ/Kmm6pPAnLNwLonDjKTzMLa91zT+QIoRTdumLjgisBdFw34b
 BqOPmbJ3xlnHG1LTSLONS3agS/vewtVxSQRlbbp6Q/ucOjxwUXbdM4LaHYsYZqAtNhLexCpIp
 PHSzjLvTrI6UBHvBkFKyQCsjo3RLE6RngfyAlfJO4iE2yJVtUQl9WLUHABDvDxSgIEqAZ/juF
 +AcdcktOBPQzS16FtNY5Lx7SYtf6TBSyIjT9s8x62wMB83duht0DB6Z470V9ZIN7pzIlTCuWz
 Ug8MS387FNiXZDa1GCZZjGucx0cLgQFzTGhw4PjtOACCl5nbuZYN12QIq8oZWcb+63dkx6G3Z
 pcps57JwvhVcF2CNxT7OQtwO5JHrYCcj2Zc3jhSceYpv/+5Jx7tw5jvhBef+R487DEpn6fCvQ
 vy1FUHbcwu61JRtPKlbiS/eJyElqgdREzlNycCA7R3j2g1JBM4Pr2xRIG5vZI2lFgvX5rp6cv
 1qKCkosDJJ+9LoL+SLy2W0qirIwQ2OxCocHg4eI0QLsspYYl4RJEyY7/NWNZBMjd4zU+LIGaw
 +mPQtKCoc2mMnXgTazHpgjbbriLNdQQj9L2h80/UzX+1DDQNkoDx83zDdWDDF/aux0m4FiAzj
 S2nOGma12ZzDdhhuBddNXsAjqFOV41JgATDsNQxqPXHNK7v0aMUGWNF10TLjFRRXvPyYiWN/S
 ftEGCtKDIc/qTNDDBdqhVPrx9GCf7EEuUBI95zFP5DH4VzEv2Qf4GOg4tw4yFNpr8FC/X1ic8
 1GvIymFa1T+zA01+Tvz2S0vxRZmhhLwaGWmV073lpS9JpngvvhiMO1y5Mhiym5w2SvzumgPh6
 9S4K+71tIkvYzoBOJvv8hqc4Eg6mGDbEEPcd308lxjV5lp8hdrZdTJC7xcO44FCzeJShGmb7i
 ypkmx09DT8tsNDgesVZH9fCHsQkQYO1gQ/bLgcyekWbCfN6+L6y42yv4/NPyRUdZ/oQDyUicT
 NGFHw7MKaiW4PM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.02.22 um 22:27 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>> Or if people do not _exclude_ tracked files from the archive, then
>>> the verifier who has a tarball and a Git tree object can consult the
>>> tree object to see which ones are added untracked cruft.
>>
>> True, but if you have the tree objects then you probably also have the
>> blobs and don't need the archive?  Or is this some kind of sparse
>> checkout scenario?
>
> My phrasing was too loose.  This is a "how to verify a distro
> tarball" (without having a copy of the project repository, but with
> some common tools like "git") scenario.
>
> The verifier has a tarball.  In addition, the verifier knows the
> object name of the Git tree object the tarball was taken from, and
> somehow trusts that the object name is genuine.  We can do either
> "untar + git-add . && git write-tree" or its equivalent to see how
> the contents hashes to the expected tree (or not).
>
> How the verifier trusts the object name is out of scope (it may come
> from a copy of a signed tag object and a copy of the commit object
> that the tag points at and the contents of signed tag object, with
> its known format, would allow you to write a stand alone tool to
> verify the PGP signature).

Right, but the tree hash does not directly allow to see which objects
are tracked or not.  This information is necessary to reconstruct the
signed tree.  (Having tracked files first, then the signature file and
then untracked files in the archive would be an easy way to transmit
it.)

> Line-end normalization and smudge filter rules may get in the way,
> if we truly did "untar" to the filesystem, but I thought "git
> archive" didn't do smudge conversion and core.crlf handling when
> creating the archive?

git archive uses convert_to_working_tree() to archive the same file
contents as tar or zip would.

Ren=C3=A9
