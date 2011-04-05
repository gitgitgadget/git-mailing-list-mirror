From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [BUG] git-svn: --no-metadata related bug
Date: Wed, 6 Apr 2011 00:37:24 +0530
Message-ID: <20110405190722.GB25644@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 05 21:08:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Bc4-0008CD-Ik
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 21:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508Ab1DETIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 15:08:23 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41364 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453Ab1DETIW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 15:08:22 -0400
Received: by iyb14 with SMTP id 14so672578iyb.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 12:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=7eUH9BjXxe3/9WtYVgpPfUM7IzSxBIFAMGkxOdsAi1I=;
        b=NptzRnL9bVIcJlMpJN1sKzVQDhRSM0Ni5px2L6zrteqD3k0EdidZAehW8MCxkWJuQP
         9IUTGiyUjFo8dgjsCqOAjIjOtH5d7RcI+eJWlfnVkjQFGtSgVgFkiAHewpjD683QgSoq
         IVDq+nobDq78QOJp/grkwDClBE4j1UrUxhCW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=XdUqb8f4qe0jfXvV3IB/5pMVSHIdKzB4dRI52HrqyLHXG/5n4cgzSlknURx1zVnfzX
         sb+/c4R2VR3QOPTBVEDi8katbnjx/U4TB9aL7DXJGbW6uUdYvJIm8I92wWxgugIfQ9cd
         leiRblwLG73g3Wq43Bjod7GyV6YtGTssChFuU=
Received: by 10.42.97.70 with SMTP id m6mr88515icn.104.1302030502088;
        Tue, 05 Apr 2011 12:08:22 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id i20sm4637674iby.31.2011.04.05.12.08.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Apr 2011 12:08:21 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170905>

Hi,

This bug was reported by sh4rm4 on #git-devel a few minutes ago [1].

Steps to reproduce:
$ git svn clone --no-metadata -T trunk http://dxirc.googlecode.com/svn/

Output:
Found possible branch point: http://dxirc.googlecode.com/svn/trunk => http://dxirc.googlecode.com/svn/branches/0.20, 93
Use of uninitialized value $u in substitution (s///) at /usr/lib/git/git-svn line 1733.
Use of uninitialized value $u in concatenation (.) or string at /usr/lib/git/git-svn line 1733.
refs/remotes/trunk: 'http://dxirc.googlecode.com/svn' not found in ''

Comments:
Works fine when '--no-metadata' is omitted.  It seems to be a simple
variable-initialization bug.  I would have posted a patch, but I can't
test it on my own system because git-svn doesn't work with the
upstream Subversion-related libraries I have installed.

[1]: http://colabti.org/irclogger/irclogger_log/git-devel?date=2011-04-05#l76

-- Ram
