From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 5/6] Teach git-describe --exact-match to avoid expensive tag searches
Date: Sun, 24 Feb 2008 02:25:33 -0800 (PST)
Message-ID: <m3skzibqjo.fsf@localhost.localdomain>
References: <20080224080731.GE22587@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 11:26:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTE3g-0005jx-Mw
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 11:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbYBXKZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 05:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753225AbYBXKZh
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 05:25:37 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:60050 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899AbYBXKZg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 05:25:36 -0500
Received: by py-out-1112.google.com with SMTP id u52so1845848pyb.10
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 02:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=0Cv+Jb71pfSxeZ0zGWqmgZRy9Xs7UvmE+xxc4cfxc6Q=;
        b=ULR+NHzx2X6ciV1rWuk/HHyN323umXFtLFQP7TR2IquNJ/seIzIDxCGMNAcJlCbgdMMzFZbawgac/W/24/mXInBwXytoPyVsQe4rvSvo3+rFPVawgak1t9k7c31XtVnNYg3imgT5YHTpQci29j4Vy29B/Elhwg46/zf7SBxaU6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=fbAMQ1iamEgJ/uYRJiHCjarkrBl60Hxk7fx1g6mJOVSEUYAknvyMv3q5zl6EAXI8AUHRys3bKENS/499C4dMrEG0p5FOO/aDce/JoqetlUZuZH7EOMlr+KZq2XvE/b3E9b3iLv7HNlpFhriB+kgyPSf+c8+wnj48rE+E1CrWrPQ=
Received: by 10.65.156.2 with SMTP id i2mr3375603qbo.3.1203848734687;
        Sun, 24 Feb 2008 02:25:34 -0800 (PST)
Received: from localhost.localdomain ( [83.8.255.46])
        by mx.google.com with ESMTPS id h6sm4263018nfh.30.2008.02.24.02.25.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Feb 2008 02:25:33 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1OAOmo6020519;
	Sun, 24 Feb 2008 11:24:59 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1OAORFd020514;
	Sun, 24 Feb 2008 11:24:27 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080224080731.GE22587@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74920>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>  A common idiom is to run git-describe twice:
> 
>   if test $(git describe $commit) = $(git describe --abbrev=0 $commit)
>   ...

Wouldn't it be easier to use?

    if test $(git rev-parse $(git describe --abbrev=0 $commit)^0) = $commit

But this is also one unnecessary, although not as costly, call to git
command.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
