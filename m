From: Wang Chen <wangchen@cn.fujitsu.com>
Subject: Re: tip tree clone fail
Date: Mon, 13 Oct 2008 17:40:26 +0800
Message-ID: <48F3178A.50106@cn.fujitsu.com>
References: <20081010083720.GA32069@elte.hu> <alpine.LFD.2.00.0810101040200.3271@apollo> <48EF14FC.1000801@cn.fujitsu.com> <alpine.LFD.2.00.0810101046260.3271@apollo> <48EF1902.4070309@cn.fujitsu.com> <48EF7BC1.4000401@zytor.com> <20081012124105.GA26988@elte.hu> <48F20663.2040407@zytor.com> <20081012152427.GA4607@elte.hu> <20081012153952.GV10544@machine.or.cz> <20081012165954.GA2317@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	FNST-Lai Jiangshan <laijs@cn.fujitsu.com>,
	FJ-KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon Oct 13 11:46:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpK00-00087c-4g
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 11:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761052AbYJMJod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 05:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762905AbYJMJoc
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 05:44:32 -0400
Received: from cn.fujitsu.com ([222.73.24.84]:50892 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1761831AbYJMJob (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 05:44:31 -0400
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 0B6A017010C;
	Mon, 13 Oct 2008 17:44:29 +0800 (CST)
Received: from fnst.cn.fujitsu.com (localhost.localdomain [127.0.0.1])
	by tang.cn.fujitsu.com (8.13.1/8.13.1) with ESMTP id m9D9iQZA018076;
	Mon, 13 Oct 2008 17:44:27 +0800
Received: from [10.167.141.111] (unknown [10.167.141.111])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id CEA49D429F;
	Mon, 13 Oct 2008 17:48:15 +0800 (CST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <20081012165954.GA2317@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98101>

Ingo Molnar said the following on 2008-10-13 0:59:
> * Petr Baudis <pasky@suse.cz> wrote:
> 
>> On Sun, Oct 12, 2008 at 05:24:27PM +0200, Ingo Molnar wrote:
>>> hm, -tip's .git/hooks/post-update already contained this, for the last 2 
>>> months:
>>>
>>>   exec git update-server-info
>>>
>>> so ... _despite_ us having this in the git repo, the HTTP protocol still 
>>> does not work. Why?
>> I think your problem is that HTTP does not know where to look for
>> objects coming from alternates; IIRC this would work if you used
>> relative paths in objects/info/alternates, or you can create
>> objects/info/http-alternates like
>>
>> 	/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects
>> 	/pub/scm/linux/kernel/git/sfr/linux-next.git/objects
> 
> ok, i've now set it up like this:
> 
>  $ pwd
>  /pub/scm/linux/kernel/git/x86/linux-2.6-tip.git
> 
>  $ cat objects/info/alternates
>  /home/ftp/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects
>  /home/ftp/pub/scm/linux/kernel/git/sfr/linux-next.git/objects
> 
>  $ cat objects/info/http-alternates
>  /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/objects
>  /pub/scm/linux/kernel/git/sfr/linux-next.git/objects
> 
> and i've added "git update-server-info" to hooks/post-receive and made 
> it chmod +x.
> 
> that should be golden, right? I'm wondering why this isnt in the default 
> setup - i've been behind a limited corporate firewall in a former life 
> and having HTTP access is indeed very handy and pragmatic. Often hotel 
> WLANs are HTTP only as well.
> 
> Soapbox: in fact it would be outright stupid to limit the kernel 
> source's availability artificially by not making HTTP a tier-one access 
> method.
> 
> Fighting against HTTP-only firewalls is like constantly pointing it out 
> to the popular press that they should say 'cracker' instead of 'hacker'. 
> It is pointless and only hurts the availability our own project.
> 	

Ingo, thank you for your work.
I can clone more, but error still occurs:

Getting alternates list for http://www.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-tip.git
Also look at http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
Also look at http://www.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git/
Getting pack list for http://www.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-tip.git
error: transfer closed with 8280 bytes remaining to read
Getting pack list for http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
Getting pack list for http://www.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git/
error: Unable to find 95630fe2917f805a26f8d8beaafb80cd2f729eb5 under http://www.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-tip.git
Cannot obtain needed object 95630fe2917f805a26f8d8beaafb80cd2f729eb5
