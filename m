From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: RFC: Subprojects
Date: Sat, 14 Jan 2006 12:30:33 -0800
Message-ID: <43C95F69.7090200@gmail.com>
References: <43C52B1F.8020706@hogyros.de> <Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de> <43C537C9.4090206@hogyros.de> <Pine.LNX.4.64.0601110928350.5073@g5.osdl.org> <7vacdzkww3.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org> <43C951B6.5030607@gmail.com> <Pine.LNX.4.64.0601141154590.13339@g5.osdl.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Simon Richter <Simon.Richter@hogyros.de>
X-From: git-owner@vger.kernel.org Sat Jan 14 21:30:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Exs2w-0005aI-NE
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 21:30:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWANUao (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 15:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWANUao
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 15:30:44 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:14211 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751080AbWANUan (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jan 2006 15:30:43 -0500
Received: by wproxy.gmail.com with SMTP id i3so818124wra
        for <git@vger.kernel.org>; Sat, 14 Jan 2006 12:30:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=hQQ88XbuHIp8TAsR/6N8g3fCcOzFNw9Y+Apf3ZqGusjC7qXxddKazsmrUfCYMkKnrVMj9VCChZY+ElwqseHOrnWgJYl4m83uH/SXn3aydk2CxHGvd00GPcKhRoHoETaLsO8uOmiGsW7I45ghnV4IAoqEkLVyd+afdOx8Aw7cb7s=
Received: by 10.54.149.7 with SMTP id w7mr1281491wrd;
        Sat, 14 Jan 2006 12:30:40 -0800 (PST)
Received: from ?10.0.0.6? ( [68.234.172.144])
        by mx.gmail.com with ESMTP id 11sm6837054wrl.2006.01.14.12.30.39;
        Sat, 14 Jan 2006 12:30:40 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601141154590.13339@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14679>

Linus Torvalds wrote:
> 
> On Sat, 14 Jan 2006, A Large Angry SCM wrote:
>>So far I've not seen any convincing arguments why the sub-projects can not be
>>managed by the Makefile, or equivalent, of the super-project. Particularly
>>when the sub-projects have a life of their own.
> 
> Now, from a developer standpoint I actually agree with you. I find 
> sub-projects totally useless - I'm much happier just having separate 
> trees.
> 
> The advantage (as far as I can tell) of sub-projects is not that they are 
> easier to develop in, but that it's a total nightmare for the technical 
> _user_ to download ten different projects from ten different sites, and 
> configure them properly and install them in the right order, and keep them 
> up-to-date.
> 
> There are projects that I simply gave up even trying to track: I wasn't 
> interested in being a developer per se, but I _was_ interested in trying 
> to test and give feedback to the current development tree - but it was 
> just too damn confusing to get it working.
> 
> If I could have just done a "git clone <top-level>" to get it all, I'd 
> have been a much more productive user.

$ make get_sub_components

This can work with most any SCM (depending on your environment), is 
amazingly flexible, and does not require special support in the SCM.

The "get" rule for each sub-project could be something like:

	git_sub-project:
		mkdir sub-project
		cd sub-project
		git-init-db
		git-fetch <fetch-options> <repository> <refspec>
		git-checkout <branch>
		$(MAKE) get_sub_components

> 
> This is why I think sub-projects are more about "git checkout" and an 
> automated "git fetch" than anything else. Doing actual development etc you 
> can easily do one project at a time. "git diff" and "git commit" wouldn't 
> need any real ability to recurse into subprojects and try to make it 
> seamless. And if you do a "git pull" that needs to do anything but 
> fast-forward, you might as well resolve the sub-projects one by one.

And all of this can be done today, without changing git, with more 
flexibility, with Make rules.
