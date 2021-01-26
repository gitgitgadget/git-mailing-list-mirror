Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECDBC433E6
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B12BD20691
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbhAZWBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390815AbhAZS2S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 13:28:18 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E195C061573
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 10:27:37 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id p72so35548910iod.12
        for <git@vger.kernel.org>; Tue, 26 Jan 2021 10:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=O5gHzj+ExpRSuRFeAZiCmudTVpEoukpBD/5UNsur/aE=;
        b=GmqFU0wZq7rfw7DxDQhjtDSGenRl36A4NQibE2L3sZVK/ld2zQXhAuQDOioi0+eG4g
         ZoB2L8bKj22WJQGnylWq3K4M60bNFR7MqIVMSz+/JyT7SyonDoVG4zHCwgGYGWvfkHJT
         4eDWeLshC37pwlLHtKLpUUD/zRJ0cZW0QzIOOFrlo1u9tQqz+H1xDJpgjnUDkflRQkec
         OuflO3Nuamg1kd+h/o5zR17KQfU46g8Q4meROqKT+ZeKqRibFFCf5r1SNepmyKhr9n2p
         iB8+tG8YFrvyPZEf3DhFqIH4syRLVVbGcD1+MGhH/A/gX1jSsfNDCngrIHendJtMlYL2
         I0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O5gHzj+ExpRSuRFeAZiCmudTVpEoukpBD/5UNsur/aE=;
        b=c+FvvQHylzpSi7d7tJiwa1muzcVk4Dc1BEIMbGMwiilS6SDclxiepu784fswa53iA2
         A8Ubl94GfhQ4/xjHFn3dMUzeJ0WcGOjgiYIjyKx8y/uQc9FmOPZVopHDr7qj874HrWhD
         w/cnQRj+BI2miGpQ4yelxdJVCouCYBGg9NaDtyg/hnh34zus+YkK42ihubvYwjPF2Xhd
         RoMxPyAatSPFxqoI2gspTtONUcUY2DaxCH59OiG7rgi7ZSyZsG6gQ1tySR/ReBNVTAmm
         qLOMC139zQPRnmMqf9lhqklUPEiVtC/2KE2JLppE4ehvAK6e/YWmyVVCCwQNcJ107T9z
         3VUQ==
X-Gm-Message-State: AOAM533TL2rdxxiElQan3yXpZAZJ4YgTSqqWhiYeO44Id3ze+9MyAazD
        /3ikt2BOFakZ6vId1vGFWDRQMl9Ii8gkHPrGWKjA6dcYJQ4=
X-Google-Smtp-Source: ABdhPJx1ZQmhoRvcm/Hx1K0Mr6FVYEsTk4GOHaVA9QhI+Cbfw/5+65hVPnwZcEQuZtnowWkufa7nqqXRgJ0MJL7s8xo=
X-Received: by 2002:a6b:b8c6:: with SMTP id i189mr4863939iof.127.1611685656881;
 Tue, 26 Jan 2021 10:27:36 -0800 (PST)
MIME-Version: 1.0
References: <20210125191710.45161-1-mirucam@gmail.com> <xmqqh7n337nq.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7n337nq.fsf@gitster.c.googlers.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Tue, 26 Jan 2021 19:27:26 +0100
Message-ID: <CAN7CjDDQw-Vr_pV=yM0eRXi02F4LjcMfE-9gs5iLS_MU-JPYKQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Finish converting git bisect to C part 3
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

