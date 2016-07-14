Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20D5120196
	for <e@80x24.org>; Thu, 14 Jul 2016 15:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbcGNPhH (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 11:37:07 -0400
Received: from lixid.tarent.de ([193.107.123.118]:41330 "EHLO mail.lixid.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751119AbcGNPhE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jul 2016 11:37:04 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jul 2016 11:37:03 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.lixid.net (MTA) with ESMTP id 3152314029E
	for <git@vger.kernel.org>; Thu, 14 Jul 2016 17:31:06 +0200 (CEST)
Received: from mail.lixid.net ([127.0.0.1])
	by localhost (mail.lixid.net [127.0.0.1]) (MFA, port 10024) with LMTP
	id fhTFDssMrrQd for <git@vger.kernel.org>;
	Thu, 14 Jul 2016 17:31:06 +0200 (CEST)
Received: from tglase.lan.tarent.de (tglase.lan.tarent.de [172.26.3.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.lixid.net (MTA) with ESMTPS id 1E61914024B
	for <git@vger.kernel.org>; Thu, 14 Jul 2016 17:31:05 +0200 (CEST)
Received: by tglase.lan.tarent.de (Postfix, from userid 2339)
	id B6E07224B64; Thu, 14 Jul 2016 17:31:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by tglase.lan.tarent.de (Postfix) with ESMTP id 99BB7224B63
	for <git@vger.kernel.org>; Thu, 14 Jul 2016 17:31:05 +0200 (CEST)
Date:	Thu, 14 Jul 2016 17:31:05 +0200 (CEST)
From:	Thorsten Glaser <t.glaser@tarent.de>
X-X-Sender: tglase@tglase.lan.tarent.de
To:	git@vger.kernel.org
Subject: Server-side preventing some files from being overwritten
Message-ID: <alpine.DEB.2.20.1607141725390.25238@tglase.lan.tarent.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
Content-Language: de-DE-1901
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi *,

is there a way, for example with some sort of pre-receive hook,
to prevent some files from being overwritten by a push?

Use case:

In some project, we use Flyway to manage the database schema,
and Jenkins to automatically build master’s HEAD after each
push (and install it, thus activating the schema files almost
immediately). Now, I wish to prevent coworkers from changing
anything in the SQL subdirectory that has ever been pushed,
forcing them to push new SQL files with ALTER statements instead.
(Yes, I am aware this will likely make me even less liked. No,
this is not an issue.)

As for the comparison, only the changes between the previous
HEAD of master and the new HEAD of master after the push would
have been accepted need to be taken into account; any intermediate
commits, merges, etc. are no problem (because Jenkins does not
build them, and because, once a push fails, the developer will
have to add a commit reverting their change and moving it to
another file on top, I’m no friend of rewriting).

File matching would be “any files under a certain subdirectory”,
nothing fancier than that.

I’ve tried a web search (with two different search engines) for
“git prevent pushed files from modification”, but this seems to
only show people who want to ignore local changes or somesuch…

I’ve asked in IRC, but with no answer for hours I thought that
maybe this was the better place to ask for it.

Thanks in advance,
//mirabilos
-- 
tarent solutions GmbH
Rochusstraße 2-4, D-53123 Bonn • http://www.tarent.de/
Tel: +49 228 54881-393 • Fax: +49 228 54881-235
HRB 5168 (AG Bonn) • USt-ID (VAT): DE122264941
Geschäftsführer: Dr. Stefan Barth, Kai Ebenrett, Boris Esser, Alexander Steeg
