From: Sam Vilain <sam@vilain.net>
Subject: Re: Split a subversion repo into several git repos
Date: Fri, 12 Oct 2007 10:40:40 +1300
Message-ID: <470E9858.5050904@vilain.net>
References: <op.tz09zaizjwclfx@ichi> <27DDC599-C7A0-4660-B5C6-7DFCEB137C14@steelskies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Eivind LM <eivliste@online.no>, git@vger.kernel.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 23:41:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig5mc-0008Bu-4U
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 23:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756342AbXJKVks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 17:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755915AbXJKVks
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 17:40:48 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:58593 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756212AbXJKVkr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 17:40:47 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 7B9E227C0FB; Fri, 12 Oct 2007 10:40:46 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id CEE5921CFF4;
	Fri, 12 Oct 2007 10:40:40 +1300 (NZDT)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <27DDC599-C7A0-4660-B5C6-7DFCEB137C14@steelskies.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60643>

Jonathan del Strother wrote:
>> For example, I want to convert one subversion repository which  
>> contains the folders:
>> trunk/projectA
>> trunk/projectB
>>
>> into two git repositories:
>> projectA.git
>> projectB.git
> 
> I have a slightly different layout to you -
> 
> projectA/trunk
> projectA/branches
> projectA/tags
> projectB/trunk
> projectB/branches
> projectB/tags
> etc
> 
> - but I've been creating separate git repos from that with (for  
> example) :
> 
> git-svn init -t tags -b branches -T trunk http://svn.host.com/projectA
> git-svn fetch
> 
> 
> Or will git-svn not work with your sort of layout?

It does work.  Use:

git-svn init -t projectA/tags -b projectA/branches \
   -T trunk/projectA http://svn.host.com/
git fetch

Also you can expect the import results of each branch to be the same
regardless of whether you import all at once using a command like the
above, or import a single path without passing -t / -b / -T to git svn init.

If you have a lot of projects to mine from a single repository, use
svnsync or SVN::Mirror/svk and then import from the local repository
with --use-svm-props.

Sam.
