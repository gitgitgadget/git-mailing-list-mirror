Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2C0F1F4B6
	for <e@80x24.org>; Tue, 14 May 2019 12:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfENMTl (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 08:19:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43949 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfENMTk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 08:19:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id w33so22573609edb.10
        for <git@vger.kernel.org>; Tue, 14 May 2019 05:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Vei0kgUeRX9m/EzwwRv/BuQrbvX06/8y6X9DZJ0T2jU=;
        b=Eq8Lf/+lMjj1vD5BrMDh9+4SMdn3LFo+2o0xTztn2Pvy/4Le7oF5/KlewQHBXX2SM8
         YYdk1U/z6YpcQq8iUAS5v/B5FxH3pauRh0rp434Wst6nY8gpXJwgvJZT4TaZPy0vB2NY
         /yqlU0slcYPO+aTO9pBcPMbxq7XSogwSFWgrH9oTzkb2kKUHJmdz4s0lY8kBHdcRx6LA
         BQDFdBTo53/eStMT+cQ6jifKPedzKNApixyMBMpu7K7uA5CPEbxVXgsC5kuRMmGbe3pL
         Ptxkc7rhylLNTfprKM6T2LU/K7J4vog5wDAAQsiLQNXilDJPBhhZUB3ofRTzmpJ3Nl8+
         H2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Vei0kgUeRX9m/EzwwRv/BuQrbvX06/8y6X9DZJ0T2jU=;
        b=War5OirDW3/JlyGxhRCsuNrk5q0W8xa3wFrmBY/GIOdsXIzZmt+cT0MuWAvVDtvzKi
         WVikMtX2kACftOS7FDlvjg9/TfdkMM7KZcsVTXFAXiaFH3SNo2AzL+OrlUCgj9fgMiFl
         x+/kIvRQ/AYW2878KH7nXAH3/k+rgOi/Uif9jm2qpgHpIFGirAqHD9UappuVGNEUyfIH
         6MmQrTOwNlVYKDQqlS+TEVV6inXKI/EKxaoEFRGLgPbc3sTq8dLu4GUG/hg0XON3w+wD
         M58pa0FOow5EjMlEVElTago8tWflzMwYsLxKQatZZbjQ6DU3n2TJ2Fdh7Qp2CbLKq+FV
         N/4A==
X-Gm-Message-State: APjAAAXXI80OBUIevzMtMoNI31CFLWwELu4Z2OdJbqEzVlbv2pLy91nh
        csyk0E9TFCjHlOpKUiKvK8/rvCEzw/I=
X-Google-Smtp-Source: APXvYqzXlPr69QtAr/4rp9tzDM7MyI/f45GYZTDwe36Aei4ZEe0OPhF70P77mkYuO47Gr8sfVJ+GDA==
X-Received: by 2002:a17:906:5390:: with SMTP id g16mr19935453ejo.12.1557836377478;
        Tue, 14 May 2019 05:19:37 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id j13sm4496409eda.91.2019.05.14.05.19.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 05:19:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] update-server-info: avoid needless overwrites
References: <20190511013455.5886-1-e@80x24.org> <87v9ygwoj0.fsf@evledraar.gmail.com> <20190512040825.GA25370@sigill.intra.peff.net> <87tve0w3ao.fsf@evledraar.gmail.com> <20190514094729.GA12256@sigill.intra.peff.net> <20190514115047.oncvfq24fhnp64re@dcvr>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190514115047.oncvfq24fhnp64re@dcvr>
Date:   Tue, 14 May 2019 14:19:36 +0200
Message-ID: <87ftphw7mv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 14 2019, Eric Wong wrote:

> Jeff King <peff@peff.net> wrote:
>> Yeah, I think there's sort of an open question here of who is calling
>> update-server-info when nothing got updated. I think the only place we
>> call it automatically is via receive-pack, but I'd guess Eric runs it as
>> part of public-inbox scripts.
>
> Correct.  post-update doesn't get run because public-inbox
> relies on fast-import.  I have mirrors using "git fetch", which
> also doesn't call post-update, either so I was calling
> update-server-info in my mirror script.
>
> Since more people have taken an interest in mirroring things,
> I figured I'd make "public-inbox-index" (the script which
> updates the Xapian and SQLite indices) call update-server-info
> itself.
>
> That way, it's simpler to mirror (v1) inboxes:
>
>   git fetch && git update-server-info && public-inbox-index
>
> becomes:
>
>   git fetch && public-inbox-index
>
> That's a huge savings in cognitive overhead.
>
> So, my eventual goal for this is we get to the point where any
> git operation which changes refs will automatically update
> info/refs if it exists.
>
> Ditto for objects/info/packs on any pack changes.
>
> This, like my bitmap-by-default change is among the things
> I'm trying to make it easier for more users to start
> self-hosting (including mirroring) any type of git repo.
>
> Anyways, I am far from knowledgeable about the locking
> discussion for git, though :x
>
>> That's my reading, too, but I didn't want to be responsible for
>> regressing some obscure case. At least Eric seems to _use_
>> update-server-info. ;)
>
> I also have something else on my mind for abusing info files with :>
> (another email)

Aside from this change, I wonder if making "fetch" optionally "exit 1"
if no refs were updated would be useful, as in the below WIP. Of course
it would be better to distinguish errors from "no refs to update".

I've hacked around it not doing that in the past for similar "fetch and
index" things by looking at for-each-ref before/after, or only seeing if
HEAD changed (so this wouldn't be a general solution...):

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4ba63d5ac6..da5414d9db 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -47,6 +47,7 @@ static int prune_tags = -1; /* unspecified */
 #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */

 static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity, deepen_relative;
+static int exit_code;
 static int progress = -1;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow, deepen;
 static int max_children = 1;
@@ -66,6 +67,7 @@ static struct refspec refmap = REFSPEC_INIT_FETCH;
 static struct list_objects_filter_options filter_options;
 static struct string_list server_options = STRING_LIST_INIT_DUP;
 static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
+static int updated_refs;

 static int git_fetch_config(const char *k, const char *v, void *cb)
 {
@@ -133,6 +135,8 @@ static struct option builtin_fetch_options[] = {
 	{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, N_("on-demand"),
 		    N_("control recursive fetching of submodules"),
 		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules },
+	OPT_BOOL(0, "exit-code", &exit_code,
+		 N_("exit successfully if refs are updated")),
 	OPT_BOOL(0, "dry-run", &dry_run,
 		 N_("dry run")),
 	OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
@@ -522,8 +526,10 @@ static int s_update_ref(const char *action,
 	struct strbuf err = STRBUF_INIT;
 	int ret, df_conflict = 0;

-	if (dry_run)
+	if (dry_run) {
+		updated_refs++;
 		return 0;
+	}
 	if (!rla)
 		rla = default_rla.buf;
 	msg = xstrfmt("%s: %s", rla, action);
@@ -545,6 +551,7 @@ static int s_update_ref(const char *action,
 	ref_transaction_free(transaction);
 	strbuf_release(&err);
 	free(msg);
+	updated_refs++;
 	return 0;
 fail:
 	ref_transaction_free(transaction);
@@ -1680,5 +1687,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	run_command_v_opt(argv_gc_auto.argv, RUN_GIT_CMD);
 	argv_array_clear(&argv_gc_auto);

-	return result;
+	if (result)
+		return result;
+	if (exit_code)
+		return !updated_refs;
+	return 0;
 }
