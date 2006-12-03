X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH] git-svn: error out when the SVN connection fails during a fetch
Date: Sun, 03 Dec 2006 19:23:52 +0100
Message-ID: <871wnget3b.fsf@mid.deneb.enyo.de>
References: <20061128220605.GA1253@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 3 Dec 2006 18:24:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061128220605.GA1253@localdomain> (Eric Wong's message of "Tue,
	28 Nov 2006 14:06:05 -0800")
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33122>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqw0d-00014G-6w for gcvg-git@gmane.org; Sun, 03 Dec
 2006 19:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758813AbWLCSYM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 13:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758892AbWLCSYM
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 13:24:12 -0500
Received: from mail.enyo.de ([212.9.189.167]:29199 "EHLO mail.enyo.de") by
 vger.kernel.org with ESMTP id S1758813AbWLCSYL (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 13:24:11 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de) by
 mail.enyo.de with esmtp id 1Gqw0V-0005yU-PB for git@vger.kernel.org; Sun, 03
 Dec 2006 19:24:08 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.63) (envelope-from
 <fw@deneb.enyo.de>) id 1Gqw0G-0002Iu-Qc for git@vger.kernel.org; Sun, 03 Dec
 2006 19:23:52 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

* Eric Wong:

> finish_report does seem to return a useful value indicating success
> or failure, so we'll just set a flag when close_edit is called
> (it is not called on failures, nor is abort_edit) and check
> the flag before proceeding.

It seems that this needs some kind of fine-tuning.  Now that git-svn
uses HTTP keepalive connections, you get a HTTP request error once you
run into the server-side request limit.  It seems a bit excessive to
