Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AE2A203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 12:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbcGZMQR (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 08:16:17 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:40603 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753802AbcGZMQP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 08:16:15 -0400
Received: (qmail 3128 invoked from network); 26 Jul 2016 12:16:10 -0000
Received: (qmail 2453 invoked from network); 26 Jul 2016 12:16:10 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 26 Jul 2016 12:16:05 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1469535363.1845.8.camel@sapo.pt>
Subject: Re: [PATCH v2] i18n: notes: mark comment for translation
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Date:	Tue, 26 Jul 2016 12:16:03 +0000
In-Reply-To: <xmqqr3ah621l.fsf@gitster.mtv.corp.google.com>
References: <1469283027-23055-1-git-send-email-vascomalmeida@sapo.pt>
	 <xmqqr3ah621l.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.4 (3.20.4-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

A Seg, 25-07-2016 às 10:49 -0700, Junio C Hamano escreveu:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
> 
> > 
> >  static const char note_template[] =
> > -	"\nWrite/edit the notes for the following object:\n";
> > +	N_("Write/edit the notes for the following object:");
> >  
> >  struct note_data {
> >  	int given;
> > @@ -179,7 +179,8 @@ static void prepare_note_data(const unsigned
> > char *object, struct note_data *d,
> >  			copy_obj_to_fd(fd, old_note);
> >  
> >  		strbuf_addch(&buf, '\n');
> > -		strbuf_add_commented_lines(&buf, note_template,
> > strlen(note_template));
> > +		strbuf_addch(&buf, '\n');
> > +		strbuf_add_commented_lines(&buf, _(note_template),
> > strlen(_(note_template)));
> 
> I do not quite understand why you want the blank lines surrounding
> the message outside add_commented_lines() call.  I think the intent
> is to produce
> 
>     #
>     # Write/edit the notes for the following object:
>     #

If this is what we want, I will send a re-roll accordingly.

> with the single call.  If you pushed the newlines outside the
> message, wouldn't you end up having this instead (____ denoting an
> extra empty line each before and after the message)?
> 
>     ____
>     # Write/edit the notes for the following object:
>     ____
> 
Yes, this was my intention. The original does:

    #
    # Write/edit the notes for the following object:
    ____

