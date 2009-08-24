Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 6841 invoked by uid 107); 24 Aug 2009 08:21:16 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 24 Aug 2009 04:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbZHXIU4 (ORCPT <rfc822;peff@peff.net>);
	Mon, 24 Aug 2009 04:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbZHXIU4
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 04:20:56 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:62623 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbZHXIUz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 04:20:55 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1240771qwh.37
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 01:20:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=t2n9bdQ/Lqlf3iIgATZfx//0cOyBIf4HF6IZDvr7710=;
        b=quRxWpz+dTb+1WOrNwcbqZ0+q7gCgOOTtpzwZHlRUFR8W8cbfzFDZ/p4TFoJKRsxPZ
         tCKyRBsgbAw8uLCE2cYhpkoEN7mifIcvoZ+KMJm8jlNpPeaKy14dGxzmGlNITiTAdrzS
         xAqD3GYCE/xKgKPX2o0YpcEFo7b74ISVnL0Ks=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tfpxaQJ3Q2ed3sYKeWJWh+ytTJJl8XLWIngWcRO+sB6N/m9cEr98NbocXy3QXM5dJn
         t6Q1Hm//rIUf8eQBeVN/h5HANui4rv6bSGHd5rlS+kTWEK+JikhXfNKVjcjrR6Ou6afE
         lL3uon/xlxFRDlKjyrTOeFhDECcv/558HHrRk=
MIME-Version: 1.0
Received: by 10.224.32.204 with SMTP id e12mr2496868qad.256.1251102054827; 
	Mon, 24 Aug 2009 01:20:54 -0700 (PDT)
In-Reply-To: <4A92476A.4060205@microchip.com>
References: <F536B7C316F9474E9F7091239725AC9A02FA7F44@CHN-CL-MAIL01.mchp-main.com>
	 <20090824060710.6117@nanako3.lavabit.com>
	 <4A92318F.6050105@microchip.com> <200908240946.52813.kai@samba.org>
	 <4A92476A.4060205@microchip.com>
Date:	Mon, 24 Aug 2009 10:20:54 +0200
Message-ID: <40aa078e0908240120o36004f78m52aa34c8a338854c@mail.gmail.com>
Subject: Re: Pulling one commit at a time.
From:	Erik Faye-Lund <kusmabite@googlemail.com>
To:	Sanjiv Gupta <sanjiv.gupta@microchip.com>
Cc:	Kai Blin <kai@samba.org>, Nanako Shiraishi <nanako3@lavabit.com>,
	git@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 24, 2009 at 9:55 AM, Sanjiv Gupta<sanjiv.gupta@microchip.com> wrote:
> It's a damn simple thing in SVN world.
> $ svn info will give you the current version you are at, assume it is
> "cur_rev"
> $ svn update -r `expr $cur_rev + 1`
> $ build
> $ test

I guess you could do it something like this. Unlike your example, this
processes all new commits, not just the next one.

$ git fetch origin master
$ for c in $(git rev-list HEAD..FETCH_HEAD); do
$ 	git checkout $c
$ 	build
$ 	test
$ done
$ git merge FETCH_HEAD

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
