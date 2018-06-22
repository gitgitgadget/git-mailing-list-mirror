Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36BB91F516
	for <e@80x24.org>; Fri, 22 Jun 2018 20:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754448AbeFVUsL (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 16:48:11 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:45459 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754384AbeFVUsK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 16:48:10 -0400
Received: by mail-wr0-f195.google.com with SMTP id o12-v6so7855568wrm.12
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 13:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H1tvHYzQHYZA43rF1omPzkqI/ldHGOF2V7vEsbVoPnc=;
        b=UfkIoSGHNR76nQmZa6ifIZypYlrt53m2yYVeNp2Fal6OkAb9oJC9eO8MBpUL9i2NPA
         dEFUWgElzZ4uWiLfVLgmmLAFvYDuMpsjDHYXFvCfiOuXz9rvoXtedF0IPcIvJAhjr9Dl
         dq8JTCFu22Bs0v+Nnq7Wf4yY1H6ZvVO4iqPDhQ0RPduMtzRLwEWwjkixfT9rQMkVZ5gc
         43s3ittVn7FzXYEiQhE9IIOtTNvoeAvojXR1n+x2vOR8YzrCu0HXgIC2fpqPPNUiFfIT
         EII6ekIfd9ENaRa/It1FlrfUqsXuiqXhE9Ixb/m2Wve9RUe1FUX8u6sVm6L9ZQBodlnX
         GXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H1tvHYzQHYZA43rF1omPzkqI/ldHGOF2V7vEsbVoPnc=;
        b=MMUxolqVg/+jyVBZNWRcyNmv33y6K5H4rdODM79+oCVYEjDw+iLvf7UNSBxHri/mTF
         YLUDWpx47ALtFwOoJXWtoLy6GaRnczrWLO2uLltDPDcgtuuBKSlCS7zIsZLBfXQyLknz
         NdSI/7f76OooLyHOy8ZqHYchfHo/IUhvmCJM975uARfwn3WvsnYS56+JP54lZijkUaoB
         r8Wt9qDvP4Gt0H9ewBqafUHEjMZ6X8N4AfF8RLsevsGcZUc3rA1eCYl44iHHphwGO0JM
         dh+38rrrkOJPjAJDIXfQDOqxqlhz0sp88MErAP/3HzFom8ozYens34HxWMD2MEUhHcqj
         Zz0Q==
X-Gm-Message-State: APt69E39FVbLA8Ccyc6djCBNmDrLULiiRhUyvMcRt6ZndtnntCbKP00c
        tbjix9dJwogylNS4oPtXU0c=
X-Google-Smtp-Source: ADUXVKIVJlh17RnkFerQvdtvI1nhSrSU2a9Ia14x51oaemUSh73P/zEFoMEl46u6DCiQqjUt4jVZkw==
X-Received: by 2002:adf:96ad:: with SMTP id u42-v6mr2864452wrb.184.1529700489263;
        Fri, 22 Jun 2018 13:48:09 -0700 (PDT)
Received: from andromeda.localnet (AToulouse-658-1-38-233.w86-221.abo.wanadoo.fr. [86.221.117.233])
        by smtp.gmail.com with ESMTPSA id j131-v6sm5239052wmg.24.2018.06.22.13.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 13:48:08 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][PATCH v3 2/3] rebase -i: rewrite setup_reflog_action() in C
Date:   Fri, 22 Jun 2018 22:48:03 +0200
Message-ID: <7094810.i0lmrLi0k7@andromeda>
In-Reply-To: <xmqq4lhurdl7.fsf@gitster-ct.c.googlers.com>
References: <20180619154421.14999-1-alban.gruin@gmail.com> <20180621141732.19952-3-alban.gruin@gmail.com> <xmqq4lhurdl7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 22/06/2018 =C3=A0 18:27, Junio C Hamano a =C3=A9crit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> > This rewrites (the misnamed) setup_reflog_action() from shell to C. The
> > new version is called checkout_base_commit().
>=20
> ;-) on the "misnamed" part.  Indeed, setting up the comment for the
> reflog entry is secondary to what this function wants to do, which
> is to check out the branch to be rebased.
>=20
> I do not think "base_commit" is a good name, either, though.  When I
> hear 'base' in the context of 'rebase', I would imagine that the
> speaker is talking about the bottom of the range of the commits to
> be rebased (i.e. "rebase --onto ONTO BASE BRANCH", which replays
> commits BASE..BRANCH on top of ONTO and then points BRANCH at the
> result), not the top of the range or the branch these commits are
> taken from.
>=20

Perhaps should I name this function checkout_onto(), and rename=20
checkout_onto() to "detach_onto()"?  And I would reorder those two commits =
in=20
the series, as this would be very confusing.

> > index 51c8ab7ac..27f8453fe 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -3129,6 +3129,36 @@ static const char *reflog_message(struct
> > replay_opts *opts,>=20
> >  	return buf.buf;
> > =20
> >  }
> >=20
> > +static int run_git_checkout(struct replay_opts *opts, const char *comm=
it,
> > +				int verbose, const char *action)
> > +{
> > +	struct child_process cmd =3D CHILD_PROCESS_INIT;
> > +
> > +	cmd.git_cmd =3D 1;
> > +
> > +	argv_array_push(&cmd.args, "checkout");
> > +	argv_array_push(&cmd.args, commit);
> > +	argv_array_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=3D%s", action);
> > +
> > +	if (verbose)
> > +		return run_command(&cmd);
> > +	return run_command_silent_on_success(&cmd);
>=20
> For the same reason as 1/3, I think it makes more sense to have
> "else" here.
>=20

Right.

> > +int checkout_base_commit(struct replay_opts *opts, const char *commit,
> > +			 int verbose)
> > +{
> > +	const char *action;
> > +
> > +	if (commit && *commit) {
>=20
> Hmm, isn't it a programming error to feed !commit or !*commit here?
> I offhand do not think of a reason why making such an input a silent
> no-op success, instead of making it error out, would be a good idea.
>=20

I think it=E2=80=99s correct. =20

> > +		action =3D reflog_message(opts, "start", "checkout %s", commit);
> > +		if (run_git_checkout(opts, commit, verbose, action))
> > +			return error(_("Could not checkout %s"), commit);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >=20
> >  static const char rescheduled_advice[] =3D
> >  N_("Could not execute the todo command\n"
> >  "\n"
> >=20
> > diff --git a/sequencer.h b/sequencer.h
> > index 35730b13e..42c3dda81 100644
> > --- a/sequencer.h
> > +++ b/sequencer.h
> > @@ -100,6 +100,9 @@ int update_head_with_reflog(const struct commit
> > *old_head,>=20
> >  void commit_post_rewrite(const struct commit *current_head,
> > =20
> >  			 const struct object_id *new_head);
> >=20
> > +int checkout_base_commit(struct replay_opts *opts, const char *commit,
> > +			 int verbose);
> > +
> >=20
> >  #define SUMMARY_INITIAL_COMMIT   (1 << 0)
> >  #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
> >  void print_commit_summary(const char *prefix, const struct object_id
> >  *oid,

Cheers,
Alban