El mar, 26 ene 2021 a las 18:55, Junio C Hamano (<gitster@pobox.com>) escri=
bi=C3=B3:
>
> Miriam Rubio <mirucam@gmail.com> writes:
>
> > These patches correspond to a third part of patch series
> > of Outreachy project "Finish converting `git bisect` from shell to C"
> > started by Pranit Bauva and Tanushree Tumane
> > (https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
> > continued by me.
>
> Did we lose [2/7] somewhere in the mailing list?  I see the same
> thing as what is shown in
>
> https://lore.kernel.org/git/20210125191710.45161-1-mirucam@gmail.com/
>
> i.e. a 7-patch series that lack its second part.

I received the [2/7] patch:

-------------------------------------------
De: Miriam Rubio <mirucam@gmail.com>
Date: lun, 25 ene 2021 a las 20:17
Subject: [PATCH v4 2/7] bisect--helper: reimplement `bisect_replay`
shell function in C
To: <git@vger.kernel.org>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, Lars Schneider
<larsxschneider@gmail.com>, Christian Couder
<chriscool@tuxfamily.org>, Johannes Schindelin
<Johannes.Schindelin@gmx.de>, Tanushree Tumane
<tanushreetumane@gmail.com>, Miriam Rubio <mirucam@gmail.com>


From: Pranit Bauva <pranit.bauva@gmail.com>

Reimplement the `bisect_replay` shell function in C and also add
`--bisect-replay` subcommand to `git bisect--helper` to call it from
git-bisect.sh

Using `--bisect-replay` subcommand is a temporary measure to port shell
function to C so as to use the existing test suite.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 85 +++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            | 34 +---------------
 2 files changed, 85 insertions(+), 34 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index a65244a0f5..d65b2f44c6 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -31,6 +31,7 @@ static const char * const git_bisect_helper_usage[] =3D {
        N_("git bisect--helper --bisect-auto-next"),
        N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
        N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
+       N_("git bisect--helper --bisect-replay <filename>"),
        NULL
 };

@@ -916,6 +917,79 @@ static enum bisect_error bisect_log(void)
        return status ? BISECT_FAILED : BISECT_OK;
 }

