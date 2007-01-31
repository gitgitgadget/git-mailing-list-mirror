From: Andreas Ericsson <ae@op5.se>
Subject: Re: When to repack?
Date: Wed, 31 Jan 2007 14:01:41 +0100
Message-ID: <45C09335.6010601@op5.se>
References: <17856.37016.341839.397309@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Jan 31 14:01:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCF5v-0007d4-QO
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 14:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933218AbXAaNBp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 08:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933226AbXAaNBp
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 08:01:45 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:56201 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933218AbXAaNBo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 08:01:44 -0500
Received: by smtp-gw1.op5.se (Postfix, from userid 588)
	id 2B0EE6BCBC; Wed, 31 Jan 2007 14:01:43 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	linux-server1.op5.se
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.1.4
Received: from [192.168.1.20] (unknown [192.168.1.20])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 0B5AB6BCD4; Wed, 31 Jan 2007 14:01:42 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
In-Reply-To: <17856.37016.341839.397309@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38245>

Bill Lear wrote:
> We have a company repo used by many people throughout the day.  When/how
> can I repack this?  I have come to adopt this approach:
> 
> % mv project project.pack
> % cd project.pack
> % GIT_DIR=. git repack -a -d
> % cd ..
> % mv project.pack project
> 

Renaming the directory isn't necessary. The packs won't be used until they
have a .idx file. That .idx-file is written after the packfile, so any
operations on the repo will simply use the old, loose, objects before the
packing is completed.

The worst thing that can happen is that an object about to be fetched is
deleted in its loose version before the upload-pack program can open it,
but that's no worse than having the entire directory being moved out from
under it.

On a side-note, this is a grade A example of something that should typically
be done sunday night at 4am.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
