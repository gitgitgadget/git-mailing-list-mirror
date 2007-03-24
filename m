From: David Lang <david.lang@digitalinsight.com>
Subject: merge strategy request
Date: Sat, 24 Mar 2007 14:46:40 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0703241430420.12864@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 25 00:12:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVFPd-00037V-ID
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 00:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbXCXXMZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Mar 2007 19:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932875AbXCXXMY
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Mar 2007 19:12:24 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:62955 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S932396AbXCXXMY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Mar 2007 19:12:24 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Sat, 24 Mar 2007 15:12:23 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Sat, 24 Mar 2007 16:12:16 -0700
X-X-Sender: dlang@dlang.diginsite.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43022>

having just gone through a painful manual mere with a config file on a gentoo 
system (not useing git) it seems to me that there should be a better way to deal 
with merging config file updates. I know that gentoo doesn't use git for it's 
config files, but I don't think that git would do a whole lot better currently 
(but with access to the history, I think it could)

what's happening is

A---B
      \
   C---D

where A and C are the distro maintained config files, B is the one customized 
for the local system, and D needs to be basicly the same as B, but accounting 
for the changes between A and C

issues that I see (there are probably others)

1. blank lines and comments are 'uninteresting' changes in that they don't 
affect the result, so if they get botched slightly it doesn't result in a broken 
systems (although it can cause confusion), what's important are changes ourside 
the comments. this is especially critical if the version in B strips out 
comments compared to the sample version in A

2. if B changes a config option and C doesn't (compared to A) then you want to 
go with what's in B

3. for most config files the order of the options doesn't matter, so look for 
the same option name out of order.

4. for some config files there are groupings in the config (tags nested inside 
other tags), the nesting is important, even if the order isn't. frequently this 
nesting is indicated by whitespace indentation  (or if it's an XML-like config 
file the nesting can be determined directly from the tags) figuring out exactly 
waht strategy to use here could be a case of 'try several and see which one 
makes sense), or it could be that the user needs to identify the strategy to use 
for a particular file.

there's been talk about custom merge strategies for different types of files 
(uncompressing office documents to merge them for example), so I think this is 
along the same lines and wanted to let other people start thinking about the 
problem and possible solutions.

David Lang
