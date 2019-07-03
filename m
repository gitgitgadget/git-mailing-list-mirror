Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A782B1F461
	for <e@80x24.org>; Wed,  3 Jul 2019 18:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfGCS4O (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 14:56:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45703 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCS4O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 14:56:14 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so1666822pgp.12
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 11:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WmMQ5LPDB+kCWJcWtIlfROvHdPnb8L0LvRkMopeKMsY=;
        b=EHkcbvW9a3ZOeHe2Q33MryuBOFl+tn1eWNEoLtlKlmL+gPEHhmd7lvBPlfdpBd1+4h
         PQ7RP4gGeEC6JL7I/VFgMgUm/A/z6qWkRu+SybxwLVzfZzaJ45h9panOeZTnnYoEcri7
         ZbgTs7IB61HXOfrZuktn1/PINyodLnAYjOC2Ar1KkUOhWXgMuL864GwUsVyOJhSlKR5f
         yNt/zU7xwWOwAOkTvGfM8hoHnp5F9evEV6tc/APA4eQ3+7sjmq1QYvKxQ83fSdlMMwUl
         Ch3ePCaHpM2xtpkbCqUJKl5NYfT9NZPLor30Gd418hIW51nmFRnogutJecEsGBf6JtsE
         YdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WmMQ5LPDB+kCWJcWtIlfROvHdPnb8L0LvRkMopeKMsY=;
        b=TW+ANe6Q+bBaZVNDZzzsRkx6iq+bg5mMEC6BfAhaH8EENMwwdQB+XUk5vSzMDo4HSf
         +ec5f1dQDaY3pGcKfLUF5x7dLZbeUASxNUEzQCCRsXWZ2XgS47zWRSswifta6ou14yq8
         EaiW29KWqnJH0vDwd0kU465sW9I8EIOwYb6o4UiMGYlxu9zZ+jqEydODOVCVBY3MR3yp
         rS5cDnLO4jx7yo31UDsDrGfdJxuuiqxG9m/PwgEQKvX+9X9WjqLz/Y06WhGeRTHiz9mQ
         ZIwIZpE1C+KltShrXcUSUbiBaw8FYA1gSPa5QUBCU8KQP0YK55stI4tKlyk7iaPUF8RC
         BJoQ==
X-Gm-Message-State: APjAAAUuu20vMg0rCN/kY0S/KjIqwKzeSuHZWtQHc+PBBpj1t9se0Ar2
        cn0wtar31M8hfMOtl97Tu68OnSiR4gjqig==
X-Google-Smtp-Source: APXvYqzwTafUEQyhR5CHE5jaFMJ5bo2Innt8Hsmi3R0iAzfucJMhK8q5omBD4CvnCbk77TIh5dLeVw==
X-Received: by 2002:a63:e953:: with SMTP id q19mr39079549pgj.313.1562180172298;
        Wed, 03 Jul 2019 11:56:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id o14sm8745499pfh.153.2019.07.03.11.56.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 11:56:11 -0700 (PDT)
Date:   Wed, 3 Jul 2019 11:56:07 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] transport-helper: enforce atomic in push_refs_with_push
Message-ID: <20190703185535.GC121233@google.com>
References: <20190702005340.66615-1-emilyshaffer@google.com>
 <nycvar.QRO.7.76.6.1907021540330.48@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1907021540330.48@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +test_expect_success 'push --atomic also prevents branch creation' '
> > +	# Make up/master
> > +	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-branches.git &&
> > +	git init --bare "$d" &&
> > +	git --git-dir="$d" config http.receivepack true &&
> 
> Why not `-C "$d"`?
The example I had found below the new ones used --git-dir, but yeah, there's no
reason not to use -C instead. Changing.

> And why not `test_config`?

Done, didn't know about it and it's not used in the test I referred to
while writing this one ('push --all can push to empty repo'). Thanks, I
learned something new.

> 
> > +	up="$HTTPD_URL"/smart/atomic-branches.git &&
> > +	test_commit atomic1 &&
> > +	test_commit atomic2 &&
> > +	git push "$up" master &&
> 
> It would be more succinct to do a `git clone --bare . "$d"` here, instead
> of a `git init --bare` and a `git push` no?

I'm not sure I would say "more succinct." This leaves the test with the
same number of lines, but now it says:

  Make some commits
  Name a Git directory
  Clone to the new Git directory
  Do some config on the new Git directory
  Name a remote URL
  Change some commits
  ...

In my opinion, it's more readable the way it is now:

  {Do some setup stuff.}
  Name a Git directory
  Init it
  Config it
  Name the remote URL
  {Do the test stuff.}
  Make some commits
  Push some commits
  Change some commits
  ...

I did add another comment to separate "Make 'up'" and "Make up/master",
which I hope expresses my intent in organizing it this way.

> 
> > +	# Make master incompatible with up/master
> > +	git reset --hard HEAD^ &&
> > +	# Add a new branch
> > +	git branch atomic &&
> > +	# --atomic should roll back creation of up/atomic
> > +	test_must_fail git push --atomic "$up" master atomic &&
> > +	git ls-remote "$up" >up-remotes &&
> > +	test_must_fail grep atomic up-remotes
> 
> Why not `test_must_fail git -C "$d" rev-parse refs/heads/atomic`?

