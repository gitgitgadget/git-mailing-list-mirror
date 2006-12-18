X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-parse-remote: fix ambiguous shell bug in expand_refs_wildcard
Date: Mon, 18 Dec 2006 03:16:27 -0500
Message-ID: <20061218081627.GB3857@coredump.intra.peff.net>
References: <20061218080941.GA3857@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 08:16:34 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061218080941.GA3857@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34728>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwDfk-0003T5-FT for gcvg-git@gmane.org; Mon, 18 Dec
 2006 09:16:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753499AbWLRIQ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 03:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753501AbWLRIQ3
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 03:16:29 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:53470
 "HELO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id
 S1753499AbWLRIQ3 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 03:16:29 -0500
Received: (qmail 26866 invoked from network); 18 Dec 2006 03:16:27 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2) by
 66-23-211-5.clients.speedfactory.net with SMTP; 18 Dec 2006 03:16:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Dec
 2006 03:16:27 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Mon, Dec 18, 2006 at 03:09:41AM -0500, Jeff King wrote:

> -				if test "z$name" != "z${name%'^{}'}" ||
> +				if test "z$name" != "z${name%'^{\}'}" ||

Urgh, sorry, this is wrong. It should be:
  ${name%^{\}}
IOW, the \ replaces the quote, not in addition to.

