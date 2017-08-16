Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1BFC208CD
	for <e@80x24.org>; Wed, 16 Aug 2017 01:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbdHPBM1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 21:12:27 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:33059 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752066AbdHPBM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 21:12:26 -0400
Received: by mail-yw0-f176.google.com with SMTP id p68so14465820ywg.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 18:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nU2O63RbODXD8YW+vloKbZAZ0JQ5FBitYuXgRRIhLtA=;
        b=i2eZ9BPBCO3fpi/MFPGMQ6zwZKV8Cq1g+pDcjyWbYSimL2rKWuO8wGKL+O/ODDRCjJ
         cjoZ8SydZW7NUtD2nG909SFNtOXdbkQwqnEOej7LXNfq1iq1AgeFFplSMFgH59KUhvsH
         TfU2P+zZzbAv1j6XbMYhq7zqg8zZqFNMw8Ulu/46c1PhOfX4XpsOg2xNdLQhYwchxk1x
         jWHqjHQGZvg/plktenTe5G0hS8H56mxQ6zfOSPUceUB4QJ17TcZREFjs0Y8x7m0BPf9R
         H+CS/iEOStnLTOW6iQQzbGvoqh4UjIGE02GDGyE62Bbyn2BZQMnkA5wmKxxZ2JA10Vqm
         oLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nU2O63RbODXD8YW+vloKbZAZ0JQ5FBitYuXgRRIhLtA=;
        b=lXuM8b2G4CLS1hilZ2H56WqEbrhq0fiscsAe6xpFC5PliwU/UunDy+TSDi3utD5iUP
         hoQgADCGLFfKY//8F2J1VNkV1Kl6XTXlsdisaaX3rX7wjkeusLHuDRWH8GN1WTyMKNiQ
         l96pPzRCeC9vZAeviQP54iWR7/YniryidLLEV+XxbGhudA6K/ldMTS9mS+FI5kDTDHYw
         KuMoVA9qj2ONYdCaXovHnPSH3WKhgFqfqmwZ6NbGGKc7w8wXrXyZvAZGqMS0W774uoms
         Lv/hvCdKst8RSqoEX8DkhDmO8NmHpDt8VMyZSNaf3or+l+e2OzLV+goKyVpvnAf2rup7
         IOQA==
X-Gm-Message-State: AHYfb5jEOr3UuLkS8fFSBLtp/bRKnucHrweXUfgFv1f0Q+a1gQ97DZDI
        CWQ23GkmnXruX+bV79xmt2h1fpXbX5pd
X-Received: by 10.37.115.78 with SMTP id o75mr47984ybc.244.1502845946084; Tue,
 15 Aug 2017 18:12:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Tue, 15 Aug 2017 18:12:25 -0700 (PDT)
In-Reply-To: <20170816010432.GD21874@google.com>
References: <20170816004558.6706-1-sbeller@google.com> <20170816010432.GD21874@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Aug 2017 18:12:25 -0700
Message-ID: <CAGZ79kYacubf_8qF=3heuwzEEa93KLV8_LsJo5hemhpKVbujfg@mail.gmail.com>
Subject: Re: [PATCH] convert add_to_alternates_file to use repository struct
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 6:04 PM, Brandon Williams <bmwill@google.com> wrote:
> On 08/15, Stefan Beller wrote:
>> The long term plan is to move most functionality to be included via
>> the repository struct, starting somewhere, convert add_to_alternates_file
>> in this patch, which has link_alt_odb_entries, which is converted, too.
>> Any caller outside add_to_alternates_file, just uses `the_repository`
>> as the repository argument to keep the functionality the same.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>>   For the series "object store is embedded in the repository object",
>>   I realized we have to convert sha1_file first as that is the foundation
>>   of all the object loading and writing. However there are currently other
>>   series in flight, such that I do not want to change all of sha1_file
>>   as it would yield serious conflicts.
>>
>>   This goes on top of origin/sb/sha1-file-cleanup and is one of the
>>   minimum viable things to get started with converting sha1_file to
>>   use the repository object.
>>
>>   Thanks,
>>   Stefan
>>
>>  builtin/clone.c |  9 +++++----
>>  cache.h         |  2 +-
>>  sha1_file.c     | 23 +++++++++++++++--------
>>  3 files changed, 21 insertions(+), 13 deletions(-)
>>
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index 08b5cc433c..b8d170d055 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -25,6 +25,7 @@
>>  #include "remote.h"
>>  #include "run-command.h"
>>  #include "connected.h"
>> +#include "repository.h"
>>
>>  /*
>>   * Overall FIXMEs:
>> @@ -327,7 +328,7 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
>>       } else {
>>               struct strbuf sb = STRBUF_INIT;
>>               strbuf_addf(&sb, "%s/objects", ref_git);
>> -             add_to_alternates_file(sb.buf);
>> +             add_to_alternates_file(the_repository, sb.buf);
>>               strbuf_release(&sb);
>>       }
>>
>> @@ -369,12 +370,12 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
>>               if (!line.len || line.buf[0] == '#')
>>                       continue;
>>               if (is_absolute_path(line.buf)) {
>> -                     add_to_alternates_file(line.buf);
>> +                     add_to_alternates_file(the_repository, line.buf);
>>                       continue;
>>               }
>>               abs_path = mkpathdup("%s/objects/%s", src_repo, line.buf);
>>               if (!normalize_path_copy(abs_path, abs_path))
>> -                     add_to_alternates_file(abs_path);
>> +                     add_to_alternates_file(the_repository, abs_path);
>>               else
>>                       warning("skipping invalid relative alternate: %s/%s",
>>                               src_repo, line.buf);
>> @@ -452,7 +453,7 @@ static void clone_local(const char *src_repo, const char *dest_repo)
>>       if (option_shared) {
>>               struct strbuf alt = STRBUF_INIT;
>>               strbuf_addf(&alt, "%s/objects", src_repo);
>> -             add_to_alternates_file(alt.buf);
>> +             add_to_alternates_file(the_repository, alt.buf);
>>               strbuf_release(&alt);
>>       } else {
>>               struct strbuf src = STRBUF_INIT;
>> diff --git a/cache.h b/cache.h
>> index 4109efcf24..fe1f1bc66a 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -1565,7 +1565,7 @@ struct alternate_object_database *alloc_alt_odb(const char *dir);
>>   * Add the directory to the on-disk alternates file; the new entry will also
>>   * take effect in the current process.
>>   */
>> -extern void add_to_alternates_file(const char *dir);
>> +extern void add_to_alternates_file(struct repository *r, const char *dir);
>>
>>  /*
>>   * Add the directory to the in-memory list of alternates (along with any
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 9186e2c6c7..298185f550 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -22,6 +22,7 @@
>>  #include "pack-revindex.h"
>>  #include "sha1-lookup.h"
>>  #include "bulk-checkin.h"
>> +#include "repository.h"
>>  #include "streaming.h"
>>  #include "dir.h"
>>  #include "mru.h"
>> @@ -422,8 +423,9 @@ static const char *parse_alt_odb_entry(const char *string,
>>       return end;
>>  }
>>
>> -static void link_alt_odb_entries(const char *alt, int len, int sep,
>> -                              const char *relative_base, int depth)
>> +static void link_alt_odb_entries(const struct repository *r, const char *alt,
>> +                              int len, int sep, const char *relative_base,
>> +                              int depth)
>
> Looks like the passed in repository 'r' isn't used in this function.  Is this intentional?
>

Doh. I missed that part in the implementation, I need to pipe it through to
link_alt_odb_entry.
