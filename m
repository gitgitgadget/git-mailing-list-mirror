From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Wed, 2 May 2007 16:30:14 +0100
Message-ID: <200705021630.16792.andyparkins@gmail.com>
References: <200705012346.14997.jnareb@gmail.com> <200705021158.04481.andyparkins@gmail.com> <Pine.LNX.4.64.0705021523290.24218@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Jakub Narebski <jnareb@gmail.com>,
	Jan Holesovsky <kendy@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 02 17:31:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjGn9-0000D2-QH
	for gcvg-git@gmane.org; Wed, 02 May 2007 17:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993227AbXEBPaw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 11:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993370AbXEBPaw
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 11:30:52 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:15782 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993227AbXEBPav (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 11:30:51 -0400
Received: by mu-out-0910.google.com with SMTP id g7so170504muf
        for <git@vger.kernel.org>; Wed, 02 May 2007 08:30:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qf2AjgoC1F77chnJRQDb/1ZTFC7JogouvfAmyZM+HiKM6Fy5qi2Fvb2vzHWxJjPNC4q0DXWEE9jb8roKrUycsqMj5JeBB+M2KMvBsLlU4sbtvllB0bShaWWzDOnhNI+6+2amqxq7/pQTwwKOsi8JZ4Uf950g3ZE/JdCyov2NTls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mcAvH9N3UVcGL5EWGbZhpT5ulO3BLTmOTMYjlrjvr5UyoGlhcu7ZwaeNn5ld3ea2DxCdhYt+WsqBtgxNSEMkXPRjddPGwNx3qEPP+5LLXzOYydMi4wvc4XXyTVwogxNblAMMIpSRhAaPGw6GoVvzdAqQp1fNKdllcC+lvBbIsCc=
Received: by 10.82.180.17 with SMTP id c17mr1640038buf.1178119849387;
        Wed, 02 May 2007 08:30:49 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b30sm61594ika.2007.05.02.08.30.32;
        Wed, 02 May 2007 08:30:44 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0705021523290.24218@reaper.quantumfyre.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46027>

On Wednesday 2007 May 02, Julian Phillips wrote:

> oops, meant 2.7G not 8.5G there ... sorry, was working from memory.

Not a problem.  That fixes one ambiguity:
  2.7G - 1.3G = 1.4G 
Which is the same as the CVS checkout size.  Both the CVS and git figures are 
now consistent:
                                CVS      git      SVN
Size of data on the server     8.5G     1.3G      n/a
Size of checkout               1.4G     2.7G     1.5G
Overhead in checkout             0G     1.3G     0.1G

So that only leaves the subversion number as being suspicious.

> the difference between 2.7G and 2.8G may be due to filesystem difference?

Could be I suppose.  Although, in that case CVS should have suffered the same 
because the disparity was in the source tree size.  Packed git shouldn't 
suffer any filesystem overhead (relatively) because the majority of it's 
space is taken up by one large pack file (which of course only suffers file 
system overhead once).

> I was wondering about the subversion figures too ...

I've just checked using subversion 1.4.2 and the .svn/text-base/*.svn-base 
files are all uncompressed copies of the working tree files.  Doesn't look 
like anythings changed in the pristine copy department.

> jp3@electron: ooo(unxsplash)>ls -sh .git/objects/pack/
> total 1.3G
>   37M pack-87efcac9bcb117328e8a1b0c1b42c88c3603c5b7.idx
> 1.2G pack-87efcac9bcb117328e8a1b0c1b42c88c3603c5b7.pack

Thanks for your help.  It's all looking more consistent to me now; only the 
subversion figures seem wrong.

I wonder when they're going to get timing numbers for the non-git systems.  
That must be a monster of a repository for them to deal with.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
