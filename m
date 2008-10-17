From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Removing some files from history
Date: Fri, 17 Oct 2008 05:20:21 -0700 (PDT)
Message-ID: <m34p3bjtx4.fsf@localhost.localdomain>
References: <96ed5eac0810170338s292fe858s1c092428a44a7ad2@mail.gmail.com>
	<48F86E6A.7080102@fastmail.fm>
	<96ed5eac0810170451y69fd864jb44ef62bca468498@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: "Gennady Kushnir" <genkush@rujel.net>
X-From: git-owner@vger.kernel.org Fri Oct 17 14:21:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqoKn-0004fm-Os
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 14:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509AbYJQMUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 08:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753028AbYJQMUZ
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 08:20:25 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:36463 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126AbYJQMUY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 08:20:24 -0400
Received: by ey-out-2122.google.com with SMTP id 6so185368eyi.37
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 05:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=ivKduqJ1naIeM7t+k7+dOGmUuyU937Aw596MQTdad38=;
        b=KflywHANjhVCwBgpQpsZksb3d7htUZAjE2rpbDLJuHOEs1ABxbBUKAYR+T87pkpkgg
         IKQbQReZc61UCK32kw1Razrf1modghzTuhvxI+svY19NfyBzz256q//1SItah4kIZ/2g
         add32QNUj6PykQ8bjovRLjhD3ndu8khS2eF58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=eNGNMZpgmG4hcH+ScUICEcL35k1UTZMeGgIbmPXHl4hnvbLOvl3VzlSQFTGfYp1W0L
         E35+0UckyQt8hn062abvCg1RaEncU41m5LsdxKbEfCJJMWo6Bn+ZJA8JCj2wGKz14tcG
         7fqAAdClZBaa1ohQV3kHWssgPIvS2kjxx0dfI=
Received: by 10.210.20.17 with SMTP id 17mr4326998ebt.132.1224246022532;
        Fri, 17 Oct 2008 05:20:22 -0700 (PDT)
Received: from localhost.localdomain (abvf153.neoplus.adsl.tpnet.pl [83.8.203.153])
        by mx.google.com with ESMTPS id 3sm3631059eyj.3.2008.10.17.05.20.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Oct 2008 05:20:21 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9HCJk35031244;
	Fri, 17 Oct 2008 14:19:56 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9HCJMR4031239;
	Fri, 17 Oct 2008 14:19:22 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <96ed5eac0810170451y69fd864jb44ef62bca468498@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98475>

Please do not toppost, and quote only fragments you are replying to.

"Gennady Kushnir" <genkush@rujel.net> writes:

> thank you for precise instructions.
> 
> however I did not completely understand the part about references
> and reflog what are these? git tags?

git-filter-branch saves old version under refs/original/* namespace.
You have to remove them after making sure that your rewritten history
is correct.  

Additionally git keeps log where branch (tip/head of branch) was in
your repository; this is kind of generalization of ORIG_HEAD, and
allows to recover from such mistakes as wrong "git reset --hard".
Reflog entries from your original history also would pin commits, so
you have to expire reflog.

And finally the commits you have are there in repository, so you have
to "prune" repository to get rid of them.  Reflog entries and
refs/original/* pin those commits, so you have to remove them prior to
pruning.  Pruning simply removes objects which are unreferenced.

> and another question:
> did I understand it right, that I can even make some changes to that
> file in history - not just simply delete one?

Yes, see man git-filter-branch.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
