Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CBFC67871
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 07:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiJ0HJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 03:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbiJ0HJP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 03:09:15 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04DA152C46
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 00:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666854547; bh=5ZNWYBCGVqc89uGGmgMWV6XQN1C8UPtHrrBv8+2VUEA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=XM1NTIPc9T9zrslgLdn6GkyJ28OOfE1uET1OfLupGe0MxUEZvYJisWP+UjX+6oOWX
         7hajlzfPt9q7FM3VAl1c9WxqgwkTzZOm9HVC7TEL2b9UJ3iLHPEUYe7E4RPprt7d/c
         VKU2ElYBN0Vxw8ilPNfEN1GWg1xoDbWuJQytZ2F/WUPDupYQixkLydXHNIKxPYTZ+B
         vY8dClNNzlXCM2Jn5NbRnNW9N7T2p5+mhkbQmpUf0ly1fIsPPjQnEEuoEH9k1zw/6a
         1CmHXxD/fa2y+LGWVJdQop+T+0/1MKR+TWzn0th2ay5zJ+F1UTHsKvZVGnlWr2tkgw
         AjydcrknNzBQw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MKuKH-1oVaHe1lRF-00LGIc; Thu, 27
 Oct 2022 09:09:07 +0200
Message-ID: <fa90e7cf-4ddc-573a-1859-9e2b6b203f95@web.de>
Date:   Thu, 27 Oct 2022 09:09:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v3 8/9] archive: add --recurse-submodules to git-archive
 command
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>,
        Heather Lapointe via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Heather Lapointe <alpha@alphaservcomputing.solutions>
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
 <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
 <4672e3d958625cd76eb8056ab434e9a37f52661e.1665973401.git.gitgitgadget@gmail.com>
 <kl6lh6zqqhvm.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <kl6lh6zqqhvm.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZLLSQvo6fy6MtMU6kQbCZcHCYXWOvz3RUFUKPI77k6dB8ZtZMLE
 XBwcVjDX9RprnRA6GFYGLOU4W5zvd9h73t0p+E+vC4HJYxGuA9FVh3gvtnz2pOurnlsohFJ
 XBu0Smp9XrlNtb1UmAIFLmSW2uPCveOna+4bqoBSwkoFnmigOCNyz7BPU29g+gcrx8kZult
 BKKvoWyoBrBOK0Bkq1Y6g==
UI-OutboundReport: notjunk:1;M01:P0:nxA9RVCk2gQ=;uM26jrDRidQEDycpk4ZTDvdCvbY
 sa4Ee7V71EzwKWYqvqz4C556dh57xE12gWVZGDdR5mDAPB36tOj2Trp/Bo907Mb3zaEQi7FVe
 VTjyhEywmM08F8xJHdhzXopY26+ENqHLcwaImWBorD4fE0vUf2r5/71uJs6NkwLnWXfBmQY9j
 zg4ce6zoa7RlPdNyHLI5+uQNECWfDrw9uCG5/6nWjVSFna8uy7VZOzGRrrnov9fx2eUKgbfBG
 yDaxOdbQU8cNPWwjqv6eopTNY+foPv4hiKWGeyK47va0WZmgy9mxUnTKrTxcz3zYgQ6vmjtfa
 ZkPrdZiUmnhaaHQ7corodN3Jacp9dhjvlgS6Kzsctg3HGI1AtPXncbr0VTmNPk3Y+eTCFlrhI
 KKdDBYrGGR8ssOeO1Xcg2p1S1Yy1/bPk0XwaMT1Q0SIkwIzB+Vab0oC76hSadWz5QkJ6eQ/UW
 Jd2qPUZW7hv6vWWhU6xB2ON1qrXH46rbGsVeWeC4z80Yfqxesa62CXcTW45edwVxgiFKEBJek
 hKltaSWKO0xLghDNBPc+BupTBGH7e98nAIhA5q8W/nbHgLidEUufFxyViHDsf7mMPNPJgGq7a
 e3S+b8+pdbCiTemkYu0+3YDm1XtoJ4I+CXx04s9c8OKEamsFoMGFy0gSpbmpAIg44BMJ0M/WG
 mFa8k6WOx7Z7Vw5Php5Lch6GnVR8/BCnUCbomO8G3BEEiTAZcFMBKmCGqMKGO2Em1cB+/bZvu
 WNn9I7HXkhQs0R3RuGyaOccGiq3bJGy778lh721+LicKOW7nM0wmIz+vCSG45AiNS9v77NLtb
 n0zOFHIik1Z16uL+nQ0NuefNA5MeOoQSaCc59tn0bB0bkP2yRAg/QxFE3uc1YnOUafL/iVFmN
 do/7P25TFtRC2OIm3NWBHuucQD/hlz3AT3vbrykUY5QsVyaJxHfpVJ9x08fwwCWo6A2cPvWdk
 CNJGbsjt8/nozJ+KC4Qw/m60XRA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.10.22 um 01:34 schrieb Glen Choo:
> "Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> index 34549d849f1..f81ef741487 100644
>> --- a/archive.c
>> +++ b/archive.c
>> @@ -213,6 +214,25 @@ static void queue_directory(const struct object_id=
 *oid,
>>  	oidcpy(&d->oid, oid);
>>  }
>>
>> +static void queue_submodule(
>> +		struct repository *superproject,
>> +		const struct object_id *oid,
>> +		struct strbuf *base, const char *filename,
>> +		unsigned mode, struct archiver_context *c)
>> +{
>> +	struct repository subrepo;
>> +
>> +	if (repo_submodule_init(&subrepo, superproject, filename, null_oid())=
)
>> +		return;
>> +
>> +	if (repo_read_index(&subrepo) < 0)
>> +		die("index file corrupt");
>> +
>> +    queue_directory(oid, base, filename, mode, c);
>> +
>> +	repo_clear(&subrepo);
>> +}
>> +

> What's much more surprising is that you can delete the entire function
> body (even queue_directory()!) and the tests still pass! The tests are
> definitely testing what they say they are (I've also checked the
> tarballs), so I'm not sure what's going on.
>
> I commented out queue_directory() in the S_ISDIR case, and the only test
> failures I saw were:
>
> - t5000.68, which uses a glob in its pathspec. I tried using a glob for
>   in the archive submodule tests, but I couldn't reproduce the failure.
> - t5004.11, which is a really big test case that I didn't bother looking
>   deeply into.
>
> So I'm at a loss as to what queue_directory() actually does.
An archive doesn't strictly need directory entries.  If it contains a
file with a deeply nested path then extractors will create the parent
directory hierarchy regardless.  diff(1) won't notice any difference.
Directory entries are mainly included to specify the permission bits.

t5000.68 checks for the directory entries in the output given by the
option --verbose of git archive.  t5004.11 checks the number of archive
entries (including directories) using "zipinfo -h".

Ren=C3=A9
