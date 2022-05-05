Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67FFC433EF
	for <git@archiver.kernel.org>; Thu,  5 May 2022 21:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385483AbiEEVIF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 17:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiEEVID (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 17:08:03 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7B25EBE2
        for <git@vger.kernel.org>; Thu,  5 May 2022 14:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1651784645;
        bh=FQ5mT7si7XwZBiNg1yeYHFkVo643uT8nq29X+rbFSqg=;
        h=X-UI-Sender-Class:Date:From:Subject:To:Cc:References:In-Reply-To;
        b=PvyUQri7NPYQLAtRxKY6jqTtFvcF9klUZYLDeptdJ29B+5m2NufcimtkEDA4OlNS+
         +YJtg4wA8V6AgkKzOqlCJLWOE1S2NDjDUoINHf31qOXxk03SYGLxgFchVEnUWbmQpW
         ZQOiIqvJW3JBWpmIdV/kHmddHmIuFqSKFAvY1bZ8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzTLO-1o06fE3SMa-00vQuT; Thu, 05
 May 2022 23:04:04 +0200
Message-ID: <0d78c98a-841e-719b-add3-acc7a7a2d7c6@web.de>
Date:   Thu, 5 May 2022 23:04:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: Git status extremely slow if any file is a multiple of 8GBi
To:     Jason Hatton <jhatton@globalfinishing.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <CY4PR16MB16558FE8E69B2045435AD59DAFC39@CY4PR16MB1655.namprd16.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <CY4PR16MB16558FE8E69B2045435AD59DAFC39@CY4PR16MB1655.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fyACanhEJm8MrKzhIJusmzyTZz2oL9CrXcGcflYD9G6YABSDTeX
 ULdp26uVQoJtKdobLMK5kJOQEXhnlpDUXwP0m7FyH6rQy3eWZRBE2cKwUWy8foxdIs4rEHJ
 JNeDhdEJbkkjVsBndzn1s3GaO7cxxEwF++Y4h9MYB45qrhiRZqaQPxIKPBauEufvRFR/nw2
 KJXC/dT9Utipld43hLYXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RsmSka1Dok8=:jNpUdoRSD6TzeLMYTYOhGz
 o/vFO7ymnKUmp5fY90mf4fAot2l0kf3gL/ojIkaiFG4RVRMJWRNecfwzarhSLYMBD6c9+xWnW
 FY8TMTub0e3rwGTI1mvJFH5tdBVpcCSkCldfi5x865D0f78mZvDE8utQ3yG04LgBh16Bl6UW2
 ElOOm+aQ3Ld0CoBlKw9GKur/6nBPFOEMMicdHn/3XGy5X4xscQ8ESvUdQ+ShLQvWqQ6qCnPF2
 UWrCe7mwiq2LexadE2nTyt1iQqvPpBvIraiIxZUuucDCpk+E5/0Ghm5IR1WanJpsE6l9h6mgh
 sU/rOCOMwSdAkpr9hib6Buwl8R6VV+e1/sbdihn+4IkJS1gTY1MQAepqO31ERrac7T+bZWA+A
 F0ZyXX3LMYFb1zHPirRfE5hbPG9BGUrylsjAxGT1sXBQlPbEXPrlNXcQ04WuAx3puUf7kzxSw
 dR1/oOaV4+Kogy/6iQ3t8IFhKmse3QiFikFAKMsLzQNPhPIj0ePbRJiXwkaX4k1SYGOIQE+Vo
 XuOXRYHrE0cH4PCKfU3IACgAJyB3iwOj7KgWuM4vA3/yxvYI5d1uaaLstpbD6orsMfN/+ilDP
 P4Zt6GlyUUyu2opWbATEHjisy7K6h5vSejHlgT68Z47iyySRYbgfuWzFWwePInc7WrTNjA+Wp
 HcC+8nw20UwD9PkHVSxetmU7/83KsIvAZ5lgY09xsxlqBQSJW68P3q4Cuw8VcJoChD9I73AMP
 IForY1qeKasdx1Adu6zlgvXUJZ6IMeIBIc3ASKdiRhJ01IbdzSoYmECcjqQNzdDmnOGQwmur3
 bR3dcw3yeaJHsUnG6lfBXnsxqmJ6D/gVkmJ4Lbz2kjd9u0BY5xxCCODMth+JQCgBNu3rpXIbk
 RJbFPVvS2MhwCS1DAq5+7prs54V+a4m7rY35pzoQvPTRfxh7K522omeWdOFCH31/GBAzsuqzt
 uMrT6dCfihpWDNmd8L8RkkMeCsvoAvAn9fDT7O0+cl531+r/9qCv3Pp4TB3KwuOTZu9v9+i86
 P82hdJvHTxh7mYqeDh1KSzHNmJ89tiv+nvYV/+i77fbX4KKPM8dkhXn2DyEfLibNhg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.05.22 um 19:47 schrieb Jason Hatton:
>>> The condition sd_size=3D=3D0 is used as a signal for "no, we really ne=
ed
>>> to compare the contents", and causes the contents to be hashed, and
>>> if the contents match the object name recorded in the index, the
>>> on-disk size is stored in sd_size and the entry is marked as
>>> CE_UPTODATE.  Alas, if the truncated st_size is 0, the resulting
>>> entry would have sd_size=3D=3D0 again, so a workaround like what you
>>> outlined is needed.
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> This is of secondary importance, but the fact that Jason observed
>> 8GBi files gets hashed over and over unnecessarily means that we
>> would do the same for an empty file, opening, reading 0-bytes,
>> hashing, and closing, without taking advantage of the fact that
>> CE_UPTODATE bit says the file contents should be up-to-date with
>> respect to the cached object name, doesn't it?
>>
>> Or do we have "if st_size =3D=3D 0 and sd_size =3D=3D 0 then we know wh=
at it
>> hashes to (i.e. EMPTY_BLOB_SHA*) and there is no need to do the
>> usual open-read-hash-close dance" logic (I didn't check)?
>
> Junio C Hamano
>
> As best as I can tell, it rechecks the zero sized files. My Linux box ca=
n run
> git ls in .006 seconds with 1000 zero sized files in the repo. Rehashing=
 every
> file that is a multiple of 2^32 with every "git ls" on the other hand...
>
> I managed to actually compile git with the proposed changes.

Meaning that file sizes of n * 2^32 bytes get recorded as 1 byte instead
of 0 bytes?  Why 1 and not e.g. 2^32-1 or 2^31 (or 42)?

> It seems to correct
> the problem and "make test" passes. If upgrading to the patched version =
if git,
> git will rehash the 8GBi files once and work normally. If downgrading to=
 an
> unpatched version, git will perceive that the 8GBi files have changes. T=
his
> needs to be corrected with "git add" or "git checkout".

Not nice, but safe.  Can there be an unsafe scenario as well?  Like if a
4GiB file gets added to the index by the new version, which records a
size of 1, then the file is extended by one byte while mtime stays the
same and then an old git won't detect the change?

> If you people are
> interested, I may be able to find a way to send a patch to the list or p=
ut it
> on github.

Patches are always welcome, they make discussions and testing easier.

Ren=C3=A9
