From: Jonathan Nieder <jrnieder@gmail.com>
Subject: git diff --added (Re: Command-line interface thoughts)
Date: Sun, 12 Jun 2011 22:43:47 -0500
Message-ID: <20110613034347.GA4222@elie>
References: <201106051311.00951.jnareb@gmail.com>
 <201106101844.16146.jnareb@gmail.com>
 <4DF25D50.5020107@ira.uka.de>
 <201106102035.42525.jnareb@gmail.com>
 <4DF29EA5.60502@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jun 13 05:44:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVy4P-0002il-4I
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 05:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873Ab1FMDn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2011 23:43:59 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46481 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122Ab1FMDn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2011 23:43:58 -0400
Received: by iwn34 with SMTP id 34so3525618iwn.19
        for <git@vger.kernel.org>; Sun, 12 Jun 2011 20:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Ii+qLG8YhTMAuk0TVSPt8AJ9/3jup2ty6+QKk3E/v1k=;
        b=VjhqUDdt0arGJ0wHzJgP/moVMc0PPb8ZFEBFa2k8yrMydgORTWOHnF5Cy/lom1ksJg
         KSz1Zx7FXCQpkg/eQ8J4RkUGIz+PMRuttfjeDa7GSmRHMsCgLB31xHOV2sgtTIznmAW0
         jtslgkyTAZUHbUIjRL2gCzQZOfuBrTAowCY/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UmoEhS9gopf9EkENOykcdXEU5kW0jWJtoouJYyAJ+ojLvNMF2F8GSnbCnsSaStfzn7
         QAqQjTM8kOcFsiHoeUBeziVbrgNxHzUwdIMDgaZ4SWK4KHTV0iSXk9Zq1M1ileFyi5GR
         x+sn9ZDd5/99OcAEGxPI9LIIzzRcst246vbE0=
Received: by 10.231.24.143 with SMTP id v15mr5436089ibb.90.1307936637471;
        Sun, 12 Jun 2011 20:43:57 -0700 (PDT)
Received: from elie (adsl-69-209-71-178.dsl.chcgil.ameritech.net [69.209.71.178])
        by mx.google.com with ESMTPS id fw9sm2604057ibb.47.2011.06.12.20.43.54
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Jun 2011 20:43:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DF29EA5.60502@ira.uka.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175679>

Holger Hellmuth wrote:

> User never heard of 'staged'. He asks instead "I want to see what I
> added" --> git diff --added --> Error Message --> User checks man page,
> again

Do you think it would be valuable to introduce --added as a synonym
for --cached and slowly steer documentation to encourage the latter
in place of the former?

Examples, to see how it could work in practice:

	# Instead of searching tracked files in the working tree,
	# search blobs registered in the index file (i.e., accepted
	# with "git add" instead of the iffy hacks that are up in
	# the air).  The main advantage of this over plain "git grep"
	# is speed.
	git grep --added -e foo

	# Remove foo.c from the next commit, without touching the
	# worktree.
	git rm --added foo.c

	# Apply patch to the index, leaving the worktree alone.
	git apply --added some-change.patch

	# List changes that I marked with "git add" for inclusion in
	# the next commit.
	git diff --added

I like it a lot more than "staged". ;-)  Though --index-only still
seems a little clearer to me.
