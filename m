Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B0AC35E15
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 21:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360C221927
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 21:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2eZuARi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgBYVTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 16:19:40 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34996 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgBYVTj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 16:19:39 -0500
Received: by mail-ed1-f66.google.com with SMTP id c7so1110840edu.2
        for <git@vger.kernel.org>; Tue, 25 Feb 2020 13:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HCVNe1r5vy59bzYzl42IoTdvExzsLwqf5B64B+K3h/g=;
        b=N2eZuARi50VQgAKtjhQLentI7xlTDVLfZYCzq7Tjw/vCKIsLs2S3f60Mn7BCBHQbKc
         vnwcGh1ITBlXGa/N6USymWb6kL4bdpHoxeVkXyvl2HFbnAfJRLffRBKGFoIFbnySicPa
         4qil2OwckjIndw+18qzUVTxRnPwV+cSJBVmotlyRDmLA7Xnhj9yXpTrprc1GjuckZdO8
         cfnyOQ85EuRiYmZHT5A2HJMb2LdMIxcPTDb0bCnQKZXxYayXANgUPmwJzMyFbbZAfMbP
         c23eREijrEtVUg87wA/f5D3B49D1K12LKAGduwb7EgdniCHRvcG3gOufnC42GoYCroY3
         SEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HCVNe1r5vy59bzYzl42IoTdvExzsLwqf5B64B+K3h/g=;
        b=qcze+E+94RsuUKYlS0EYyhSITstiy244sNGnkpsttv7tuO8KlFgyKbeCWmsX82wfmS
         0SotGCmqzoYcXfHZKTuO2WIcbDlfrnkXckHsN84Sdd9nwc5v5gYyAW0GqN/yN0fW4xVf
         Tqd5mWhan4wOUgG7d+IhjU+ZZ37Pt5uX29XIcWQ4LiljdVwPU7NIPZkKAXYIqh/2q5qH
         ERA12vC7mjwisq5a4E5QEPRfG07jeVBtfTdT8b4F6ckS/09bYoX9kdY6Y8Lum0m309gx
         xCnAbWo28HzlQ80jcgZSjXmW29aziLvbEVPKDFHZHVCHImbIKMu2DlYwtYiPlFZ4aMez
         AV/Q==
X-Gm-Message-State: APjAAAUnt4TzylldrWMBTuB4lHmFdJ0NT2b5R84T5LinkR5ZcTD4fY/8
        0EvylvFk30/zEA9d92jGWMW5pVOP9oJxd+df00g=
X-Google-Smtp-Source: APXvYqzZDqf52MTVlR4D8x9gWTla5yotwly5hVGU/Lo0N9ZJv6YPgHg4w4SBvdVsoMJzvKsbJHjraqTpip7+1ipvoq8=
X-Received: by 2002:aa7:da8d:: with SMTP id q13mr1019249eds.8.1582665577145;
 Tue, 25 Feb 2020 13:19:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
 <pull.548.v5.git.1582628141.gitgitgadget@gmail.com> <b7f10d060a41c1ef3d25e4c07be3747c7902b997.1582628141.git.gitgitgadget@gmail.com>
 <xmqqsgiymupf.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgiymupf.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Wed, 26 Feb 2020 10:19:25 +1300
Message-ID: <CACg5j27SfWsj2t_z8zxOvjc6MSot2yMi1J+R4HJinFhHgTpveg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] advice: revamp advise API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 26, 2020 at 6:40 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Heba Waly <heba.waly@gmail.com>
> >
> > Currently it's very easy for the advice library's callers to miss
> > checking the visibility step before printing an advice. Also, it makes
> > more sense for this step to be handled by the advice library.
> >
> > Add a new advise_if_enabled function that checks the visibility of
> > advice messages before printing.
> >
> > Add a new helper advise_enabled to check the visibility of the advice
> > if the caller needs to carry out complicated processing based on that
> > value.
> >
> > A list of config variables 'advice_config_keys' is added to be used by
> > list_config_advices() instead of 'advice_config[]' because we'll get
> > rid of 'advice_config[]' and the global variables once we migrate all
> > the callers to use the new APIs.
> >
>
>
> > Also change the advise call in tag library from advise() to
> > advise_if_enabled() to construct an example of the usage of the new
> > API.
>
> This is for step [3/3], isn't it?  I'll discard this paragraph.

Yes, should have been discarded.

