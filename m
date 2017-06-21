Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ABA220D0C
	for <e@80x24.org>; Wed, 21 Jun 2017 20:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751154AbdFUUr2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 16:47:28 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35057 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdFUUr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 16:47:27 -0400
Received: by mail-pf0-f172.google.com with SMTP id c73so30043932pfk.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 13:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kTsJqJi8UCh2Ejz5k3r1QBJqsUO8buJ1poRegy6DfZA=;
        b=VbjkBt3NKcByZY1l4180QVTLX3UJfqmqcECEYXdZvVcpghd4o0imA47Ueht8d8eNCa
         6psxnJvDuYdvWNN8RgYi52uqQXupW4pNH917lDbevm+FJURh0D5JfY3z7T5x3twYR/dx
         c6OemIOuZhaG/FMDSlbEcoDShWolPUd7MMKC8gk8zlsUeiP6O7dkqtUAD4Ch9+twSJaY
         a9CUktZGrzZg7v0IctCbP6SprOG7RO7XT2Sw/6eu3tE1M+kyS3PNtVM6WmFUGRPoiLM2
         DjKW1ClM3wxbrzMyPH8+36A04uFy9EMdhZh9iPLkms1BRz/DlqPz1OGNd+zFOZ4HqUQd
         wfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kTsJqJi8UCh2Ejz5k3r1QBJqsUO8buJ1poRegy6DfZA=;
        b=clgcj5cBPKE3oCRvB9lia+YAyzPcemsEGZfzsJv2JvLkHKVvWSUkty6lOf6PRkBEKP
         aGNWgL87nT0FfXRDxYg1/ahA9dhWUrkbqOBQQlfg9gT/hGQDdUtESmTLa2caLZaqqlDu
         JEnyS9mAs7ktkczzabDUKobqw7H5pXywse4AHgsj3unrJG+ZzHKABb6vDG1Nil/96lvz
         BlZhR4nuO6dqwv7vsSsb5Zcq4z89qFi0sCsdP4MPvX+5H8blvAKmc2UOuHz76t1Kz0tV
         r4QC9VwcQxcqwHwAQJXOEheb5VBkQyAkbTgDMLUhlSI2NnzbZAXGe76dwDrR0djgNjj6
         3KCQ==
X-Gm-Message-State: AKS2vOwYBgsOvtV5AqzM3yOqRJkq8mtyhmM55ka1uhCZJyyrb6dy8FzE
        uRHKy6nOR7CZhxXiHsJ8IggmkjbsM+q8
X-Received: by 10.98.205.194 with SMTP id o185mr38036502pfg.105.1498078046497;
 Wed, 21 Jun 2017 13:47:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.227 with HTTP; Wed, 21 Jun 2017 13:47:26 -0700 (PDT)
In-Reply-To: <xmqqr2ydnlok.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com> <20170620024816.20021-14-sbeller@google.com>
 <xmqqr2ydnlok.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 21 Jun 2017 13:47:26 -0700
Message-ID: <CAGZ79kbfMumUjfUx4MzLWEXzXtv9GtaCohW4-QxJZ=5bAqcqng@mail.gmail.com>
Subject: Re: [PATCH 13/26] diff.c: emit_diff_symbol learns about DIFF_SYMBOL_BINARY_FILES
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 1:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  diff.c | 21 ++++++++++++++++-----
>>  1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/diff.c b/diff.c
>> index 95f11ea86f..e56962b844 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -572,6 +572,7 @@ enum diff_symbol {
>>       DIFF_SYMBOL_WORDS,
>>       DIFF_SYMBOL_FILEPAIR,
>>       DIFF_SYMBOL_HEADER,
>> +     DIFF_SYMBOL_BINARY_FILES,
>>  };
>>  /*
>>   * Flags for content lines:
>> @@ -689,6 +690,10 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
>>       case DIFF_SYMBOL_HEADER:
>>               fprintf(o->file, "%s", line);
>>               break;
>> +     case DIFF_SYMBOL_BINARY_FILES:
>> +             fprintf(o->file, "%sBinary files %s differ\n",
>> +                     diff_line_prefix(o), line);
>> +             break;
>
> It is curious why the "line" is defined to be "A and B" here.  It
> could have been defined to be the whole string "Binary files A and B
> differ" or even with the terminating LF.
>
> And with that it may have been able to share concepts with the
> "HEADER" we see above.  SYMBOL_HEADER becomes "oneline without
> prefix", and this one (updated to make the caller prepare the whole
> sentence) becomes "oneline with prefix".

I thought about saving memory in the buffered operation,
but for simplicity it may be better to make them the same.
Then they can even share the implementation.
With that thought, I'll check more different symbols to share
the same implementation.

>
>> @@ -2549,8 +2555,10 @@ static void builtin_diff(const char *name_a,
>>                       }
>>                       emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
>>                                        header.buf, header.len, 0);
>> -                     fprintf(o->file, "%sBinary files %s and %s differ\n",
>> -                             line_prefix, lbl[0], lbl[1]);
>> +                     strbuf_addf(&sb, "%s and %s", lbl[0], lbl[1]);
>> +                     emit_diff_symbol(o, DIFF_SYMBOL_BINARY_FILES,
>> +                                      sb.buf, sb.len, 0);
>> +                     strbuf_release(&sb);
>>                       goto free_ab_and_return;
>>               }
>>               if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
>> @@ -2567,9 +2575,12 @@ static void builtin_diff(const char *name_a,
>>               strbuf_reset(&header);
>>               if (DIFF_OPT_TST(o, BINARY))
>>                       emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
>> -             else
>> -                     fprintf(o->file, "%sBinary files %s and %s differ\n",
>> -                             line_prefix, lbl[0], lbl[1]);
>> +             else {
>> +                     strbuf_addf(&sb, "%s and %s", lbl[0], lbl[1]);
>> +                     emit_diff_symbol(o, DIFF_SYMBOL_BINARY_FILES,
>> +                                      sb.buf, sb.len, 0);
>> +                     strbuf_release(&sb);
>> +             }
>>               o->found_changes = 1;
>>       } else {
>>               /* Crazy xdl interfaces.. */
