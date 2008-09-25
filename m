From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git log and utf-u in filenames
Date: Thu, 25 Sep 2008 16:15:58 -0700 (PDT)
Message-ID: <m3fxnn3ji6.fsf@localhost.localdomain>
References: <20080925215002.GA30810@kodama.kitenet.net>
	<20080925224354.GA6072@kodama.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Fri Sep 26 01:17:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj05B-0006cY-Mi
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 01:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbYIYXQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 19:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753429AbYIYXQD
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 19:16:03 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:14070 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405AbYIYXQB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 19:16:01 -0400
Received: by mu-out-0910.google.com with SMTP id g7so536482muf.1
        for <git@vger.kernel.org>; Thu, 25 Sep 2008 16:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=+eD5zF58gfS5D+iLcggzVbDFh5M2by1Htpddf0M5IAk=;
        b=t+ZIiWCW+RwGosS7bevwoE/2dydJWmP97iHw7cZaOP6Yk7gD42UYvmY5onCYbXFPcZ
         +etVVO7h2kCSbVuUkFjoXNxp6KYL+CxTxEwLhPS8iAiplVyh8MPwhktQ8q22S6kmHCAi
         /kwkyDZHL0imQbdmCPnZPL1E/nPp4DOfksPoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=icy7wcSMMSMW0EfCvou2py1UEkLomdNsR37INxw6FtEDtYlfmIO3DtLJnzQ+XsKdo2
         qqR+i65UJW1nJlsGfrmCXO7edzHnx0N3Ub4In3ngakw5/u6Q66yDZDn/cCGmh32QtDOi
         Gxu+75Gsb6ah9NoaMv/Mi03M6LC87W4TG2Upg=
Received: by 10.103.176.20 with SMTP id d20mr301272mup.136.1222384559613;
        Thu, 25 Sep 2008 16:15:59 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.235.56])
        by mx.google.com with ESMTPS id e10sm1338285muf.14.2008.09.25.16.15.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Sep 2008 16:15:58 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8PNFOlb002544;
	Fri, 26 Sep 2008 01:15:35 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8PNFDxY002540;
	Fri, 26 Sep 2008 01:15:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080925224354.GA6072@kodama.kitenet.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96815>

Joey Hess <joey@kitenet.net> writes:

> Joey Hess wrote:

> > And did earlier versions of git (circa 2006) perhaps not do that
> > escaping? I have code in ikiwiki that apparently used to work, but
> > is certianly not working with current git, due to this escaping.
> 
> No, I guess it's always done that, perhaps something broke on my side
> in the meantime.
> 
> But it doesn't seem right somehow that gitweb, ikiwiki, and seemingly
> any other program that needs to look at git log / commits and figure out
> what filename is being changed needs to include their own nasty code[1] to
> convert the escaped characters back to normal characters.

Well, in gitweb we could use '-z' option for git-diff-tree and git-ls-tree,
but it has its disadvantages, like having to do actual parsing record after
record instead of simplys splitting outout on end of line ("\n") characters.

> Would making git-log and git-commit display de-escaped filenames be likely
> to break something?

core.quotepath limits filename escaping, but you still _have_ to quote
"\n", "\t", and of course '"' and '\', if you want for filename to have
in single line in text format.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
