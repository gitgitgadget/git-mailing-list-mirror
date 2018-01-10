Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41A851F404
	for <e@80x24.org>; Wed, 10 Jan 2018 20:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeAJUXB (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 15:23:01 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:40882 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbeAJUW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 15:22:59 -0500
Received: by mail-it0-f66.google.com with SMTP id f190so890647ita.5
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 12:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WZ5qyNQXkN8QjQph5qe4bkgtKnhXo3nXZ9eBbzV2eEc=;
        b=RypkKXcyESrdc8akz3L+DyreFqhh7VgiiVS4KbahzqDaFYr/a8e5Cju1J3yqVgsjRK
         7pmw1cMZ4q7gUxqbLWsTX8uvyVuwgPSjKhbQ4psDFnKr7/RkVK5GCPpAH2lZKIgw0dpN
         wIUqnowEMlAvNJ/x1jTOmzoTolOc70sANazr9D1wNV32iWrxK15KHSMif71GMd3jwRbM
         b7BU4sJB0TA7fc7KN885ET5ROFeNzSNAlnO68fsUhNUbptWLMC2MtdGkytHum1oBLtme
         alVC2heK7F649xO1b+Va69r4dIvYpjD1HZl2KZlrJ88gm3heGZvVJEWFXPmqEj8PeyuF
         aQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WZ5qyNQXkN8QjQph5qe4bkgtKnhXo3nXZ9eBbzV2eEc=;
        b=a40U8/XFD5K4iee5pecDmLwA0aOVjIbr12TKrGJXGsI823BRX7xRRr41adC3rSHil8
         eRCTeKBGaI99aE0dbb3Rmug/h5eqCvVMyPvrEFWxTW7fl1cY5j2KJPmTbs39W0isYp5f
         jtpFAHVEO/n06HGtaPMlEOkE36crHcWn872QJcvPhVF38k317ZyqKZiSBHVabhp/6ayS
         YKLxh0EAfShP21YrNO/Z0a2+IIzyUYamlVv6+vf/yOmJWYuEJ47Y61wlrILUBqFcovDb
         D0J8/0wmlzW0YFwB2Itno5XDA90UVAqDCd50+Fj/NOdyHdP22/uYM/RadfRSRwBS9hYZ
         j9Jg==
X-Gm-Message-State: AKGB3mKe4uIZz3wzfCrivgzSXyjafsIMOy590bTz0KjNPk8yMxEpteud
        F3WUo872p+G4d7zZDCMmfHhCisjkay7DCcEs3vU=
X-Google-Smtp-Source: ACJfBovAy+PNLL3VlY1e86WE0PlWM9ysyqdlPXiHL06X520gJY2ulIKj1HajY19rhlHMlzFXWbVH+MmW1HbvELq+e9s=
X-Received: by 10.36.111.205 with SMTP id x196mr19124594itb.126.1515615778701;
 Wed, 10 Jan 2018 12:22:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.17.133 with HTTP; Wed, 10 Jan 2018 12:22:58 -0800 (PST)
In-Reply-To: <xmqq7esq4tf6.fsf@gitster.mtv.corp.google.com>
References: <20180109175703.4793-1-pc44800@gmail.com> <20180109175703.4793-3-pc44800@gmail.com>
 <xmqq7esq4tf6.fsf@gitster.mtv.corp.google.com>
From:   Prathamesh Chavan <pc44800@gmail.com>
Date:   Thu, 11 Jan 2018 01:52:58 +0530
Message-ID: <CAME+mvXaL4AcK1ib2rDZKdH0eLc7te+3e9zYv8pNqNj-4cyT3Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] submodule: port submodule subcommand 'deinit' from
 shell to C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 10, 2018 at 2:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Prathamesh Chavan <pc44800@gmail.com> writes:
