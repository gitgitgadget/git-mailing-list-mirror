Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E73F61F597
	for <e@80x24.org>; Mon, 30 Jul 2018 20:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbeG3V5U (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 17:57:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46735 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbeG3V5U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 17:57:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id h14-v6so14216135wrw.13
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 13:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ptfkvYqkPKVAahSpP63B02akg30UDzk7xJ8rfgNejPA=;
        b=S8rU7CGazKSFi8zrcs9IWfp7lLwU52BHq1qG1F5MQ3sOUd9TJHy8U8fOLJ9A7kRulb
         msSFTqu5QJbpoc3GPuAD+A8LlXtuvDTchL3yUoxUVAwewnV6AdlsMbNX3Zly+3ACmrl4
         qO+U5rvCaFvgLL+7Q/WHwlg8Va9KjKxS+zuUB32s9MlmdC8HFA83z4vJ7m5vQRYrgtn+
         rfs0IMSWpATWLkn75lZUrhP3OqIImca14oIHTb2YeoXbuLVkHchOKVppNVNNUXZfvf9K
         J20gD59ctH6Kx/2kEB7CCBEmQ5bCkEAJPEGq9vLVSYW/BhyiOWqSd/Mh4sgE5c+1NV04
         OdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ptfkvYqkPKVAahSpP63B02akg30UDzk7xJ8rfgNejPA=;
        b=k2n+DzwJNsGm19talS/jsSzDlPRMxLB+AcZFFI1efR+25uiwVJ+K5RiZRW8bk2gJFD
         ryRbg2RCmSMnqpOKFsTDHzVx6kXMChvmZSwZzkq61wT0I4Qr9P3WweWO4LGCHJt4komt
         +kY5tEPEb3S3BIITir6cKDthIzQZLUkPAh5R7wMoqahz6ZP7cEUWFj/M7NmtN47H1KZL
         0fXtCg7eH32Wk3IyB5CPpXRV11Io1KfnvPiAgasCNSm8MOjqrlO+f8rEs2JWiTvCPoc5
         G1KHFcB5NkLyMjzK6uuBlltxO2iVUJPmXa7yPY2SOxFTSFmXRwSS3roruPFqN5AuEOV8
         tQTw==
X-Gm-Message-State: AOUpUlGoCxU5TWNyMM+I8LTayUGp06AWbDsK4S/8wczIBjef/xvUjOcy
        XwKDT80FikmxxPb9xykMY5MLBAzK
X-Google-Smtp-Source: AAOMgpdhyXvfXTDGCq7uNUXllNt10dEu/QRWiUHAF5lRYmOpbI9s0nqf8uiucjO7QMHWIKqRpyTWTw==
X-Received: by 2002:adf:de84:: with SMTP id w4-v6mr19555969wrl.270.1532982039304;
        Mon, 30 Jul 2018 13:20:39 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id b13-v6sm20381403wrn.17.2018.07.30.13.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 13:20:38 -0700 (PDT)
Date:   Mon, 30 Jul 2018 21:20:37 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 10/11] rerere: teach rerere to handle nested conflicts
Message-ID: <20180730202037.GF9955@hank.intra.tgummerer.com>
References: <20180605215219.28783-1-t.gummerer@gmail.com>
 <20180714214443.7184-1-t.gummerer@gmail.com>
 <20180714214443.7184-11-t.gummerer@gmail.com>
 <xmqqzhy8hb2s.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzhy8hb2s.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/30, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Currently rerere can't handle nested conflicts and will error out when
> > it encounters such conflicts.  Do that by recursively calling the
> > 'handle_conflict' function to normalize the conflict.
> >
> > The conflict ID calculation here deserves some explanation:
> >
> > As we are using the same handle_conflict function, the nested conflict
> > is normalized the same way as for non-nested conflicts, which means
> > the ancestor in the diff3 case is stripped out, and the parts of the
> > conflict are ordered alphabetically.
> >
> > The conflict ID is however is only calculated in the top level
> > handle_conflict call, so it will include the markers that 'rerere'
> > adds to the output.  e.g. say there's the following conflict:
> >
> >     <<<<<<< HEAD
> >     1
> >     =======
> >     <<<<<<< HEAD
> >     3
> >     =======
> >     2
> >     >>>>>>> branch-2
> >     >>>>>>> branch-3~
> 
> Hmph, I vaguely recall that I made inner merges to use the conflict
> markers automatically lengthened (by two, if I recall correctly)
> than its immediate outer merge.  Wouldn't the above look more like
> 
>      <<<<<<< HEAD
>      1
>      =======
>      <<<<<<<<< HEAD
>      3
>      =========
>      2
>      >>>>>>>>> branch-2
>      >>>>>>> branch-3~
>     
> Perhaps I am not recalling it correctly.

