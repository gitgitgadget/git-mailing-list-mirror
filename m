From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: inotify daemon speedup for git [POC/HACK]
Date: Tue, 27 Jul 2010 18:58:31 -0500
Message-ID: <AANLkTi=6pPrQkEozTR6OXuO6C4kGk61ExTWiLD6vQ1Mp@mail.gmail.com>
References: <20100727122018.GA26780@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Wed Jul 28 01:58:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Odu2z-0001CM-GZ
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 01:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458Ab0G0X6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 19:58:52 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37672 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab0G0X6v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 19:58:51 -0400
Received: by ywh1 with SMTP id 1so661718ywh.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 16:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=N/Kun4Q1vJje7Tbw8ExMza1FgYjZ+Nmyv3zSFKFXahU=;
        b=G1YCN/xbFsQva8x2x0xDrzEaG9tVSuJwKSxoC5fQryFvQgSJvS7NFjnZELigUyxpKr
         lFE1NT3GrZzdi6pZ/SznWJNy5A8bPUwcoVPewJISSsHKfTrQxwObZkVLwwdKuslUPjII
         mQPy6w7OHJaUR5Cg0fxLwnzZgpgJnJQ1cL9vo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=OYBotHbpwnKY6sv1hAEtASH/mqyN/8irAhoPXnx08h3iePUN7BAiNnUxNJm9WV2pCc
         J0dgcvejS6+NXuSvVFBCdGnRJ295y0OKtAfVmHejTYXMpTmCnTAbGtqLzD6WjbJMZ6oR
         hj4KkLLn27uq8gQeyaendF6+CpvRKN1oVZbIU=
Received: by 10.151.139.16 with SMTP id r16mr11663935ybn.168.1280275131076; 
	Tue, 27 Jul 2010 16:58:51 -0700 (PDT)
Received: by 10.150.66.12 with HTTP; Tue, 27 Jul 2010 16:58:31 -0700 (PDT)
In-Reply-To: <20100727122018.GA26780@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152018>

Heya,

On Tue, Jul 27, 2010 at 07:20, Finn Arne Gangstad <finnag@pvv.org> wrote:
> There is one minor nit: The speedup gain is zero :) git still
> traverses all directories to look for .gitignore files, which seems to
> totally kill the optimisation.

This is very true. In my experience with ginormous trees even if you
'git update-index --assume-unchanged' every file and directory it's
still unbearably slow due to the .gitignore files. Any solution that
aims to solve this problem should also address the .gitignore file
problem. Note: a safe assumption here is that to solve the problem it
needs to work if there are more .gitignore files than regular files
:).

-- 
Cheers,

Sverre Rabbelier
