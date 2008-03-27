From: Toby Corkindale <toby.corkindale@rea-group.com>
Subject: .git/info/attributes not cloned
Date: Thu, 27 Mar 2008 14:08:30 +1100
Organization: REA Group
Message-ID: <47EB0FAE.5000102@rea-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 27 04:16:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeibG-0003Tw-9W
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 04:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755319AbYC0DPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 23:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757469AbYC0DPY
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 23:15:24 -0400
Received: from mel-nat68.realestate.com.au ([210.50.192.68]:14391 "EHLO
	mel-nat68.realestate.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755319AbYC0DPW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2008 23:15:22 -0400
X-Greylist: delayed 913 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Mar 2008 23:15:22 EDT
Received: from [192.168.53.6] ([192.168.53.6]) by mel-nat68.realestate.com.au with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 27 Mar 2008 13:59:47 +1100
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
X-OriginalArrivalTime: 27 Mar 2008 02:59:47.0032 (UTC) FILETIME=[9D8FB580:01C88FB6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78325>

Hi.
If one creates a .git/info/attributes file in a Git repo, it will not be 
present in cloned repos.
I don't know if this is a bug or not, but it /seems/ wrong behaviour to 
me, and reading from the manual pages.

This shell script demonstrates the issue:

#!/bin/bash
mkdir testgit
cd testgit
mkdir original
cd original
git init --shared
echo -e "# gitattributes(5) file\n*.pm ident" > .git/info/attributes
echo "# \$Ident\$" > example.pm
git add example.pm
git commit -m "initial commit"
cd ..
git clone --bare original copy
if [ -e copy/info/attributes ]; then
     echo "Good, attributes file exists."
else
     echo "Bad! attributes file does not exist in copy."
fi
