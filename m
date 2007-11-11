From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: t7005 and vi in GIT_EXEC_PATH
Date: Sun, 11 Nov 2007 11:10:12 -0500
Message-ID: <FCFF59B3-D3F1-4BEB-B3C3-D07DD5D5D8EF@silverinsanity.com>
References: <9A9986E7-E03D-458A-9A19-A3EF0E7B203D@silverinsanity.com> <Pine.LNX.4.64.0711111557370.4362@racer.site>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 11 17:10:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrFON-0004nl-8s
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 17:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471AbXKKQKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 11:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754662AbXKKQKT
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 11:10:19 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:36823 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754366AbXKKQKS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 11:10:18 -0500
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 3A0171FFC10F;
	Sun, 11 Nov 2007 16:10:17 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.64.0711111557370.4362@racer.site>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64471>


On Nov 11, 2007, at 10:58 AM, Johannes Schindelin wrote:

>> If vi is in GIT_EXEC_PATH, then t7005-editor.sh fails because the  
>> real
>> vi is invoked instead of the test vi script.  This is because the git
>> wrapper puts GIT_EXEC_PATH ahead of ".".  I see no easy solution to  
>> this
>> problem, and thought I should bring it up with the list.
>
> I don't understand.  GIT_EXEC_PATH should be set to the build  
> directory
> when you are running the tests.  Unless you copy vi _there_, you  
> should
> not have any problem.

I'm sorry, I should have been more clear.  I was referring to the  
GIT_EXEC_PATH build variable, not the environment variable.  The git  
wrapper always adds the path determined during build to the front of  
PATH.  When I was changing my build script, this got set to "/usr/ 
local/bin" (I usually use /usr/local/stow/git, instead).  Since I have  
a /usr/local/bin/vim, PATH for git-commit.sh during the test was:

- my git build directory
- /usr/local/bin (containing a symlink vi -> vim)
- the t/trash directory, added by the test via `PATH=".:$PATH"`  
(containing the test vi script)
- my normal path

The test appeared to hang when running it normally.  When I ran it  
with -v, I saw that vim was started.

~~ Brian
