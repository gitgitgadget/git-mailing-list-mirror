Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E6191F404
	for <e@80x24.org>; Thu, 12 Apr 2018 18:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752940AbeDLSMh (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 14:12:37 -0400
Received: from mail-out01.uio.no ([129.240.10.50]:44265 "EHLO
        mail-out01.uio.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752931AbeDLSMg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 14:12:36 -0400
X-Greylist: delayed 679 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Apr 2018 14:12:36 EDT
Received: from mail-mx02.uio.no ([129.240.10.43])
        by mail-out01.uio.no with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <h.b.furuseth@usit.uio.no>)
        id 1f6gX6-0003MI-Cc
        for git@vger.kernel.org; Thu, 12 Apr 2018 20:01:16 +0200
Received: from bombur.uio.no ([129.240.203.105])
        by mail-mx02.uio.no with esmtp  (Exim 4.90_1)
        (envelope-from <h.b.furuseth@usit.uio.no>)
        id 1f6gX5-0001jC-T7; Thu, 12 Apr 2018 20:01:16 +0200
Received: by bombur.uio.no (Postfix, from userid 2112)
        id 9F5501057FD7; Thu, 12 Apr 2018 20:01:15 +0200 (CEST)
From:   Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
To:     git@vger.kernel.org
Subject: File versioning based on shallow Git repositories?
Date:   Thu, 12 Apr 2018 20:01:15 +0200
Message-ID: <hbf.20180412fvfi@bombur.uio.no>
MIME-Version: 1.0
Content-Type: text/plain
X-UiO-SPF-Received: Received-SPF: neutral (mail-mx02.uio.no: 129.240.203.105 is neither permitted nor denied by domain of usit.uio.no) client-ip=129.240.203.105; envelope-from=h.b.furuseth@usit.uio.no; helo=bombur.uio.no;
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.4, required=5.0, autolearn=disabled, AWL=-0.047,SPF_NEUTRAL=0.652,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 6CEA158946B5753FC97B09D7BC36A11312C1652C
X-UiOonly: DE45EBF58F8069B4D93C3DB5E8E6D8DD7C2C1957
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Can I use a shallow Git repo for file versioning, and regularly purge
history older than e.g. 2 weeks?  Purged data MUST NOT be recoverable.

Or is there a backup tool based on shallow Git cloning which does this?
Push/pull to another shallow repo would be nice but is not required.
The files are text files up to 1/4 Gb, usually with few changes. 


If using Git - I see "git fetch --depth" can shorten history now.
How do I do that without 'fetch', in the origin repo?
Also Documentation/technical/shallow.txt describes some caveats, I'm
not sure how relevant they are.

To purge old data -
  git config core.logallrefupdates false
  git gc --prune=now --aggressive
Anything else?

I'm guessing that without --aggressive, some expired info might be
deduced from studying the packing of the remaining objects.  Don't
know if we'll be required to be that paranoid.

-- 
Hallvard
