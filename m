From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] pack-objects: use of version 3 delta is now optional.
Date: Sun, 15 Oct 2006 13:00:25 -0700
Message-ID: <45329359.1030302@gmail.com>
References: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net> <7virim10rb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610151135110.17085@xanadu.home> <7vac3xzbze.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610151422510.17085@xanadu.home>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Oct 15 22:00:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZCA5-0002oV-US
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 22:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422893AbWJOUAi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 16:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422895AbWJOUAi
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 16:00:38 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:33666 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422893AbWJOUAi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 16:00:38 -0400
Received: by py-out-1112.google.com with SMTP id n25so2030851pyg
        for <git@vger.kernel.org>; Sun, 15 Oct 2006 13:00:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=sQdlnr0qPFCLPV+8zqutWVQhfqdJLEuwwMwjLkVNzkY9FoQjU8VomgLijLQJnJOEKSniElelieI5u/hsx1fq1N+hJI6IifKBzJ130bb9FRu1QOpAAKmy5jO/k4Wr8unLOMneLylpvCZab3N0NzY98W+FD/4VZ8Mj7Cmswp94Ptw=
Received: by 10.65.239.13 with SMTP id q13mr8805060qbr;
        Sun, 15 Oct 2006 13:00:28 -0700 (PDT)
Received: from ?10.0.0.6? ( [68.233.231.217])
        by mx.google.com with ESMTP id d12sm8064087qbc.2006.10.15.13.00.26;
        Sun, 15 Oct 2006 13:00:27 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0610151422510.17085@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28932>

Nicolas Pitre wrote:
> On Sun, 15 Oct 2006, Junio C Hamano wrote:
> 
>> Nicolas Pitre <nico@cam.org> writes:
>>
>>> If anything, maybe this patch can be added before v1.4.3 is released:
>>> ...
>>> This way pack v3 could be fed to GIT v1.4.3 and above whenever we add 
>>> back pack v3 generation, and a pack converted to v2 from any v3 on the 
>>> fly when that capability is not present.
>> I think that is sensible.  I also was thinking that we should
>> call the current one packv3 and the one with delta-base-offset
>> packv4.
> 
> I think we should not.  The pack version should be tied to incompatible 
> pack data to prevent older GIT versions from misinterpreting newer 
> packs.  The delta block copy encoding is a perfect example of that where 
> a bit changed meaning.
> 
> The delta-base-offset case included a new object type that wasn't used 
> before hence there is no room for confusion, and yet that new delta 
> object could be encoded according to pack version 2 or pack version 3 
> which makes it orthogonal to the pack version itself.

It's not a new object type. It's a new object _encoding_ method.
