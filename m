Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5BDC4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 13:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbiKHNGP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 08:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiKHNGN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 08:06:13 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B727127
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 05:06:12 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u6so14104330plq.12
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 05:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIiwQQKxX9+R94krWNhFdx3Fl88CCWGT053FrItw5lE=;
        b=lsTGbmBtnj6txZGAav1NMHtp69X5yvZWdNUd1iwiyLmhT34EcBVoZbTX209XLvr3kr
         3VQRumtRFV7FPNjMg4IWSC2p37CZ6SQCd1d/0tusn8GaDBtdPty5ZgL/i55H//qw9B1P
         R/UfVTrNNrPmJ7WQY9axFABhO7NvTYgYX70NlCUpPoC6e4eh9k3q3S9UmMIBrQOiB7gb
         nQpW/N/jgYb/syjIMwolHjWIYKiVQtyikPffxasjuoFK+TyajGtSQw0/RzbQUdh9ZsaA
         G2jPN7qKpTBbmFkgaroCjS0k06vrougK/TkRqinXaRrtVkRP9JRWx8P8JhxglSMcblQb
         LhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIiwQQKxX9+R94krWNhFdx3Fl88CCWGT053FrItw5lE=;
        b=VUJhc5NY6wHPX+eTleFkjqFDoj8ZC3pTl0xUW++bpw5ks43BJ9hiL3fPvgM74FbwLT
         EX0cj5cMCVX3M5+pkbSm3FOLTy+ErrmPIjnKxvUutHd9E0jszUEz6V2R8vFW0pgqUgzy
         e7kx+XEEf6LRoLNnBWKhC4qDL1x3Ealo1L51tN/rBImg+MffVql5G5nob9/6Aa5bNgmS
         Hoi//qd+XB6i1rXe3YJ+0w9YtH1HLV9MIIYCKGiKEGTkCTO1R6Z5JoTmey35GPr0rKfR
         EaiwnmAkam36YZTdmLb9ovEvBv8Qx4S44BLiATlQJ/2KcNwij6IotD+hW1eoPWP/6foo
         CVNw==
X-Gm-Message-State: ACrzQf0cK7rptEvE+FzoRLISwo9lYKTQTfzA8KBA4L3S1yWR53ZQcBLO
        xfVqpS5qyW4fiWkvdm04Gmpgi+tgH2OOp02w
X-Google-Smtp-Source: AMsMyM7xx/4DNhTMbE2tvDgSTuIb94CurGZpwtlyNJvP/xS+2W57aIDb7lOTa6BBhWGGscK0bWMGtw==
X-Received: by 2002:a17:90b:2393:b0:213:ecb2:2e04 with SMTP id mr19-20020a17090b239300b00213ecb22e04mr45311260pjb.100.1667912771975;
        Tue, 08 Nov 2022 05:06:11 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.50])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b001866049ddb1sm6907719plk.161.2022.11.08.05.06.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2022 05:06:11 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     avarab@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 1/3] notes.c: introduce "--blank-line" option
Date:   Tue,  8 Nov 2022 21:06:06 +0800
Message-Id: <20221108130606.82005-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.385.g0d8ce0b14b0.dirty
In-Reply-To: <221107.864jvax1hz.gmgdl@evledraar.gmail.com>
References: <221107.864jvax1hz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ævar Arnfjörð Bjarmason" <avarab@gmail.com> writes:

> >  	int allow_empty = 0;
> > +	int blankline = 1;
>
> So keep this...
>
> >  	const char *object_ref;
> >G  	struct notes_tree *t;
> >  	struct object_id object, new_note;
> > @@ -584,6 +585,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
> >  			parse_reuse_arg),
> >  		OPT_BOOL(0, "allow-empty", &allow_empty,
> >  			N_("allow storing empty note")),
> > +		OPT_BOOL(0, "blank-line", &blankline,
>
> ...and just make this "no-blank-line", and parse_options() will do the
> right thing. I.e. PARSE_OPT_NONEG is implied.

Sorry for another question. By the explanation of "api-parse-options.txt" :

`OPT_BOOL(short, long, &int_var, description)`::
	Introduce a boolean option. `int_var` is set to one with
	`--option` and set to zero with `--no-option`

I think it means the same as "parse_options() will do right thing" as you said
to me , but...after the modification the effect is opposite:

diff --git a/builtin/notes.c b/builtin/notes.c
index a6273781fb8..73427ea8dff 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -562,6 +562,7 @@ static int copy(int argc, const char **argv, const char *prefix)
 static int append_edit(int argc, const char **argv, const char *prefix)
 {
        int allow_empty = 0;
+       int blankline = 1;
        const char *object_ref;
        struct notes_tree *t;
        struct object_id object, new_note;
@@ -584,6 +585,8 @@ static int append_edit(int argc, const char **argv, const char *prefix)
                        parse_reuse_arg),
                OPT_BOOL(0, "allow-empty", &allow_empty,
                        N_("allow storing empty note")),
+               OPT_BOOL(0, "no-blank-line", &blankline,
+                       N_("insert paragraph break before appending to an existing note")),
                OPT_END()
        };
        int edit = !strcmp(argv[0], "edit");
@@ -618,7 +621,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
                enum object_type type;
                char *prev_buf = read_object_file(note, &type, &size);

-               if (d.buf.len && prev_buf && size)
+               if (blankline && d.buf.len && prev_buf && size)
                        strbuf_insertstr(&d.buf, 0, "\n");
                if (prev_buf && size)
                        strbuf_insert(&d.buf, 0, prev_buf, size);

----
So, I am a bit confused and I guess maybe somewhere I misunderstood or didn't
notice some details.

Thanks.