> >
> > Signed-off-by: Heba Waly <heba.waly@gmail.com>
> > ---
> >  Makefile               |  1 +
> >  advice.c               | 86 ++++++++++++++++++++++++++++++++++++++++--
> >  advice.h               | 52 +++++++++++++++++++++++++
> >  t/helper/test-advise.c | 19 ++++++++++
> >  t/helper/test-tool.c   |  1 +
> >  t/helper/test-tool.h   |  1 +
> >  t/t0018-advice.sh      | 32 ++++++++++++++++
> >  7 files changed, 188 insertions(+), 4 deletions(-)
> >  create mode 100644 t/helper/test-advise.c
> >  create mode 100755 t/t0018-advice.sh
> >
> > diff --git a/Makefile b/Makefile
> > index 09f98b777ca..ed923a3e818 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -695,6 +695,7 @@ X =
> >
> >  PROGRAMS += $(patsubst %.o,git-%$X,$(PROGRAM_OBJS))
> >
> > +TEST_BUILTINS_OBJS += test-advise.o
> >  TEST_BUILTINS_OBJS += test-chmtime.o
> >  TEST_BUILTINS_OBJS += test-config.o
> >  TEST_BUILTINS_OBJS += test-ctype.o
> > diff --git a/advice.c b/advice.c
> > index fd836332dad..5c2068b8f8a 100644
> > --- a/advice.c
> > +++ b/advice.c
> > @@ -96,13 +96,56 @@ static struct {
> >       { "pushNonFastForward", &advice_push_update_rejected }
> >  };
> >
> > -static void vadvise(const char *advice, va_list params)
> > +static const char *advice_config_keys[] = {
> > +     [ADD_EMBEDDED_REPO]                      = "addEmbeddedRepo",
> > +     [AMWORKDIR]                              = "amWorkDir",
> > +     [CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME]  = "checkoutAmbiguousRemoteBranchName",
> > +     [COMMIT_BEFORE_MERGE]                    = "commitBeforeMerge",
> > +     [DETACHED_HEAD]                          = "detachedHead",
> > +     [FETCH_SHOW_FORCED_UPDATES]              = "fetchShowForcedUpdates",
> > +     [GRAFT_FILE_DEPRECATED]                  = "graftFileDeprecated",
> > +     [IGNORED_HOOK]                           = "ignoredHook",
> > +     [IMPLICIT_IDENTITY]                      = "implicitIdentity",
> > +     [NESTED_TAG]                             = "nestedTag",
> > +     [OBJECT_NAME_WARNING]                    = "objectNameWarning",
> > +     [PUSH_ALREADY_EXISTS]                    = "pushAlreadyExists",
> > +     [PUSH_FETCH_FIRST]                       = "pushFetchFirst",
> > +     [PUSH_NEEDS_FORCE]                       = "pushNeedsForce",
> > +
> > +     /* make this an alias for backward compatibility */
> > +     [PUSH_UPDATE_REJECTED_ALIAS]             = "pushNonFastForward",
> > +
> > +     [PUSH_NON_FF_CURRENT]                    = "pushNonFFCurrent",
> > +     [PUSH_NON_FF_MATCHING]                   = "pushNonFFMatching",
> > +     [PUSH_UNQUALIFIED_REF_NAME]              = "pushUnqualifiedRefName",
> > +     [PUSH_UPDATE_REJECTED]                   = "pushUpdateRejected",
> > +     [RESET_QUIET_WARNING]                    = "resetQuiet",
> > +     [RESOLVE_CONFLICT]                       = "resolveConflict",
> > +     [RM_HINTS]                               = "rmHints",
> > +     [SEQUENCER_IN_USE]                       = "sequencerInUse",
> > +     [SET_UPSTREAM_FAILURE]                   = "setupStreamFailure",
> > +     [STATUS_AHEAD_BEHIND_WARNING]            = "statusAheadBehindWarning",
> > +     [STATUS_HINTS]                           = "statusHints",
> > +     [STATUS_U_OPTION]                        = "statusUoption",
> > +     [SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE] = "submoduleAlternateErrorStrategyDie",
> > +     [WAITING_FOR_EDITOR]                     = "waitingForEditor",
> > +};
> > +
> > +static const char turn_off_instructions[] =
> > +N_("\n"
> > +   "Disable this message with \"git config %s false\"");
> > +
> > +static void vadvise(const char *advice, int display_instructions,
> > +                 char *key, va_list params)
> >  {
> >       struct strbuf buf = STRBUF_INIT;
> >       const char *cp, *np;
> >
> >       strbuf_vaddf(&buf, advice, params);
> >
> > +     if (display_instructions)
> > +             strbuf_addf(&buf, turn_off_instructions, key);
> > +
> >       for (cp = buf.buf; *cp; cp = np) {
> >               np = strchrnul(cp, '\n');
> >               fprintf(stderr, _("%shint: %.*s%s\n"),
> > @@ -119,8 +162,43 @@ void advise(const char *advice, ...)
> >  {
> >       va_list params;
> >       va_start(params, advice);
> > -     vadvise(advice, params);
> > +     vadvise(advice, 0, "", params);
> > +     va_end(params);
> > +}
> > +
> > +static int get_config_value(enum advice_type type)
> > +{
> > +     int value = 1;
> > +     char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
> > +
> > +     git_config_get_bool(key, &value);
> > +     free(key);
> > +     return value;
> > +}
>
> So, in this hypothetical but quite realistic example:
>
>         if (advice_enabled(ADVICE_FOO)) {
>                 char *foo = expensive_preparation();
>                 advice_if_enabled(ADVICE_FOO, "use of %s is discouraged", foo);
>         }
>
> we end up formulating the "advice.*" key twice and ask git_config_get_bool()
> about the same key twice?

No, in the above example, advise() should be called not advise_if_enabled().
As we discussed in the beginning of this thread.
https://public-inbox.org/git/xmqqa75py7u8.fsf@gitster-ct.c.googlers.com/

>
> > +int advice_enabled(enum advice_type type)
> > +{
> > +     switch (type) {
> > +     case PUSH_UPDATE_REJECTED:
> > +             return get_config_value(PUSH_UPDATE_REJECTED) &&
> > +                    get_config_value(PUSH_UPDATE_REJECTED_ALIAS);
> > +     default:
> > +             return get_config_value(type);
> > +     }
> > +}
>
> Also, as "enum advice_type" will be part of the public API, and
> there is little type checking for enums, we shouldn't be naming them
> randomly like these---we'd at least want to use a common prefix,
> like "ADVICE_", in front of them.  Those who are focused only on
> advice subsystem may feel that names like PUSH_UPDATE_REJECTED are
> sufficiently clear, but within the context of the whole system,
> there is no cue that these UPCASED_WORDS identifiers belong to the
> advice subsystem or somewhere else.
>

I agree.

> > +void advise_if_enabled(enum advice_type type, const char *advice, ...)
> > +{
> > +     char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
> > +     va_list params;
> > +
> > +     if (!advice_enabled(type))
> > +             return;
>
> Oh, no, make the number of calls to xstrfmr() three times, not
> twice, as I said in the previous example.
>
> I wonder if it would make the implementation better to do these:
>
>  - Rename advice_config_keys[] to advice_setting[] that does not
>    imply it is only about the keys;
>
>  - This table will know, for each enum advice_type, which
>    configuration variable enables it, *and* if it is enabled.
>
> i.e.
>
>         static struct {
>                 const char *config_key;
>                 int disabled;
>         } advice_setting[] = {
>                 [ADVICE_ADD_EMBEDED_REPO] = { "addEmbeddedRepo" },
>                 [ADVICE_AM_WORK_DIR]      = { "amWorkDir" },
>                 ...
>                 [ADVICE_WAITING_FOR_EDITOR] = { "waitingForEditor" },
>         };
>
>
> Side Note: you have AMWORKDIR that is unreadable.  If the config
>            name uses camelCase by convention, the UPCASED_WORDS
>            should be separated with underscore at the same word
>            boundary.

I followed the original global variable name, which is
`advice_amworkdir`, we can change that.

>
> Then, upon the first call to advice_enabled(), call git_config()
> with a callback like
>
>         static int populate_advice_settings(const char *var, const char *value, void *cb)
>         {
>                 int advice_type;
>                 const char *name;
>
>                 if (!skip_prefix(var, "advice.", &name))
>                         return 0;
>                 advice_type = find_advice_type_by_name(advice_setting, name);
>                 if (advice_type < 0)
>                         return 0; /* unknown advice.* variable */
>                 /* advice.foo=false means advice.foo is disabled */
>                 advice_setting[advice_type].disabled = !git_config_bool(var, value);
>         }
>
> only once.  Your get_config_value() would then become a mere lookup
> in advice_setting[] array, e.g.
>
>         int advice_enabled(unsigned advice_type)
>         {
>                 static int initialized;
>
>                 if (!initialized) {
>                         initialized = 1;
>                         git_config(populate_advice_settings, NULL);
>                 }
>                 if (ARRAY_SIZE(advice_setting) <= advice_type)
>                         BUG("OOB advice type requested???");
>                 return !advice_setting[advice_type].disabled;
>         }
>
> with your "push-update-rejected has two names" twist added.
>
> Hmm?

I wasn't very happy about having to keep the list of config keys in
memory, but that was a good enough solution for now.
I also agree that there could be benefits for caching the values, as
you mentioned it will be less expensive than looking up from the
hashmap, but this array will grow with every new advice added to the
system. And this data is already loaded in the hashmap, so we are
duplicating it.
So are the benefits worth the duplication? I don't know.

Thanks,
Heba