Sure, changed.

> > > +'
> > +
> > +test_expect_success 'push --atomic shows all failed refs' '
> > +	# Make up/master, up/allrefs
> > +	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-failed-refs.git &&
> > +	git init --bare "$d" &&
> > +	git --git-dir="$d" config http.receivepack true &&
> > +	up="$HTTPD_URL"/smart/atomic-failed-refs.git &&
> > +	test_commit allrefs1 &&
> > +	test_commit allrefs2 &&
> > +	git branch allrefs &&
> > +	git push "$up" master allrefs &&
> > +	# Make master and allrefs incompatible with up/master, up/allrefs
> > +	git checkout allrefs &&
> > +	git reset --hard HEAD^ &&
> > +	git checkout master &&
> > +	git reset --hard HEAD^ &&
> > +	# --atomic should complain about both master and allrefs
> > +	test_must_fail git push --atomic "$up" master allrefs >&output &&
> > +	grep master output &&
> > +	grep allrefs output
> > +'
> 
> I have the impression that the setup these two new test cases perform are
> _very_ similar, making it most likely that a combined test case would be
> more succinct, yet still complete and easily readable.

(Junio replied to this downthread... I have more to ask too.)

> 
> > +
> > +test_expect_success 'push --atomic indicates collateral failures' '
> > +	# Make up/master, up/collateral
> > +	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-collateral.git &&
> > +	git init --bare "$d" &&
> > +	git --git-dir="$d" config http.receivepack true &&
> > +	up="$HTTPD_URL"/smart/atomic-collateral.git &&
> > +	test_commit collateral1 &&
> > +	test_commit collateral2 &&
> > +	git branch collateral &&
> > +	git push "$up" master collateral &&
> > +	# Make master incompatible with up/master
> > +	git reset --hard HEAD^ &&
> > +	# --atomic should mention collateral was OK but failed anyway
> > +	test_must_fail git push --atomic "$up" master collateral >&output &&
> > +	grep "master -> master" output &&
> > +	grep "collateral -> collateral" output
> > +'
> 
> Same here.
> 
> > +
> >  test_expect_success 'push --all can push to empty repo' '
> >  	d=$HTTPD_DOCUMENT_ROOT_PATH/empty-all.git &&
> >  	git init --bare "$d" &&
> > diff --git a/transport-helper.c b/transport-helper.c
> > index c7e17ec9cb..6b05a88faf 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -853,6 +853,7 @@ static int push_refs_with_push(struct transport *transport,
> >  {
> >  	int force_all = flags & TRANSPORT_PUSH_FORCE;
> >  	int mirror = flags & TRANSPORT_PUSH_MIRROR;
> > +	int atomic = flags & TRANSPORT_PUSH_ATOMIC;
> >  	struct helper_data *data = transport->data;
> >  	struct strbuf buf = STRBUF_INIT;
> >  	struct ref *ref;
> > @@ -872,6 +873,11 @@ static int push_refs_with_push(struct transport *transport,
> >  		case REF_STATUS_REJECT_NONFASTFORWARD:
> >  		case REF_STATUS_REJECT_STALE:
> >  		case REF_STATUS_REJECT_ALREADY_EXISTS:
> > +			if (atomic) {
> > +				string_list_clear(&cas_options, 0);
> > +				return 0;
> > +			} else
> > +				continue;
> >  		case REF_STATUS_UPTODATE:
> >  			continue;
> >  		default:
> > diff --git a/transport.c b/transport.c
> > index f1fcd2c4b0..f4d6b38f9d 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -1226,10 +1226,23 @@ int transport_push(struct repository *r,
> >  		err = push_had_errors(remote_refs);
> >  		ret = push_ret | err;
> >
> > -		if (!quiet || err)
> > +		if ((flags & TRANSPORT_PUSH_ATOMIC) && err) {
> 
> This looks funny. And it does so only...
> 
> > +			for (struct ref *it = remote_refs; it; it = it->next)
> > +				switch (it->status) {
> > +				case REF_STATUS_NONE:
> > +				case REF_STATUS_UPTODATE:
> > +				case REF_STATUS_OK:
> > +					it->status = REF_STATUS_ATOMIC_PUSH_FAILED;
> > +				default:
> > +					continue;
> > +				}
> > +		}
> > +
> > +		if (!quiet || err) {
> 
> ... because a curly was introduced around a single-liner. This adds
> unnecessary noise to the patch.
> 
> This easily distracts reviewers like myself from more important questions
> such as: why was this conditional switch added before this conditional
> block, does it intend to influence the printed push status? Ah, yes, of
> course, even if `it->status` is changed, it actually modifies the data
> to which `remote_refs` points. So yes, this has to be done here.

Oops, I thought I had omitted the new braces when I was staging the changes.
Really sorry for the distraction. You're right that it makes the diff
look weird.

> 
> >  			transport_print_push_status(transport->url, remote_refs,
> >  					verbose | porcelain, porcelain,
> >  					reject_reasons);
> > +		}
> >
> >  		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
> >  			set_upstreams(transport, remote_refs, pretend);
> > --
> 
> Apart from minor nits, I like it. Thanks,
> Dscho
> 
> > 2.22.0.410.gd8fdbe21b5-goog
> >
> >
