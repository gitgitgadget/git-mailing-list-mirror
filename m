Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 176161F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 13:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbdCBM75 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 07:59:57 -0500
Received: from mail-oi0-f52.google.com ([209.85.218.52]:35800 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbdCBM7v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 07:59:51 -0500
Received: by mail-oi0-f52.google.com with SMTP id 62so38636809oih.2
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 04:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M9APiqpl5/VioOUVZoigFP+PzuakipWJJkCjllBqx2U=;
        b=mCIvSNVKepoXu2uRG+hPpk0zl4I9He3g5lgXCuHYTHZSPlv/KhWD9Zc2u4EjxAMZRf
         1hLKqsLsl5VNCjK/SXGz9i40KhPT8eZ0O/uDDObV0ECK+thcLqSMq7Iwd28QnYBR3Ztv
         QSNmtLZw9KZXYqS408CRNtIht9NmDEOTKshqeNh6yRnYgDn6CcWgEjjp6uTc/8dCHbpF
         qB6oQ7xyq2R06Vr3AGpKxe1oCSBA0vyTAzwPIQCrI8VABWXBHhNAS1S4SP6qDl7R+NHP
         nqhE2aCpdDXBNWTAv3FMttOAm2WuoPywEh5OIfeyozjIuSVK3etE4ZrK3KJqJSwWVCL/
         4A4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M9APiqpl5/VioOUVZoigFP+PzuakipWJJkCjllBqx2U=;
        b=jYcTt5NcLYQ3Cn43L4FN8SBhmt8lSLJz6Qay3sWR8brgdiOdWPaXshNLDYeilVRnV/
         8d+TR7Au4Bq8/6Uniod1BeZTIhb5TijCmZkxVEBS1X2bg8+hrATLzCXXND3cr+DQ8EWR
         U6umJryPmDvLudRwYapjZY/dDIe+8JCpl3FapEOHTFCYtPq/gLa2zLiu+rLBtn46fXBz
         4Mx8qmP0UY/epcSpDeylv8tV0vlZbt0h4f8fF+QTbQq5yE9MiEZ+lpZO299mog7RbKdt
         /voOdpquanA6OZMeh6m9U7SChADzMHQW2Uc2/kxozAAz/yecv4CrqgbT2+KpcWwArvzI
         gp/Q==
X-Gm-Message-State: AMke39neju9mw+tKDRo/UiUuWeAGyQdRtHD+/JrAD0I02zYVd7JyQjsvApYAkqmZj/rR+uHAGhKIaQaoHpBwYA==
X-Received: by 10.202.80.212 with SMTP id e203mr7440558oib.146.1488459185396;
 Thu, 02 Mar 2017 04:53:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Thu, 2 Mar 2017 04:52:34 -0800 (PST)
In-Reply-To: <9074fcd9-2b80-8927-19d2-1659eb0e327c@alum.mit.edu>
References: <20170218133303.3682-1-pclouds@gmail.com> <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-5-pclouds@gmail.com> <9074fcd9-2b80-8927-19d2-1659eb0e327c@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 Mar 2017 19:52:34 +0700
Message-ID: <CACsJy8B-xi0Dob=KkHv2zMZ=ffca5qSo39VLGC1wPN6uXK6SGQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/24] files-backend: convert git_path() to strbuf_git_path()
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 12:06 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> @@ -2681,13 +2709,19 @@ static int files_rename_ref(struct ref_store *ref_store,
>>       log_all_ref_updates = flag;
>>
>>   rollbacklog:
>> -     if (logmoved && rename(git_path("logs/%s", newrefname), git_path("logs/%s", oldrefname)))
>> +     strbuf_git_path(&sb_newref, "logs/%s", newrefname);
>> +     strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
>> +     if (logmoved && rename(sb_newref.buf, sb_oldref.buf))
>>               error("unable to restore logfile %s from %s: %s",
>>                       oldrefname, newrefname, strerror(errno));
>> +     strbuf_git_path(&tmp_renamed_log, TMP_RENAMED_LOG);
>>       if (!logmoved && log &&
>> -         rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", oldrefname)))
>> +         rename(tmp_renamed_log.buf, sb_oldref.buf))
>>               error("unable to restore logfile %s from "TMP_RENAMED_LOG": %s",
>>                       oldrefname, strerror(errno));
>
> It feels like you're writing, releasing, re-writing these strbufs more
> than necessary. Maybe it would be clearer to set them once, and on
> errors set `ret = error()` then jump to a label here...
>
>> +     strbuf_release(&sb_newref);
>> +     strbuf_release(&sb_oldref);
>> +     strbuf_release(&tmp_renamed_log);
>>
>
> ...and change this to `return ret`?

If that's ok with you, will do. I kept the patch dumb so the reader
does not have to keep track of many things when they check if there
are any behavior changes.

>>  static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
>>  {
>> +     struct strbuf sb = STRBUF_INIT;
>> +
>>       /* Check validity (but we don't need the result): */
>>       files_downcast(ref_store, 0, "init_db");
>>
>>       /*
>>        * Create .git/refs/{heads,tags}
>>        */
>> -     safe_create_dir(git_path("refs/heads"), 1);
>> -     safe_create_dir(git_path("refs/tags"), 1);
>> +     strbuf_git_path(&sb, "refs/heads");
>> +     safe_create_dir(sb.buf, 1);
>> +     strbuf_reset(&sb);
>> +     strbuf_git_path(&sb, "refs/tags");
>> +     safe_create_dir(sb.buf, 1);
>> +     strbuf_reset(&sb);
>>       if (get_shared_repository()) {
>> -             adjust_shared_perm(git_path("refs/heads"));
>> -             adjust_shared_perm(git_path("refs/tags"));
>> +             strbuf_git_path(&sb, "refs/heads");
>> +             adjust_shared_perm(sb.buf);
>> +             strbuf_reset(&sb);
>> +             strbuf_git_path(&sb, "refs/tags");
>> +             adjust_shared_perm(sb.buf);
>>       }
>> +     strbuf_release(&sb);
>>       return 0;
>>  }
>
> It looks to me like `safe_create_dir()` already has the ability to
> `adjust_shared_perm()`, or am I missing something? (I realize that this
> is preexisting code.)

Yeah you're right. I guess this code was written when
safe_create_dir() didn't do that. That certainly shortens this patch.
-- 
Duy
