Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C41B1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 16:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753859AbcJTQ3u (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 12:29:50 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:33608 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753603AbcJTQ3t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 12:29:49 -0400
Received: (qmail 11389 invoked from network); 20 Oct 2016 16:29:47 -0000
Received: (qmail 549 invoked from network); 20 Oct 2016 16:29:47 -0000
Received: from unknown (HELO catarina) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <gitster@pobox.com>; 20 Oct 2016 16:29:44 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
Message-ID: <1476980984.14459.14.camel@sapo.pt>
Subject: Re: [PATCH v4 05/14] i18n: add--interactive: mark plural strings
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        =?ISO-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
        Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        David Aguilar <davvid@gmail.com>
Date:   Thu, 20 Oct 2016 16:29:44 +0000
In-Reply-To: <xmqqtwc8kwqz.fsf@gitster.mtv.corp.google.com>
References: <20161010125449.7929-1-vascomalmeida@sapo.pt>
         <20161005172110.30801-1-vascomalmeida@sapo.pt>
         <20161010125449.7929-6-vascomalmeida@sapo.pt>
         <xmqqtwc8kwqz.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A Qua, 19-10-2016 às 11:40 -0700, Junio C Hamano escreveu:
> Vasco Almeida <vascomalmeida@sapo.pt> writes:
> 
> > 
> > @@ -669,12 +669,18 @@ sub status_cmd {
> >  sub say_n_paths {
> >  	my $did = shift @_;
> >  	my $cnt = scalar @_;
> > -	print "$did ";
> > -	if (1 < $cnt) {
> > -		print "$cnt paths\n";
> > -	}
> > -	else {
> > -		print "one path\n";
> > +	if ($did eq 'added') {
> > +		printf(__n("added %d path\n", "added %d paths\n",
> > +			   $cnt), $cnt);
> > +	} elsif ($did eq 'updated') {
> > +		printf(__n("updated %d path\n", "updated %d
> > paths\n",
> > +			   $cnt), $cnt);
> > +	} elsif ($did eq 'reverted') {
> > +		printf(__n("reverted %d path\n", "reverted %d
> > paths\n",
> > +			   $cnt), $cnt);
> > +	} else {
> > +		printf(__n("touched %d path\n", "touched %d
> > paths\n",
> > +			   $cnt), $cnt);
> >  	}
> >  }
> 
> Nice to see you covered all verbs currently in use and then
> future-proofed by adding a fallback "touched" here.
> 
> Thanks.
> 

Thanks. Here I added %d to the singular sentences "added %d path\n" to
avoid a Perl warning about a redundant argument in printf.
