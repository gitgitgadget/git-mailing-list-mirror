Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2974E2023D
	for <e@80x24.org>; Thu, 18 May 2017 06:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753135AbdERGdF (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 02:33:05 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33908 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753994AbdERGdC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 02:33:02 -0400
Received: by mail-io0-f176.google.com with SMTP id k91so22823696ioi.1
        for <git@vger.kernel.org>; Wed, 17 May 2017 23:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Tmrhmdb5/Wh6tHMbPcd6xkQfH98A6ztWU4gT4nTfzwY=;
        b=bw0ear25ufxJu/fYgzyBa0ZE9iXZNA+jpdxOAAbCkg83VmEJtETd86TJTEaLA9ScEc
         mS4Y4rLDpVskgw1pVzkvB3cUR8veR5adFBPY3boNVml9hukn5ErjoS28b9i+QtyVKSxu
         6PHwEumJ9XmP6/tuMpaO27Emzh5753UMjj4WVsFBrwtY9hpvk/AmlerttglB2S50PKGw
         epYuXM7KgV115rt3jmFNV938+AekPnWy0M9FekwzRONZbcfRIAbuvpYzVagyY3HTmL5X
         I1/TPWDM4UfZYCS7WdvKrMgmmqTPp1kU5VBSalmyJh++TcJg/4SrHTQNzRi51iipdZxg
         DH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Tmrhmdb5/Wh6tHMbPcd6xkQfH98A6ztWU4gT4nTfzwY=;
        b=JJfpsDaPNmRVPB8I7Oco110fWkrohbiR+0RPCOigWYinUXdXFxRKk4dl91tj+tMFQ3
         9aoVEZxYRg6FVINXEnKa12/THRaroTeJY9fbqOp9mOn6RgYAofhS3N0oh4GBjwrEtuQ6
         eVvTWpiPt/M3FD0CuAyenqxHsC58YiGotEN6mK113KhuLRRi/KSYVkYb4IJvVMlZVPTm
         Ak9bADtjWeG7FWp34yqoWDzLd4N7+iWcv+i5gNWxf8BlOu94ZMltYIQv6jiJPs4RL0q9
         +mtL1i1lSU3j2CZAojaodrp8q9YWfwMxuIICAXG8q9l0KssQHZS+uLj+4TCEeTS5rbPy
         v+nQ==
X-Gm-Message-State: AODbwcCZzM7oTxieky6vQlhZaTN8ZjqqqSvrM98/t6VYCfp6/cwaO4x3
        /IjvmWqOxeiiHR+1IZyznJSwM1EsVcma
X-Received: by 10.107.195.70 with SMTP id t67mr3256249iof.17.1495089176274;
 Wed, 17 May 2017 23:32:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Wed, 17 May 2017 23:32:15 -0700 (PDT)
In-Reply-To: <xmqq4lwix58s.fsf@gitster.mtv.corp.google.com>
References: <20170516073423.25762-1-sxlijin@gmail.com> <20170505104611.17845-1-sxlijin@gmail.com>
 <20170516073423.25762-7-sxlijin@gmail.com> <xmqq4lwix58s.fsf@gitster.mtv.corp.google.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Thu, 18 May 2017 02:32:15 -0400
Message-ID: <CAJZjrdUPChKF=3DvQ01-CusaxYoUWJTpsrPBbnnqnmh3MQ9eYg@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] clean: teach clean -d to skip dirs containing
 ignored files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 10:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Samuel Lijin <sxlijin@gmail.com> writes:
>
>> @@ -932,7 +935,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>>
>>       fill_directory(&dir, &pathspec);
>>
>> -     for (i = 0; i < dir.nr; i++) {
>> +     for (k = i = 0; i < dir.nr; i++) {
>>               struct dir_entry *ent = dir.entries[i];
>>               int matches = 0;
>>               struct stat st;
>> @@ -954,10 +957,35 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>>                   matches != MATCHED_EXACTLY)
>>                       continue;
>>
>> +             // skip any dir.entries which contains a dir.ignored
>> +             for (; k < dir.ignored_nr; k++) {
>> +                     if (cmp_dir_entry(&dir.entries[i],
>> +                                             &dir.ignored[k]) < 0)
>> +                             break;
>
> It is a bit unfortunate that we do not use the short-hand "ent" we
> established for dir.entries[i] at the beginning of this loop here.
>
>> +             }
>> +             if ((k < dir.ignored_nr) &&
>> +                             check_dir_entry_contains(dir.entries[i], dir.ignored[k])) {
>> +                     continue;
>> +             }
>
> The above logic is not needed when dir.entries[i] is a directory,
> right?

Au contraire - this logic only matters when dir.entries[i] is a directory.

>> +
>> +             // current entry does not contain any ignored files
>
> ... or the entry may not have been a directory in the first place.

If it's not a directory, it can't contain ignored files ;)

>>               rel = relative_path(ent->name, prefix, &buf);
>>               string_list_append(&del_list, rel);
>> +
>> +             // skip untracked contents of an untracked dir
>> +             for (j = i + 1;
>> +                      j < dir.nr &&
>> +                          check_dir_entry_contains(dir.entries[i], dir.entries[j]);
>> +                      j++);
>> +             i = j - 1;
>>       }
>>
>> +     for (i = 0; i < dir.nr; i++)
>> +             free(dir.entries[i]);
>> +
>> +     for (i = 0; i < dir.ignored_nr; i++)
>> +             free(dir.ignored[i]);
>> +
>
> The above logic may not be incorrect per-se, but I have this
> suspicion that the resulting code may become cleaner and easier to
> understand if we did it in a new separate loop we call immediately
> after fill_directory() returns.  Or it could even be a call to a
> helper that "post processes" the "dir" thing that was polupated by
> fill_directory() that removes elements in the entries[] array that
> contains any element in ignored[] array.

Will try it out.

>>       if (interactive && del_list.nr > 0)
>>               interactive_main_loop();
>
> Thanks.
