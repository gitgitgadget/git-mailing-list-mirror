Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 863411F461
	for <e@80x24.org>; Fri, 19 Jul 2019 18:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfGSSON (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 14:14:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34641 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbfGSSON (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 14:14:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so33175199wrm.1
        for <git@vger.kernel.org>; Fri, 19 Jul 2019 11:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CbIW0u/IQZ6k/KqfUyCx5AUAXmL4S6YT9ecaiTrHyqw=;
        b=nVoY/WniGKHRkIwYWEOh9wU5Ketsf3af99tccsFIg4j3t99oLvmdz0tIvswYMBI30E
         7xrqtU+QwpeBPPUDb9VHsd24/XHYf+ZK6AV75ozlRJtAkqLnIPl2+VLgt8gZwQca1v4f
         rsqNZMpYNDxxtg7NNxDdq1oujeH324wrin3iKn3pvklO2fX5BnvHWGBDXZJbF/EcLq+m
         zyI2pMbPYqpoSTdfZpsHM4VEZ69DrjbL/9/6t02bjUw2pZ3inlUji6Q4BA78E4XrvX5x
         3kLF18bWc+ZjsLbIdbMr2zBQ7QscvHeYflxm6Tu3lhoB5r2iPhdTg+jvIXaBJXmGatsi
         uMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CbIW0u/IQZ6k/KqfUyCx5AUAXmL4S6YT9ecaiTrHyqw=;
        b=E5VUklt5iw26qiXbFienrgvvCOOeV6Qpo94/wm58HIy/I1UrD6bFq//Q0LRtcoLHO1
         ZlcoyOoKz1UCrjYwO5cSV4r0sOwmYO+aWdHCdeLmZTQ20FTEVuU8xVuoVNrIYILIz2gJ
         BVDsoip0BZ/Jf6KwNa+MJCrjUwoaP5/v6HC/ECegrosUc+6tMUGhzxGi1M1JnggKcEta
         pXwWkJG3ksNrHfF5Cc/KHKRr70Xb+7frj6ipk9Vpo7TDrggJpy7MrVxCjnX9GJ8mEdE2
         Q+d+aj+JvXzfRIQwFTkMltXarBK7/EhjIiJM09k2WE/J3G7Ikvoi1HONLdQs80j66JqI
         k4gg==
X-Gm-Message-State: APjAAAU7torUq9LZRABWbEf4WroHeU8jzsJCiVlLK5vGNYV0QeSfgdNd
        X7XNsyqN515zlMIiNg4SsSE=
X-Google-Smtp-Source: APXvYqyrmfSRF+rB+SlOxY6t0wOqDOs/mfe1POzyIVxzpY6vXH1bsT60ArpdpkgOxy+424/CpPSWUw==
X-Received: by 2002:a5d:4211:: with SMTP id n17mr52472099wrq.137.1563560051288;
        Fri, 19 Jul 2019 11:14:11 -0700 (PDT)
Received: from andromeda.localnet ([80.214.30.27])
        by smtp.gmail.com with ESMTPSA id n9sm58363780wrp.54.2019.07.19.11.14.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jul 2019 11:14:10 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 5/9] sequencer: move the code writing total_nr on the disk to a new function
Date:   Fri, 19 Jul 2019 20:14:02 +0200
Message-ID: <6145932.27YfOFK3Rs@andromeda>
In-Reply-To: <xmqqk1cfxg6d.fsf@gitster-ct.c.googlers.com>
References: <20190717143918.7406-1-alban.gruin@gmail.com> <20190717143918.7406-6-alban.gruin@gmail.com> <xmqqk1cfxg6d.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Le 18/07/2019 =E0 22:04, Junio C Hamano a =E9crit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> > The total amount of commands can be used to show the progression of the
> > rebasing in a shell.  This number is written to the disk by
> > read_populate_todo() when the todo list is loaded from
> > sequencer_continue() or pick_commits(), but not by complete_action(),
> > which releases its todo list before calling sequencer_continue(), which
> > reloads it immediatly afterwards.
> >=20
> > To avoid to reload the todo list from the disk, sequencer_continue()
> > will be modified to accept a todo list, and if it is not null,
> > read_populate_todo() will not be called.
>=20
> That may be good as a plan, but readers who are reading this step
> are left puzzled as the changes so far do not seem to have much to
> do with that change.  Perhaps this paragraph belongs to the step
> that actually makes that modification?
>=20
> > This moves the part writing total_nr to a new function so it can be
> > called by complete_action().
>=20
> So without 3/9 and 4/9, we have been simply writing out wrong
> number?  Good.
>=20

Not here, the numbers computed in read_populate_todo() are correct.  But th=
ey=20
may be incorrect in complete_action(), before calling sequencer_continue().=
 =20
This was not a big deal as the todo list was released before and=20
sequencer_continue() re-read it, but it would have became a problem with 6/=
9.

> > Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> > ---
> >=20
> >  sequencer.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/sequencer.c b/sequencer.c
> > index ec9c3d4dc5..d66b80d49f 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -2343,6 +2343,16 @@ void sequencer_post_commit_cleanup(struct
> > repository *r, int verbose)>=20
> >  	sequencer_remove_state(&opts);
> > =20
> >  }
> >=20
> > +static void todo_list_write_total_nr(struct todo_list *todo_list)
> > +{
> > +	FILE *f =3D fopen_or_warn(rebase_path_msgtotal(), "w");
> > +
> > +	if (f) {
> > +		fprintf(f, "%d\n", todo_list->total_nr);
> > +		fclose(f);
> > +	}
> > +}
> > +
> >=20
> >  static int read_populate_todo(struct repository *r,
> > =20
> >  			      struct todo_list *todo_list,
> >  			      struct replay_opts *opts)
> >=20
> > @@ -2388,7 +2398,6 @@ static int read_populate_todo(struct repository *=
r,
> >=20
> >  	if (is_rebase_i(opts)) {
> >  =09
> >  		struct todo_list done =3D TODO_LIST_INIT;
> >=20
> > -		FILE *f =3D fopen_or_warn(rebase_path_msgtotal(), "w");
> >=20
> >  		if (strbuf_read_file(&done.buf, rebase_path_done(), 0)=20
> 0 &&
> >  	=09
> >  		    !todo_list_parse_insn_buffer(r, done.buf.buf,=20
&done))
> >=20
> > @@ -2400,10 +2409,7 @@ static int read_populate_todo(struct repository =
*r,
> >=20
> >  			+ count_commands(todo_list);
> >  	=09
> >  		todo_list_release(&done);
> >=20
> > -		if (f) {
> > -			fprintf(f, "%d\n", todo_list->total_nr);
> > -			fclose(f);
> > -		}
> > +		todo_list_write_total_nr(todo_list);
> >=20
> >  	}
> >  =09
> >  	return 0;




