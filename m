From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git hooks are not called over HTTP
Date: Fri, 17 Oct 2008 02:22:06 -0700 (PDT)
Message-ID: <m38wsnk24l.fsf@localhost.localdomain>
References: <7beb12420810162323o6dce0a71r897fbed9b9d3e417@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "KwangYul Seo" <kwangyul.seo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 11:23:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqlYW-0005Db-Dn
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 11:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752572AbYJQJWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 05:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbYJQJWM
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 05:22:12 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:49678 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbYJQJWK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 05:22:10 -0400
Received: by ey-out-2122.google.com with SMTP id 6so160890eyi.37
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 02:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=tiayKvxyTXGrtmy6p8nV3Q5pX8gSCve4uyVLEQnFJv4=;
        b=G/DnuwiesKGlAXnS5aRBUUCnA1OSVKcAWebbvnD2y/RNLUlzrheOmhgNJwALCPtfT/
         9XyobofKFauZSP4EE9dEbb2DMBqdzFhcznxP9CswDujn6tfaBxNbmrpnQiu69QDh52BW
         73GkWQ5IRUBmCVv7LxqzZ4gYeTrLgSzjyU80M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=m01SzoiIN8wkefGwENshJX/yOv64n0U4JRt11YKhnXKIseQngM0zm1gg00VoYt3Qvr
         Jprh5yK0kYhn7lr6Chr7sIbYzYj3/diogS0+arZo0K6jdkxXRRjSpF6cWh+hnuMIVopM
         qdV3GrnZv70moO1L0tQu14VsjY9Uv4pMIl4iM=
Received: by 10.210.51.18 with SMTP id y18mr4135705eby.103.1224235327991;
        Fri, 17 Oct 2008 02:22:07 -0700 (PDT)
Received: from localhost.localdomain (abvf153.neoplus.adsl.tpnet.pl [83.8.203.153])
        by mx.google.com with ESMTPS id 7sm3536799eyg.0.2008.10.17.02.22.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Oct 2008 02:22:06 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9H9M3vF029966;
	Fri, 17 Oct 2008 11:22:03 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9H9M2Ra029963;
	Fri, 17 Oct 2008 11:22:02 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7beb12420810162323o6dce0a71r897fbed9b9d3e417@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98463>

"KwangYul Seo" <kwangyul.seo@gmail.com> writes:

> I have setup a git repository with post-receive and post-update
> enabled. I configured hooks.envelopesender and hooks.mailinglist. I
> confirmed that it works fine with push from local repositories.
> However, hooks are never called when push is done over HTTP. I added
> 'echo abc' to post-receive to see if it is called or not. With local
> push, abc was printed, but with HTTP push it was not printed. What is
> the problem here?

The "problem" here (which is very much the way HTTP protocol was
designed) is that it isn't _git_ that updates repository on remote
side on push (which knows about hooks), but _web server_ via WebDAV.
And web server knows nothing about hooks.

Perhaps that would get improved when "smart" HTTP protocol gets
implemented (currently in the phase of design, I think just after
designing protocol).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
