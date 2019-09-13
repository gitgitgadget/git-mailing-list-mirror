Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B86CD1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 07:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfIMHrD (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 03:47:03 -0400
Received: from sym2.noone.org ([178.63.92.236]:58840 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727405AbfIMHrD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 03:47:03 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 46V7515t4Bzvjc1; Fri, 13 Sep 2019 09:47:01 +0200 (CEST)
Date:   Fri, 13 Sep 2019 09:47:01 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-svn: trim leading and trailing whitespaces in
 author name
Message-ID: <20190913074700.hwmyalfmn66kkgbs@distanz.ch>
References: <20190912145638.32192-1-tklauser@distanz.ch>
 <CAPig+cTAY=4cuDyrsPiDH+MUvz4+H4eMKAsmTAETep2On5=q3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cTAY=4cuDyrsPiDH+MUvz4+H4eMKAsmTAETep2On5=q3g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for the review Eric!

On 2019-09-12 at 20:20:11 +0200, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Sep 12, 2019 at 10:56 AM Tobias Klauser <tklauser@distanz.ch> wrote:
> > v2:
> >  - move whitespace trimming below defined'ness check as per Eric Sunshine's
> >    review comment
> > diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> > @@ -1494,6 +1494,7 @@ sub check_author {
> >         if (!defined $author || length $author == 0) {
> >                 $author = '(no author)';
> >         }
> > +       $author =~ s/^\s+|\s+$//g;
> 
> Hmm, this still looks questionable. I would have expected the
> whitespace trimming to be below the 'defined' check but before the
> length($author)==0 check (since the length might become 0 once
> whitespace is trimmed).

Agree, I didn't consider this case. Will change in v3.

> Also, a minor style/comprehension nit: Perhaps I'm just old-school,
> but for me, the idiom:
> 
>     $author =~ s/^\s+//;
>     $author =~ s/\s+$//;
> 
> is easier to understand at-a-glance as trimming leading and trailing
> whitespace than the more compact (noisy) expression this patch uses.
> But that's just a subjective review comment, not necessarily
> actionable.

Agree, the form you propose is more readable and saving just a line
doesn't seem worth the possible impact on comprehension/readability.
Will change in v3.
