From: Ivan Zorin <ivan.a.zorin@gmail.com>
Subject: Re: how to check remote git repo for updates without pull/fetch
Date: Fri, 19 Dec 2008 19:39:19 +0300
Message-ID: <494BCE37.1080204@gmail.com>
References: <494BC89F.9070107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 19 17:40:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDiP6-0004jx-H5
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 17:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbYLSQjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 11:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbYLSQjZ
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 11:39:25 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:33325 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbYLSQjY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 11:39:24 -0500
Received: by ewy10 with SMTP id 10so1153968ewy.13
        for <git@vger.kernel.org>; Fri, 19 Dec 2008 08:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=nPOym3npRfG8vTuqQ4A2NdsvQUnMUAZvaVquV9ufsrc=;
        b=KEqXJWbImbb+AvMmZiwOu+9tJkeCGdR1VSBLLt38GdclF7MjV1yjMT+Lig9/FgtffJ
         eYTuxVyVaWNX1WHyOaq74dj12vvO5WehLfQAjU5y+0BaubZJ0pCQCrtGqoZM3ctxTA7N
         /IV9PrkpWVOkkQUi4/T3uTxesnYBVAbNVeYSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=G9LqnZPMmgV5q303Alg3O9Vbeil2htRBXdZnUm47VGch1OarSkRDbcIxp4lA/9Effd
         k5dZVd8UzplBZUp7kSY8lVXPWMy88JuGpqGH50pTkicib7IcpBxcEkRGjysVdm2yWDT9
         09dnvRVzlVZ6iiyHGpwvQlvY3KUGmAZq2AG6A=
Received: by 10.210.133.2 with SMTP id g2mr3923217ebd.185.1229704762998;
        Fri, 19 Dec 2008 08:39:22 -0800 (PST)
Received: from ?192.168.128.2? ([89.169.165.188])
        by mx.google.com with ESMTPS id 32sm4838194nfu.61.2008.12.19.08.39.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Dec 2008 08:39:22 -0800 (PST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081125)
In-Reply-To: <494BC89F.9070107@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103568>


> does exist some way to check remote git repository for updates without downloading any essential files?
Well, actually, I think, that I've found one of possible soulution already:
First, check remote repo:
$ git ls-remote /path/to/git/repo
<some sha1-hash>	HEAD
...
Then check local repo:
$ cat .git/HEAD
ref: refs/heads/master
$ cat .git/refs/heads/master
<other sha1-hash>
So, if both hashes identical, then current working tree with HEAD, which points to "master", already up-to-dated,
but if they don't, then there is some updates at remote repo.
