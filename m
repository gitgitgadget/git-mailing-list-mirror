From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Teach git submodule update to use distributed   repositories
Date: Fri, 18 Jul 2008 18:38:27 -0400
Message-ID: <48811B63.4090005@gmail.com>
References: <alpine.DEB.1.00.0807171513560.8986@racer> <320075ff0807170807l1537e34ev510deda537e4d11e@mail.gmail.com> <20080717182253.GZ32184@machine.or.cz> <320075ff0807180111q4ca55cc4v15487af35f6fa63c@mail.gmail.com> <20080718091608.GL10151@machine.or.cz> <320075ff0807180236u4e7f5f9bm81b702d14c052de8@mail.gmail.com> <20080718100048.GN10151@machine.or.cz> <320075ff0807180420k4b28c317mc026713b22c44839@mail.gmail.com> <20080718144325.GR10151@machine.or.cz> <320075ff0807180809x599aefafw2c7fe88fea2691d2@mail.gmail.com> <20080718154959.GS10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nigel Magnay <nigel.magnay@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Jul 19 00:39:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJyc3-0002JN-16
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 00:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757778AbYGRWid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 18:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756640AbYGRWid
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 18:38:33 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:28851 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756067AbYGRWic (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 18:38:32 -0400
Received: by yw-out-2324.google.com with SMTP id 9so167423ywe.1
        for <git@vger.kernel.org>; Fri, 18 Jul 2008 15:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=bBJi0M3RHK8MDzcn4+e6LBfx/0OsCn1/cEcxY2o4l6Y=;
        b=IfUUOAz3t20HoftsYgBTmMRgUVOhLm1V4O669pdSjC0np2XNwGLvaPIBjGOoYIIqT7
         W35x1jn+4t+a3s8ls8ucnq8FlM66+NqQ6TyifHjXdaiQ5jsTYZhoTPd5b3Vz4dpJ1cyA
         SciVvoS+9o84vX6KW5ho+1UO0r26TVgDOyNRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=DWkh09bX4cN+lusFL23RCkUnlVtTcP3HCuqtk5pnK5G9ZVmahvQPYAZQqL1wuICyPr
         Qx3JFVC5Hsh0gS77bdIXP4ADbxKPgW3qMWesYSk7+ghARlGQnpJ2xisyIoyKNF7UY9aG
         EckbUbyY15+avMdwysKlaGvnrtQ931iwQMVI0=
Received: by 10.150.227.14 with SMTP id z14mr703293ybg.145.1216420711274;
        Fri, 18 Jul 2008 15:38:31 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.191.242.168])
        by mx.google.com with ESMTPS id 6sm2060782yxg.6.2008.07.18.15.38.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jul 2008 15:38:30 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20080718154959.GS10151@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89084>

Petr Baudis wrote:
> On Fri, Jul 18, 2008 at 04:09:40PM +0100, Nigel Magnay wrote:
> 
> In that case you would need the "URL mappings", perhaps as a per-remote
> attribute. That is, you could configure:
> 
> 	"When I am doing git pull fred, do git submodule update but
> 	apply remote.fred.subrewrite sed script on each URL before
> 	fetching the submodule."
> 
> Still, that feels quite hackish to me, and I'm not convinced that your
> workflow cannot be adjusted so that users merge only the next-to-last
> commit of a branch instead of the last one.
> 

There really are two distinct forms of submodule URL's supported by 
git-submodule: absolute and relative. The first says "always go to repository x 
on server y", and is the correct form for a *very* loosely coupled submodule. 
However, it requires a lot of hacking to support fetching from an alternate 
location.

The relative form says "go to this location *relative* to the superproject's 
repository". Using this form greatly eases the use case. Basically, fred has his 
tree of trees on his system, arranged exactly as they are on the main server. If 
you do a git fetch "fred" into superproject, then submodule update, submodule 
should be able to find the related submdodules on "fred" and get the data 
relatively easily.

I actually submitted a patch series a while back that does this, but no-one on 
the list cared for the use case it supported so that series died.

Mark
