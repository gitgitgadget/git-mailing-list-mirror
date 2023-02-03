Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEF2C61DA4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 16:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjBCQnT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 11:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjBCQnO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 11:43:14 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54A123305
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 08:43:12 -0800 (PST)
Received: from host-2-103-194-72.as13285.net ([2.103.194.72] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1pNz9a-0003am-Eo;
        Fri, 03 Feb 2023 16:43:10 +0000
Message-ID: <43d807f1-07f0-c0a1-e6ae-bdb5df73a565@iee.email>
Date:   Fri, 3 Feb 2023 16:43:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] .gitattributes: include `text` attribute for eol
 attributes
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20220216115239.uo2ie3flaqo3nf2d@tb-raspi4>
 <20230203125920.751-1-philipoakley@iee.email>
 <230203.86k00yc167.gmgdl@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <230203.86k00yc167.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/02/2023 13:40, Ævar Arnfjörð Bjarmason wrote:
> On Fri, Feb 03 2023, Philip Oakley wrote:
>
>> The standard advice for text file eol endings in the .gitattributes file
>> was updated in e28eae3184 (gitattributes: Document the unified "auto"
>> handling, 2016-08-26) with a recent clarification in 8c591dbfce (docs:
>> correct documentation about eol attribute, 2022-01-11), with a follow
>> up comment by the original author in [1] confirming the use of the eol
>> attribute in conjunction with the text attribute.
>>
>> Update Git's .gitattributes file to reflect our own advice.
>>
>> [1] https://lore.kernel.org/git/?q=%3C20220216115239.uo2ie3flaqo3nf2d%40tb-raspi4%3E.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.email>
>> ---
>>
>> I was catching up on last year's back emails, and had saved those on
>> eol and text conversion, and was prompted by Torsten's [1] to check
>> my .gitattribute files, only to discover, we aren't providing a good
>> example to others. Let's fix that. 
> This seems sensible, but if we're taking the churn of changing these
> lines maybe it's worth moving or adjusting some of this while-at-it.

Seems reasonable.
I've added in dscho (cc) for consideration of the Git for Windows
viewpoint..
>
> In particular:
>
>>  .gitattributes | 22 +++++++++++-----------
>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/.gitattributes b/.gitattributes
>> index b0044cf272..158c3d45c4 100644
>> --- a/.gitattributes
>> +++ b/.gitattributes
>> @@ -1,17 +1,17 @@
>>  * whitespace=!indent,trail,space
>>  *.[ch] whitespace=indent,trail,space diff=cpp
>> -*.sh whitespace=indent,trail,space eol=lf
>> -*.perl eol=lf diff=perl
>> -*.pl eof=lf diff=perl
>> -*.pm eol=lf diff=perl
>> -*.py eol=lf diff=python
>> -*.bat eol=crlf
> We don't have any *.bat in-tree except in compat/vcbuild/. Shouldn't we
> just create a compat/vcbuild/.gitattributes? This was added in
> https://lore.kernel.org/git/pull.149.v2.git.gitgitgadget@gmail.com/; so
> it's for those specific files.

sensible
>>  CODE_OF_CONDUCT.md -whitespace

Maybe the CODE_OF_CONDUCT.md should also be marked as text?

>> -/Documentation/**/*.txt eol=lf
>> -/command-list.txt eol=lf
>> -/GIT-VERSION-GEN eol=lf
>> -/mergetools/* eol=lf
>> -/t/oid-info/* eol=lf
>> +/Documentation/**/*.txt text eol=lf
> We have a Documentation/.gitattributes, shouldn't we move this
> Documentation/ rule there instead?

ok
>
>> +/command-list.txt text eol=lf
>> +/GIT-VERSION-GEN text eol=lf
>> +/mergetools/* text eol=lf
> ..maybe we should create a mergetools/.gitattributes & move this there?

perhaps. There are probably sufficient listed there to make it work it.
>
>> +/t/oid-info/* text eol=lf
> Ditto t/.gitattributes and this t/oid-info/ rule.
>
>>  /Documentation/git-merge.txt conflict-marker-size=32
>>  /Documentation/gitk.txt conflict-marker-size=32
>>  /Documentation/user-manual.txt conflict-marker-size=32
I'll hold a day or so for any extra contributions.

Philip
