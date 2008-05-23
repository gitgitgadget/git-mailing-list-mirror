Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 27963 invoked by uid 111); 23 May 2008 11:04:24 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 23 May 2008 07:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbYEWLEN (ORCPT <rfc822;peff@peff.net>);
	Fri, 23 May 2008 07:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753846AbYEWLEN
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 07:04:13 -0400
Received: from manchester.eukhost.com ([92.48.75.3]:41107 "EHLO
	manchester.eukhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769AbYEWLEM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 May 2008 07:04:12 -0400
X-Greylist: delayed 3379 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 May 2008 07:04:12 EDT
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=diamand.org;
	h=Received:Received:To:Subject:Received:To:Subject:Date:X-Mailer:Message-ID:In-Reply-To:From:Bounce-To:Errors-To:MIME-Version:Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse;
	b=dDhqBrBnb89hT1jrtglgRIIYRmP0DzGZfLSU3glXr5NNttbEb5qLROjzt53PrrqZfv0G/2wzmv3icNEvREIsBq4baD0ByJ2/wAnsTTTA5pcyTkgmUxvlqhZ4Sej+5Szs;
Received: from cpc2-cmbg6-0-0-cust826.cmbg.cable.ntl.com ([81.107.35.59]:35416 helo=ethel.local.diamand.org)
	by manchester.eukhost.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <luke@diamand.org>)
	id 1JzUBi-00053V-OW
	for git@vger.kernel.org; Fri, 23 May 2008 10:07:50 +0000
Received: from www-data by ethel.local.diamand.org with local (Exim 4.69)
	(envelope-from <luke@diamand.org>)
	id 1JzUBg-0005F6-HB; Fri, 23 May 2008 11:07:48 +0100
To:	git@vger.kernel.org
Subject: perforce import: git-p4 memory usage
Received: from 212.44.20.129 (auth. user lgd@ethel)
          by blacksquirrel.dyndns.org with HTTP; Fri, 23 May 2008 10:07:48 +0000
To:	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: perforce import: git-p4 memory usage
Date:	Fri, 23 May 2008 10:07:48 +0000
X-Mailer: IlohaMail/0.8.14 (On: blacksquirrel.dyndns.org)
Message-ID: <H1SlcXmh.1211537268.4996380.lgd@diamand.org>
In-Reply-To: <20080522160414.GA11158@sigill.intra.peff.net>
From:	"Luke Diamand" <luke@diamand.org>
Bounce-To: "Luke Diamand" <luke@diamand.org>
MIME-Version: 1.0
Content-Type:	text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - manchester.eukhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - diamand.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


Hi!

I'm trying to import part of a perforce repo with git-p4.

However, git-p4 appears to try to read all the repo into memory (and
moreover seems to need about twice as much memory as repo).

Once it runs out of swap, it dies (unsurprisingly).

I think it's failing in readP4Files(), where it appears to read the
entire repository in one go with "p4 -G -x - print".

Can I just rework this function to do stuff one file at a time? Or is
that dumb?

Thanks
Luke Diamand
