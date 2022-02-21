Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1D5C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 14:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378073AbiBUOiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:38:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347872AbiBUOiG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 09:38:06 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2364A205CF
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:37:43 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m3so23834303eda.10
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 06:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=uzOPLysjkzO3wMgAK6szbN8Imy8u64LnD+lEjYmEvg0=;
        b=nsuinsM3pajUlM53nZPNr5gxOObLCKR04x55E9MK9DPycEN2O1KjvOilirqfia/vv0
         77j0377wxAK5oNCcvGIWijWt9bSf98SRy0OPhWgpboHoDmEVlvjP9ELAdCOflIP6TBC0
         53gel0rDp2/rLbbqUY94dG2/zYDDHCF2q4VMQIZ5iN3I6ib21Zo3eSG5QDmmoyUFYK2a
         rk+3QhPUKdtpynTAMYpl7i48i4V3WOoFrTGbrtyiAAD/OBGRYWpAQQSfY/wTtajodS+w
         Unq4DL6sAT6bNX5OeSjwMrbsER8LgkI7/Oe6WXdwpcCIGzwb+aDRVxBfSwo7CfEz7uly
         w9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=uzOPLysjkzO3wMgAK6szbN8Imy8u64LnD+lEjYmEvg0=;
        b=jsKVV4kW4lJWX46G7OlhDXzxfp5gyYt0gaitJ190PeNqaLKh+buSDakYG7DE5lFGOb
         Jr4ikiId1fQ4KErLnGSyxo+bbMyIEEzfeagSIetYn7dlf16kclCh6D3sUwpp3WMX3Kz9
         Qo+35J1oUjI4dGYS68ZR1mUQW3xzL/fp8FU5IA/6cC/V5cCcHrkdlpOHbDHGYDoVIm+Q
         mmQeuCV97F0uUI6RjTvW+FZIKY8hscECieFo4nR7fXzFwvyeLQ58kcTSsir3C7VK5Qzm
         9TxofOtZ3/DI4GWNkzNXEnpK7IPSRxyQdVU5URuQtS80UTDOIk8nMlUlGPArezDrtJh8
         fOdg==
X-Gm-Message-State: AOAM533t5wrHZW593LdlxMnxM3DJXL4PIwj2L58o7RVinmja/CPk1r5u
        YrgwCBbv+rCVuWWdbFlbhY0=
X-Google-Smtp-Source: ABdhPJwK+ZcFXXMueg+h2Q3VbyopWs5htUHKbhrvSy0LIm9Gi6P67vvXOPMY47H/jwX0FZsO3OIG4Q==
X-Received: by 2002:a05:6402:26cf:b0:413:1741:eeab with SMTP id x15-20020a05640226cf00b004131741eeabmr2351762edd.442.1645454261529;
        Mon, 21 Feb 2022 06:37:41 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h8sm8653947edk.14.2022.02.21.06.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 06:37:40 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nM9oq-005e4C-3f;
        Mon, 21 Feb 2022 15:37:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: machine-parsable git-merge-tree messages (was: [PATCH 08/12]
 merge-ort: provide a merge_get_conflicted_files() helper function)
Date:   Mon, 21 Feb 2022 15:28:15 +0100
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet>
 <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
 <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org>
 <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet>
 <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet>
Message-ID: <220221.86y224b80b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 21 2022, Johannes Schindelin wrote:

[I sent out an empty reply to this earlier by mistake, sorry about that]

