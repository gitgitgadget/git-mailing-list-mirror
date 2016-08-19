Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E55031F859
	for <e@80x24.org>; Fri, 19 Aug 2016 20:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755295AbcHSUvR (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 16:51:17 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:35331 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754171AbcHSUvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 16:51:16 -0400
Received: by mail-yb0-f196.google.com with SMTP id x37so1649271ybh.2
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 13:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lovAEaK7aWBsPg2+1O2j4PgSUm82Op2nH4NHp+Vgy5k=;
        b=kEVukFJ+jPqAfj0eUKzcMI8bA05nwLDYO4M4jzKfcK39SWu8ukKsadV1uFv71LBsoC
         C0VqID7r1JuXmzmHNVzZFyfjAEj2WP71Dh+qgeWapDvlhsYZG4W6TcZO2ENFxyeyym6B
         lJa/BNpscdA+fGpFIxPRgG+xcxTZng0sC3q8/LtTre/o0zDUkbuXW/JgAXycRsoHw+AS
         EOUJ7jLbXKyavNf4XdVtM85la3i/igNkBUCFU+etqDDIIy28VcAQqKHCOoTzYvffrrvO
         IrCJlQj/lu9kfTxLL4XKBAOkTNBvL+Yx/PwoSuuhGDpmAoF15OHmUpTXRwu4czQKuwTW
         ROqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lovAEaK7aWBsPg2+1O2j4PgSUm82Op2nH4NHp+Vgy5k=;
        b=PK+FAbjRp0aN4S7xPA6EN5Z4UkQJ8vvzCcIzTbXlcIRMVv3oRueJ1upLS6QtkN80JS
         Hxf/SuoIO3a4gRXkWwLAQJWlYQ5u6GXzkdsts1pLmt7rzh7hcOtZ1RsYZajvpJylKW4w
         Nf1fY1EZhYoLtQXHg+lgE7S9EMe/BFAQGWkn3UKIdFlxp2a8O3ve01aFBVVZmfoV9YkC
         Xhsi9qX3tIkB5Cg9up91d8hKvolEurOAgbXswNClGYdvXRdicfNET0BflRsK8YDd2JWy
         unOchS1I6x69NW/Y7gvh7RrH4O9cgdRYd7mEmwwmhOWn3llVFXRnlwYT4n2lEpb6dm7E
         ch8g==
X-Gm-Message-State: AEkoouvt51v74FU6JNPSanIgi3DxICH1R1NKhz0k2P760kho1YGOcPtUlCXQIOa3nJcyBiiN8qMDVa/HRiQomA==
X-Received: by 10.37.97.149 with SMTP id v143mr7675369ybb.164.1471638768065;
 Fri, 19 Aug 2016 13:32:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Fri, 19 Aug 2016 13:32:27 -0700 (PDT)
In-Reply-To: <xmqqvayw1q1z.fsf@gitster.mtv.corp.google.com>
References: <20160819000031.24854-1-jacob.e.keller@intel.com>
 <20160819000031.24854-5-jacob.e.keller@intel.com> <xmqqvayw1q1z.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 19 Aug 2016 13:32:27 -0700
Message-ID: <CA+P7+xrFkCbLyvXKt1PKYsdFH2rCmjdMEyB27sDEScvGhxs7XA@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] submodule: allow add_submodule_odb to work even if
 path is not checked out
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 1:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> diff --git a/path.c b/path.c
>> index 17551c483476..0cb30123e988 100644
>> --- a/path.c
>> +++ b/path.c
>> @@ -482,6 +482,11 @@ static void do_submodule_path(struct strbuf *buf, const char *path,
>>               strbuf_reset(buf);
>>               strbuf_addstr(buf, git_dir);
>>       }
>> +     if (!is_git_directory(buf->buf)) {
>> +             strbuf_reset(buf);
>> +             strbuf_git_path(buf, "%s/%s", "modules", path);
>> +     }
>> +
>>       strbuf_addch(buf, '/');
>>       strbuf_addbuf(&git_submodule_dir, buf);
>
> So, given submodule at $path, so far we have tried $path/.git and
> would have been happy if it was already a directory (i.e. an
> embedded repository in place), would have been happy if it was
> pointing at elsewhere (presumably at .git/modules/$name) that is a
> directory, and this is a fallback that covers the case where $path
> in the working tree of the superproject is missing.
>
> I _think_ "path" needs to be mapped to the "name" of the submodule
> that should be at the "path".  Other than that, this hunk looks
> correct to me.

