From: Abdelrazak Younes <younes@lyx.org>
Subject: Re: [QGIT PATCH] Add safeguards to Git::userInfo()
Date: Tue, 07 Oct 2008 20:20:04 +0200
Message-ID: <48EBA854.1020205@lyx.org>
References: <48EB10C8.4070009@lyx.org>	 <e5bfff550810070410t1097ace4pf401821292fd7565@mail.gmail.com>	 <48EB49B3.1090509@lyx.org>	 <e5bfff550810070457i702c2935lfcc0b60ae3df4dc4@mail.gmail.com>	 <48EB5FAF.4080303@lyx.org>	 <e5bfff550810070950j66bbb980vc26bd50a5615d44@mail.gmail.com>	 <e5bfff550810070955o5ea20e90jf52faf31a0ada013@mail.gmail.com>	 <48EB9EB1.7080302@lyx.org> <e5bfff550810071103j52ce2617iae2f77b9bd3fba93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 20:24:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnHBZ-0006ML-FY
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 20:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753899AbYJGSUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 14:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753877AbYJGSUP
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 14:20:15 -0400
Received: from smtp7-g19.free.fr ([212.27.42.64]:36559 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753863AbYJGSUO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 14:20:14 -0400
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 918C4B012D;
	Tue,  7 Oct 2008 20:20:12 +0200 (CEST)
Received: from [192.168.0.10] (gre92-10-88-181-30-42.fbx.proxad.net [88.181.30.42])
	by smtp7-g19.free.fr (Postfix) with ESMTP id CF293B0159;
	Tue,  7 Oct 2008 20:20:11 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1b1pre) Gecko/20080918110343 Shredder/3.0b1pre
In-Reply-To: <e5bfff550810071103j52ce2617iae2f77b9bd3fba93@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97739>

On 07/10/2008 20:03, Marco Costalba wrote:
> On Tue, Oct 7, 2008 at 6:38 PM, Abdelrazak Younes<younes@lyx.org>  wrote:
>    
>> So how do you explain this:
>>
>>      
>
> Form git-config(1) docs:
>
> This command will fail if:
>
> -The config file is invalid,
> ......
> -you use --global option without $HOME being properly set.
>
>
> So please try to comment out following line
>
> --- a/src/git.cpp
> +++ b/src/git.cpp
> @@ -345,7 +345,7 @@ void Git::userInfo(SList info) {
>   	info.clear();
>   	info<<  "Environment"<<  user<<  email;
>
> -	errorReportingEnabled = false; // 'git config' could fail, see docs
> +	//errorReportingEnabled = false; // 'git config' could fail, see docs
>
>   	run("git config user.name",&user);
>   	run("git config user.email",&email);
>
>
> run from double click and you probably will see an error message box
> where git says $HOME is not set (I can reproduce this now).
>    

Right!

> So what I think is that when you run from command line there is the
> $HOME variable set and command does not fails.
>    

I see... but the only variable I have is HOMEPATH:

HOMEPATH=\Users\abdel

So I guess this was set by msysgit at installation time. But I see this 
variable only at the console (after typing 'set'), I don't see it in the 
user environment variable nor in the system one. So I guess the fix 
would be for msysgit to create this entry?

Thanks,
Abdel.
