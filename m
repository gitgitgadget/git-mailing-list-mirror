Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 763F120984
	for <e@80x24.org>; Tue, 13 Sep 2016 16:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759374AbcIMQfP (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 12:35:15 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:34609 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756512AbcIMQfP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 12:35:15 -0400
Received: (qmail 320 invoked from network); 13 Sep 2016 16:35:12 -0000
Received: (qmail 23634 invoked from network); 13 Sep 2016 16:35:10 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <jn.avila@free.fr>; 13 Sep 2016 16:35:05 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1473784505.7329.18.camel@sapo.pt>
Subject: Re: [PATCH v2 09/14] i18n: notes: mark error messages for
 translation
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     =?ISO-8859-1?Q?Jean-No=EBl?= Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Date:   Tue, 13 Sep 2016 16:35:05 +0000
In-Reply-To: <83f72924-9a9d-dc1c-109f-341f0cd7ac96@free.fr>
References: <1473679802-31381-1-git-send-email-vascomalmeida@sapo.pt>
         <1473679802-31381-9-git-send-email-vascomalmeida@sapo.pt>
         <83f72924-9a9d-dc1c-109f-341f0cd7ac96@free.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A Seg, 12-09-2016 às 14:23 +0200, Jean-Noël Avila escreveu:
> Le 12/09/2016 à 13:29, Vasco Almeida a écrit :
> > 
> > Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> > ---
> >  builtin/notes.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/builtin/notes.c b/builtin/notes.c
> > index f848b89..abacae2 100644
> > --- a/builtin/notes.c
> > +++ b/builtin/notes.c
> > @@ -340,7 +340,7 @@ static struct notes_tree
> > *init_notes_check(const char *subcommand,
> >  
> >  	ref = (flags & NOTES_INIT_WRITABLE) ? t->update_ref : t-
> > >ref;
> >  	if (!starts_with(ref, "refs/notes/"))
> > -		die("Refusing to %s notes in %s (outside of
> > refs/notes/)",
> > +		die(_("Refusing to %s notes in %s (outside of
> > refs/notes/)"),
> >  		    subcommand, ref);
> >  	return t;
> >  }
> 
> Not sure this one will be easy to localize. The verb is passed as a
> parameter : see line 366 "list", line 426 "add", line 517 "copy",
> line
> 658 "show", line 816 "merge", line 908 "remove" or line 595 with
> argv[0].
> 
> If all the verbs are real subcommands, then the translators should be
> warned that this is some english twisting, but that they need to
> refer
> to the subcommand on the command line.

Yes, these verbs are git notes subcommands. I will add a Translators
comment to it explaining so. Or we can unfold that error messages like

if (!strcmp(subcommand, "add")
	die(_("Refusing to add notes in %s (outside of refs/notes/)"),
ref);
elseif ...

else
	die(_("Refusing to %s notes in %s (outside of refs/notes/)"),
subcommand, ref);

This is more verbose but translations would benefit from it being more
natural. What do we prefer: (1) concise source and a little unnatural
translations or (2) verbose code and natural translations?

Compare, imaging that English is a target translation language, the
user would read:
"Refusing to do add of notes in /path [...]" (1)
"Refusing do add notes in /path [...]" (2)

> Otherwise,
> 
> Acked-by: Jean-Noël Avila <jean-noel.avila@free.fr>
> 
> JN
