From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: chronologically listed tags?
Date: Tue, 24 Apr 2007 19:36:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704241924070.4438@castor.milkiway.cos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 19:36:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgOwi-0004qg-NY
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 19:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422824AbXDXRgw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 13:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422829AbXDXRgw
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 13:36:52 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:38185 "EHLO
	mailout06.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422824AbXDXRgv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2007 13:36:51 -0400
Received: from fwd30.aul.t-online.de 
	by mailout06.sul.t-online.com with smtp 
	id 1HgOwb-0005ft-03; Tue, 24 Apr 2007 19:36:49 +0200
Received: from [192.168.2.100] (SrdMe2Z1oenmk+UrfKtJRyn6Ew6R29LyiGguKzfu86U7aWS4aqPQUm@[84.163.251.19]) by fwd30.sul.t-online.de
	with esmtp id 1HgOwK-18Bs0W0; Tue, 24 Apr 2007 19:36:32 +0200
X-X-Sender: michael@castor.milkiway.cos
X-ID: SrdMe2Z1oenmk+UrfKtJRyn6Ew6R29LyiGguKzfu86U7aWS4aqPQUm
X-TOI-MSGID: da41b4a5-f99d-4950-b4f6-6dc81535736c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45477>

Hi,

I would like to list tags chronologically. I failed to find out how to do 
this using git or cogito directly. So I wrote the simplistic bash script 
below. Is there a way more direct way?


-----
#!/bin/bash

export PAGER=''

git-tag -l |
while read line
do
    MYTIME=`git-show --pretty=raw $line | perl -ne 'print $1 if /committer\s+\w+\s+\S+\s+(\d+)/'`
    echo "$MYTIME $line"
done | sort | perl -ne 'use POSIX qw(strftime); if (  /(\d+) (\S+)/ ) {print strftime "%a %b %e %H:%M:%S %Y", localtime $1; print "\t\t$2\n" }'

------

Cheers,
Michael
