Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECD711F859
	for <e@80x24.org>; Wed, 31 Aug 2016 19:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753840AbcHaTjI (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 15:39:08 -0400
Received: from smtprelay0146.hostedemail.com ([216.40.44.146]:48222 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753384AbcHaTjI (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 Aug 2016 15:39:08 -0400
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id C746BC1F83;
        Wed, 31 Aug 2016 19:39:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: son83_325a6161ce319
X-Filterd-Recvd-Size: 1811
Received: from XPS-9350.home (unknown [96.251.125.34])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed, 31 Aug 2016 19:39:05 +0000 (UTC)
Message-ID: <1472672344.4176.32.camel@perches.com>
Subject: Re: [PATCH V2] git-send-email: Add ability to cc: any "bylines" in
 the commit message
From:   Joe Perches <joe@perches.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 31 Aug 2016 12:39:04 -0700
In-Reply-To: <xmqq4m6020nh.fsf@gitster.mtv.corp.google.com>
References: <aa4c9e0b37e70423baa69bc27cc9adda0f152efe.1472669418.git.joe@perches.com>
         <xmqq4m6020nh.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2016-08-31 at 12:34 -0700, Junio C Hamano wrote:
> Joe Perches <joe@perches.com> writes:
> > Many commits have various forms of bylines similar to
> A missing blank line (I can tweak while queuing).
[]
> > +				next if $suppress_cc{'bylines'} and $what !~ /Signed-off-by/i and $what =~ /by$/i;
> Having to keep this /by$/i in sync with whatever definition of
> bylines is will be error prone.  How about doing it in this way?
> 
> 	# Now parse the message body
> +	my $bypat = r/[\w-]+-by/;
> 	while (<$fh>) {
>         	...
>                 if (/^(Signed-off-by|Cc|$bypat): (.*)$/i) {
>                 	...
>                         	next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;
> +				next if $suppress_cc{'bylines'} and
> +					$what !~ /^Signed-off-by/i and
> +					$what =~ /^$bypat/i;
> 
> Other than that, looking good.

Sure, whatever you want, do you want a v3 from me or can
you fix it up however you want?

