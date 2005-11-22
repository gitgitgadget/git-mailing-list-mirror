From: Andreas Ericsson <ae@op5.se>
Subject: Re: Question about handling of heterogeneous repositories
Date: Tue, 22 Nov 2005 20:40:50 +0100
Message-ID: <43837442.9060602@op5.se>
References: <81b0412b0511220850w429d2f36lafe9de7ce19ce8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 20:44:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eee12-0003NV-EH
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 20:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965153AbVKVTkx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 14:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965151AbVKVTkx
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 14:40:53 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:25996 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S965150AbVKVTkw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 14:40:52 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id CFC146BCBE
	for <git@vger.kernel.org>; Tue, 22 Nov 2005 20:40:50 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
In-Reply-To: <81b0412b0511220850w429d2f36lafe9de7ce19ce8f@mail.gmail.com>
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12570>

Alex Riesen wrote:
> Hi,
> 
> it is sometimes the case that a project consists of parts which are
> unrelated to each other, and only thing in common between them is that
> they all are used in that particular project. For example a program
> uses some library and the developer(s) of that program would like to
> have the source of that library somewhere close. Well, for this simple
> example one could just use two repositories, laid close to each other
> in a directory, like project/lib and project/prog.
> Now, if I make the example a bit more complex and say, that the
> developers of the program are the developers in that project and
> change everything under project/ directory, including
> project/library/. They are also good people and ready to give the
> changes to the library upstream.
> 
> How do they achieve that, without sending project/ and project/program/?
> 
> For everyone who have an experience with ClearCase or Perforce (I'm
> sorry for mentioning it) it is what the "mappings" are often used for:
> a project is build together from different parts, which can be worked
> on separately.
> 
> I'm trying to introduce git at work, but have to prepare myself for
> possible questions first, and this is one of them :)
> 

We do like this;

core
core/gui
core/lib

$ cat .gitignore
gui
lib

This is also nice because it lets the gui maintainers have the gui as 
the root with the core and lib parts as subdirectories. Everyone has 
their own responsibility checked out at top-level with other pieces 
below it. It's easy enough to script a pull of all repos so everyone's 
up to sync and everybody's happy.

It would certainly be nicer to have git ignore directories that have the 
".git" directory (so long as it's not the top of the repo, that is), but 
I haven't had the energy to fix that when there's already a solution 
that's simple enough and quite adequate.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
