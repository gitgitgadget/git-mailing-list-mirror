Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB57BC05027
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 14:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjBTOBX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 09:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjBTOBV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 09:01:21 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D60F1E9E3
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 06:00:56 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id bh1so1458159plb.11
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 06:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1P6PwJWIaVWokxt9UVRRrQ4vaOT0E1yeoOCf4QCvZg=;
        b=RH4JSqr52dZobdDdA+3nF3HEzvs4SUxbCb1Un3qWEEkMYxO4xrg6dFBDESn/hxhxtJ
         bbFU+zcmhlXQ/Zzo52kh0CEAX511v/bePRsGXg5xokf1Z1VHMI5b+fnTmXNf+rT8SdHi
         HwG2/FnufoxP+jqK9lu2yK8Iu2s6tClf1hv/iXRb4CFlxjL7nzf2+Y1Sf7be+cYffz5V
         NiKMaGlQcQEhDXph2PP1p+Bp8FkuLJoNDN2ZEHSjHXO72vJ+5IQm9iumudFgM7E83dQv
         t44pl8k2DcAdg4fIOE4NMYE/4Ic9Zyz/F0xTxtsph0ZnzMULvVvtYUaGuGrZ019dBTlb
         Qihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1P6PwJWIaVWokxt9UVRRrQ4vaOT0E1yeoOCf4QCvZg=;
        b=NKG9dVykoPcz7Ds7AoNBOj5L8Als2fGylzTU9eXd+7Ir6bc3tHtcHi2hmWa8Se/j30
         6Pg2/lDp8Mj00nuoYPDCt36OXx0x5bnGmOxZ4H3jzENOFbEfcFSu5OZjNItwlC0CbEoH
         A4eHhkTLgBSmJZbrZyrwnOOpi9WUzwOGWEOaX7bYT4w34rHOmfCNXM2ypa9YuXqfKSBJ
         K3xQM20YNufvk1hziyZ5Wh6GGN7xATiJ/8kDYibiHM40Eio8yPPUFFmtI08MWZ46U2bw
         d8PQIPNWWd5QJvfcQYFgAvM6kkH0ATnESPsryUzKfX0kwPXTCvisDIKhypJ3NG5oAJvH
         Q/yQ==
X-Gm-Message-State: AO0yUKUrFLYsEIS8WlvvdWYVLrqiI/knWRbUr2X/HDO5AzozCHUD/vH0
        rCTRRELeU53Esg5KONxVyCU=
X-Google-Smtp-Source: AK7set+D1bxvhBDGnrVsVjNtOES19oZ3kk9i+QIlpr6pmXu996ZbDGUp5EnYOEpBauRdIGOo2w61rA==
X-Received: by 2002:a17:903:18e:b0:19a:5933:936e with SMTP id z14-20020a170903018e00b0019a5933936emr4321786plg.38.1676901654294;
        Mon, 20 Feb 2023 06:00:54 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.53])
        by smtp.gmail.com with ESMTPSA id bi12-20020a170902bf0c00b00194c1281ca9sm7945267plb.166.2023.02.20.06.00.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Feb 2023 06:00:52 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        sunshine@sunshineco.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v5 3/3] notes.c: introduce "--separator" option
Date:   Mon, 20 Feb 2023 22:00:46 +0800
Message-Id: <20230220140046.16986-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.39.2.459.g1d9d282d
In-Reply-To: <xmqq7cwhnql3.fsf@gitster.g>
References: <xmqq7cwhnql3.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote on Thu, 16 Feb 2023 15:22:16 -0800:

> > When appending to a given notes object and the appended note is not
> > empty too, we will insert a blank line at first which separates the
> > existing note and the appended one, which as the separator.
>
> ", which as the separator" does not sound grammatically correct.
> Without that part, the above is a perfectly readable description of
> the current behaviour.

OK, I will remove ", which as the separator".

> > Sometimes, we want to use a specified <separator> as the separator. For
> > example, if we specify as:
> >
> >     * --separator='------': we will insert "------\n" as the separator,
> >     because user do not provide the line break char at last, we will add
> >     the trailing '\n' compatibly.
>
> In a way compatible to what?  I think s/compatibly// would be even
> easier to read.  I think you are doing that for convenience.

My bad, I think I use a wrong word, maybe s/compatibly/automatically
and I look back and think the representation of "------\n" is not
correct, because "\n" is two characters here and will not treat
as a newline. So, after modification, maybe like:

   * --separator='------': we will insert "------" and a trailing
   newline character, because if no newline specified at the end,
   one will be added automatically.

> >     * --separator='------\n': we will insert as-is because it contains
> >     the line break at last.
>
> If this behaviour gets spelled out like this, it needs to be
> justified.
>
> After seeing that "------" gives the user these dashes on its own
> single line, wouldn't a natural expectation by the user be to see a
> line with dashes, followed by a blank line, if you give "------\n"?
> How do you justify removal of that newline in a way that is easy to
> understand to readers?
>
> I am not saying that you should allow --separator="---\n\n\n" to
> give three blank lines between paragraphs. I think it makes sense to
> keep the stripspace in the code after a paragraph gets added. I just
> prefer to see it done as our design choice, not "because there is
> stripspace that removes them", i.e. what the code happens to do.

