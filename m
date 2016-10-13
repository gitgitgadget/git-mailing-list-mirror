Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03FB920989
	for <e@80x24.org>; Thu, 13 Oct 2016 18:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756260AbcJMSsV (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 14:48:21 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:32847 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754692AbcJMSsR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 14:48:17 -0400
Received: by mail-qt0-f178.google.com with SMTP id s49so54921450qta.0
        for <git@vger.kernel.org>; Thu, 13 Oct 2016 11:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zgIjt+gfYTiGIDpPPjVDCKtFvu5tKpMHAQSRn7fNE+E=;
        b=kSYJ2Sc5vj+sJohYr37RRswX6S8sfMEHMbrIITNPwusuGDo+uPKihCYUWv10GLvdDM
         7TKDi1OG35gX5O6rXMAvwSe8L2YJD/H24C9AZ5RZs7siUVkXDflgUhQMVwQaGjCtcVDn
         X2Pif85erg7FaHuZ+XOT+fPYf9UHCWM+BWmxp+VmzZ5TIgQRuly2BDxWfZGs0rH9jDVJ
         6pCKNq0iYldR2Uwz0l5eGeZtg3elUgObWSFnJ9HKhor5amZgxyfTx3zrv22xv8NWyz5H
         JZBdNSuRJ8i57m0h96GntU0BZEeBQPXkt2tQ+T9K4t7U4LBNANrdf0Nc1JcadxDECzAK
         QaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zgIjt+gfYTiGIDpPPjVDCKtFvu5tKpMHAQSRn7fNE+E=;
        b=EEbJXU8kTMYMnKUbRaLGatV9oFFeDNnLUXu3bBmgbr6E1Q/Ou89FNINhF4bt7SsKym
         gPo0/RHHSisgdfKsybRdjdZ+dQ59guc5Qfucri/muCfj47twlBaAsu5ufzfPReVU/V6e
         DwWqZCm24hXvWimjgGQHjGzGoaJCj+gW6ltaUPy3XmFzO/YiKjU1JNxvO2qUbdGjJLKs
         a177oZNiy/uyEQmiAh9Gx2wZlWMkhrnPx8TB2z1np5SbGBGDlYd3+Aw5fTW24dRhhuKr
         uULDEbas8ea1Knb6bk5BZU6oXuGP+KDTzr42Nzu1jm+dt6Id8BD4gDnmDRPZr50FmHpd
         jqnw==
X-Gm-Message-State: AA6/9RkIUPjoltFMrXv9zWlV/o4e02LZd6oX+6pPjlC1xi8RkRhWXu5IATA/o4UbUPZdGR4MGLkCIGCqQSvABK61
X-Received: by 10.200.34.6 with SMTP id o6mr8630427qto.88.1476384139018; Thu,
 13 Oct 2016 11:42:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 13 Oct 2016 11:42:18 -0700 (PDT)
In-Reply-To: <xmqqfuo116t0.fsf@gitster.mtv.corp.google.com>
References: <20161012224109.23410-1-sbeller@google.com> <xmqqfuo116t0.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Oct 2016 11:42:18 -0700
Message-ID: <CAGZ79kYEefzKJT5TLXaGV0ZYoW=OUzrRBPTOovDG0ofO8-i5Jg@mail.gmail.com>
Subject: Re: [PATCHv3] attr: convert to new threadsafe API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 4:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> @@ -89,15 +114,20 @@ static void setup_check(void)
>>
>>  ------------
>>       const char *path;
>> +     struct git_attr_result *result;
>>
>>       setup_check();
>> -     git_check_attr(path, check);
>> +     result = git_check_attr(path, check);
>
> This looks stale by a few revisions of the other parts of the patch?

I'll update the documentation.

>
>> diff --git a/archive.c b/archive.c
>> index 11e3951..15849a8 100644
>> --- a/archive.c
>> +++ b/archive.c
>> @@ -107,10 +107,12 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
>>               void *context)
>>  {
>>       static struct strbuf path = STRBUF_INIT;
>> +     static struct git_attr_check *check;
>> +
>>       struct archiver_context *c = context;
>>       struct archiver_args *args = c->args;
>>       write_archive_entry_fn_t write_entry = c->write_entry;
>> -     static struct git_attr_check *check;
>> +     struct git_attr_result result = GIT_ATTR_RESULT_INIT;
>>       const char *path_without_prefix;
>>       int err;
>>
>> @@ -124,12 +126,16 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
>>               strbuf_addch(&path, '/');
>>       path_without_prefix = path.buf + args->baselen;
>>
>> -     if (!check)
>> -             check = git_attr_check_initl("export-ignore", "export-subst", NULL);
>> -     if (!git_check_attr(path_without_prefix, check)) {
>> -             if (ATTR_TRUE(check->check[0].value))
>> +     git_attr_check_initl(&check, "export-ignore", "export-subst", NULL);
>> +     git_attr_result_init(&result, check);
>> +
>> +     if (!git_check_attr(path_without_prefix, check, &result)) {
>> +             if (ATTR_TRUE(result.value[0])) {
>> +                     git_attr_result_clear(&result);
>>                       return 0;
>> -             args->convert = ATTR_TRUE(check->check[1].value);
>> +             }
>> +             args->convert = ATTR_TRUE(result.value[1]);
>> +             git_attr_result_clear(&result);
>>       }
>
> This is exactly what I meant by "can we avoid alloc/free of result
> in leaf function when we _know_ how many attributes we are
> interested in already, which is the majority of the case?".

We can avoid that. For now I settled with an implementation that
has no "answer" type, but uses a bare "const char *result[FLEX_ARRAY];",
or rather a const char **.

>
> Starting with a simple but unoptimized internal implementation of
> the attr subsystem is one thing (which is good).  Exposing an API that
> cannot be optimally implemented later without changing the callers
> is another (which is bad).
>
> By encapsulating each element into "struct git_attr_result", we can
> extend the API without changing the API user [*1*].

Oh I see.

So instead of a raw string we want to have

struct git_attr_result {
    const char *value;
};

just to have it extensible. Makes sense. I'll redo that.


>
> But I do not think of a way to allow an efficient implementation
> later unless the source of the API user somehow says "this user is
> only interested in this many attributes", like having this
>
>         struct git_attr_result result[2];

    const char *result[2] = {NULL, NULL};

as of now would be

    struct git_attr_result result[2];

but we'd lose the ability to set them to NULL easily. Probably not needed.

>
> (because this caller only wants "ignore" and "subst") on the API
> user's side [*2*].  Without such a clue (like the patch above, that
> only says "there is a structure called 'result'"), I do not think of
> a way to avoid dynamic allocation on the API implementation side.
>
> All the other callers in the patch (pack-objects, convert, ll-merge,
> etc.) seem to share the exact same pattern.  Each of the leaf
> functions knows a fixed set of attributes it is interested in, the
> caller iterates over many paths and makes calls to these leaf
> functions, and it is a waste to pay alloc/free overhead for each and
> every iteration when we know how many elements result needs to
> store.
>

Right.

>
> [Footnote]
>
> *1* Would we need a wrapping struct around the array of results?  If
>     that is the case, we may need something ugly like this on the
>     API user side:
>
>         GIT_ATTR_RESULT_TYPE(2) result = {2,};
>
>     with something like the following on the API implementation
>     side:
>
>         #define GIT_ATTR_RESULT_TYPE(n) \
>             struct { \
>                     int num_slots; \
>                     const char *value[n]; \
>             }
>
>         struct git_attr_result {
>                 int num_slots;
>                 const char *value[FLEX_ARRAY];
>         };
>         git_attr_result_init(void *result_, struct git_attr_check *check)
>         {
>                 struct git_attr_result *result = result_;
>
>                 assert(result->num_slots, check->num_attrs);
>                 ...
>         }
>         git_check_attr(const char *path,
>                        struct git_attr_check *check,
>                        void *result_)
>         {
>                 struct git_attr_result *result = result_;
>
>                 assert(result->num_slots, check->num_attrs);
>                 for (i = 0; i < check_num_attrs; i++)
>                         result->value[i] = ... found value ...;
>         }
>
>
> *2* Or the uglier
>
>         GIT_ATTR_RESULT_TYPE(2) result = {2,};
>
>     I can see why the "check" side would benefit from a structure
>     that contains an array, but I do not see why "result" side would
>     want to, so I am hoping that we won't have to do this uglier
>     variant and just go with the simple "array of resulting values".

So I currently have the "array of resulting values", but not wrapped.

Do we expect to get more than the values out of the attr system?
