From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git log and utf-u in filenames
Date: Thu, 25 Sep 2008 16:11:54 -0700 (PDT)
Message-ID: <m3k5cz3jp4.fsf@localhost.localdomain>
References: <20080925215002.GA30810@kodama.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Fri Sep 26 01:13:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj01D-0005Kf-S3
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 01:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbYIYXL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 19:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753429AbYIYXL6
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 19:11:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:17788 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142AbYIYXL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 19:11:57 -0400
Received: by fg-out-1718.google.com with SMTP id 19so453657fgg.17
        for <git@vger.kernel.org>; Thu, 25 Sep 2008 16:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=4ZVwM3E6mKajjiTA1XtyK4MWhveMBi/R1KpM2p+mWNE=;
        b=rsuo3gomm5vxR7WN0lF2LujZkjtK6e3ZXeaw8RBW8lSqVwD1ddIcB4s4ikcdLCxReI
         p9ICnGJSMcWkQ6ovSMf3IxUfAIUbxPDHt0DDuEVBJfeQY9A9R5IWZwfICpkoJ+nJWNY8
         P8/DQWPbJsxUAETVY7dpKYbMVqyDGm5m28/uc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=b/b9DlNnspuDghNJP6NUvN8nZu0+QOXqbaV7q48qKTzb+7npXyJJOghvsAzrDukulA
         inmIzMR2SqAg9G39EvWp3BpZilY/Gd6q/2G+hui7BI12JVeyCjl9pb8/eC6xmoZC4jSL
         8VL4gpRC/UmbTtL9KOG00RSyS7V90xDy7Il4Q=
Received: by 10.86.63.19 with SMTP id l19mr706630fga.60.1222384315629;
        Thu, 25 Sep 2008 16:11:55 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.235.56])
        by mx.google.com with ESMTPS id 4sm3227825fgg.4.2008.09.25.16.11.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Sep 2008 16:11:54 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8PNBKDW002520;
	Fri, 26 Sep 2008 01:11:31 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8PNB4Cc002511;
	Fri, 26 Sep 2008 01:11:04 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080925215002.GA30810@kodama.kitenet.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96814>

Joey Hess <joey@kitenet.net> writes:

> Git, particularly git-log seems to not display utf-8 characters in filenames,
> instead showing an escaped representation. On the other hand, commit messages,
> as git-log(1) notes, are assumed to be utf-8, and the same utf-8 character
> used in a commit message is not escaped, and displays ok.
> 
> Can anyone point me at the documentation for this utf-8 filename
> escaping, assuming it's not a bug? And did earlier versions of git
> (circa 2006) perhaps not do that escaping? I have code in ikiwiki
> that apparently used to work, but is certianly not working with
> current git, due to this escaping.

Err... it always worked like this, mainly I think to have 7bit safe
patches for sending via email.  Now in the time of 8bit transfer
and using single utf-8 encoding instead of multitude of different
filesystem encodings, you can set core.quotepath to false, although
this would eliminate only octal escaping for >127 ASCII characters;
TAB, CR etc. would still be quoted (and they have to be).

gitconfig(7):

  core.quotepath::
        The commands that output paths (e.g. 'ls-files',
        'diff'), when not given the `-z` option, will quote
        "unusual" characters in the pathname by enclosing the
        pathname in a double-quote pair and with backslashes the
        same way strings in C source code are quoted.  If this
        variable is set to false, the bytes higher than 0x80 are
        not quoted but output as verbatim.  Note that double
        quote, backslash and control characters are always
        quoted without `-z` regardless of the setting of this
        variable.


-- 
Jakub Narebski
Poland
ShadeHawk on #git
