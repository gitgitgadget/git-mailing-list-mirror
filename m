From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Will git have a baseline feature or something alike?
Date: Fri, 29 Feb 2008 05:21:45 -0800 (PST)
Message-ID: <m3tzjrkie4.fsf@localhost.localdomain>
References: <f17812d70802290123raa099bag17a6f7b89de65dd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "eric miao" <eric.y.miao@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 14:23:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV5Bx-0001ML-O9
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 14:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbYB2NVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 08:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752629AbYB2NVt
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 08:21:49 -0500
Received: from ik-out-1112.google.com ([66.249.90.181]:22920 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502AbYB2NVs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 08:21:48 -0500
Received: by ik-out-1112.google.com with SMTP id c28so2230169ika.5
        for <git@vger.kernel.org>; Fri, 29 Feb 2008 05:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=Jgn8MGqY47OuXBIJp7RzTB35SiecYmTTHqlkzGheO7I=;
        b=tCl7Q/iOo1+iBNLUucwv9Tt3xYVVBF0AtiLOJCldT1EiA6YgPbl50f7vzsUHwL3ndJVSVWZUNO2q4qUs/AFbj9hRFdops2UECijPe/5v30Pj7B2XgWaQq/CG8NecuDpYMTXF2Chu6SV5FltsNLlyrTj9L0gV3H+Qp+g6vogU3oQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=WRMsTF2u8LhzNRtuAApIBitRAHd0x0seeZeMb3YC73OabanIUEcGH57kXzokTBxGuVM7KiKWga9pxVHSo3XZi5DNVY3ko2ay7TLezOQLOL2iZ5fRi2MB3Y/y4UxT6luhdOJbCpAolizcXKdMVvOIbwGpr596k/H+3LIlIkd1E4g=
Received: by 10.78.149.15 with SMTP id w15mr9804483hud.73.1204291306859;
        Fri, 29 Feb 2008 05:21:46 -0800 (PST)
Received: from localhost.localdomain ( [83.8.217.18])
        by mx.google.com with ESMTPS id k10sm18164347nfh.17.2008.02.29.05.21.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Feb 2008 05:21:45 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1TDLgr8023714;
	Fri, 29 Feb 2008 14:21:42 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1TDLdk5023711;
	Fri, 29 Feb 2008 14:21:39 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <f17812d70802290123raa099bag17a6f7b89de65dd4@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75533>

"eric miao" <eric.y.miao@gmail.com> writes:

> I kept a mirror of
> 
> http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 
> by a crontab task fetching the updated commits at midnight everyday.
> 
> Yet I found the repository now grows to be 1.2G without checking out
> anything. The checked out working tree of this is about 1.5G.

Did you (re)packed this repository, running "git gc", or "git repack"?
Currently git either downloads small packs, or loose objects; it needs
to repack to make repository size smaller.

BTW. the largest git repository is 1.6G OpenOffice.org conversion,
with > 2G checkout, and some large binary files under version
control. Mozilla and GCC, other large repos, got under 0.5G IIRC.
So kernel should be quite smaller.
 
> I tried "git prune" and "git repack" but it still remains so large. The
> trend of the kernel is still going to be enlarged. Thus I'm thinking
> of the possibility of a baseline feature. One can totally forget about
> the history before that baseline, and start the development there
> after.

There is so called "shallow clone" feature, which allows to clone only
part of history. Currently it dupports only --depth, i.e. number of
commits from tips; it could I guess support providing tag as
delimiter. (You are welcome to implement it ;-).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
