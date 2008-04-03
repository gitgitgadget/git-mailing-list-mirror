From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Can I switch a git-svn clone from a file => http url?
Date: Thu, 3 Apr 2008 09:05:46 +0300
Message-ID: <200804030905.46425.tlikonen@iki.fi>
References: <p06240804c41942f6276e@[192.168.1.114]>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Stephen Bannasch <stephen.bannasch@deanbrook.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 08:06:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhIan-00062Q-4F
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 08:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755041AbYDCGFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 02:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754545AbYDCGFt
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 02:05:49 -0400
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:49513 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754798AbYDCGFs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Apr 2008 02:05:48 -0400
Received: from [192.168.0.2] (80.220.180.181) by pne-smtpout4-sn1.fre.skanova.net (7.3.129)
        id 47A7970A0034105F; Thu, 3 Apr 2008 08:05:47 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <p06240804c41942f6276e@[192.168.1.114]>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78727>

Stephen Bannasch kirjoitti:

> I've just created a git-svn clone from a svn repo accessed locally
> with a file:/// path.
>
> Unfortunately the local svn repo is just a copy of the main svn repo
> normally accessed with http or https (served through Apache). I was
> having problems cloning the main svn repository (more details below)
> so I archived the remote svn repository and copied it to my local
> hard drive.

I know two options:

1. Keep your current Git repo but set the url and rewriteroot options 
in .git/config:

[svn-remote "svn"]
	url = http://...
	rewriteroot = file:///...

Your commit messages will still have git-svn-id pointing at file:///... 
url but it should work fine.


2. Convert your repo again:

$ mkdir repo ; cd repo
$ git svn init --rewrite-root=http://... file:///...
$ git svn fetch

This way you'll create new Git repo from file:///... url but commit 
messages will have git-svn-id's url pointing at http://... . After that 
set the correct remote url to .git/config:

[svn-remote "svn"]
	url = http://...
