From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: User authentication in GIT
Date: Tue, 07 Feb 2012 01:12:21 -0800 (PST)
Message-ID: <m3aa4vknwv.fsf@localhost.localdomain>
References: <1328595129258-7261349.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: supadhyay <supadhyay@imany.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 10:12:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ruh6O-0007uJ-7L
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 10:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756773Ab2BGJM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 04:12:26 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:37161 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756725Ab2BGJMY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 04:12:24 -0500
Received: by eaah12 with SMTP id h12so2751422eaa.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 01:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=0yY6Uf8N48PLB91g/eLOLdQS8bJ6IbSWPR/SkW1wy+s=;
        b=TxNhY56Lmq2L6ZfgUNJqA6S1LGDQ3oSvdKWJ+vQSix4QkyhIEhgAG9xsqK7MSdXjkE
         ViXP0OtnNQCz2kOkfyq7/ByrGRYw3efs2+LVKLZHrLnHpgpuc+3pky8ains0umw8dK2D
         75/l3iQOHdz52eeFz5vBks/j3ZCtWM3Ur/ohI=
Received: by 10.14.100.80 with SMTP id y56mr6812955eef.68.1328605942484;
        Tue, 07 Feb 2012 01:12:22 -0800 (PST)
Received: from localhost.localdomain (abrz152.neoplus.adsl.tpnet.pl. [83.8.119.152])
        by mx.google.com with ESMTPS id n56sm71275954eeh.6.2012.02.07.01.12.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Feb 2012 01:12:21 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q179CHaw028558;
	Tue, 7 Feb 2012 10:12:18 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q179CGYT028555;
	Tue, 7 Feb 2012 10:12:16 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1328595129258-7261349.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190157>

supadhyay <supadhyay@imany.com> writes:

> I want to migrate my existing version control system (CVS) into GIT. The
> first question which comes to me is in CVS we have user authentication like
> username and their password while in GIT there is SSH authentication. 

Do you use _unencrypted_ pserver, or tunelling over SSH (with CVS_RSH)?
 
> Can any one suggest me what is the optimal way to manage the users in GIT?
> Does all users having username, passoword and SSH key? or there is no users
> credential but only SSH authentication? if I have 1000 users in old system
> CVS then do I need to create a key for all 1000 users in GIT? or etc.

First, Git supports unauthenticated anonymous fetching via custom
git:// protocol and via HTTP.  If you only need read-only access to
repository, it would be enough.  No account or SSH key necessary.

Second, Git uses SSH for authenthication instead of hand-rolling its
own security system, badly.  You don't need to create 1000 shell
accounts for SSH access: use tool like gitolite to manage git
repositories, which uses public-key infrastructure without need to
generate 1000 accounts.  You would still need for each user to
generate their own SSH key.

See gitolite documentation for more detail (older gitosis tool is no
longer maintained, as far as I know).

HTH
-- 
Jakub Narebski
