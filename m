From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] svn-fe: warn about experimental status
Date: Fri, 11 Feb 2011 04:36:44 -0600
Message-ID: <20110211103643.GA29005@elie>
References: <20101107112129.GA30042@burratino>
 <20101121063149.GA15449@burratino>
 <20101205113717.GH4332@burratino>
 <20110105233915.GB22975@burratino>
 <20110211090931.GA27410@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 11:36:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnqMx-0005nY-PQ
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 11:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011Ab1BKKgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 05:36:51 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35294 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab1BKKgu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 05:36:50 -0500
Received: by iwn9 with SMTP id 9so2265005iwn.19
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 02:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=SuF1YHha1GktXSHPjPBiOzTOQ04r7yHNChlA42xuXAw=;
        b=nINYzDPyTSCeIk63fABc9kVMnYWcJpAgOUBWGsbvAaq7d5NPrrfG3QwCSPooH2Q7hm
         wuuKCv1wy/mTezguk/zQP68l31A08UzcqndQMPkxlhgSn0EO7gtkf6qJqI59JNfz9KyI
         GzviVAa2gYEMSw2ewBC92YVq2iC1PB5sOTC98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SfjHJkF+xnXxEyM8ZVy0y1qKK2iriERvVvoN/FDxFzt5voLVsofqdrnQ0s4S5Au3S1
         eil1eIpV3/2a2w2uIQVP6ubhoauSKxItz+6REdlrM0S47snBn4sq2OWpZ+R4Rz85OW/p
         rXd0ec4Oot12pgyLTgRyuQZZ1TuHNNO78wEek=
Received: by 10.42.178.4 with SMTP id bk4mr428473icb.30.1297420609603;
        Fri, 11 Feb 2011 02:36:49 -0800 (PST)
Received: from elie ([76.206.235.233])
        by mx.google.com with ESMTPS id k42sm475717ick.8.2011.02.11.02.36.47
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Feb 2011 02:36:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110211090931.GA27410@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166550>

svn-fe is young and some coming cleanups might involve backward
incompatible UI changes.  Add some words of warning to the manual so
early adopters that are not following the project closely don't get
burned.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:

> Applying this code removal early would make your local branch juggler
> very, very happy.  Might make sense to pair it with
[...]
> we weren't louder about svn-fe's command line usage being subject to
> change.  Live and learn. :/

That probably wasn't as clear as hoped.  All I mean is that svn-fe is
young and although the aforementioned cleanup involves a UI change
(going from

	... | svn-fe | git fast-import

to

	mkfifo replies
	... | svn-fe 3<replies | git fast-import --cat-blob-fd=3 3>replies

), such changes are to be expected.  So hopefully no one will be
confused, but it would be better to mention the experimental status
somewhere in svn-fe.txt, like so:

 contrib/svn-fe/svn-fe.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index 35f84bd..cd075b9 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -18,6 +18,9 @@ Subversion repository mirrored on the local disk. Remote Subversion
 repositories can be mirrored on local disk using the `svnsync`
 command.
 
+Note: this tool is very young.  The details of its commandline
+interface may change in backward incompatible ways.
+
 INPUT FORMAT
 ------------
 Subversion's repository dump format is documented in full in
-- 
1.7.4
