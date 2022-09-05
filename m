Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F73C6FA8B
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 20:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiIEU0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 16:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiIEU0b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 16:26:31 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6235645F51
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 13:26:30 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q63so8824867pga.9
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 13:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=RYXdN7cacRWMX9/4waP/be+2WMI1M31+ECniuZ1/zqY=;
        b=pHFR1gj2xh7K4nLz/59RwEzaZDwq13G0dvohSOueV085C6QjGnKHSas9diT4HTnlIs
         bQ9CKBfv3TAV89TaXhO+U2Tv0tqqPCATdeeh+1fD1NepctdKY5mj3pW2d5XawJ+IO+kQ
         S81qR30VBk9Z4e+C7HKO4ZedR5GdMnv9xxjZTH6G4YYAzq2RrRqy9Ta8BoLxbZnZ2t98
         ChsV/pJEffyi/bw17jTqR8PKa70K2VpW9akCtnR+18vPLBFF3F2L7+k5LV/kB4UVBYaj
         psL92oza2Mt9jJm4cuBI6eFJQMYI3mc57cLcWXHYvTxPHYJNiBDc+IQ4sTWO7Ja7CdJH
         X1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RYXdN7cacRWMX9/4waP/be+2WMI1M31+ECniuZ1/zqY=;
        b=chPAo++B1xPCHqsZ9dAyfc2VClAI0HBitOLYzQQok6NzQNh9RrJdwQU+l0jRUVs1cn
         C41vRUPSHTAF6aAsj9CLvUkT4p6reqDoMxAT2RZoepXTB2lKrSpCM7XzPg4Qg4SjuMEd
         /gGeRogIoQEy21tyZVctYyMnArBW9oATXt243Kd3CDn8mbvzYWm3CqOw2EAvzmx8iDyd
         DLtThXPsWdVl4ORcZjKducLTg+eFOtaxnhQ7T0ThnscIsWpZ5VF1c8cYJrZJ6x84pLYH
         uTiV/qY3SlSWDeU1RWVLmECIR8w5umgp/RC1Md9gdE3KXT+ejOBVv+MUp/4QVAuEIn+d
         9lNA==
X-Gm-Message-State: ACgBeo24esfYVpPse70KnIlna6fQEgiRvLIiiyjxjw4rTu6ILT7YFvXW
        owPFZdUpi29e/bS15s+BI5k=
X-Google-Smtp-Source: AA6agR7Njsn7Cs7LL6xcnACfTcVsiUDaoFsxEkW/OdHX/DeaJYFeC+Y4taNeagHK4FZOeplvQDe5xA==
X-Received: by 2002:a05:6a00:e1b:b0:537:7c74:c405 with SMTP id bq27-20020a056a000e1b00b005377c74c405mr51457711pfb.43.1662409589642;
        Mon, 05 Sep 2022 13:26:29 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902e88800b0016c4546fbf9sm8102499plg.128.2022.09.05.13.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 13:26:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] diff --no-index: unleak paths[] elements
References: <xmqqilm579hc.fsf@gitster.g> <xmqqilm51gn6.fsf@gitster.g>
        <181c029b-8b36-4b04-30f9-97a3f252bfbc@web.de>
Date:   Mon, 05 Sep 2022 13:26:28 -0700
In-Reply-To: <181c029b-8b36-4b04-30f9-97a3f252bfbc@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 3 Sep 2022 08:00:23 +0200")
Message-ID: <xmqq8rmx1saz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 03.09.22 um 01:49 schrieb Junio C Hamano:
>> "git diff --no-index" codepath starts with the two elements in
>> argv[] and munges them into two paths to be compared, stored in a
>> separate path[] arrays.  The munging is implemented in a rather
>> haphazard way, sometimes overwriting old version with a new copy,
>> and sometimes a constant string assigned to path[], making it
>> impossible to release the resources properly:
>>
>>  * A single dash "-" from the command line is a special signal that
>>    the standard input is used for the side to be compared, and is
>>    internally replaced with a copy of string "-" at a known address.
>>
>>  * When run in a subdirectory, full paths to the two paths are
>>    allocated and placed in path[].
>>
>>  * After the above happens, when comparing a file with a directory,
>>    the directory side is replaced with the path to a file in the
>>    directory with the same name as the file.
>>
>> This was perfectly fine for just two strings that are pathnames used
>> during the lifetime of the program and cleaned up upon program exit,
>> but it gets in the way when leak sanitizer is in effect.  The third
>> step can be losing the full path that was allocated in the second
>> step, but it is not easy to tell if its input is an allocated piece
>> of memory to begin with.
>>
>> Loosen the earlier two steps a bit so that elements of the path[]
>> array that come to the directory/file comparison code are either the
>> singleton "-" or an allocated piece of memory.  Use that knowledge
>> in the third step to release an allocated piece of memory when it
>> replaces the path to a directory with the path to a file in that
>> directory, and also at the end to release the two elements of the
>> path[] array as needed.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>
>>  * The previous one allowed strbuf_release() to free replacement.buf
>>    which may be used in path[0] or path[1] potentially leading to
>>    double freeing.  The kosher way may be to use strbuf_detach() in
>>    fixup_paths(), but this is a simpler fix, it is getting late in
>>    the day, and I am getting sick of fighting the leak-checker, so...
>>
>>  diff-no-index.c | 24 ++++++++++++++++++++++--
>>  1 file changed, 22 insertions(+), 2 deletions(-)
>>
>>
>> diff --git a/diff-no-index.c b/diff-no-index.c
>> index 9a8b09346b..77a126469b 100644
>> --- a/diff-no-index.c
>> +++ b/diff-no-index.c
>> @@ -208,6 +208,14 @@ static void append_basename(struct strbuf *path, const char *dir, const char *fi
>>  	strbuf_addstr(path, tail ? tail + 1 : file);
>>  }
>>
>> +static void free_allocated_path(const char *path)
>> +{
>> +	if (!path ||
>
> How can path be NULL?  And if it was, why shield free(3) from it?

See the comment under three-dashes of the first iteration.

>> +	/*
>> +	 * do not strbuf_release(&replacement), as it is in paths[]
>> +	 * when replacement was actually used.
>> +	 */
>> +	free_allocated_path(paths[0]);
>> +	free_allocated_path(paths[1]);
>>
>>  	/*
>>  	 * The return code for --no-index imitates diff(1):
>
> Perhaps avoid the need for that comment by moving that strbuf to where
> it's used and have it spend its full lifecycle there?  Something like:

Yup, that is what I said in the comment under three-dashes (with the
reason why I didn't bother).

Quite honestly I am sick of fighting the overzealous leak-checker so
I'd very much appreciate if somebody else pick this up and run with
it.

Thanks.

