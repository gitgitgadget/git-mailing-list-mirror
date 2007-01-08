From: Jakub Narebski <jnareb@gmail.com>
Subject: Bug (?) in setting values with git-repo-config
Date: Mon, 08 Jan 2007 03:41:25 +0100
Organization: At home
Message-ID: <ensb0c$si4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Jan 08 03:43:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3kTa-00029y-LK
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 03:43:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030460AbXAHCnB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 21:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030461AbXAHCnA
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 21:43:00 -0500
Received: from main.gmane.org ([80.91.229.2]:53210 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030460AbXAHCnA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 21:43:00 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H3kSq-0008TN-Vs
	for git@vger.kernel.org; Mon, 08 Jan 2007 03:42:24 +0100
Received: from host-81-190-18-145.torun.mm.pl ([81.190.18.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Jan 2007 03:42:20 +0100
Received: from jnareb by host-81-190-18-145.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Jan 2007 03:42:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-145.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36227>

Currently there is no way to set up configuration variable to a value with
preceding whitespace, trailing whitespace, or one of comment delimiters
('#' or ';'). And one can't use "..." for that, because even encompassing
doublequotes gets escaped.

I think that git-repo-config should detect if value needs to be quoted, and
do that automatically...

$ declare -x GIT_CONFIG=gitconf
$ git repo-config section.key "value with # inside" 
$ git repo-config --get section.key                    
value with
$ git repo-config section.key2 '"value with # inside"'
$ git repo-config --get section.key2 
"value with
$ cat gitconf 
[section]
        key = value with # inside
        key2 = \"value with # inside\"

(and the value should be:
        keyn = "value with # inside"
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
