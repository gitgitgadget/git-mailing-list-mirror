Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACDD5207EB
	for <e@80x24.org>; Fri, 28 Apr 2017 00:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939440AbdD1ANZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 20:13:25 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35776 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754271AbdD1ANX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 20:13:23 -0400
Received: by mail-pg0-f66.google.com with SMTP id s1so204676pgc.2
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 17:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0fMCEhMHBxxrtRni42J+XUBMdAMgOxgP5C4MUE8l214=;
        b=cn0kjWibPqrF0rIyVoYJi3fX+7MVyMEImFLt18XHzPrVq9dqhd3hJLwZW2uKvmS8ze
         ibQsm6AgeGO8r4BMBXVgJnKL2ZPM96ZwbTI0xl9akZnuj5FIIMlmPlVrVyAK3oc9s2Ff
         Kb8K1+uBCA0qwXxJkMzCgVQlPCxkj4OrEru8Nrmi60tCkbve2vC7jGg7ODvAasH28yTe
         C0rFpQCs5q1oNK4AS0CkNACxFXkqzQJGo7WtjLeA3f1Q2GMH+N+gn7xSYCuPdUk7/0MI
         xRGKlOj8xZ1i16zJR2gzxpvvrb8cRUzAO9neFJkjZrPiK8BjAsClgcONCaWgYNsxI36v
         pXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0fMCEhMHBxxrtRni42J+XUBMdAMgOxgP5C4MUE8l214=;
        b=qJVjtkYMUptyb0lZSBoPlIs+OHADA+u5pAOg34pYfeM7Lf0sWUW6CdMkray+QMJP7j
         YcHGyNkUaWX8+ZZdNmhjsi181pV7gVAbtkDhDYbqiwayG3c9C9nQJQHlkkWaA+isIElh
         UONA/3CVuY1l2Dzgo17/MPs+5kBKFBGHhHrEwMaXucNe06ytuqLZEGTIg80vUJKL9/rS
         bkwUlmoLSWjjBP/NYGChw6G7VstJWDdo0Ek50Q7JHbfRPNgsFo9tq9kih+IDd2E5sHqB
         WUyuXwam212UsZl1oivTaD4ibgpkrKJyHMsddQLBLVnpPqbKnrdrd/RoNgf0buU5nGuW
         PUkQ==
X-Gm-Message-State: AN3rC/6x2khduX8gv63A6ohzPp3u5XmZZwDBgOMCALZ5/DFqjvY9/75i
        tGdr+QC+0UZXDw==
X-Received: by 10.99.97.85 with SMTP id v82mr8856246pgb.186.1493338402713;
        Thu, 27 Apr 2017 17:13:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:51c2:e137:8e5a:b68b])
        by smtp.gmail.com with ESMTPSA id u23sm7450720pgo.58.2017.04.27.17.13.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 27 Apr 2017 17:13:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/9] rebase -i: generate the script via rebase--helper
References: <cover.1493128210.git.johannes.schindelin@gmx.de>
        <cover.1493207864.git.johannes.schindelin@gmx.de>
        <c44a15ed1f1015d7e9377e18610a0c428786995b.1493207864.git.johannes.schindelin@gmx.de>
        <xmqqvapqo4i8.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1704271607550.3480@virtualbox>
Date:   Thu, 27 Apr 2017 17:13:19 -0700
In-Reply-To: <alpine.DEB.2.20.1704271607550.3480@virtualbox> (Johannes
        Schindelin's message of "Thu, 27 Apr 2017 16:18:44 +0200 (CEST)")
Message-ID: <xmqqbmrhmlsw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 26 Apr 2017, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > diff --git a/sequencer.c b/sequencer.c
>> > index 77afecaebf0..e858a976279 100644
>> > --- a/sequencer.c
>> > +++ b/sequencer.c
>> > @@ -2388,3 +2388,48 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
>> >  
>> >  	strbuf_release(&sob);
>> >  }
>> > +
>> > +int sequencer_make_script(int keep_empty, FILE *out,
>> > +		int argc, const char **argv)
>> > +{
>> > +	char *format = xstrdup("%s");
>> > +	struct pretty_print_context pp = {0};
>> > +	struct strbuf buf = STRBUF_INIT;
>> > +	struct rev_info revs;
>> > +	struct commit *commit;
>> > +
>> > +	init_revisions(&revs, NULL);
>> > +	revs.verbose_header = 1;
>> > +	revs.max_parents = 1;
>> > +	revs.cherry_pick = 1;
>> > +	revs.limited = 1;
>> > +	revs.reverse = 1;
>> > +	revs.right_only = 1;
>> > +	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
>> > +	revs.topo_order = 1;
>> > +
>> > +	revs.pretty_given = 1;
>> > +	git_config_get_string("rebase.instructionFormat", &format);
>> > +	get_commit_format(format, &revs);
>> > +	free(format);
>> > +	pp.fmt = revs.commit_format;
>> > +	pp.output_encoding = get_log_output_encoding();
>> 
>> All of the above feels like inviting unnecessary future breakages by
>> knowing too much about the implementation the current version of
>> revision.c happens to use.
>
> You mean that the `--reverse` option gets translated into the `reverse`
> bit, and the other settings?

Yes.  The "pretty_given" trick is one example that the underlying
implementation can change over time.  If you wrote this patch before
66b2ed09 ("Fix "log" family not to be too agressive about showing
notes", 2010-01-20) happened, you wouldn't have known to flip this
bit on to emulate the command line parsing of "--pretty" and
friends, and you would have required the author of that change to
know that you have this cut & pasted duplicated code here when the
commit is primarily about updating revision.c

So I am very serious when I say that this is adding an unnecessary
maintenance burden.

