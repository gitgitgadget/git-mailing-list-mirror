Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 570FE20248
	for <e@80x24.org>; Mon, 11 Mar 2019 21:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfCKVke (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 17:40:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39839 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbfCKVke (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 17:40:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id p8so482591wrq.6
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 14:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lVwCpVLMHQVTep4DYhr01w5gj+GPnFKn+CEaVVfKot8=;
        b=h57i/0dTOEBAzqTZCZ0NGKVvFy4oMVJkFdgKlq3Q+owaXYx6lSFovHKZtSSl/zinLg
         L9WlB7t7qJFQJsDgj6BgSD+auXWpqUYGjv/29+uABrFb1hMvq+XohREIyt0gO4jfkKWx
         HzlJy3fKl3CXVRJnAFP0ZVut59WZn6wucPlgRTa3+drk6undcMOwCFYn4Pi3xf1XUEO9
         maQTpsQ3RAR958O/AyvTt7kZ6Sz6Uwc2WbaI0bjvP3MS5YCuoWIpjyVMDhqV2oo8XdCu
         yGGpPg2dpE1f0pHr0LJuijeuusxBPp1UUDpYVpIoGPqPaWK+j2GF2E4tWbFVipWbLube
         BlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lVwCpVLMHQVTep4DYhr01w5gj+GPnFKn+CEaVVfKot8=;
        b=aF1xXr9Sh7OEptZKBTHysnsybNHkahFsKj7Yer8u1GA+hJfqVvXEZULirpFIZWpqSd
         /1I0OVH/MLkX5534UXeNgHD+4TUx64X+49TcqtyfAjZo0/buJqlInsKfhVI1WmcZw4mS
         2vtL32SQe0JqfNqmi+puGxfXu7lv8rKhC3wR3ZmRv/fQUt96WsqbGg98hs93KAhka77B
         D4dZ0mEVUDh6o6lHEwZXlSOzYY0Q3L1i8w8hj16yq3C0MSHqTfauSxqx+QuTOx7q7+gr
         CzyACj3H+5wHhQ8H6l02gF8fKZbY0da0eqAH2AydGmHSXU5+NJDI8vyh1aa4YEc4xN3m
         aUkw==
X-Gm-Message-State: APjAAAUiCWX+LnPECDbfczTMR0pSe4WF2E+GalaHUT85XAF/lWOf6iDi
        4W4B1oai60Vmw1Nf3vCH0WI=
X-Google-Smtp-Source: APXvYqx6hu8oPVmnRKAkeBqS8PniKrwiJE6Uhsbxo1n2H7X001JC0uJUf9wrbwgyZJwafV8ZA10GKw==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr22927154wrv.126.1552340431930;
        Mon, 11 Mar 2019 14:40:31 -0700 (PDT)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id j17sm5283186wrw.67.2019.03.11.14.40.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 14:40:30 -0700 (PDT)
Date:   Mon, 11 Mar 2019 21:40:29 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>
Subject: Re: [PATCH v13 12/27] stash: convert drop and clear to builtin
Message-ID: <20190311214029.GA16414@hank.intra.tgummerer.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
 <20190225231631.30507-13-t.gummerer@gmail.com>
 <20190307191533.GA29221@sigill.intra.peff.net>
 <20190309183021.GE31533@hank.intra.tgummerer.com>
 <xmqqmum2mbn4.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmum2mbn4.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/11, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Agreed, I'd be happy to keep the parameter there.  Looking at your
> > fork, you seem to have some WIP patches to introduce a UNUSED macro
> > for parameters like this, which I don't think I've seen on the list
> > yet (though I may have just missed them).
> >
> > I guess it's probably best for you to mark this parameter as UNUSED as
> > part of your series, but if you have a different preference on how to
> > handle it, let me know.
> 
> I agree that the uniformity among near-toplevel helpers like
> create_stash() is a good thing to have.
> 
> In the meantime, you want the patch you sent (below) on top of the
> stash-in-c topic to address do_drop_stash()?

Yes, I think that would be good, thanks! (And if I read Peff's reply
in this thread correctly, I think that's his preference as well).

I also just realized that this is patch 2/2 as I created it on the
same branch as the pathspec fixups.  But they are really independent,
even though they should both end up on top of ps/stash-in-c.

> Thanks for working well together.
> 
> > --- >8 ---
> > Subject: [PATCH 2/2] stash: drop unused parameter
> >
> > Drop the unused prefix parameter in do_drop_stash.
> >
> > We also have an unused "prefix" parameter in the 'create_stash'
> > function, however we leave that in place for symmetry with the other
> > top-level functions.
> >
> > Reported-by: Jeff King <peff@peff.net>
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  builtin/stash.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/builtin/stash.c b/builtin/stash.c
> > index 6eb67c75c3..069bf14846 100644
> > --- a/builtin/stash.c
> > +++ b/builtin/stash.c
> > @@ -527,7 +527,7 @@ static int apply_stash(int argc, const char **argv, const char *prefix)
> >  	return ret;
> >  }
> >  
> > -static int do_drop_stash(const char *prefix, struct stash_info *info, int quiet)
> > +static int do_drop_stash(struct stash_info *info, int quiet)
> >  {
> >  	int ret;
> >  	struct child_process cp_reflog = CHILD_PROCESS_INIT;
> > @@ -597,7 +597,7 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
> >  
> >  	assert_stash_ref(&info);
> >  
> > -	ret = do_drop_stash(prefix, &info, quiet);
> > +	ret = do_drop_stash(&info, quiet);
> >  	free_stash_info(&info);
> >  	return ret;
> >  }
> > @@ -626,7 +626,7 @@ static int pop_stash(int argc, const char **argv, const char *prefix)
> >  		printf_ln(_("The stash entry is kept in case "
> >  			    "you need it again."));
> >  	else
> > -		ret = do_drop_stash(prefix, &info, quiet);
> > +		ret = do_drop_stash(&info, quiet);
> >  
> >  	free_stash_info(&info);
> >  	return ret;
> > @@ -663,7 +663,7 @@ static int branch_stash(int argc, const char **argv, const char *prefix)
> >  	if (!ret)
> >  		ret = do_apply_stash(prefix, &info, 1, 0);
> >  	if (!ret && info.is_stash_ref)
> > -		ret = do_drop_stash(prefix, &info, 0);
> > +		ret = do_drop_stash(&info, 0);
> >  
> >  	free_stash_info(&info);
