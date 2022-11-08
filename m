Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21604C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 03:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiKHDlb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 22:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiKHDla (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 22:41:30 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B6417A9C
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 19:41:28 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x2so20601417edd.2
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 19:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cqZdJlbDQI81NV18hFY0su+NHYoX4prnWTImcjiLB8Y=;
        b=RqcPCLNXZ7/fmm5OGcKvJPCgrmkOGZQtG0H6KAcbJj7pYQy0apNbyMORjzSNSl2M0j
         As8RubjKJU4j45CVzy8kRYucmC372ABN+0tKRXMocqgiHlUzCPyo1xgdcDv/j2gtt6lK
         YxNq0nhzrrlvYhiv4V5bkv0aF0at3qicIDaTbC8PNReYkEBaGk/gGVhTgjh+wQBehd5B
         CR6uAYrx2Drl+9UgKasVm+R21MFcwKaKQC+h/lpqgBMOm6Im3GMiTTOBBM0fODt1BaNT
         w3lIDcaZJNNmwHb0ZGUymU6zqScom6+smbMX6HrZCJv3GjbGayDRsHICp5FQf9nQQurz
         9Okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cqZdJlbDQI81NV18hFY0su+NHYoX4prnWTImcjiLB8Y=;
        b=roTwS1LsNU2Sh8L+YJD9Wz1Zt+gIdABArgFvY1i92WWG2vwVLwUtHuW8ixrdidW8Xi
         m6ATW6PWltSx4o09lkBVf+nmpL5u7/vRzPXJgGcpOcnhD5trbpDA01bUZIreY47aBmIs
         TU5lJfG0kOZUMZwwyRv0pNUKwB/+6qZxigRlyQbafM7y1kRM7SVRs2X92jQULcoe7e8x
         1WqvKWsS9POboN8jobV/3vNqXPiKISndwET8ZsEGkTaE6orGOBMBgWyVcTXmbO0IpGW5
         2t3Q2bvH3d0Tjh555NpLjzH94pLZRZtf6cXKl+m888AcKv6aDULJzkJyFH9mH9Xis08k
         uiFw==
X-Gm-Message-State: ACrzQf2s2wfPuVae/R4OcpCkmv0teXtterb6+UfXUEoF/6X0vbinVaCu
        MtDfxoFmD6Ue7ULy0mjvj98=
X-Google-Smtp-Source: AMsMyM4+AeBlkehX17qyXT8v4iZzNqLJL3yYMs0sdQTa3dK8Nmm0PmLfn2+C1N4buO3E/byisO7ROQ==
X-Received: by 2002:aa7:dd45:0:b0:458:7474:1fbe with SMTP id o5-20020aa7dd45000000b0045874741fbemr53958933edw.334.1667878887416;
        Mon, 07 Nov 2022 19:41:27 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906584600b007acc5a42e77sm4127245ejs.88.2022.11.07.19.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 19:41:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osFUM-000VWc-1Z;
        Tue, 08 Nov 2022 04:41:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Matti =?utf-8?Q?M=C3=B6ll?= <Matti.Moell@opensynergy.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Jonas Bernoulli <jonas@bernoul.li>,
        git@vger.kernel.org
Subject: Re: "submodule foreach" much slower than removed "submodule--helper
 --list"
Date:   Tue, 08 Nov 2022 04:37:55 +0100
References: <Y0r4US7AKxT/BLiY@coredump.intra.peff.net>
 <xmqqwn904sof.fsf@gitster.g>
 <b5017077-720b-3085-39f0-54dc6b6fcaf6@opensynergy.com>
 <Y2nD9AR8acaGLXDH@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2nD9AR8acaGLXDH@nand.local>
Message-ID: <221108.86tu3aru3d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 07 2022, Taylor Blau wrote:

> On Mon, Nov 07, 2022 at 12:01:40PM +0100, Matti M=C3=B6ll wrote:
>> On 16.10.22 00:40, Junio C Hamano wrote:
>> >
>> > If one likes the output from "submodule--helper list" so much, I
>> > think your "ls-files" above should be the closest.  There seems to
>> > have existed some logic to squash unmerged entries down to a single
>> > one, too (git-submodule.sh in Git 2.0.0 era has a module_list shell
>> > function that shows what "helper list" should be doing), though.
>>
>> I do actually like that submodule is hoisted out of the scripts but as a
>> matter of fact it seems that the openembedded folks relied on the
>> "submodule--helper list" call and with later git versions that doesn't w=
ork
>> anymore.
>>
>> https://github.com/openembedded/openembedded-core/commit/6d9364e5f353595=
4f65cbbc694ee7933ac1d664f
>>
>> At the end of the day it's kinda their fault to depend on the
>> submodule--helper but it does hinder adoption of new git versions for pe=
ople
>> using openembedded.
>
> Yeah, I agree. It's unfortunate, but I think we consider anything with
> '--' in the builtin name to be outside of our compatibility guarantee.
>
> I recall a recent message on the list which where Junio said as much,
> but I can't seem to find it :-<.

We've never even documented it, so the uses that have been made of it
have been the result of source spelunking.=20

B.t.w. the openembedded commit above using "git config" is not going to
get the same results as "git submodule--helper list", or the equivalent
"git submodule foreach", but perhaps it works well enough for what they
need it for...
