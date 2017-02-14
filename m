Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D66D02013A
	for <e@80x24.org>; Tue, 14 Feb 2017 09:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752850AbdBNJcm (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 04:32:42 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33492 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752418AbdBNJck (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 04:32:40 -0500
Received: by mail-ot0-f195.google.com with SMTP id t47so681758ota.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 01:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ff5NlqvfHa+AVjAUU952APKWcFLyqFIpUfY+55ooYyM=;
        b=IcoEHV8mpG+hCfjG7TvbAvL/HzoZS9sLHkSaFG09qYxFN8AvpqYYeZAUp22g7EV/Ml
         +YS8dmnxEkVAQgcSU5DvNkI4hnvzHtGc3CWA8VAbotwK6aXI31YsWF4rhkSm4jsiBQ+C
         W1wHCcWDW0YkbaqR23Eg6euoDgoSio+jMkFVL6qdtmN4PKckFO6wP2vXaOYBkS67EFCT
         N/S67ykxNaJz/Wr4ig0B9HGvL+Dvd0N1DAXTc37ewotualtIQhvnnrYzzzklf9c2PvZ1
         D5bBLoGphxxTFkbbapwNU8wFEDfWpnm1t6A36cgxYErGwMcFEFwdHGXkQK6NR5fOhkMu
         ve1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ff5NlqvfHa+AVjAUU952APKWcFLyqFIpUfY+55ooYyM=;
        b=m4+ltepi+my4Jb+vYInsh3gvny7LEny1nBMqNnYy4Wc1wrpFJhoo18Zn9Y1OpiWiR1
         orlKbYdNs0IAXyBKkf5JmZ4kCHxXdW/4DLaW4N+c1cjagLtmTyymQ0jUfMQOdrkF1358
         N0vwQg0J9KT5wUWCxwaUXkMl3qAChCger/iKb9cIQBVsCLYmoEnZP8Dw5KoQMvtw7mjo
         tKhbl37azYB7wBX5ICLLug8NxyYwCSpKNx8YaEx+pBhor3A9JCeQc+/V68H/uskMwxUe
         87EIfSP5hq3jGdMNjXXrACwah/Mxqn6zyw/+bV7rkA9aDZ1X1qtEUnixui93HBfM2HI0
         9k1A==
X-Gm-Message-State: AMke39lHkDwibPqyn3QkPtf5zxuLnqwWTVV4XHJDFlaq68PuojwqkkjQHyzTIBgXS1Hr6q4u3g50SYVCCYYF8g==
X-Received: by 10.157.46.57 with SMTP id q54mr17631961otb.28.1487064759222;
 Tue, 14 Feb 2017 01:32:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Tue, 14 Feb 2017 01:32:08 -0800 (PST)
In-Reply-To: <CAGZ79kannQDWWYN5rHr6q-6=o1_ajeEjLn8Wzsc4RjqkfYOYwg@mail.gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com> <20170213152011.12050-10-pclouds@gmail.com>
 <CAGZ79kannQDWWYN5rHr6q-6=o1_ajeEjLn8Wzsc4RjqkfYOYwg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 14 Feb 2017 16:32:08 +0700
Message-ID: <CACsJy8B-B9Ebz2tXCq4sUzMGfnp6ojGcEXA4amSOsCN1u2SjNQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] refs: move submodule code out of files-backend.c
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 6:35 AM, Stefan Beller <sbeller@google.com> wrote:
>> +       git_dir = read_gitfile(buf.buf);
>
> if buf.buf is a (git) directory as opposed to a git file,
> we error out in read_gitfile. Did you mean to use
> read_gitfile_gently here or rather even resolve_gitdir_gently ?

This is what strbuf_git_path_submodule() does. I don't know the
backstory so I'm going to keep it as it is to keep the behavior
exactly (or very close) as before. We can replace it with a better
version (with explanation and all).

>> +       if (git_dir) {
>
> when not using the _gently version git_dir is always
> non NULL here (or we're dead)?
>
>> +               strbuf_reset(&buf);
>> +               strbuf_addstr(&buf, git_dir);
>> +       }
>> +       if (!is_git_directory(buf.buf)) {
>> +               gitmodules_config();
>> +               sub = submodule_from_path(null_sha1, path);
>> +               if (!sub)
>> +                       goto done;
>> +               strbuf_reset(&buf);
>> +               strbuf_git_path(&buf, "%s/%s", "modules", sub->name);
>
> You can inline "modules" into the format string?

Hm.. because this is strbuf_git_path_submodule() code. Perhaps it's
better to split it to a separate function and call it from here? Then
you can make more improvements on top that benefit everybody.

>>         } else {
>>                 strbuf_addstr(&refs->gitdir, get_git_dir());
>>                 strbuf_addstr(&refs->gitcommondir, get_git_common_dir());
>> @@ -1034,8 +1025,6 @@ static struct ref_store *files_ref_store_create(const char *submodule)
>>  static void files_assert_main_repository(struct files_ref_store *refs,
>>                                          const char *caller)
>>  {
>> -       if (refs->submodule)
>> -               die("BUG: %s called for a submodule", caller);
>>  }
>
> In a followup we'd get rid of files_assert_main_repository
> presumably?

Yes. Can't delete it now because I would need to touch all callers.
-- 
Duy
