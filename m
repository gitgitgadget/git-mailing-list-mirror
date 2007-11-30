From: Andreas Ericsson <ae@op5.se>
Subject: Re: importing bk into git
Date: Fri, 30 Nov 2007 08:59:01 +0100
Message-ID: <474FC2C5.8060400@op5.se>
References: <200711292232.03352.christoph.duelli@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: christoph.duelli@gmx.de
X-From: git-owner@vger.kernel.org Fri Nov 30 08:59:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy0mk-0000XH-O8
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 08:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbXK3H7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 02:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758136AbXK3H7I
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 02:59:08 -0500
Received: from mail.op5.se ([193.201.96.20]:48886 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756978AbXK3H7G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 02:59:06 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E84B41F0807F;
	Fri, 30 Nov 2007 08:59:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eH1D2xT+dib3; Fri, 30 Nov 2007 08:59:03 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 49CF01F0809D;
	Fri, 30 Nov 2007 08:59:03 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <200711292232.03352.christoph.duelli@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66623>

Christoph wrote:
> I am trying to import a BitKeeper repo into a (new) git repo.
> 
> I am trying with the script bk2git.py that I found on the web.
> This does not quite work - I fear script is no longer working with the current 
> git release. (I am using the current git release.)
> 
> If I have understood the script correctly, it does repeated bk checkouts and 
> imports the updates the git repo diff of the (next) checkout etc.
> 
> It seems this script tries to do so by settings environment vars
> GIT_OBJECT_DIRECTORY and GIT_INDEX_FILE
> to point at the git repo.
> 
> The bk checkout are done at a temp. dir (tmp_dir).
> 
> 
> The following lines fail
>   os.system("cd %s; git-ls-files --deleted | xargs 
> git-update-cache --remove" % tmp_dir)
> 
> with: fatal: Not a git repository
> xargs: git-update-cache: No such file or directory
> 

You may have better luck using "git update-index" instead of
git-update-cache. If that doesn't work, try finding out which
version of git the importer script was written against and try
using that version of git for the import.

If you run into problems while using a newer git on the
imported repository that'll be a different discussion.

> The problem seems to be that the script cd's into the temp dir (which is not a 
> git repo) and the git-ls-files fails to find a git repo there.
> I think the issue might be that an earlier version of git was perhaps able to 
> find the repo by means of the env. vars mentioned above.
> 

It should still do this, afaik, although it's probably better
to just use GIT_DIR nowadays.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
