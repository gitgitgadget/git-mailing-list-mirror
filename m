Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5048E207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 13:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2998004AbdD1NjT (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 09:39:19 -0400
Received: from mout.gmx.net ([212.227.15.19]:62811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164453AbdD1NjS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 09:39:18 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ma1Mt-1dO6jb15DT-00Lr5W; Fri, 28
 Apr 2017 15:39:08 +0200
Date:   Fri, 28 Apr 2017 15:39:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 06/26] get_mail_commit_oid(): avoid resource leak
In-Reply-To: <xmqq8tmmo0q6.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704281538140.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>        <1a12ba40a2db3925534bd2192ed8e9ab9a87215e.1493237937.git.johannes.schindelin@gmx.de>        <CAGZ79kbQTbFEtg7N8kpnWDhPmuVyhc-=gey7ca0XobgOwE8Q3w@mail.gmail.com>
 <xmqq8tmmo0q6.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RzULUHi3KqI4xjxkJoF70WveaGizg82XnviuvbG/avCAB/nDCL+
 tTucoikuGzOiwuJ8pHmVtC1iNkkjRlYfYD4bLIrLvbYp2jJeZjHdlGaqvDA5lOFGof6IMXK
 Eftxt2Lx9nOvVsgNkIQyi0RSJvkhhp0vAinUECYC2mdQ2rsZqQQxX/l3Ur8aQxPH1A5sDYo
 urpYlnYS6INHlkWTwGbIg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a34v9f5UC0Y=:Bdhx83PT4KdYdQ5FvNgbmu
 gqX8PHJRlj5Wyx/xXwVGlwaCjenVI0j9L1vFqvgXwUW8FWogel76LexBd0wLHebTdlqo+/Dky
 s8URGh7Yf0T93MFfhdYE8/5IPhC1ksAksSiWAa99p0sJ4uN32vZ+xQo4jnWwi4yJJdi74lsKi
 XLGX69SxNgTNh4HYrUfJYB/h4dLobghAgzTKS/o91iA7hm94Fof8TND937y3VNc4+aeRySXfL
 mgSh7N30caKxh1MjCiUWPlJIl+xcuLbpsgFhLRXPrO81HjD4ctVi8IpFDAZzgPZo7VFCK+Gkl
 QiqORJb6NP6tiQuwaubVIwrf3RLVuWoIvK+CD4gzWwSQiX1OJvQKf/yNBQ/o0M0v1Ty7GWwug
 wUTb1ELVR3tN264VJPCoY9kkT3r5mUqmuPuS0PrcKIl+qzepXVyql2xEFhO78WrUfQ17zbz9e
 laUs1FIrVK7+UNV8TqOuOP/IAM6mirApdSF+28Xz80WJHc+pI1VuErwkGAP5FriXzjOPt227E
 SkhdY4qFdbfiHbmWKsEZQ+fMDh2ZdC1jUaaMygcn1ZvW8VOuL9rqN3iSDb/Jsv45hONw03kaa
 KwacTN84NFnbV7IC7uLG/G4F/BSrHJjiKGJSaGTh223g1OWBy2Z/gaN4YpLD1p8yilecmUaF6
 GA2O3vTYMurtlODzhEs349sqaiZIQgOgoUdV5nQ31NMyN1M+iTZwZvMoG7pgyQTYIJvat94s/
 /yBxG63cTtY8aVeTmgAQtTaMTBcxOYFYShIY9L3dsjxvnGueR95XMaCSXCYEWsZjOuUBi2MYm
 spCntFn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Stefan,


On Wed, 26 Apr 2017, Junio C Hamano wrote:

> Stefan Beller <sbeller@google.com> writes:
> 
> >> -       if (get_oid_hex(x, commit_id) < 0)
> >> -               return -1;
> >> +       if (!ret && get_oid_hex(x, commit_id) < 0)
> >> +               ret = -1;
> >>
> >
> > In similar cases of fixing mem leaks, we'd put a label here
> > and make excessive use of goto, instead of setting ret to -1.
> > As "ret" and the commands are short, this is visually just as appealing.
> 
> I wouldn't call that visually appealing.  Fixing resource leaks is
> good, and only because this function is short enough and the funny
> way to skip over various operation need to last for just a few
> instructions, it is tolerable.  If the function were shorter, then
> we may have used
> 
> 	if (!strbuf_getline_lf() &&
> 	    skip_prefix() &&
> 	    !get_oid_hex())
> 		ret = 0; /* happy */
> 	else
> 		ret = -1;
> 	release resources here;
>         return ret;

I did almost what you suggested here, but I avoided the explicit ret = 0,
as it is initialized that way.

> and that would have been OK.  If longer, as you said, jumping to a
> label at the end of function to release the acquired resource would
> be a lot more maintainable way than either of the above alternatives
> that are only usable for short functions.
> 
> The patch as posted makes the function fail to return -1 when it
> finds problems, by the way.  It needs to return "ret" not the
> hardcoded "0" at the end.

Oops.

Ciao,
Dscho
