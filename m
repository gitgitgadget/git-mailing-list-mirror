Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 699AF2095E
	for <e@80x24.org>; Sat, 25 Mar 2017 12:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbdCYMOJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 08:14:09 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33573 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbdCYMOI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 08:14:08 -0400
Received: by mail-lf0-f53.google.com with SMTP id h125so4557861lfe.0
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 05:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rQVKzeBTX96X4VdS40ML5dI/iqm3nP3hTWb4+itLBmc=;
        b=HatWMYyFOKe2Y5/cMOnEDU07SgQ2pVfRPO9LaFRR2twTi/kL+6j+n/sfJi67QSKVRD
         nDDUAMu/KeybwuWk/upJipzAzspMx3gvtqmiJg37qWGlC9z9WSyzl1gsERdTnsN3j90L
         dOYq+nkdrGkxJdp2ZBDjBhzCpg1mv3vEsl0RYGDE3CuM91ixVj44i5ipJv9cnHCsKeFk
         mmY/+sG8aU5gb4y20FBYjFooDZW3syhty/KQKEIP4a5sfYzlTpFMdckYEuZ6t7o8maEI
         2gOrdc/sdx+Gx82HNmOArrnB5pg/bi1sH4ROnjU4qn0gR+KBegpDycOVXAUXw+cc/zHn
         PBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rQVKzeBTX96X4VdS40ML5dI/iqm3nP3hTWb4+itLBmc=;
        b=E+4bKVGSA379hShRJYpszg0gFPYxzcpEdi9EEuAAuqQ07sDin55T7j58awqfGWY8M9
         9UvHEihKXAVQ2vDFsONyyl1m8wL5wlASa7omklyEDeSfUr0sO5DET3Dzw5rav0MyDJNC
         uY8pDqp47TvVgAvx9b2zsBMZhNBqQod4uvO1uZCEgFB+b92KtVTtcwZxkRnh6GrZPMeP
         YDYXNfjaLyS4qnLqKApki81W1TeI6nd1jvnxqMv4/PEoqWwdjmNGUjvvX8SKIvbLqf1v
         yOgQb9MlxN0QhLT4QWquU+/33WGD23gP0K+66tOtk3ncneAz2ymje/Qf1LiNPp/SmsQc
         3mwA==
X-Gm-Message-State: AFeK/H3eDRbz6a/rEZL+QSFXV4hirKb6ccv9s46aO+wyCQKb8MZqqe5/+xiNXtPNMZziklHJnpmDUWcrVm7D/g==
X-Received: by 10.25.219.213 with SMTP id t82mr6355957lfi.75.1490444045689;
 Sat, 25 Mar 2017 05:14:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.18.73 with HTTP; Sat, 25 Mar 2017 05:13:35 -0700 (PDT)
In-Reply-To: <CACsJy8Aajf1Lb4mKC=NEUQTNy7QRK99Aont_UCRnHJfho8n+UA@mail.gmail.com>
References: <1490441257-44727-1-git-send-email-bnmvco@gmail.com> <CACsJy8Aajf1Lb4mKC=NEUQTNy7QRK99Aont_UCRnHJfho8n+UA@mail.gmail.com>
From:   "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Date:   Sat, 25 Mar 2017 09:13:35 -0300
Message-ID: <CAEA2_RK=zMwKeidPDS9u5Ep1htb3TUeOqJ6Cfd644ira4DeXaA@mail.gmail.com>
Subject: Re: [PATCH v2] [GSoC] remove_subtree(): reimplement using iterators
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You are correct, which shows that since all tests pass, we need to
come up with better cases for this function.

As for a solution, I believe that the best way to go for it is to
dir_iterator's implementation to have an "Option to iterate over
directory paths before vs. after their contents" (something predicted
in the commit that created it). If it iterates over directories after
all of its contents (currently it does so before) we just need to
check if the entry is a directory and if so, rmdir() it. Does that
make sense?

On Sat, Mar 25, 2017 at 8:51 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Mar 25, 2017 at 6:27 PM, Daniel Ferreira <bnmvco@gmail.com> wrote:
>> Use dir_iterator to traverse through remove_subtree()'s directory tree,
>> avoiding the need for recursive calls to readdir(). Simplify
>> remove_subtree()'s code.
>>
>> A conversion similar in purpose was previously done at 46d092a
>> ("for_each_reflog(): reimplement using iterators", 2016-05-21).
>>
>> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
>> ---
>>
>> This is a second-version patch of the Google Summer of Code microproject for
>> refactoring recursive readdir() calls to use dir_iterator instead. v1 can be
>> found in:
>>
>> https://public-inbox.org/git/CAGZ79kZwT-9mHTiOJ5CEjk2wDFkn6+NcogjX0=vjhsAh16ANYg@mail.gmail.com/T/#mae023e7a7d7626f00e0923833c4359f5af493730
>>
>> Additionally, for debugging purposes I turned remove_subtree() into a no-op
>> and ran git tests. Some failures were at:
>>
>> * t2000-checkout-cache-clash.sh
>> * t2003-checkout-cache-mkdir.sh
>>
>> If you guys could check those files out and warn me if any additional tests
>> would be welcome, please let me know.
>>
>> Thanks.
>>
>>  entry.c | 28 +++++++---------------------
>>  1 file changed, 7 insertions(+), 21 deletions(-)
>>
>> diff --git a/entry.c b/entry.c
>> index c6eea240b..3cb92592d 100644
>> --- a/entry.c
>> +++ b/entry.c
>> @@ -2,6 +2,8 @@
>>  #include "blob.h"
>>  #include "dir.h"
>>  #include "streaming.h"
>> +#include "iterator.h"
>> +#include "dir-iterator.h"
>>
>>  static void create_directories(const char *path, int path_len,
>>                                const struct checkout *state)
>> @@ -46,29 +48,13 @@ static void create_directories(const char *path, int path_len,
>>
>>  static void remove_subtree(struct strbuf *path)
>>  {
>> -       DIR *dir = opendir(path->buf);
>> -       struct dirent *de;
>> -       int origlen = path->len;
>> -
>> -       if (!dir)
>> -               die_errno("cannot opendir '%s'", path->buf);
>> -       while ((de = readdir(dir)) != NULL) {
>> -               struct stat st;
>> -
>> -               if (is_dot_or_dotdot(de->d_name))
>> -                       continue;
>> -
>> -               strbuf_addch(path, '/');
>> -               strbuf_addstr(path, de->d_name);
>> -               if (lstat(path->buf, &st))
>> -                       die_errno("cannot lstat '%s'", path->buf);
>> -               if (S_ISDIR(st.st_mode))
>> -                       remove_subtree(path);
>> -               else if (unlink(path->buf))
>> +       struct dir_iterator *diter = dir_iterator_begin(path->buf);
>> +
>> +       while (dir_iterator_advance(diter) == ITER_OK) {
>> +               if (unlink(diter->path.buf))
>>                         die_errno("cannot unlink '%s'", path->buf);
>> -               strbuf_setlen(path, origlen);
>>         }
>> -       closedir(dir);
>> +
>>         if (rmdir(path->buf))
>>                 die_errno("cannot rmdir '%s'", path->buf);
>
> Even though it's very nice that lots of code is deleted. This is not
> entirely correct, is it? Before this patch, rmdir() is called for
> every recursive remove_subtree() call. After this patch, it's only
> called once (and likely fails unless you have no subdirectories).
>
>>  }
>> --
>> 2.12.1.433.g82305b74f.dirty
>>
>
>
>
> --
> Duy
