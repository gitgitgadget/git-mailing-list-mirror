Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894C4C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 22:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCWWCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 18:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCWWCT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 18:02:19 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3011A4BA
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 15:02:15 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i13so13977752lfe.9
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 15:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679608933;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=prZ/x7yz5XF2Z9T7VObe+DQyNqynoN77vYroTQSdpbA=;
        b=iOcn8JjoaXIVcn/uXxjhnGnem/MKM7OyWYQtmzv7qeYk3ghn310Wfms1HoMsCOK1MC
         tyMSbrOAgaj3Ga0ukoxzvfDMcBau8dKbOXi0d7PwrRWFWmVOnJi5Td/BZcoYQFygiezP
         ZOCj4e08Hm5POtL/BMflbOgmt89b4MF+fRQDe2SrOSczskxDwim/aXn9Yeu142V1ajv9
         UlYtAiB5VGBL9FEFlFdRxSQyMC5CNp0oPrN4ux6TfXwXKej/k3T2lhMByKKaVM8/dnQ+
         J1SFfo+lOCnXd6QbE06AycJAnY5yR80zXny9RduPV8Mc3ROdxXEkzWZ+uOx5+JdpAEjk
         eTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679608933;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=prZ/x7yz5XF2Z9T7VObe+DQyNqynoN77vYroTQSdpbA=;
        b=3AwxwBdtd45brZtcElbv2u2McPm2hGOwCKgkoNodWQpgyOe52dA2KZrSF7psqUg/pI
         QG7M1kpxzAfSp92B5tpJPv2xP87STABLqE541DCVpC8DpLnVrnIYyoKqYHWMFAgmlk6i
         2ZnbRMt9vD7Q5tROGDTq2O/qoUv6jhEuAm6wjh5Oqq0BrdyIK2gzcZw6OsE3WGRfwdmp
         dzZs2JrQDudRTk/1D+QmVW4gAXGwIzfB9lwKq6hndt1uovGZnExCvxvAE5z9jhH3O5fR
         eJM6cvWQhpZWRVcCS/j+otFX0ChQlKCW/CWLJPp7wPqzazOxe5IWdVRZhcjs3ExLuKR/
         XTDA==
X-Gm-Message-State: AAQBX9fWFMiJo9WeBXrjllvavBRfeLjaTS58MmZE8QJaxHzofhi6jd9X
        k7GIScyUUM1R0TegfBueNJo=
X-Google-Smtp-Source: AKy350blI6+uEqwASgq6/yC4FwBhkUNhGnyGg60G2heMUUrchQ3lG09bKFr1dyAXtwgqVVNgQ24Spg==
X-Received: by 2002:ac2:4184:0:b0:4d5:c996:2940 with SMTP id z4-20020ac24184000000b004d5c9962940mr41447lfh.61.1679608932969;
        Thu, 23 Mar 2023 15:02:12 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (178235188095.dynamic-4-waw-k-3-0-0.vectranet.pl. [178.235.188.95])
        by smtp.gmail.com with ESMTPSA id f21-20020ac251b5000000b004eaf2207a33sm1081549lfk.223.2023.03.23.15.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 15:02:12 -0700 (PDT)
