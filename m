From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Possible bug in git-completion.sh
Date: Fri, 08 Jan 2010 16:40:26 +0100
Message-ID: <4B4751EA.8060707@drmicha.warpmail.net>
References: <4B474C73.8080100@mtu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: Jon Schewe <jpschewe@mtu.net>
X-From: git-owner@vger.kernel.org Fri Jan 08 16:42:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTGyc-0006GA-OK
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 16:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713Ab0AHPmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 10:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753579Ab0AHPmI
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 10:42:08 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:54012 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753569Ab0AHPmH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 10:42:07 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1728DC93D6;
	Fri,  8 Jan 2010 10:42:07 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 08 Jan 2010 10:42:07 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=bBsRTcOTUro8Yk4/9KHW0Oiysr4=; b=JFbtxm3bB07+97y82Ix9BM5dc9+hN0tU/HoCU5Cv27lH4Tyog/hy4Drc0aVQpkYj9QXjd87aGypBTIS6ZXhHd+aS/3H2JrN8gCwWuKNaTKfonKyWKw2ydyJmPrbjb/Vm0+kMUr2oJLLAOghoJ5+ARDBXcbS4odGgQXIxeCmOCto=
X-Sasl-enc: ptt7fz0jH+ANSqSr1odlvh02RKp3d4zr3Yq0AeZ4cr81 1262965326
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5F0524C012B;
	Fri,  8 Jan 2010 10:42:06 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7pre) Gecko/20091209 Lightning/1.0b2pre Shredder/3.0.1pre
In-Reply-To: <4B474C73.8080100@mtu.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136445>

Jon Schewe venit, vidit, dixit 08.01.2010 16:17:
> If I create a directory "build" at the top of my git repository and then
> add it to .gitignore, git behaves as expected and ignores the build
> directory when checking status. Now git-completion.sh has some issues. I
> have GIT_PS1_SHOWUNTRACKEDFILES to "1", so that I will be notified when
> there are untracked files in my working directory. When I'm in the
> top-level directory my prompt looks like expected, no '%'. However if I
> change to the build directory I get a '%', even though git status shows
> no untracked files. I see that git-completion.sh is using git ls-files
> to check this and that function does indeed show output when in my build
> directory. So the question here: Is git-completion.sh using ls-files
> improperly or is ls-files behaving improperly?
> 

Neither, but: output between status and ls-files is inconsistent. More
specifically, different commands behave differently with respect to the
treatment of subdirs. ls-files assumes "." implicitly, status does not.
"git status ." should give you the same behavior is "git ls-files" in
this regard.

Michael