How do we do that? I tried to find a way to do that, couldn't, and
decided it was probably already normalized. It seems to be, based on
my tests, where I run git-log from within a subdirectory that has the
submodule. I think we already have the complete path. Or is the name
*not* equivalent to the path?

>
>> diff --git a/submodule.c b/submodule.c
>> index 1b5cdfb7e784..e1a51b7506ff 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -348,7 +348,7 @@ void show_submodule_summary(FILE *f, const char *path,
>>       if (is_null_sha1(two))
>>               message = "(submodule deleted)";
>>       else if (add_submodule_odb(path))
>> -             message = "(not checked out)";
>> +             message = "(not initialized)";
>>       else if (is_null_sha1(one))
>>               message = "(new submodule)";
>>       else if (!(left = lookup_commit_reference(one)) ||
>
> This is a change unrelated to the fix you made above, and should be
> done in its own separate patch, I would think.
>

It is the same change. The first hunk makes it so that "not checked
out" is no longer what occurs. We change the behavior of
add_submodule_odb into "work even if there is no check out, but only
fail when the submodule isn't initialized at all, either in path/.git
or ./git/modules/path/" so we need to change the message because we've
changed behavior.

>> diff --git a/t/t4059-diff-submodule-not-initialized.sh b/t/t4059-diff-submodule-not-initialized.sh
>> new file mode 100755
>> index 000000000000..cc787454033a
>> --- /dev/null
>> +++ b/t/t4059-diff-submodule-not-initialized.sh
>> @@ -0,0 +1,105 @@
>> +#!/bin/sh
>> +#
>> +# Copyright (c) 2016 Jacob Keller, based on t4041 by Jens Lehmann
>> +#
>> +
>> +test_description='Test for submodule diff on non-checked out submodule
>> +
>> +This test tries to verify that add_submodule_odb works when the submodule was
>> +initialized previously but the checkout has since been removed.
>> +'
>> +
>> +TEST_NO_CREATE_REPO=1
>> +. ./test-lib.sh
>> +
>> +# Tested non-UTF-8 encoding
>> +test_encoding="ISO8859-1"
>> +
>> +# String "added" in German (translated with Google Translate), encoded in UTF-8,
>> +# used in sample commit log messages in add_file() function below.
>> +added=$(printf "hinzugef\303\274gt")
>
> Have an empty line here?
>

Makes sense I suppose.

>> +add_file () {
>> +     (
>> +             cd "$1" &&
>> +             shift &&
>> +             for name
>> +             do
>> +                     echo "$name" >"$name" &&
>> +                     git add "$name" &&
>> +                     test_tick &&
>> +                     # "git commit -m" would break MinGW, as Windows refuse to pass
>> +                     # $test_encoding encoded parameter to git.
>> +                     echo "Add $name ($added $name)" | iconv -f utf-8 -t $test_encoding |
>> +                     git -c "i18n.commitEncoding=$test_encoding" commit -F -
>> +             done >/dev/null &&
>> +             git rev-parse --short --verify HEAD
>> +     )
>> +}
>
> Have an empty line here?
>

There was no empty line in the place I copied from.

>> +commit_file () {
>> +     test_tick &&
>> +     git commit "$@" -m "Commit $*" >/dev/null
>> +}
>
> Surround these ...
>
>> +test_create_repo sm1 &&
>> +test_create_repo sm2 &&
>> +add_file sm1 foo >/dev/null &&
>> +add_file sm2 foo1 foo2 >/dev/null &&
>> +smhead1=$(cd sm2; git rev-parse --short --verify HEAD) &&
>
> ... inside its own "test_expect_success setup"?
>
> None of the ">/dev/null" we see in the above helper functions (and
> use of these helper functions) are necessary or desired, I would
> think.

If we put them in test_expect_success setup they aren't. They were
because add_file returns the sha1 of the rev-parse on HEAD after
adding.

>
> The last one can become "$(git -C sm2 rev-parse ...)".
>

Yea.

>> +cd sm1
>
> I can sort of see the attraction of doing it this way, but we avoid
> chdir'ing around outside subshells, especially in a newly added test
> script.  It is very easy to go down and forget to come back up, or
> worse yet, stop going down and forget to remove matching "cd .." and
> end up being outside the $TEST_DIRECTORY by mistake.
>

That would make a lot of tests problematic here.. but probably doable.

>> +test_expect_success 'setup - submodule directory' '
>> +...
>> +
>> +cd ..
>> +
>> +test_expect_success 'submodule not initialized in new clone' '
>> +...
>
> The tests themselves looked sensible.  Thanks.

Thanks,
Jake
