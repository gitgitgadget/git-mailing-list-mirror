Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 258FD1F6C1
	for <e@80x24.org>; Sat, 27 Aug 2016 19:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751194AbcH0TrV (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 15:47:21 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:36597 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751487AbcH0TrU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 15:47:20 -0400
Received: by mail-yw0-f175.google.com with SMTP id u134so66694692ywg.3
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mCg7ImoMWGjwWzVzp5ksIgnWhM/GqJWzYj36Eow9+KU=;
        b=bn79bP5dB8DlyoGx1SUGUE5pqusmE8TkdTet4bEHNnli2zV4rLMcIQ2ZRqrtK1prBR
         hEIrwp7iRVEd1rMz/Uio4DBckZIlHV0srqGja4MKKmFTljYM+aTQbgKkyNkGm4StLw9+
         K6Ivp42YPD05xJn7fThoDcjPvloC67x1GK0VQcRL8Zc0kL7mp628drcgVVpzaQQc7FVt
         H6ExxuAI4RrvoOX62yImZe/WU3bVDkvClhSBTk+6cLHx+oVj7ZvWnM/hLaGQ7BDn91hI
         ZJo4bwD0mstanJ5Ks06C/Jj37Z3/6Z9dm2jN2r3QyKvXAI81cJtk+dCwJyoXtZH5fu9+
         NTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mCg7ImoMWGjwWzVzp5ksIgnWhM/GqJWzYj36Eow9+KU=;
        b=BIJXWNOsWZZmM9n+ULqWdknEpTXzHzTQwWrmE+GJ0zeBtFuinwYhvIl67StigQY34Q
         RGLM+0FrSHNLNEAZTOwMiwRQjjifzqOZV2Jny7mIvCewONvgSuDTsapRPPIt17nrDeGJ
         2FY1QRdK6aP/vQ5EUNZBVh7tXq5QwbiGOnObThHYVKDzx2CV3+9P8vHFX+QN/87Pgb/v
         buqj4w/SpcAXFdZXcjGSndKkfBNva8OtBbjSp7kwaWYgFKh1E5qJYS50Gj7wccBK9hP8
         JVLvoKsYxKWqifwmzbMW99ER/YYtnpr4AOCAW/vR3J2/ZmwpRU6waP+eFaPNhkAlV79Q
         C8FQ==
X-Gm-Message-State: AE9vXwNusARqZnhE4TCKNzzmExL6p7rk5FQ/fLXB+00eOPCUEjsqsYIVtXbjTt1Az/bbHxPFQnQM7oTZ1vatiQ==
X-Received: by 10.129.136.5 with SMTP id y5mr9257103ywf.30.1472327230686; Sat,
 27 Aug 2016 12:47:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Sat, 27 Aug 2016 12:47:10 -0700 (PDT)
In-Reply-To: <xmqqd1kwn035.fsf@gitster.mtv.corp.google.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
 <01020156b73fe6b9-5e500c96-9bc3-4a6b-beb9-b5988dc9ee85-000000@eu-west-1.amazonses.com>
 <xmqqd1kwn035.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sun, 28 Aug 2016 01:17:10 +0530
Message-ID: <CAFZEwPMotQ1k0EZN-buEt9MhJUKhXLS8eB5zV5A3Qr-j=DEwfQ@mail.gmail.com>
Subject: Re: [PATCH v14 13/27] bisect--helper: `bisect_start` shell function
 partially in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Fri, Aug 26, 2016 at 12:32 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> +static int bisect_start(struct bisect_terms *terms, int no_checkout,
>> +                     const char **argv, int argc)
>> +{
>> +     int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
>> +     int flags, pathspec_pos;
>> +     struct string_list revs = STRING_LIST_INIT_DUP;
>> +     struct string_list states = STRING_LIST_INIT_DUP;
>
> The original has a single state, not states.  Let's see if there is
> a reason behind the name change....
>
>> +     unsigned char sha1[20];
>> +     struct object_id oid;
>
> More on these below...
>
>> + ...
>> +     for (i = 0; i < argc; i++) {
>> +             const char *commit_id = xstrfmt("%s^{commit}", argv[i]);
>> +             if (!strcmp(argv[i], "--")) {
>> +                     has_double_dash = 1;
>> +                     break;
>> +             } else if (!strcmp(argv[i], "--no-checkout"))
>> +                     no_checkout = 1;
>> +             else if (!strcmp(argv[i], "--term-good") ||
>> + ...
>> +             } else if (starts_with(argv[i], "--") &&
>> +                      !one_of(argv[i], "--term-good", "--term-bad", NULL)) {
>> +                     string_list_clear(&revs, 0);
>> +                     string_list_clear(&states, 0);
>> +                     die(_("unrecognised option: '%s'"), argv[i]);
>> +             } else if (get_oid(commit_id, &oid) && has_double_dash) {
>> +                     string_list_clear(&revs, 0);
>> +                     string_list_clear(&states, 0);
>> +                     die(_("'%s' does not appear to be a valid revision"), argv[i]);
>> +             } else {
>> +                     string_list_append(&revs, oid_to_hex(&oid));
>> +             }
>> +     }
>
> What I do not understand is clearing the string list "states" inside
> this loop.  It may have been INIT_DUPed, but nothing in this loop
> adds anything to it.  Because "revs" does get extended in the loop,
> it is understandable if you wanted to clear it before dying, but "if
> you are dying anyway why bother clearing?" is also a valid stance to
> take.

I think I should probably use return here instead of die().

> The same "perhaps want to use the 'retval' with goto 'finish:' pattern?"
> comment applies here, too.

Okay sure could do that.

>> +     pathspec_pos = i;
>> +
>> +     /*
>> +      * The user ran "git bisect start <sha1> <sha1>", hence did not
>> +      * explicitly specify the terms, but we are already starting to
>> +      * set references named with the default terms, and won't be able
>> +      * to change afterwards.
>> +      */
>> +     must_write_terms |= !!revs.nr;
>> +     for (i = 0; i < revs.nr; i++) {
>> +             if (bad_seen)
>> +                     string_list_append(&states, terms->term_good.buf);
>> +             else {
>> +                     bad_seen = 1;
>> +                     string_list_append(&states, terms->term_bad.buf);
>> +             }
>> +     }
>
> This is certainly different from the original.  We used to do one
> "bisect_write" per element in revs in the loop; we no longer do that
> and instead collect them in states list.  Each element in these two
> lists, i.e. revs.item[i] and states.item[i], corresponds to each
> other.
>
> That explains why the variable is renamed to states.  We haven't
> seen enough to say if this behaviour change is a good idea or not.
>
>> +     /*
>> +      * Verify HEAD
>> +      */
>> +     head = resolve_ref_unsafe("HEAD", 0, sha1, &flags);
>> +     if (!head) {
>> +             if (get_sha1("HEAD", sha1)) {
>> +                     string_list_clear(&revs, 0);
>> +                     string_list_clear(&states, 0);
>> +                     die(_("Bad HEAD - I need a HEAD"));
>> +             }
>> +     }
>> +     if (!is_empty_or_missing_file(git_path_bisect_start())) {
>> +             /* Reset to the rev from where we started */
>> +             strbuf_read_file(&start_head, git_path_bisect_start(), 0);
>> +             strbuf_trim(&start_head);
>> +             if (!no_checkout) {
>> +                     struct argv_array argv = ARGV_ARRAY_INIT;
>> +                     argv_array_pushl(&argv, "checkout", start_head.buf,
>> +                                      "--", NULL);
>> +                     if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
>> +                             error(_("checking out '%s' failed. Try 'git "
>> +                                     "bisect start <valid-branch>'."),
>> +                                   start_head.buf);
>> +                             strbuf_release(&start_head);
>> +                             string_list_clear(&revs, 0);
>> +                             string_list_clear(&states, 0);
>> +                             return -1;
>
> The original died here, but you expect the caller to respond to a
> negative return.  I haven't read enough to judge if that is a good
> idea, but doesn't it make sense to do the same throughout the
> function consistently?  I saw a few die()'s already in the command
> line parsing loop--shouldn't they also return -1?

Yes they should use return rather than die().

> The original has called bisect_write already when we attempt this
> checkout and the user will see the states in the filesystem.  This
> rewrite does not.  What effect does this behaviour change have to
> the end-user experience?  The error message tells the end user to
> run another "git bisect start" with a valid commit, and when that
> happens, hopefully she will give us something we can check out, and
> then we will hit the bisect_clean_state() call we see below before
> starting to do anything meaningful, so I am guessing it won't, but
> I just want to make sure that you thought about the ramifications
> of the change above to delay calls to bisect_write.
>
>> +                     }
>> +             }
>> +     } else {
>> +             if (starts_with(head, "refs/heads/") ||
>> +                 !get_oid_hex(head, &oid) || ref_exists(head)) {
>
> This ref_exists() check is new, and I think it should not be there.
> In the original, if .git/HEAD pointed at refs/tags/v1.0, we would
> have diagnosed it as a strange symbolic ref.  This no longer does.
>
> If you wanted to make sure that the branch exists, it should have
> been
>
>         if ((starts_with(head, "refs/heads/") && ref_exists(head)) ||
>             !get_oid_hex(head, &oid)) {
>
> anyway.

I forgot to consider about tags. Thanks for reminding.

> Also, why do you use get_oid_hex() here?  You used get_sha1("HEAD",
> sha1) in the early part of "Verify HEAD" above, which seems to be
> perfectly adequate.  That sha1 taken from get_sha1() is what you end
> up using in the code below anyway.  If you can stick to one or the
> other, please do so.

I should use get_sha1().

>> +                     /*
>> +                      * This error message should only be triggered by
>> +                      * cogito usage, and cogito users should understand
>> +                      * it relates to cg-seek.
>> +                      */
>> +                     if (!is_empty_or_missing_file(git_path_head_name())) {
>> +                             strbuf_release(&start_head);
>> +                             string_list_clear(&revs, 0);
>> +                             string_list_clear(&states, 0);
>> +                             die(_("won't bisect on cg-seek'ed tree"));
>> +                     }
>
> Not to be done as part of this series, but it probably is safe to
> retire this part by now.  Cogito has been dead for how many years?

Been around 10 years. Last update seemed around 2006. Here is the link[1].

>> +                     if (starts_with(head, "refs/heads/")) {
>> +                             strbuf_reset(&start_head);
>> +                             strbuf_addstr(&start_head, head + 11);
>
> skip_prefix?

Ya sure! That's a better way to go.

>> +                     }
>> +                     else {
>> +                             strbuf_reset(&start_head);
>> +                             strbuf_addstr(&start_head, sha1_to_hex(sha1));
>> +                     }
>> +             } else {
>> +                     strbuf_release(&start_head);
>> +                     string_list_clear(&revs, 0);
>> +                     string_list_clear(&states, 0);
>> +                     die(_("Bad HEAD - strange symbolic ref"));
>> +             }
>> +     }
>
> I wonder the whole thing above is better restructured to avoid
> repeated checks of the same thing.
>
>         if (is it 40-hex, i.e. detached?) {
>                 stuff it to start_head;
>         } else if (skip_prefix(head, "refs/heads/", &branchname)) {
>                 do the "cogito" check;
>                 stuff it to start_head;
>         } else {
>                 that's a strange symbolic ref HEAD you have there;
>         }

I guess it changes the behaviour. Its a strange symbolic ref if it
does not start with "refs/heads".

>> +     /*
>> +      * Get rid of any old bisect state.
>> +      */
>> +     if (bisect_clean_state()) {
>> +             return -1;
>> +     }
>
> If we are going to get a lot more code inside {} in later patches,
> then this single "return -1" enclosed inside a {} pair is
> justifiable (but in that case we'd prefer an empty line after it to
> separate it from the next comment block).  Otherwise lose the {}.

I had thought initially that I would need to keep something after
bisect_next() conversion. But it turns out that I actually don't.

>> +     /*
>> +      * In case of mistaken revs or checkout error, or signals received,
>> +      * "bisect_auto_next" below may exit or misbehave.
>> +      * We have to trap this to be able to clean up using
>> +      * "bisect_clean_state".
>> +      */
>
> That explains the "trap" statements in the original.  Does it apply
> to this code here?
>
>> +     /*
>> +      * Write new start state
>> +      */
>> +     write_file(git_path_bisect_start(), "%s\n", start_head.buf);
>> +
>> +     if (no_checkout) {
>> +             get_oid(start_head.buf, &oid);
>> +             if (update_ref(NULL, "BISECT_HEAD", oid.hash, NULL, 0,
>> +                            UPDATE_REFS_MSG_ON_ERR)) {
>> +                     strbuf_release(&start_head);
>> +                     string_list_clear(&revs, 0);
>> +                     string_list_clear(&states, 0);
>> +                     return -1;
>> +             }
>> +     }
>> +     strbuf_release(&start_head);
>> +
>> +     if (pathspec_pos < argc - 1)
>> +             sq_quote_argv(&bisect_names, argv + pathspec_pos, 0);
>> +     write_file(git_path_bisect_names(), "%s\n", bisect_names.buf);
>> +     strbuf_release(&bisect_names);
>> +
>> +     for (i = 0; i < states.nr; i++) {
>> +             if (bisect_write(states.items[i].string,
>> +                               revs.items[i].string, terms, 1)) {
>> +                     string_list_clear(&revs, 0);
>> +                     string_list_clear(&states, 0);
>> +                     return -1;
>> +             }
>> +     }
>
> Hmph.  I do not particuarly see why doing this in a separate loop
> here, instead of doing it just like in the original, i.e. inside the
> loop we already saw, is an improvement.  It seems to me that the
> only effect of this change is to make the code more complex by
> forcing you to maintain (and clear) another string list "states" and
> have a separate loop here.
>
> Unless there is a reason why delaying calls to bisect_write() is a
> good thing and I am not seeing it, that is.
>
>> diff --git a/git-bisect.sh b/git-bisect.sh
>> index d6c8b5a..f0896b3 100755
>> --- a/git-bisect.sh
>> +++ b/git-bisect.sh
>> @@ -71,122 +71,7 @@ bisect_autostart() {
>>  }
>>
>>  bisect_start() {
>> -...
>> +     git bisect--helper --bisect-start $@ || exit
>>  ...
>> +     get_terms
>
> Understandable.  As the handling of the terms is done in the helper,
> you need to read the terms it left in the filesystem.  OK.
>
>>       bisect_auto_next


Regards,
Pranit Bauva