From:   Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: What is the status of GSoC 2022 work on making Git use roaring bitmaps?
References: <858rfnb770.fsf@gmail.com> <ZBy18EBE7WM/E4KF@nand.local>
Date:   Thu, 23 Mar 2023 23:01:46 +0100
In-Reply-To: <ZBy18EBE7WM/E4KF@nand.local> (Taylor Blau's message of "Thu, 23
        Mar 2023 16:26:24 -0400")
Message-ID: <851qlfazzp.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Taylor,

Thanks for a fast response.

Taylor Blau <me@ttaylorr.com> writes:
> On Thu, Mar 23, 2023 at 08:26:11PM +0100, Jakub Nar=C4=99bski wrote:
>> Hello,
>>
>> Could you tell me what is the status of the Abhradeep Chakraborty work
>> in integrating roaring bitmaps (using CRoaring) in addition to, or
>> replacing current EWAH bitmaps (using ewok)? The last communication
>> about this shows that the patches were on the road to being merged in,
>> see e.g. https://medium.com/@abhra303/gsoc-final-report-feaaacfae737 ,
>> but there is no mention of 'roaring' in Git's code or documentation.
>
> Abhradeep started working on a prototype to teach Git how to read and
> write Roaring+Run bitmaps in this series:
>
>   https://lore.kernel.org/git/pull.1357.git.1663609659.gitgitgadget@gmail=
.com/
>
> Some folks gave it a review, but there wasn't any serious traction and I
> don't think that Abhradeep has had a chance to come back to the series.
>
> For what it's worth, I would love if Abhradeep (or anybody else
> interested in working on this area) picked it back up, either using that
> series as a starting point or going from scratch.

When I searched the mailing list archives, the thread was never continued.

>> Moreover, there is no proposal to finish this on the GSoC 2023 ideas
>> page: https://git.github.io/SoC-2023-Ideas/ .  Is it because it would be
>> too small of a project?  Or maybe it turned out that roaring bitmaps
>> were not a good idea - though I haven't found mentions of any benchmarks
>> of roaring vs EWAH in the mailing list archives?  Or perhaps there is no
>> one to mentor this proposal?
>
> I don't have the capacity to mentor a student this cycle, and I am
> probably the most interested among potential mentors in seeing this
> project through ;-).

Ah, so it is mostly the last issue - lack of a potential mentor for
conntinuing this project.

> I don't think that it's too small (in fact, it was probably an error on
> my part to include this as a potential stretch goal in Abhradeep's
> project). We don't have any evidence that it's a good or bad idea.
>
> Abhradeep promised[1] that he'd include some performance work in his
> next version of that series. I think the main things we'd be interested
> in are:
>
>   - Does using Roaring provide a file-size advantage over
>     EWAH-compressed bitmaps?
>   - Does Roaring make it faster to inflate bitmaps? To deflate them?

As far as I understand it, after reading articles about EWAH[2] and
about Roaring Bitmaps[3][4], the Roaring have the advantage that you
don't need to decompress (inflate) bitmaps to perform bitwise operations
on them.

Run-Length-Encoding (RLE) formats like EWAH can be made to perform
operations without decompressing, but only if operations are symmetric.
The AND and OR operations are symmetrical, but AND NOT is not.  The last
is used by Git to find "want"-ed that are not present (not "have") is
not.  That is why Git needs to decompress bitmap and perform operation.

If I understand it correctly, for both cases (EWAH and Roaring) you can
do membership check without decompressing bitmap.


[2] Daniel Lemire et al. "Sorting improves word-aligned bitmap indexes",
    arXiv:0901.3751

[3] Samy Chambi, Daniel Lemire et al. "Optimizing Druid with Roaring
    bitmaps", https://dl.acm.org/doi/10.1145/2938503.2938515
[4] Daniel Lemire et al. "Roaring Bitmaps: Implementation of an
    Optimized Software Library", arXiv:1709.07821v3

>
> Deflating bitmaps doesn't matter as much, IMHO, since that is a cost
> that we pay only when we first have to compress bitmaps before writing
> them. But if we could significantly reduce the inflation cost, that
> would be an advantage to using Roaring+Run bitmaps over EWAH ones since
> they would be faster to decompress at read-time.

Well, if Roaring were to be significantly slower when deflating, but
only slightly faster when using / inflating, that would affect their
evaluation.

>
> [1]: https://lore.kernel.org/git/CAPOJW5wkXrV8eOysz6aJ5jN2u_u-iTX_3om3tSD=
Kw+EmfCJBEw@mail.gmail.com/

Regards,
--
Jakub Nar=C4=99bski
