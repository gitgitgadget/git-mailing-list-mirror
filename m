From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: User Authentication ?
Date: Sat, 11 Oct 2008 11:28:29 -0700 (PDT)
Message-ID: <m3y70vj8ag.fsf@localhost.localdomain>
References: <912ec82a0810110941t33343fe1mfe1bce58739f79fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Neshama Parhoti" <pneshama@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 11 20:29:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KojDm-0006Nr-6v
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 20:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753845AbYJKS2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2008 14:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754117AbYJKS2d
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Oct 2008 14:28:33 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:25360 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085AbYJKS2c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Oct 2008 14:28:32 -0400
Received: by ey-out-2122.google.com with SMTP id 6so396728eyi.37
        for <git@vger.kernel.org>; Sat, 11 Oct 2008 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=teXH/prPceEGtC2jaSMpdLrzUU/zkkvh7tYFDzgSjVQ=;
        b=iRghzGrbxIdIjWzuEST13jQX7AtKd+G+k5pK3ltOkGrqiEw2GM2DDge0WQs0HQwnTj
         3saJ1TqtHdO2+L0ocFcQ7y2lFUgl/fSebNbH5l+O7sdeGAcIOrLLZvT0Guw4NcyEPzo+
         nb3ByRUDy/ZTjZ2m7QJzrkJSaS+LNX3dQ83EY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=FRF7P2jyiJIkxd1YdXcSI0az9yhHpX+E1yXjX06LzmSraOGTa6gnhQuLNHMnX9qcRc
         p5Vdge0qBQ9GHVzKknyqqbX7Jps4jOs/gilUBRg6uctlmPHsMl32VCyG2dwFQAwoCZAm
         d1HFSTAclsfNSSoHVZlHLFFPjF9Ogk5P/jefM=
Received: by 10.210.59.14 with SMTP id h14mr2430263eba.50.1223749710495;
        Sat, 11 Oct 2008 11:28:30 -0700 (PDT)
Received: from localhost.localdomain (abwl133.neoplus.adsl.tpnet.pl [83.8.235.133])
        by mx.google.com with ESMTPS id 20sm5871369eyk.4.2008.10.11.11.28.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Oct 2008 11:28:29 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9BISRB2020955;
	Sat, 11 Oct 2008 20:28:28 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9BISRRf020952;
	Sat, 11 Oct 2008 20:28:27 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <912ec82a0810110941t33343fe1mfe1bce58739f79fa@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97984>

"Neshama Parhoti" <pneshama@gmail.com> writes:

> I want to setup a git server on the web but I need user
> authentication.
> 
> From what I understand, currently git-daemon does not support
> authentication.

The purpose of git-daemon is to allow fast (and bandwidth-saving)
anonymous read-only (fetch) access to git repositories.  The ability
to push via git-daemon was added later, and is turned off by default
because it should be used only in special situation.

> Is there any way to achieve that ?

The reason behind git-daemon not supporting authentication is that
re-implementing authentication poorly is a bad idea.

If you need authentication there is SSH that provides authentication
(for ssh:// protocol), or WebDAV (for HTTP push protocol). Perhaps
also future "smart" HTTP server would support some kind of
authentification...

> I really don't want to give ssh logins for people who I just want to
> be able to access my repository...

First, you can always set git-shell as shell for those git only
accounts. Second, you can set up Gitosis, which IIRC needs only single
account, and handles authentication by itself; I have heard also of
ssh_acl in this context...

I don't know if there is some other equivalent of Gitosis...

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
