From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-describe --contains fails on given tree
Date: Sat, 21 Aug 2010 12:55:53 -0700 (PDT)
Message-ID: <m3occvoi5c.fsf@localhost.localdomain>
References: <alpine.LSU.2.01.1008212145520.14934@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Sat Aug 21 21:56:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmuAb-0004OJ-T4
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 21:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033Ab0HUTz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 15:55:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39120 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab0HUTz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 15:55:56 -0400
Received: by fxm13 with SMTP id 13so2353709fxm.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 12:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=3Hbr+9ArA2QUV+z9mZsCnIV+mYEV7jjhN6g3oUUamFg=;
        b=AOW2sp/0KknpjARMg7VCSR8XO3J05OnpOO6PAiF3L1nSbD9Z1YMCEAP9QtofKKIScL
         M911XUktLABbN68F01MDGgX5+HfSE25a2XL7Qy28OZ3kpMfjXL4d+tEGaE7tTtBY1V6n
         lSLC3GxjzsjjcXNWG8htAP+EfcuSJtgbjJcA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=g5tlzCnGVi6NRsAv8hgbzBSRh70m78SeLx+JmYuZ3FPJ7wJ7mHfreFciNEt2gGfuzx
         9f2dr0FGygZJQalp4M4kMiDqDrRKk+1Q+kJLxONN5CNYo3PLwtP3azlvfHvGgCwzSVuN
         Lj1q3qx9c3/MENmQNk3zyHf5u4AQlPctmonG0=
Received: by 10.223.103.194 with SMTP id l2mr2552011fao.6.1282420553861;
        Sat, 21 Aug 2010 12:55:53 -0700 (PDT)
Received: from localhost.localdomain (aeho172.neoplus.adsl.tpnet.pl [79.186.196.172])
        by mx.google.com with ESMTPS id k25sm1727883fac.17.2010.08.21.12.55.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 12:55:53 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o7LJtNWl005940;
	Sat, 21 Aug 2010 21:55:33 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o7LJtC8U005936;
	Sat, 21 Aug 2010 21:55:12 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LSU.2.01.1008212145520.14934@obet.zrqbmnf.qr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154154>

Jan Engelhardt <jengelh@medozas.de> writes:

> Hi,
> 
> 
> 
> for some reason, git-describe cannot figure out v1.17~15^2^2 in
> the pam_mount tree, despite me being able to actually give
> a description that would fit the contains syntax:
> 
> $ git clone
> git://pam-mount.git.sf.net/gitroot/pam-mount/pam-mount
> Initialized empty Git repository in /dev/shm/pam-mount/.git/
> remote: Counting objects: 7261, done.
> remote: Compressing objects: 100% (1819/1819), done.
> remote: Total 7261 (delta 5557), reused 6990 (delta 5348)
> Receiving objects: 100% (7261/7261), 1.40 MiB | 832 KiB/s, done.
> Resolving deltas: 100% (5557/5557), done.
> 
> $ cd pam-mount/
> $ git describe --contains v1.17~15^2^2
> fatal: cannot describe '95ce932690dfce8cbe50b6a3a8949e41a54c8966'
> 
> (Expected to get back: v1.17~15^2^2)
> 
> Why would it not want to return something? Possible bug?

Is v1.17 an *annotated* tag?  What does

  $ git describe --contains --tags v1.17~15^2^2

return?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
