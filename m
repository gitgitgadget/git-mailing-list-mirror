X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] remove "[PATCH]" prefix from shortlog output
Date: Sun, 10 Dec 2006 23:40:56 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612102337090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0612091954010.2630@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 10 Dec 2006 22:41:28 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0612091954010.2630@xanadu.home>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33946>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtXME-0003a2-1u for gcvg-git@gmane.org; Sun, 10 Dec
 2006 23:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761271AbWLJWlA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 17:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759125AbWLJWlA
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 17:41:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:38080 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1759854AbWLJWk7
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 17:40:59 -0500
Received: (qmail invoked by alias); 10 Dec 2006 22:40:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp027) with SMTP; 10 Dec 2006 23:40:57 +0100
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Hi,

On Sat, 9 Dec 2006, Nicolas Pitre wrote:

> This doesn't convey much information in the shortlog context.
> And the perl version did strip it as well.

From the current builtin-shortlog.c:128ff:

        if (!strncmp(oneline, "[PATCH", 6)) {
                char *eob = strchr(oneline, ']');

                if (eob) {
                        while (isspace(eob[1]) && eob[1] != '\n')
                                eob++;
                        if (eob - oneline < onelinelen) {
                                onelinelen -= eob - oneline;
                                oneline = eob;
                        }
                }
        }

It tries not only to strip "[PATCH]", but also "[PATCH 0/n]" and basically 
every prefix beginning with "[PATCH" and ending in "]". I do not remember 
if I really tested that code, but it should work.

Ciao,
Dscho
