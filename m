From: Andreas Ericsson <ae@op5.se>
Subject: Re: can anybody explain the following to a git noob?
Date: Fri, 22 May 2009 11:35:33 +0200
Message-ID: <4A1671E5.4030400@op5.se>
References: <855e4dcf0905212046o3e1d6ec6l487829a0a411dcaf@mail.gmail.com>	 <32541b130905212202q9aed54cn892171b7e654812f@mail.gmail.com> <855e4dcf0905212244r454a5c21w7bdbfb566a28efb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Tim Uckun <timuckun@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 11:35:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7RAI-0006wI-5v
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 11:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbZEVJfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2009 05:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbZEVJfh
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 05:35:37 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:59533 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbZEVJfg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2009 05:35:36 -0400
Received: by ewy24 with SMTP id 24so1729196ewy.37
        for <git@vger.kernel.org>; Fri, 22 May 2009 02:35:35 -0700 (PDT)
Received: by 10.210.63.18 with SMTP id l18mr4522631eba.78.1242984935278;
        Fri, 22 May 2009 02:35:35 -0700 (PDT)
Received: from clix.int.op5.se (90-227-179-205-no128.tbcn.telia.com [90.227.179.205])
        by mx.google.com with ESMTPS id 24sm1104560eyx.53.2009.05.22.02.35.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 May 2009 02:35:34 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <855e4dcf0905212244r454a5c21w7bdbfb566a28efb8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119721>

Tim Uckun wrote:
>>> *********Try to rename a directory  WTF?: Git thinks any directory with a
>>> .git folder is empty and refuses to rename the directory.
>> Well, why do other folders contain .git directories?
> 
> It just worked out that way.  I am experimenting with a rails app and
> those plugins were pulled from github.
> 

But not, I take it, as submodules?

>>  Are they
>> *separate* git repositories?  If so, git doesn't know what to do with
>> them and leaves them alone.  (Well, in fact it treats them as
>> submodules.)
> 
> 
> yes they are separate repositories. I would be happy if it left them
> alone or treated them as submodules.  I was just puzzled as to why git
> thought they were empty when they were clearly not.
> 

Because from git's point of view, they were already managed in a
separate repository as a submodule. When you have submodules in a
repository, the parent repository can't (well, won't anyways) track
files inside the submodule directory, so git ignores everything under
a worktree subdirectory that contains a .git folder.

>> All your other weird problems seem to come from this, as far as I can
>> tell.  If not, it would be helpful if you could give *complete*
>> reproduction steps for your problem.
> 
> Those were the complete steps. I did no other operations on the
> directory.  So the fact that the test directory is misbehaving is
> because a directory in the vendor hierarchy has a .git folder?
> 
> I'll have to clean up all those and see if the problem remains.

A better way is probably to import those projects as proper
submodules so you can update them without hassle later. "git help
submodule" should get you a long way, but be prepared to study the
docs a little so you understand the caveats with submodules before
you use them. For instance, you *will* run into problems if you
later replace a worktree subdirectory belonging to the parent git
repository with a submodule, so it's really better to have them as
submodules from the start.

HTH

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
