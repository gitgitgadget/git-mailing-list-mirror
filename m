Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C81012070D
	for <e@80x24.org>; Fri,  8 Jul 2016 16:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290AbcGHQiI (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 12:38:08 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33120 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932486AbcGHQgz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 12:36:55 -0400
Received: by mail-io0-f196.google.com with SMTP id t74so10547969ioi.0
        for <git@vger.kernel.org>; Fri, 08 Jul 2016 09:36:50 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ymtUswHBvxW87dMMdzFsJBnHgWPYRlkZ7f1W6loEPkk=;
        b=zySd7hnrfQe6fZ0iirK85e5ZhuEC/x2OrRXK9yre+iE18MTK2wsRw4N/kJaHSG6TEV
         e4M+r2PUb5YM22uZ9F4nXykDgSXgIVMQ2/naMbEZbDwH6LEhuRHm1Z9l716+3XzEZLgp
         2TZUXoKZuZCbpSqXrOkJf8bbgcYAuhVugJFl+uEsGufiJy22Ynmbi8GD3QIfuwApgngt
         TPJK2AF6oRKXqul4UfgYb4rEpFuydD3iM9YuB8dZjnXoTUc43GAUmJ8U6n7FCJo48chn
         549ptaXZdwN1ycWfSHR4aZd2grWpUYXGU2wdA3V084l8PK99IHBiCfbqTuT+RQWn23pf
         sO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ymtUswHBvxW87dMMdzFsJBnHgWPYRlkZ7f1W6loEPkk=;
        b=DoSKhNjPsDOym5SzvyMdWXwvjUOGp3eYUuCR7bTbwJ2bVRYAfcv1NnuTZqrk0zZgf8
         sBXzRN9I3oeiHCUvQptYXY6eQYXl73L7lfE3SOKpr0oFeuRYwsxDihPkxHWDG+e0iVuj
         gtyj0hnwL+a8tyR0k54XttF9gA/57qA/wpqJwcjfkkbZC3RhPpu52WBIoYiuwpG6yWY9
         ThISDxgxii/CR38trp5AUj7ttQyqvgCQgqTpWGnZd5cmo4LndB/B4TAjYsFmhX2x/NYS
         hNXvTu8NSrjZlXPHhAaLC9V9KUSIyiQXxpQlFkFS7iDjVgjDCM5CJLqKTGD5Txv/Vzfa
         C/ow==
X-Gm-Message-State: ALyK8tLHyUENBdCFRESG96q0zVn6AKBH5qlg6AaAtkkzx8xMmd72/VJ3ObGpKaYmQeCdha3/rhZkOJ323Hlh8g==
X-Received: by 10.107.22.6 with SMTP id 6mr9196496iow.128.1467995810061; Fri,
 08 Jul 2016 09:36:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Fri, 8 Jul 2016 09:36:20 -0700 (PDT)
In-Reply-To: <xmqqwpkwm8ho.fsf@gitster.mtv.corp.google.com>
References: <20160704174807.6578-1-pclouds@gmail.com> <20160706184829.31825-1-pclouds@gmail.com>
 <20160706184829.31825-3-pclouds@gmail.com> <xmqqeg76sh44.fsf@gitster.mtv.corp.google.com>
 <20160707171237.GA31445@duynguyen> <xmqqmvltp9f9.fsf@gitster.mtv.corp.google.com>
 <20160708153930.GA19448@duynguyen> <xmqqwpkwm8ho.fsf@gitster.mtv.corp.google.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Fri, 8 Jul 2016 18:36:20 +0200
Message-ID: <CACsJy8DkXuszC2f=TVzzXPKz2zvyRKFOVqXRoZGbwfo+oUMP7Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cache-tree: do not generate empty trees as a
 result of all i-t-a subentries
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Yuri Kanivetsky <yuri.kanivetsky@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 8, 2016 at 5:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Yeah that's better. So the squash patch is something like this
>
> Rather...
>
>> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
>> index a19f06b..80880b7 100755
>> --- a/t/t2203-add-intent.sh
>> +++ b/t/t2203-add-intent.sh
>> @@ -107,7 +107,9 @@ test_expect_success 'cache-tree does skip dir that becomes empty' '
>>               mkdir -p 1/2/3 &&
>>               echo 4 >1/2/3/4 &&
>>               git add -N 1/2/3/4 &&
>> -             test_must_fail git commit -m committed
>> +             git write-tree >actual &&
>> +             echo 4b825dc642cb6eb9a060e54bf8d69288fbee4904 >empty-tree &&
>> +             test_cmp empty-tree actual
>
>         written=$(git write-tree) &&
>         git ls-tree "$written" >actual &&
>         ! grep 1 actual
>
> That way, we have one less thing to worry about when the hash
> function changes in the future.  You may want to rename 1/2/3
> to something more readable (e.g. dir/2/3) and grep for "dir"
> instead, though.

I thought about that too, then did a grep which showed empty sha1 tree
was used elsewhere. And thought of sending a patch to define
$EMPTY_SHA1 in test-lib-functions.sh or somewhere so we don't hard
code it everywhere, but I didn't. But yeah ls-tree works. The last
line could be test_must_be_empty actual (a bit stricter than grep 1)
-- 
Duy