Firstly, like the problem I talked above, please let me figure out that
"------\n" is not represent as "------" and a blank line, but only
as "------\n" verbatim because "\n" will be treated as two characters
but not a blank line while parsing. If the user wants to specify a
blank line in the value of the option, they can pass "CTRL+v CTRL+j".

Then, I think I did get some interference from old logic. Returning
to the user scenario, I think about what the user needs and what is
my original idea is: consistent behavior

   * behavior 1: What the user enters is used as the delimiter itself
   without any special processing.

   * behavior 2: No matter what the user enters, we always add a
   newline at the end or other logic like stripspace, etc.

I prefer the first one, sometimes users want to be next to the previous
note, then:

   git notes append -m foo -m bar --separator=""

and they can also choose to add as many line breaks as they want, then:

    export LF="
    "
    git notes append -m foo -m bar --separator="$LF$LF$LF"

We didn't help users make choices but I have to say it may be a little
inconvenient to enter a newline character in the terminal, but I still
prefer this way.

> >     * not specified --separator option: will use '\n' as the separator
> >     when do appending and this is the default behavour.
>
> s/not specified --separator option/no --separator option/; the way
> you phrased can be misread for
>
Will apply as:

        * no --separator option: will use '\n' as the separator when
        do appending and this is the default behavour.

> 	git notes --separator -m foo -m bar
>
> i.e. any additional specifics is not given but --separator is still
> on the command line.  But I do not think you meant that---rather
> this entry is what happens by default, i.e. a blank line separates
> each paragraph.

Yes, only separate the messages(-m), but not each paragraph in it.

> >     * --separator='': we specify an empty separator which has the same
> >     behavour with --separator='\n' and or not specified the option.
>
> I do not quite see why it is necessary to spell this out.  Isn't
> this a natural consequence of the first one (i.e. "six dashes
> without any terminating LF gets a line with dashes plus LF"
> naturally extends to "0 dashes without any terminating LF gets a
> blank line")?

Agree.. will remove.

> > In addition, if a user specifies multple "-m" with "--separator", the
> > separator should be inserted between the messages too, so we use
> > OPT_STRING_LIST instead of OPT_CALLBACK_F to parse "-m" option, make
> > sure the option value of "--separator" been parsed already when we need
> > it.
>
> This is hard to grok.  Is it an instruction to whoever is
> implementing this new feature, or is it an instruct to end-users
> telling that they need to give --separator before they start giving
> -m <msg>, -F <file>, -c <object>, etc.?

No, it's not the order of the user give, but the backend we deal.

We use "parse_msg_arg" as a callback when parsing "-m " by OPT_CALLBACK_F,
so if we have to read the separator before we parse it, so we could insert
it correctly between the messages, So I use OPT_STRING_LIST instead.


> > diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> > index efbc10f0..5abe6092 100644
> > --- a/Documentation/git-notes.txt
> > +++ b/Documentation/git-notes.txt
> > @@ -11,7 +11,7 @@ SYNOPSIS
> >  'git notes' [list [<object>]]
> >  'git notes' add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
>
> Doesn't add allow you to say
>
> 	$ git notes add -m foo -m bar
>
> Shouldn't it also honor --separator to specify an alternate
> paragraph break?

Agree, you also mentioned me that, does git-notes-add need to be implies by
this option too? I think it needs too.

> > @@ -86,7 +86,9 @@ the command can read the input given to the `post-rewrite` hook.)
> >
> >  append::
> >  	Append to the notes of an existing object (defaults to HEAD).
> > -	Creates a new notes object if needed.
> > +	Creates a new notes object if needed. If the note and the
> > +	message are not empty, "\n" will be inserted between them.
> > +	Use the `--separator` option to insert other delimiters.
>
> "\n" is so, ... programmer lingo?  "A blank line" is inserted
> between these paragraphs.

Will apply.

> > +--separator <separator>::
> > +	The '<separator>' inserted between the note and message
> > +	by 'append', "\n" by default. A custom separator can be
>
> I see no reason to single out 'append'; "add -m <msg> -m <msg>"
> follows exactly the same paragraph concatenation logic in the
> current code, no?  If we allow customized paragraph separators,
> we should use the same logic there as well.

Agree, as I replied above, I think it will be done in next patch.

> It probably is simpler to explain if you treat the "current note in
> 'append'" as if the text were just "earlier paragraphs", to which
> more paragraphs taken from each -m <msg> and -F <file> are
> concatenated, with paragraph break before each of them.  In the case
> of 'add', there happens to be zero "earlier paragraphs", but
> everything else gets concatenated the same way, no?

Yes, they are the same way, you are right, so we should let add and append
both be implied by the option.

> > +	provided, if it doesn't end in a "\n", one will be added
> > +	implicitly .
>
> Funny punctuation.

My bad, will fix.

Thanks very much for your detailed review.
