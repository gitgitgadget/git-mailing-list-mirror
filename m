Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F0FC43463
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 20:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D73312087D
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 20:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgIQU7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 16:59:46 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:61185 "EHLO bsmtp8.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgIQU7q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 16:59:46 -0400
Received: from bsmtp2.bon.at (unknown [192.168.181.107])
        by bsmtp8.bon.at (Postfix) with ESMTPS id 4Bsp9Z5VLSz5vqq;
        Thu, 17 Sep 2020 22:15:14 +0200 (CEST)
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Bsp9W6c8Rz5tl9;
        Thu, 17 Sep 2020 22:15:11 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 0A2E42100;
        Thu, 17 Sep 2020 22:15:10 +0200 (CEST)
Subject: Re: [RFC PATCH 2/2] core.fsyncObjectFiles: make the docs less
 flippant
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, tytso@mit.edu, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <87sgbghdbp.fsf@evledraar.gmail.com>
 <20200917112830.26606-3-avarab@gmail.com>
 <xmqqv9gcs91k.fsf@gitster.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <5b969f59-0006-8632-d040-6a816416f51a@kdbg.org>
Date:   Thu, 17 Sep 2020 22:15:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqv9gcs91k.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.09.20 um 17:43 schrieb Junio C Hamano:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
>> As amusing as Linus's original prose[1] is here it doesn't really explain
>> in any detail to the uninitiated why you would or wouldn't enable
>> this, and the counter-intuitive reason for why git wouldn't fsync your
>> precious data.
>>
>> So elaborate (a lot) on why this may or may not be needed. This is my
>> best-effort attempt to summarize the various points raised in the last
>> ML[2] discussion about this.
>>
>> 1.  aafe9fbaf4 ("Add config option to enable 'fsync()' of object
>>     files", 2008-06-18)
>> 2. https://lore.kernel.org/git/20180117184828.31816-1-hch@lst.de/
>>
>> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> ---
>>  Documentation/config/core.txt | 42 ++++++++++++++++++++++++++++++-----
>>  1 file changed, 36 insertions(+), 6 deletions(-)
> 
> When I saw the subject in my mailbox, I expected to see that you
> would resurrect Christoph's updated text in [*1*], but you wrote a
> whole lot more ;-) And they are quite informative to help readers to
> understand what the option does.  I am not sure if the understanding
> directly help readers to decide if it is appropriate for their own
> repositories, though X-<.

Not only that; the new text also uses the term "fsync" in a manner that
I could be persuaded that it is actually an English word. Which, so far,
I doubt that it is ;) A little bit less 1337 wording would help the
users better.

> 
> 
> Thanks.
> 
> [Reference]
> 
> *1* https://public-inbox.org/git/20180117193510.GA30657@lst.de/
> 
>>
>> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
>> index 74619a9c03..5b47670c16 100644
>> --- a/Documentation/config/core.txt
>> +++ b/Documentation/config/core.txt
>> @@ -548,12 +548,42 @@ core.whitespace::
>>    errors. The default tab width is 8. Allowed values are 1 to 63.
>>  
>>  core.fsyncObjectFiles::
>> -	This boolean will enable 'fsync()' when writing object files.
>> -+
>> -This is a total waste of time and effort on a filesystem that orders
>> -data writes properly, but can be useful for filesystems that do not use
>> -journalling (traditional UNIX filesystems) or that only journal metadata
>> -and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
>> +	This boolean will enable 'fsync()' when writing loose object
>> +	files. Both the file itself and its containng directory will
>> +	be fsynced.
>> ++
>> +When git writes data any required object writes will precede the
>> +corresponding reference update(s). For example, a
>> +linkgit:git-receive-pack[1] accepting a push might write a pack or
>> +loose objects (depending on settings such as `transfer.unpackLimit`).
>> ++
>> +Therefore on a journaled file system which ensures that data is
>> +flushed to disk in chronological order an fsync shouldn't be
>> +needed. The loose objects might be lost with a crash, but so will the
>> +ref update that would have referenced them. Git's own state in such a
>> +crash will remain consistent.
>> ++
>> +This option exists because that assumption doesn't hold on filesystems
>> +where the data ordering is not preserved, such as on ext3 and ext4
>> +with "data=writeback". On such a filesystem the `rename()` that drops
>> +the new reference in place might be preserved, but the contents or
>> +directory entry for the loose object(s) might not have been synced to
>> +disk.
>> ++
>> +Enabling this option might slow git down by a lot in some
>> +cases. E.g. in the case of a naïve bulk import tool which might create
>> +a million loose objects before a final ref update and `gc`. In other
>> +more common cases such as on a server being pushed to with default
>> +`transfer.unpackLimit` settings the difference might not be noticable.
>> ++
>> +However, that's highly filesystem-dependent, on some filesystems
>> +simply calling fsync() might force an unrelated bulk background write
>> +to be serialized to disk. Such edge cases are the reason this option
>> +is off by default. That default setting might change in future
>> +versions.
>> ++
>> +In older versions of git only the descriptor for the file itself was
>> +fsynced, not its directory entry.
>>  
>>  core.preloadIndex::
>>  	Enable parallel index preload for operations like 'git diff'
> 