The only way I could reproduce this is by not resolving a conflict
(just leaving the conflict markers in place, but running 'git add
conflicted'), and then merging something else, which produces another
conflict, where one of the sides was the one with conflict markers
already in the file, same as what I did in the test.

So in that case, the conflict markers of the already existing conflict
would just be treated as normal text during the merge I believe, and
thus the new conflict markers would be the same length.

The usage of git is really a bit wrong here, so I don't know if it's
actually worth helping the users at this point.  But trying to
understand how rerere exactly works, I had this written up already, so
I thought I would include it in this series anyway in case it helps
somebody :)

> > it would be recorde as follows in the preimage:
> >
> >     <<<<<<<
> >     1
> >     =======
> >     <<<<<<<
> >     2
> >     =======
> >     3
> >     >>>>>>>
> >     >>>>>>>
> >
> > and the conflict ID would be calculated as
> >
> >     sha1(1<NUL><<<<<<<
> >     2
> >     =======
> >     3
> >     >>>>>>><NUL>)
> >
> > Stripping out vs. leaving the conflict markers in place in the inner
> > conflict should have no practical impact, but it simplifies the
> > implementation.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  Documentation/technical/rerere.txt | 42 ++++++++++++++++++++++++++++++
> >  rerere.c                           | 10 +++++--
> >  t/t4200-rerere.sh                  | 37 ++++++++++++++++++++++++++
> >  3 files changed, 87 insertions(+), 2 deletions(-)
> >
> > [..snip..]
> > 
> > diff --git a/rerere.c b/rerere.c
> > index a35b88916c..f78bef80b1 100644
> > --- a/rerere.c
> > +++ b/rerere.c
> > @@ -365,12 +365,18 @@ static int handle_conflict(struct strbuf *out, struct rerere_io *io,
> >  		RR_SIDE_1 = 0, RR_SIDE_2, RR_ORIGINAL
> >  	} hunk = RR_SIDE_1;
> >  	struct strbuf one = STRBUF_INIT, two = STRBUF_INIT;
> > -	struct strbuf buf = STRBUF_INIT;
> > +	struct strbuf buf = STRBUF_INIT, conflict = STRBUF_INIT;
> >  	int has_conflicts = -1;
> >  
> >  	while (!io->getline(&buf, io)) {
> >  		if (is_cmarker(buf.buf, '<', marker_size)) {
> > -			break;
> > +			if (handle_conflict(&conflict, io, marker_size, NULL) < 0)
> > +				break;
> > +			if (hunk == RR_SIDE_1)
> > +				strbuf_addbuf(&one, &conflict);
> > +			else
> > +				strbuf_addbuf(&two, &conflict);
> 
> Hmph, do we ever see the inner conflict block while we are skipping
> and ignoring the common ancestor version, or it is impossible that
> we see '<' only while processing either our or their side?

As mentioned above, I haven't been able to reproduce creating an inner
conflict block outside of the case mentioned above, where the user
committed conflict markers, and then did another merge.

I don't think it can appear outside of that case in "normal"
operation.

> > +			strbuf_release(&conflict);
> >  		} else if (is_cmarker(buf.buf, '|', marker_size)) {
> >  			if (hunk != RR_SIDE_1)
> >  				break;
> > diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> > index 34f0518a5e..d63fe2b33b 100755
> > --- a/t/t4200-rerere.sh
> > +++ b/t/t4200-rerere.sh
> > @@ -602,4 +602,41 @@ test_expect_success 'rerere with unexpected conflict markers does not crash' '
> >  	git rerere clear
> >  '
> >  
> > +test_expect_success 'rerere with inner conflict markers' '
> > +	git reset --hard &&
> > +
> > +	git checkout -b A master &&
> > +	echo "bar" >test &&
> > +	git add test &&
> > +	git commit -q -m two &&
> > +	echo "baz" >test &&
> > +	git add test &&
> > +	git commit -q -m three &&
> > +
> > +	git reset --hard &&
> > +	git checkout -b B master &&
> > +	echo "foo" >test &&
> > +	git add test &&
> > +	git commit -q -a -m one &&
> > +
> > +	test_must_fail git merge A~ &&
> > +	git add test &&
> > +	git commit -q -m "will solve conflicts later" &&
> > +	test_must_fail git merge A &&
> > +
> > +	echo "resolved" >test &&
> > +	git add test &&
> > +	git commit -q -m "solved conflict" &&
> > +
> > +	echo "resolved" >expect &&
> > +
> > +	git reset --hard HEAD~~ &&
> > +	test_must_fail git merge A~ &&
> > +	git add test &&
> > +	git commit -q -m "will solve conflicts later" &&
> > +	test_must_fail git merge A &&
> > +	cat test >actual &&
> > +	test_cmp expect actual
> > +'
> > +
> >  test_done
