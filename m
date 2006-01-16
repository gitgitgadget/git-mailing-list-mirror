From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: RFC: Subprojects
Date: Mon, 16 Jan 2006 11:08:55 -0800
Message-ID: <43CBEF47.7050607@gmail.com>
References: <43C52B1F.8020706@hogyros.de>  <Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de>  <43C537C9.4090206@hogyros.de>  <Pine.LNX.4.64.0601110928350.5073@g5.osdl.org>  <7vacdzkww3.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>  <43C951B6.5030607@gmail.com>  <Pine.LNX.4.64.0601141154590.13339@g5.osdl.org>  <43C95F69.7090200@gmail.com> <7vk6d2fsu6.fsf@assigned-by-dhcp.cox.net> <46a038f90601141628n2ec32e8fy7fc23d8d7884c0f2@mail.gmail.com> <Pine.LNX.4.64.0601152248030.25300@iabervon.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Simon Richter <Simon.Richter@hogyros.de>
X-From: git-owner@vger.kernel.org Mon Jan 16 20:09:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyZj6-0002KL-U6
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 20:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWAPTJK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 14:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWAPTJK
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 14:09:10 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:46814 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750760AbWAPTJJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2006 14:09:09 -0500
Received: by zproxy.gmail.com with SMTP id n29so1049376nzf
        for <git@vger.kernel.org>; Mon, 16 Jan 2006 11:09:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ushIC/XoPqLW3puW297BzdUtQGgLtjYS4YlWZ9kkiwyI1HVCwP6VoHMw/oDwH7T0UHBi8jvYFcj1Nz28Oc8iMNT0qSNYImX848KjTgefiYGVwJfG7ZjGwBEO1DSrn3ZQnUATsVgkOm9o5SlmeBjyDerhy5N/Yqr1nklpLxEY6/k=
Received: by 10.65.15.15 with SMTP id s15mr3174664qbi;
        Mon, 16 Jan 2006 11:09:07 -0800 (PST)
Received: from ?10.0.0.6? ( [68.234.172.144])
        by mx.gmail.com with ESMTP id e15sm1043526qba.2006.01.16.11.09.05;
        Mon, 16 Jan 2006 11:09:06 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0601152248030.25300@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14754>

Daniel Barkalow wrote:
[...]
> 
> So the problem with handling subprojects with the build system is that it 
> is too tempting to use the revision control system directly on the 
> subproject, at which point the thing you're developing and testing isn't 
> at all what other people will get if they check out your commit. You want 
> "git status" to report it as an uncommitted change if you have a different 
> revision of the subproject than your previous commit had, and it can't 
> tell if this information is buried in the build system.

Using "git-status" is the wrong tool to use there. What you should be 
using is "make project_status". Claiming "that it is too tempting to use 
the revision control system on the subproject" is wrong; you should use 
the SCM (of the subproject) to manage the subproject. You use the build 
system to manage the _entire_ project.

> I like Linus's proposal: which revision of which project goes where is 
> part of the content, while how you manipulate data for that project is a 
> matter of local policy, and is not tracked, although it might be a good 
> idea to let project provide overridable defaults (so that, if you're a 
> random member of the general public and don't have a special method for 
> accessing the repository, you don't have to track it down yourself).

I think Linus' proposal is an attempt to solve the problem in the wrong 
place; it encumbers the SCM with features of limited applicability, that 
impose a specific methodology on how to handle subprojects, and requires 
that the SCM of the subproject be Git.


> The tricky question is whether we should permit the "subproject" objects 
> to specify a revision that isn't a hash, for use in identifying revisions 
> of subprojects in other systems.

Why would you want to limit how required versions of subprojects are 
specified? Your project policies and procedures may require that 
subprojects be specified by a subproject SCM specific immutable revision 
but the policies and procedures of other projects may not be so 
restrictive and could accept a tag identifying the latest "stable" (or 
something) revision.

--
