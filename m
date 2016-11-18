Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AF271FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 22:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752302AbcKRWwY (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 17:52:24 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:35107 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbcKRWwX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 17:52:23 -0500
Received: by mail-pg0-f48.google.com with SMTP id p66so107282970pga.2
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 14:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pETZVY4Ej35XPRlVAXeIQAXjTG2wGeNRmKeur+ddA/M=;
        b=MFOFl9husyvOJO07A4tkiqahfi1+np5ZW0RHEYfmF4Cs3XsXrGoK+iMg5OvZbbS3Mo
         mmMmGTxe8qrZF5ae50sD3epxj4+G59fKkU0SziR2eiqTocj4unIlm9uLaqEocYVUg5ky
         VkTgt88U+2qzH0NsiXbjhhxQnthUbgmdK7WUhXM4C2uU262HgsfzSu6+VDPMAZkAwExM
         v00tggliQc9H6+j35v0TimICq3nJYXEFbbKFHP8jlhevh4o3cV+4e+qL7oekGpywZ/qc
         xNLbFrxgl7mzTV65IIBYq7kG0xvYxcQVxpisQaRev1eKjWyljA2hsW23QsfCTsltDOUO
         gYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pETZVY4Ej35XPRlVAXeIQAXjTG2wGeNRmKeur+ddA/M=;
        b=h4oOQToQLPxD8XDxIVtB7ZXqENMFSa8vaP4oSqz7OBRnRaslUNfVxW2vqt9syTNp3e
         el+LK2qM2VlHeK6NZvmuRvBYNq+a459uNH7SIrQQAECAvd86oRyb1xuFZAJSSAGaGVwr
         xOsekAbZedxYe4v8mZg94qpgj6PYTexo5DrGB/t/+vLBgTHcdZ+9GaPfW/qFeHN7QmsI
         3yJsh92Wf6M2uDAqA+AuO75pxyChOgDOdCJxPjbvElX20FG9suvfxeLjIA4BrjNO9Cs0
         TDeojGSTOZPqNjjv9ndDjW2umFL+6I4aMqBVY+SW92zPck1wW3TgGKp6xCX9F6WFGzE1
         YZEQ==
X-Gm-Message-State: AKaTC03M51y6N8ImqFcSUb0ykGSZgccql88FkzEsdBsYLEBWqtCMJUC6nTsRRvv6B784T1HZ
X-Received: by 10.98.157.148 with SMTP id a20mr2707289pfk.1.1479509542901;
        Fri, 18 Nov 2016 14:52:22 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:dc40:d740:d9f4:37a3])
        by smtp.gmail.com with ESMTPSA id q14sm20262757pfa.40.2016.11.18.14.52.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 18 Nov 2016 14:52:21 -0800 (PST)
Date:   Fri, 18 Nov 2016 14:52:20 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 5/6] grep: enable recurse-submodules to work on <tree>
 objects
Message-ID: <20161118225220.GA76630@google.com>
References: <1478908273-190166-1-git-send-email-bmwill@google.com>
 <1479499135-64269-1-git-send-email-bmwill@google.com>
 <1479499135-64269-6-git-send-email-bmwill@google.com>
 <xmqqh974l9bz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh974l9bz.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/18, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > @@ -671,12 +707,29 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
> >  	enum interesting match = entry_not_interesting;
> >  	struct name_entry entry;
> >  	int old_baselen = base->len;
> > +	struct strbuf name = STRBUF_INIT;
> > +	int name_base_len = 0;
> > +	if (super_prefix) {
> > +		strbuf_addstr(&name, super_prefix);
> > +		name_base_len = name.len;
> > +	}
> >  
> >  	while (tree_entry(tree, &entry)) {
> >  		int te_len = tree_entry_len(&entry);
> >  
> >  		if (match != all_entries_interesting) {
> > -			match = tree_entry_interesting(&entry, base, tn_len, pathspec);
> > +			strbuf_setlen(&name, name_base_len);
> > +			strbuf_addstr(&name, base->buf + tn_len);
> > +
> > +			if (recurse_submodules && S_ISGITLINK(entry.mode)) {
> > +				strbuf_addstr(&name, entry.path);
> > +				match = submodule_path_match(pathspec, name.buf,
> > +							     NULL);
> 
> The vocabulary from submodule_path_match() returns is the same as
> that of do_match_pathspec() and match_pathspec_item() which is
> MATCHED_{EXACTLY,FNMATCH,RECURSIVELY}, which is different from the
> vocabulary of the variable "match" which is "enum interesting" that
> is used by the tree-walk infrastructure.
> 
> I doubt they are compatible to be usable like this.  Am I missing
> something?

I think i initially must have thought it would work out, but looking
back at this I can clearly see that they aren't 100% compatible...

It slightly feels odd to me that we have so many different means for
checking pathspecs, all of which pretty much duplicate some of the
functionality of the other.  Is there any reason there are these two
different code paths?  Do we want them to remain separate or have them
be unified at some point?

Also, in order to use the tree_entry_interesting code it looks like I'll
either have to pipe through a flag saying 'yes i want to match against
submodules' like I did for the other pathspec codepath.  Either that or
add functionality to perform wildmatching against partial matches (ie
directories and submodules) since currently the tree_entry_interesting
code path just punts and says 'well say it matches for now and check
again later' whenever it runs into a directory (I can't really make it
do that for submodules without a flag of somesort as tests could break).
Or maybe both?

-- 
Brandon Williams