> [...]
> Which brings me to the next concern: since `merge-tree` is a low-level
> tool meant to be called by programs rather than humans, we need to make
> sure that those messages remain machine-parseable, even if they contain
> file names.
>
> Concretely: while I am not currently aware of any web UI that allows to
> resolve simple rename/rename conflicts, it is easily conceivable how to
> implement such a thing. When that happens, we will need to be able to
> teach the server-side code to discern between the cases that can be
> handled in the web UI (trivial merge conflicts, trivial rename/rename
> conflicts) as compared to scenarios where the conflicts are just too
> complex.
>
> Here's an excerpt from t4301:
>
> -- snip --
> Auto-merging greeting
> CONFLICT (content): Merge conflict in greeting
> Auto-merging numbers
> CONFLICT (file/directory): directory in the way of whatever from side1; moving it to whatever~side1 instead.
> CONFLICT (modify/delete): whatever~side1 deleted in side2 and modified in side1.  Version side1 of whatever~side1 left in tree.
> -- snap --
>
> This is the complete set of messages provided in the `test conflict
> notices and such` test case.
>
> I immediately notice that every line contains at least one file name.
> Looking at https://github.com/git/git/blob/v2.35.1/merge-ort.c#L1899, it
> does not seem as if the file names are quoted:
>
> 		path_msg(opt, path, 1, _("Auto-merging %s"), path);
>
> (where `path` is used verbatim in a call to `merge_3way()` before that,
> i.e. it must not have been quoted)
>
> I would like to register a wish to ensure that file names with special
> characters (such as most notably line-feed characters) are quoted in these
> messages, so that a simple server-side parser can handle messages starting
> with `Auto-merging` and with `CONFLICT (content): Merge conflict in `, and
> "throw the hands up in the air" if any other message prefix is seen.
>
> Do you think we can switch to `sq_quote_buf_pretty()` for these messages?
> For the `Auto-merging` one, it would be trivial, but I fear that we will
> have to work a bit on the `path_msg()` function
> (https://github.com/git/git/blob/v2.35.1/merge-ort.c#L630-L649) because it
> accepts a variable list of arguments without any clue whether the
> arguments refer to paths or not. (And I would be loathe to switch _all_
> callers to do the quoting themselves.)
>
> I see 28 calls to that function, and at least a couple that pass not only
> a path but also an OID (e.g.
> https://github.com/git/git/blob/v2.35.1/merge-ort.c#L1611-L1613).
>
> We could of course be sloppy and pass even OIDs through
> `sq_quote_buf_pretty()` in `path_msg()`, knowing that there won't be any
> special characters in them, but it gets more complicated e.g. in
> https://github.com/git/git/blob/v2.35.1/merge-ort.c#L1648-L1651, where we
> pass an `strbuf` that contains a somewhat free-form commit message.
>
> I guess we could still pass those through `sq_quote_buf_pretty()`, even if
> they are not paths, to ensure that there are no special characters in the
> machine-parseable lines.
>
> What do you think?

That sounds like a rather nasty hack, this is too, but demonstrates that
we can pretty easily extract this in a machine-readable format with just
a few lines now):

diff --git a/merge-ort.c b/merge-ort.c
index 8a5f201d190..a906881f9b3 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -633,7 +633,7 @@ static void path_msg(struct merge_options *opt,
 		     int omittable_hint, /* skippable under --remerge-diff */
 		     const char *fmt, ...)
 {
-	va_list ap;
+	va_list ap, cp;
 	struct strbuf *sb, *dest;
 	struct strbuf tmp = STRBUF_INIT;
 
@@ -650,7 +650,9 @@ static void path_msg(struct merge_options *opt,
 
 	dest = (opt->record_conflict_msgs_as_headers ? &tmp : sb);
 
+	va_copy(cp, ap);
 	va_start(ap, fmt);
+
 	if (opt->priv->call_depth) {
 		strbuf_addchars(dest, ' ', 2);
 		strbuf_addstr(dest, "From inner merge:");
@@ -659,6 +661,15 @@ static void path_msg(struct merge_options *opt,
 	strbuf_vaddf(dest, fmt, ap);
 	va_end(ap);
 
+	va_start(cp, fmt);
+	trace2_region_enter_printf("merge", "conflict/path", opt->repo, "%s", path);
+	trace2_region_leave("merge", "conflict/path", opt->repo);
+	trace2_region_enter_printf("merge", "conflict/fmt", opt->repo, "%s", fmt);
+	trace2_region_leave("merge", "conflict/fmt", opt->repo);
+	trace2_region_enter_printf_va("merge", "conflict/msg", opt->repo, fmt, cp);
+	trace2_region_leave("merge", "conflict/msg", opt->repo);
+	va_end(cp);
+
 	if (opt->record_conflict_msgs_as_headers) {
 		int i_sb = 0, i_tmp = 0;
 
You can run that with one of the tests added in this series to get the
output as JSON, e.g.:

     GIT_TRACE2_EVENT=/dev/stderr GIT_TRACE2_EVENT_NESTING=10 ~/g/git/git merge-tree --write-tree --no-messages --name-only --messages side1 side2 2>&1|jq -r .| grep '"msg"'
      "msg": "whatever~side1"
      "msg": "CONFLICT (file/directory): directory in the way of %s from %s; moving it to %s instead."
      "msg": "CONFLICT (file/directory): directory in the way of whatever from side1; moving it to whatever~side1 instead."
      "msg": "whatever~side1"
      "msg": "CONFLICT (modify/delete): %s deleted in %s and modified in %s.  Version %s of %s left in tree."
      "msg": "CONFLICT (modify/delete): whatever~side1 deleted in side2 and modified in side1.  Version side1 of whatever~side1 left in tree."
      "msg": "numbers"
      "msg": "Auto-merging %s"
      "msg": "Auto-merging numbers"
      "msg": "greeting"
      "msg": "Auto-merging %s"
      "msg": "Auto-merging greeting"
      "msg": "greeting"
      "msg": "CONFLICT (%s): Merge conflict in %s"
      "msg": "CONFLICT (content): Merge conflict in greeting"

A "proper" fix for this doesn't sound too hard, we'd just instrument the
path_msg() function to pass along some "message category", see
e.g. unpack_plumbing_errors in unpack-trees.c for one example of such a
thing, or the "enum fsck_msg_id".

Then we'd just allow you to emit any of the sprintf() format itself, or
the expanded version, the path, or an id like "CONFLICT:file/directory"
or "auto-merging" etc.

I think that would be particularly useful in conjuction with the
--format changes I was proposing for this (and hacked up a WIP patch
for). You could just have a similar --format-messages or whatever.

Then you could pick \0\0 as a delimiter for your "main" --format, and
"\0" as the delimiter for your --format-messages, and thus be able to
parse N-nested \0-delimited content.





