From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [PATCH] Documentation update for 'git branch --list'
Date: Tue, 22 Nov 2011 07:40:36 +0100
Message-ID: <4ECB43E4.7030607@lyx.org>
References: <1321886000-4163-1-git-send-email-vfr@lyx.org> <7v7h2tgyw6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, git@drmicha.warpmail.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 07:42:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSk3Q-0008JO-ER
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 07:42:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917Ab1KVGkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 01:40:42 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:50367 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496Ab1KVGkl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 01:40:41 -0500
Received: by eye27 with SMTP id 27so6176549eye.19
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 22:40:40 -0800 (PST)
Received: by 10.14.4.196 with SMTP id 44mr1269087eej.224.1321944039827;
        Mon, 21 Nov 2011 22:40:39 -0800 (PST)
Received: from [145.94.168.114] (wlan-145-94-168-114.wlan.tudelft.nl. [145.94.168.114])
        by mx.google.com with ESMTPS id o4sm38686846eeb.0.2011.11.21.22.40.38
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 22:40:38 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <7v7h2tgyw6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185775>

Op 21-11-2011 18:37, Junio C Hamano schreef:
> Vincent van Ravesteijn<vfr@lyx.org>  writes:
>
>> Indicate that the<pattern>... argument is only valid when using --list.
>> Otherwise a branch with the name<pattern>  will be created.
> I actually think there are some bugs in the implementation along that line
> and the way forward is to fix the implementation, instead of documenting
> the buggy behaviour.
>
> It is natural to expect "git branch --merged pu vr/\*" to list branches
> that are contained in 'pu' whose names match the given pattern, but it
> seems to try creating a branch called "vr/*" and fails, for example.

If this is what you naturally would expect, I would expect the following 
"git branch vr/*" to work as well.

What would you say if we try to interpret the argument as a pattern when 
the argument is not a valid ref name ? This includes all arguments 
containing '*'. In case of confusion we can demand the "--list" 
parameter to make clear what we mean.

Another thing is noticed is that the pattern use is different for 'git 
for-each-ref <pattern...>' and 'git branch --list <pattern...>'.

Two examples:

> c:\Users\Vincent\Documents\git\git>git for-each-ref refs/heads/
> f56ef114eeefee755f422e6cbef2d83974cb90f1 commit refs/heads/master
> c2ee0c73bcb4d1980e5d0bb0d20912b565d8ae38 commit refs/heads/next
> e341d009b2e0374520ac72973c6e98d315218624 commit refs/heads/pu
> 5fd37a7da3df644a85887051ae36117c732d1781 commit refs/heads/vr/fix-crashes
> cec815158934d82cdef815ea1342be2c3edbc5c8 commit 
> refs/heads/vr/msvc-compile-fix
> 777963bd4a9f41ac3eae8de2a7b7177917d127e6 commit 
> refs/heads/vr/msvc-compile-fix-poll
>
> c:\Users\Vincent\Documents\git\git>git branch --list refs/heads/
>
> c:\Users\Vincent\Documents\git\git>

and

> c:\Users\Vincent\Documents\git\git>git branch --list v*
>   vr/fix-crashes
>   vr/msvc-compile-fix
>   vr/msvc-compile-fix-poll
>
> c:\Users\Vincent\Documents\git\git>git for-each-ref v*
>
> c:\Users\Vincent\Documents\git\git>


Vincent
