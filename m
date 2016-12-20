Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A93DA1FF6D
	for <e@80x24.org>; Tue, 20 Dec 2016 11:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759616AbcLTLJo (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 06:09:44 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34292 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757845AbcLTLJm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 06:09:42 -0500
Received: by mail-qk0-f196.google.com with SMTP id t184so3858426qkd.1
        for <git@vger.kernel.org>; Tue, 20 Dec 2016 03:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c53au1llwHAoxbAGmjKW+icKiHXGY/u6nEk9F0PurF4=;
        b=fkA6fEfgrO3FEnoaz4HefwsQu8F8gM6gzpFivAQ4gmQM8APnpWTLKmcHise1OF0JAJ
         TnueZ30JSqImkSrFi4IkNpZB/VYkunuh97hlTQuXBz4E2NaPm2YEAGgFvbkXRvgc+HvE
         iqUBh6EzMEboQMFrbnhrHWLmVjMgYZu6u3LGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c53au1llwHAoxbAGmjKW+icKiHXGY/u6nEk9F0PurF4=;
        b=HuK7Q2IlPiCcVewvdFDxeytdrPO0Bdsb96Sto7viqiQFXJSuA787P9O1oXSUfYLwSm
         ZOjPQQqbvwEd/2A4uwpHowJfenniRL4a1icPoOqY5kpBJoh7heB9zaW+gArr1PGsX+/0
         JsNh8Zw8veQKa8X3bf8wdzgVhOhxo5f+99coOA+yvTJwHcWIM5a9hVCJPepnGBUuuLvQ
         Sn7LT5AmmhztarHdeAFU3o7J8GmkCM5h5VuxBAsmBdu4WqNr65DyE+mCtIIBRoxeez6F
         eErSdu9cudgMngxO3u1QfIgsBEiR6MZ39cBWjVGw3Z8AhzH1g6ZSiD8g8f8EWnW5soTI
         WMGQ==
X-Gm-Message-State: AIkVDXJwy69A1/scAaMzhgbxAIfYFh49ySjvUEFSbPM2dYYrQnTaSuQ2nsMp55k0wT3xXx26Lztk3h6TOCpiQQ==
X-Received: by 10.55.144.70 with SMTP id s67mr5330131qkd.290.1482232181414;
 Tue, 20 Dec 2016 03:09:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.47.111 with HTTP; Tue, 20 Dec 2016 03:09:41 -0800 (PST)
In-Reply-To: <xmqqy3zbmwu5.fsf@gitster.mtv.corp.google.com>
References: <20161218190140.3732-1-larsxschneider@gmail.com> <xmqqy3zbmwu5.fsf@gitster.mtv.corp.google.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 20 Dec 2016 11:09:41 +0000
Message-ID: <CAE5ih79CyeEM0DZXBmrY6tSVD6Y-iMY0Wc6d8Wm1e=rT2zY-yQ@mail.gmail.com>
Subject: Re: [PATCH v1] git-p4: add diff/merge properties to .gitattributes
 for GitLFS files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19 December 2016 at 21:29, Junio C Hamano <gitster@pobox.com> wrote:
> larsxschneider@gmail.com writes:
>
>> From: Lars Schneider <larsxschneider@gmail.com>
>>
>> The `git lfs track` command generates a .gitattributes file with diff
>> and merge properties [1]. Set the same .gitattributes format for files
>> tracked with GitLFS in git-p4.
>>
>> [1] https://github.com/git-lfs/git-lfs/blob/v1.5.3/commands/command_track.go#L121
>>
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>
> Thanks.  Luke, does this look ok?

Yes, looks good to me.

Luke


>
>>
>> Notes:
>>     Base Commit: d1271bddd4 (v2.11.0)
>>     Diff on Web: https://github.com/git/git/compare/d1271bddd4...larsxschneider:e045b3d5c8
>>     Checkout:    git fetch https://github.com/larsxschneider/git git-p4/fix-lfs-attributes-v1 && git checkout e045b3d5c8
>>
>>  git-p4.py                 |  4 ++--
>>  t/t9824-git-p4-git-lfs.sh | 24 ++++++++++++------------
>>  2 files changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index fd5ca52462..87b6932c81 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -1098,10 +1098,10 @@ class GitLFS(LargeFileSystem):
>>                  '# Git LFS (see https://git-lfs.github.com/)\n',
>>                  '#\n',
>>              ] +
>> -            ['*.' + f.replace(' ', '[[:space:]]') + ' filter=lfs -text\n'
>> +            ['*.' + f.replace(' ', '[[:space:]]') + ' filter=lfs diff=lfs merge=lfs -text\n'
>>                  for f in sorted(gitConfigList('git-p4.largeFileExtensions'))
>>              ] +
>> -            ['/' + f.replace(' ', '[[:space:]]') + ' filter=lfs -text\n'
>> +            ['/' + f.replace(' ', '[[:space:]]') + ' filter=lfs diff=lfs merge=lfs -text\n'
>>                  for f in sorted(self.largeFiles) if not self.hasLargeFileExtension(f)
>>              ]
>>          )
>> diff --git a/t/t9824-git-p4-git-lfs.sh b/t/t9824-git-p4-git-lfs.sh
>> index 110a7e7924..1379db6357 100755
>> --- a/t/t9824-git-p4-git-lfs.sh
>> +++ b/t/t9824-git-p4-git-lfs.sh
>> @@ -81,9 +81,9 @@ test_expect_success 'Store files in LFS based on size (>24 bytes)' '
>>               #
>>               # Git LFS (see https://git-lfs.github.com/)
>>               #
>> -             /file2.dat filter=lfs -text
>> -             /file4.bin filter=lfs -text
>> -             /path[[:space:]]with[[:space:]]spaces/file3.bin filter=lfs -text
>> +             /file2.dat filter=lfs diff=lfs merge=lfs -text
>> +             /file4.bin filter=lfs diff=lfs merge=lfs -text
>> +             /path[[:space:]]with[[:space:]]spaces/file3.bin filter=lfs diff=lfs merge=lfs -text
>>               EOF
>>               test_path_is_file .gitattributes &&
>>               test_cmp expect .gitattributes
>> @@ -109,7 +109,7 @@ test_expect_success 'Store files in LFS based on size (>25 bytes)' '
>>               #
>>               # Git LFS (see https://git-lfs.github.com/)
>>               #
>> -             /file4.bin filter=lfs -text
>> +             /file4.bin filter=lfs diff=lfs merge=lfs -text
>>               EOF
>>               test_path_is_file .gitattributes &&
>>               test_cmp expect .gitattributes
>> @@ -135,7 +135,7 @@ test_expect_success 'Store files in LFS based on extension (dat)' '
>>               #
>>               # Git LFS (see https://git-lfs.github.com/)
>>               #
>> -             *.dat filter=lfs -text
>> +             *.dat filter=lfs diff=lfs merge=lfs -text
>>               EOF
>>               test_path_is_file .gitattributes &&
>>               test_cmp expect .gitattributes
>> @@ -163,8 +163,8 @@ test_expect_success 'Store files in LFS based on size (>25 bytes) and extension
>>               #
>>               # Git LFS (see https://git-lfs.github.com/)
>>               #
>> -             *.dat filter=lfs -text
>> -             /file4.bin filter=lfs -text
>> +             *.dat filter=lfs diff=lfs merge=lfs -text
>> +             /file4.bin filter=lfs diff=lfs merge=lfs -text
>>               EOF
>>               test_path_is_file .gitattributes &&
>>               test_cmp expect .gitattributes
>> @@ -199,8 +199,8 @@ test_expect_success 'Remove file from repo and store files in LFS based on size
>>               #
>>               # Git LFS (see https://git-lfs.github.com/)
>>               #
>> -             /file2.dat filter=lfs -text
>> -             /path[[:space:]]with[[:space:]]spaces/file3.bin filter=lfs -text
>> +             /file2.dat filter=lfs diff=lfs merge=lfs -text
>> +             /path[[:space:]]with[[:space:]]spaces/file3.bin filter=lfs diff=lfs merge=lfs -text
>>               EOF
>>               test_path_is_file .gitattributes &&
>>               test_cmp expect .gitattributes
>> @@ -237,8 +237,8 @@ test_expect_success 'Add .gitattributes and store files in LFS based on size (>2
>>               #
>>               # Git LFS (see https://git-lfs.github.com/)
>>               #
>> -             /file2.dat filter=lfs -text
>> -             /path[[:space:]]with[[:space:]]spaces/file3.bin filter=lfs -text
>> +             /file2.dat filter=lfs diff=lfs merge=lfs -text
>> +             /path[[:space:]]with[[:space:]]spaces/file3.bin filter=lfs diff=lfs merge=lfs -text
>>               EOF
>>               test_path_is_file .gitattributes &&
>>               test_cmp expect .gitattributes
>> @@ -278,7 +278,7 @@ test_expect_success 'Add big files to repo and store files in LFS based on compr
>>               #
>>               # Git LFS (see https://git-lfs.github.com/)
>>               #
>> -             /file6.bin filter=lfs -text
>> +             /file6.bin filter=lfs diff=lfs merge=lfs -text
>>               EOF
>>               test_path_is_file .gitattributes &&
>>               test_cmp expect .gitattributes
