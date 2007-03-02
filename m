From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: [PATCH] Add git-config --remove-section, document --rename-section
Date: Fri, 02 Mar 2007 13:13:13 +0100
Message-ID: <45E814D9.7020104@lu.unisi.ch>
References: <es66vt$jej$1@sea.gmane.org> <Pine.LNX.4.63.0703012344270.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45E7DDB5.9060009@lu.unisi.ch> <Pine.LNX.4.63.0703021220420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 02 13:13:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN6dY-0004oN-H9
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 13:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423046AbXCBMNV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 07:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423051AbXCBMNV
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 07:13:21 -0500
Received: from server.usilu.net ([195.176.178.200]:56362 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1423046AbXCBMNU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 07:13:20 -0500
Received: from [192.168.68.211] ([192.168.68.211] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 2 Mar 2007 13:13:16 +0100
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
In-Reply-To: <Pine.LNX.4.63.0703021220420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-OriginalArrivalTime: 02 Mar 2007 12:13:16.0815 (UTC) FILETIME=[289E31F0:01C75CC4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41201>


> Of course you would have to move "int removing" and the related two lines 
> to rename_section(), too.
> 
> The diff would be shorter, and if you then rename the function to 
> rename_or_remove_section() it becomes all clearer.

It's more different than it looks like.  For example, remove_section needs this,

        if (buf[i] == '[') {
                if (section_name_match (&buf[i + 1], name)) {
		} else
			...
	}

while rename_section can use

        if (buf[i] == '[' && section_name_match (&buf[i+1], old_name)) {

and has more indenting in it.  The amount of indentation in the combined function is not makign things easier to read.

Paolo
