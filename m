Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B639020D11
	for <e@80x24.org>; Tue, 30 May 2017 15:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750925AbdE3P5z (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 11:57:55 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:32958 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdE3P5y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 11:57:54 -0400
Received: by mail-io0-f193.google.com with SMTP id m4so9478217ioe.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x2cx4oqJ1SRBhAAZwJYr+nzSrAGFD6xLF1/W9v1uo8Q=;
        b=Ro08gkURLtI1WMHNG/eYhXYa6JNA+0VIUMZ8W+jzt/zAUq1TuRJ/QxzVJR5ojmgyAF
         lKK0/EtG59MlUXPjZPZQOO+KJ8Xq6FmN1faqW/cinbzSjpqYWaLvVZgG+mWBdOyTk9YF
         xiW5UCu9NwHQRRmf5GDpTNFa8GrfukNEKectPxI9F6tG8D4roPkZkHqlHm8oZuEuxg2w
         t3RLEFTUyVIB8/k2JUrIAEaaz3JXm1vQCo6qCDd7M8YCqL3QFy7E6gsTVhQxVrO7D2lV
         dPJ/kzFldug3v9h0PbN7Het/UkfRkqzExmiqnEmvXnSZkJ22uEY8bQ9JWiTBpkuWT9WL
         CIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x2cx4oqJ1SRBhAAZwJYr+nzSrAGFD6xLF1/W9v1uo8Q=;
        b=Yo9T2nYrXAf1jX3NA9aDruBbbCaefk3mYVypKeFnJAxq0fkZWm5jgzCoTYaP9q9wNC
         n4//6LgkEoCaHzjLvv3WEp/TteoA/4+LNf6dPOOPSE8FisKKG3vvILQV+olzUXiqVtqf
         kBKXIKpMohh2sUziRbKS3uEBpNGzoMAqh1Tb7Fr0EOwYjH8qOWvCpHO5xQkvSZltY+d1
         b1K4lBEVYoiBR8+f1o4QCfaA4b4IiXWVR4o2RQwKRCcbYFnfbOmmcsHNxvN/ParioV/6
         s1TnuwHgPZrabwdI20+K/dYpYOOoJ322zGaebJjakx5YpXE0I/mpwr416I/1CDjW2UCz
         4nOg==
X-Gm-Message-State: AODbwcBjZNWjILxXZBEX91BMUtG8vHIM393M08gi6pAMPYZ9AtY8aS2L
        ZYH4390uHyHl5w==
X-Received: by 10.107.157.67 with SMTP id g64mr17386197ioe.48.1496159873201;
        Tue, 30 May 2017 08:57:53 -0700 (PDT)
Received: from [192.168.2.102] (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id g12sm5674891ioi.44.2017.05.30.08.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 May 2017 08:57:52 -0700 (PDT)
Subject: Re: [PATCH v4 02/10] rebase -i: generate the script via
 rebase--helper
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, phillip.wood@dunelm.org.uk
References: <e173445d9a6321f80053967e50375400c0a61764.1493414945.git.johannes.schindelin@gmx.de>
 <20170526031516.26287-1-liambeguin@gmail.com>
 <alpine.DEB.2.21.1.1705291256430.3610@virtualbox>
From:   liam Beguin <liambeguin@gmail.com>
Message-ID: <9baa8898-36c7-79a9-025b-799785c81284@gmail.com>
Date:   Tue, 30 May 2017 11:57:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1705291256430.3610@virtualbox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 29/05/17 06:59 AM, Johannes Schindelin wrote:
> Hi Liam,
> 
> On Thu, 25 May 2017, Liam Beguin wrote:
> 
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>>
>>> diff --git a/sequencer.c b/sequencer.c
>>> index 130cc868e51..88819a1a2a9 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -2388,3 +2388,52 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
>>>  
>>>  	strbuf_release(&sob);
>>>  }
>>> +
>>> +int sequencer_make_script(int keep_empty, FILE *out,
>>> +		int argc, const char **argv)
>>> +{
>>> +	char *format = NULL;
>>> +	struct pretty_print_context pp = {0};
>>> +	struct strbuf buf = STRBUF_INIT;
>>> +	struct rev_info revs;
>>> +	struct commit *commit;
>>> +
>>> +	init_revisions(&revs, NULL);
>>> +	revs.verbose_header = 1;
>>> +	revs.max_parents = 1;
>>> +	revs.cherry_pick = 1;
>>> +	revs.limited = 1;
>>> +	revs.reverse = 1;
>>> +	revs.right_only = 1;
>>> +	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
>>> +	revs.topo_order = 1;
>>> +
>>> +	revs.pretty_given = 1;
>>> +	git_config_get_string("rebase.instructionFormat", &format);
>>> +	if (!format || !*format) {
>>> +		free(format);
>>> +		format = xstrdup("%s");
>>> +	}
>>> +	get_commit_format(format, &revs);
>>> +	free(format);
>>> +	pp.fmt = revs.commit_format;
>>> +	pp.output_encoding = get_log_output_encoding();
>>> +
>>> +	if (setup_revisions(argc, argv, &revs, NULL) > 1)
>>> +		return error(_("make_script: unhandled options"));
>>> +
>>> +	if (prepare_revision_walk(&revs) < 0)
>>> +		return error(_("make_script: error preparing revisions"));
>>> +
>>> +	while ((commit = get_revision(&revs))) {
>>> +		strbuf_reset(&buf);
>>> +		if (!keep_empty && is_original_commit_empty(commit))
>>> +			strbuf_addf(&buf, "%c ", comment_line_char);
>>
>> I've never had to use empty commits before, but while testing this, I
>> noticed that `git rebase -i --keep-empty` behaves differently if using
>> the --root option instead of a branch or something like 'HEAD~10'.
>> I also tested this on v2.13.0 and the behavior is the same.
> 
> FWIW the terminology "empty commit" is a pretty poor naming choice. This
> is totally not your fault at all. I just wish we had a much more intuitive
> name to describe a commit that does not introduce any changes to the tree.
> 
> And yes, doing this with --root is a bit of a hack. That's because --root
> is a bit of a hack.
> 
> I am curious, though, as to the exact differences you experienced. I mean,
> it could be buggy behavior that needs to be fixed (independently of this
> patch series, of course).
> 

Sorry, reading this I realized that I didn't give any details!
When using --root, --keep-empty has no effect. The empty commits
do not appear in the todo list and they are removed.
Also, when using --root without --keep-empty, the empty commits
do not show up as comments in the list.

> Ciao,
> Johannes
> 

Liam 