+static int process_replay_line(struct bisect_terms *terms, struct strbuf *=
line)
+{
+       const char *p =3D line->buf + strspn(line->buf, " \t");
+       char *word_end, *rev;
+
+       if ((!skip_prefix(p, "git bisect", &p) &&
+       !skip_prefix(p, "git-bisect", &p)) || !isspace(*p))
+               return 0;
+       p +=3D strspn(p, " \t");
+
+       word_end =3D (char *)p + strcspn(p, " \t");
+       rev =3D word_end + strspn(word_end, " \t");
+       *word_end =3D '\0'; /* NUL-terminate the word */
+
+       get_terms(terms);
+       if (check_and_set_terms(terms, p))
+               return -1;
+
+       if (!strcmp(p, "start")) {
+               struct strvec argv =3D STRVEC_INIT;
+               int res;
+               sq_dequote_to_strvec(rev, &argv);
+               res =3D bisect_start(terms, argv.v, argv.nr);
+               strvec_clear(&argv);
+               return res;
+       }
+
+       if (one_of(p, terms->term_good,
+          terms->term_bad, "skip", NULL))
+               return bisect_write(p, rev, terms, 0);
+
+       if (!strcmp(p, "terms")) {
+               struct strvec argv =3D STRVEC_INIT;
+               int res;
+               sq_dequote_to_strvec(rev, &argv);
+               res =3D bisect_terms(terms, argv.nr =3D=3D 1 ? argv.v[0] : =
NULL);
+               strvec_clear(&argv);
+               return res;
+       }
+       error(_("'%s'?? what are you talking about?"), p);
+
+       return -1;
+}
+
+static enum bisect_error bisect_replay(struct bisect_terms *terms,
const char *filename)
+{
+       FILE *fp =3D NULL;
+       enum bisect_error res =3D BISECT_OK;
+       struct strbuf line =3D STRBUF_INIT;
+
+       if (is_empty_or_missing_file(filename))
+               return error(_("cannot read file '%s' for replaying"),
filename);
+
+       if (bisect_reset(NULL))
+               return BISECT_FAILED;
+
+       fp =3D fopen(filename, "r");
+       if (!fp)
+               return BISECT_FAILED;
+
+       while ((strbuf_getline(&line, fp) !=3D EOF) && !res){
+               res =3D process_replay_line(terms, &line);
+       }
+
+       strbuf_release(&line);
+       fclose(fp);
+
+       if (res)
+               return BISECT_FAILED;
+
+       return bisect_auto_next(terms, NULL);
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
        enum {
@@ -929,7 +1003,8 @@ int cmd_bisect__helper(int argc, const char
**argv, const char *prefix)
                BISECT_NEXT,
                BISECT_AUTO_NEXT,
                BISECT_STATE,
-               BISECT_LOG
+               BISECT_LOG,
+               BISECT_REPLAY
        } cmdmode =3D 0;
        int res =3D 0, nolog =3D 0;
        struct option options[] =3D {
@@ -953,6 +1028,8 @@ int cmd_bisect__helper(int argc, const char
**argv, const char *prefix)
                         N_("mark the state of ref (or refs)"), BISECT_STAT=
E),
                OPT_CMDMODE(0, "bisect-log", &cmdmode,
                         N_("list the bisection steps so far"), BISECT_LOG)=
,
+               OPT_CMDMODE(0, "bisect-replay", &cmdmode,
+                        N_("replay the bisection process from the
given file"), BISECT_REPLAY),
                OPT_BOOL(0, "no-log", &nolog,
                         N_("no log for BISECT_WRITE")),
                OPT_END()
@@ -1020,6 +1097,12 @@ int cmd_bisect__helper(int argc, const char
**argv, const char *prefix)
                        return error(_("--bisect-log requires 0 arguments")=
);
                res =3D bisect_log();
                break;
+       case BISECT_REPLAY:
+               if (argc !=3D 1)
+                       return error(_("no logfile given"));
+               set_terms(&terms, "bad", "good");
+               res =3D bisect_replay(&terms, argv[0]);
+               break;
        default:
                BUG("unknown subcommand %d", cmdmode);
        }
diff --git a/git-bisect.sh b/git-bisect.sh
index 05863cc142..e834154e29 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -77,38 +77,6 @@ bisect_visualize() {
        eval '"$@"' --bisect -- $(cat "$GIT_DIR/BISECT_NAMES")
 }

-bisect_replay () {
-       file=3D"$1"
-       test "$#" -eq 1 || die "$(gettext "No logfile given")"
-       test -r "$file" || die "$(eval_gettext "cannot read \$file for
replaying")"
-       git bisect--helper --bisect-reset || exit
-       oIFS=3D"$IFS" IFS=3D"$IFS$(printf '\015')"
-       while read git bisect command rev tail
-       do
-               test "$git $bisect" =3D "git bisect" || test "$git" =3D
"git-bisect" || continue
-               if test "$git" =3D "git-bisect"
-               then
-                       rev=3D"$command"
-                       command=3D"$bisect"
-               fi
-               get_terms
-               git bisect--helper --check-and-set-terms "$command"
"$TERM_GOOD" "$TERM_BAD" || exit
-               get_terms
-               case "$command" in
-               start)
-                       eval "git bisect--helper --bisect-start $rev $tail"=
 ;;
-               "$TERM_GOOD"|"$TERM_BAD"|skip)
-                       git bisect--helper --bisect-write "$command"
"$rev" "$TERM_GOOD" "$TERM_BAD" || exit;;
-               terms)
-                       git bisect--helper --bisect-terms $rev || exit;;
-               *)
-                       die "$(gettext "?? what are you talking about?")" ;=
;
-               esac
-       done <"$file"
-       IFS=3D"$oIFS"
-       git bisect--helper --bisect-auto-next || exit
-}
-
 bisect_run () {
        git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail ||=
 exit

@@ -203,7 +171,7 @@ case "$#" in
        reset)
                git bisect--helper --bisect-reset "$@" ;;
        replay)
-               bisect_replay "$@" ;;
+               git bisect--helper --bisect-replay "$@" || exit;;
        log)
                git bisect--helper --bisect-log || exit ;;
        run)
--
2.29.2
>
I have to resend only this patch to the mailing list? or what I have to do?
Thank you.
Miriam.
> Thanks.
