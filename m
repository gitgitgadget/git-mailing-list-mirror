From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: git describe
Date: Mon, 2 Jun 2008 19:25:48 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0806021908210.3330@pollux>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 21:45:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3FyA-00072O-72
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 21:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbYFBToW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 15:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbYFBToW
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 15:44:22 -0400
Received: from mailout01.t-online.de ([194.25.134.80]:48699 "EHLO
	mailout01.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbYFBToU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 15:44:20 -0400
X-Greylist: delayed 1089 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Jun 2008 15:44:20 EDT
Received: from fwd24.aul.t-online.de 
	by mailout01.t-online.de with smtp 
	id 1K3FfW-0005vk-01; Mon, 02 Jun 2008 21:26:10 +0200
Received: from [192.168.2.100] (ZXXGB+ZQrhyexv3w7kcTlZuSZ629gZqcZKZwaW8-KovZW76H+KGQwTcRpDb1tNSQXd@[84.163.225.196]) by fwd24.t-online.de
	with esmtp id 1K3Ff8-0zB6cy0; Mon, 2 Jun 2008 21:25:46 +0200
X-X-Sender: michael@pollux
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
X-ID: ZXXGB+ZQrhyexv3w7kcTlZuSZ629gZqcZKZwaW8-KovZW76H+KGQwTcRpDb1tNSQXd
X-TOI-MSGID: 6508f3c8-f134-4f72-8dac-98010d3dacea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83560>

Hi,

git describe does not seam to apply the pattern given by the --match 
option in case the tag is a soft one. Is that done intentionally?

In addition I wonder if it was possible to introduce an option that would 
show all tags of a given commit, at least when --exact-match is specified 
too?

At the moment I'm using git log --decorate in a script to get the above
result. Part of the script looks something like this:


  		mytags=`git log --pretty=oneline --max-count=1\
  			--decorate $commit\
  		| awk '
/.*\/tags\/V1\..*/ {
  	sub("^.*[(]","")
  	gsub("tag: ","")
  	sub("[)].*","")
  	gsub(" ","")


  	split($0, tl, ",")
  	for (var in tl)
  	{
  		if (tl[var] ~ /refs\/tags/ && tl[var] ~ V1){
  			sub("refs/tags/","",tl[var])
  			print tl[var]
  		}
  	}
}
'`

Since that is quite clumsy. I would like to use git describe which
almost does what I need.

Cheers,
Michael