>
>> The same mechanism is used even for porting this submodule
>> subcommand, as used in the ported subcommands till now.
>> The function cmd_deinit in split up after porting into four
>> functions: module_deinit(), for_each_listed_submodule(),
>> deinit_submodule() and deinit_submodule_cb().
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
>> ---
>>  builtin/submodule--helper.c | 153 ++++++++++++++++++++++++++++++++++++++++++++
>>  git-submodule.sh            |  55 +---------------
>>  2 files changed, 154 insertions(+), 54 deletions(-)
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index dd7737acd..54b0e46fc 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -20,6 +20,7 @@
>>  #define OPT_QUIET (1 << 0)
>>  #define OPT_CACHED (1 << 1)
>>  #define OPT_RECURSIVE (1 << 2)
>> +#define OPT_FORCE (1 << 3)
>>
>>  typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
>>                                 void *cb_data);
>> @@ -908,6 +909,157 @@ static int module_sync(int argc, const char **argv, const char *prefix)
>>       return 0;
>>  }
>>
>> +struct deinit_cb {
>> +     const char *prefix;
>> +     unsigned int flags;
>> +};
>> +#define DEINIT_CB_INIT { NULL, 0 }
>> +
>> +static void deinit_submodule(const char *path, const char *prefix,
>> +                          unsigned int flags)
>> +{
>> +     const struct submodule *sub;
>> +     char *displaypath = NULL;
>> +     struct child_process cp_config = CHILD_PROCESS_INIT;
>> +     struct strbuf sb_config = STRBUF_INIT;
>> +     char *sub_git_dir = xstrfmt("%s/.git", path);
>> +     mode_t mode = 0777;
>> +
>> +     sub = submodule_from_path(&null_oid, path);
>> +
>> +     if (!sub || !sub->name)
>> +             goto cleanup;
>> +
>> +     displaypath = get_submodule_displaypath(path, prefix);
>> +
>> +     /* remove the submodule work tree (unless the user already did it) */
>> +     if (is_directory(path)) {
>> +             struct stat st;
>> +             /*
>> +              * protect submodules containing a .git directory
>> +              * NEEDSWORK: automatically call absorbgitdirs before
>> +              * warning/die.
>> +              */
>
> I guess that you mean "instead of dying, automatically call absorb
> and (possibly) warn"?  That sounds like a sensible improvement.
>
>> +             if (is_directory(sub_git_dir))
>> +                     die(_("Submodule work tree '%s' contains a .git "
>> +                           "directory use 'rm -rf' if you really want "
>> +                           "to remove it including all of its history"),
>
> This changes the message text by removing () around "use ... history",
> which I do not think you intended to do.
>
>> +                           displaypath);
>> +
>> +             if (!(flags & OPT_FORCE)) {
>> +                     struct child_process cp_rm = CHILD_PROCESS_INIT;
>> +                     cp_rm.git_cmd = 1;
>> +                     argv_array_pushl(&cp_rm.args, "rm", "-qn",
>> +                                      path, NULL);
>> +
>> +                     if (run_command(&cp_rm))
>> +                             die(_("Submodule work tree '%s' contains local "
>> +                                   "modifications; use '-f' to discard them"),
>> +                                   displaypath);
>> +             }
>> +
>> +             if (!lstat(path, &st)) {
>
> What is this if statement doing here?  It does not make sense,
> especially without an 'else' clause on the other side, at least to
> me.
>
> At this point in the flow, the code has already determined that path
> is a directory above before starting to check if it has ".git/"
> immediately below it, or trying to run "git rm" in the dry run mode
> to see if it yields an error, so at this point lstat() should
> succeed (and would say it is a directory).  I would sort-of
> understand it if this "if()" has an "else" clause to act on an
> error, but that is not something the original does not do, so I am
> not sure if it belongs to a "rewrite to C" patch.
>
>> +                     struct strbuf sb_rm = STRBUF_INIT;
>> +                     const char *format;
>> +
>> +                     strbuf_addstr(&sb_rm, path);
>> +
>> +                     if (!remove_dir_recursively(&sb_rm, 0))
>> +                             format = _("Cleared directory '%s'\n");
>> +                     else
>> +                             format = _("Could not remove submodule work tree '%s'\n");
>> +
>> +                     if (!(flags & OPT_QUIET))
>> +                             printf(format, displaypath);
>> +
>> +                     mode = st.st_mode;
>> +
>> +                     strbuf_release(&sb_rm);
>> +             }
>> +     }
>
> If the reason is "avoid losing the original directory mode by
> removing and recreating", then you should be able to do much better
> by using REMOVE_DIR_KEEP_TOPLEVEL in the above "do we still have a
> directory?  if so get rid of working tree contents" thing.  And the
> call to mkdir() below can be placed in the else clause of that
> check, i.e. "the user has removed the directory as well, but there
> should be an empty directory even for a de-initialized submodule"
> side of this.
>
> That of course does not have to be part of "rewrite to C" patch.  In
> fact, it probably should come as a follow-up improvement after the
> dust settles.
>
Firstly, thanks a lot for taking time and reviewing the patches.
I have a few queries about the above changes to be made in the
"rewrite to C" patch.

Function lstat() was used for mainly getting the mode for the to be
created new directory.
And since sometimes st.st_mode may be containing garbage value, a new variable
mode was introduced with initial value 0777.

Thanks for pointing out that we can introduce the flag REMOVE_DIR_KEEP_TOPLEVEL
which solves the issue. And for the case where no directory exists: we
create an empty
directory.Since this won't be similar to what happens in the shell
script, this change
can be included in a saperate patch as an imporvement. But till the
dust settles, does the
current patch serve the purpose? (After imporving over the other
points being pointed above)

Thanks,
Prathamesh Chavan

>> +     if (mkdir(path, mode))
>> +             die_errno(_("could not create empty submodule directory %s"),
>> +                   displaypath);
>> + ...
>> +
>> +static int module_deinit(int argc, const char **argv, const char *prefix)
>> +{
>> +...
>> +     if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
>> +             BUG("module_list_compute should not choke on empty pathspec");
>> +...
>> +     if (all && argc) {
>> +             error("pathspec and --all are incompatible");
>> +             usage_with_options(git_submodule_helper_usage,
>> +                                module_deinit_options);
>> +     }
>> +
>> +     if (!argc && !all)
>> +             die(_("Use '--all' if you really want to deinitialize all submodules"));
>
> Shouldn't these two checks come before we call module_list_compute()?
>
>> +
>> +     for_each_listed_submodule(&list, deinit_submodule_cb, &info);
>> +
>> +     return 0;
>> +}
