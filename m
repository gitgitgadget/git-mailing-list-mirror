From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: rebase question
Date: Sat, 12 Mar 2011 20:05:32 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1103121714280.15442@debian>
References: <AANLkTi=8Q+gNSY2jzgMMtPX-JHUy4MUEGNTeK85Ddvys@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ryan Sun <ryansun81@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 13 02:05:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyZkc-0001ag-6C
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 02:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140Ab1CMBFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2011 20:05:37 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44756 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137Ab1CMBFg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2011 20:05:36 -0500
Received: by vxi39 with SMTP id 39so3544641vxi.19
        for <git@vger.kernel.org>; Sat, 12 Mar 2011 17:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=31dXPZsweHzl7Z6T28EPQNBPtKUup8cyDtSxNKswyg4=;
        b=KrAEtvmSDSWOHB+Gpms5sSEWbB34IVAjqf6YTls3gkE6lc9onMVmyvClCWHK/uSDK4
         NqbMj5wg+vDs8/awL8Ygbi4f30SheCyvo1rYA+HIFq5j6cY1UGe6/GgKdabIGAsn14c3
         cgDK3eMXj0USyj+eF8mkh7z0SNqs+l7I77BTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=Uia/gjh9KC4fTZkRPteOovSbeuk2anBteRuqfgWV2JAmPR5MaU2MpRKs9Pt9rPbc5H
         Wy5gh6rBG3lHVJukjei8uqzWLvImUQGbfe3EPQ8OVrRQbEk3W8JCwGdlKfvE4m+ADpvN
         rtyVtE4QBqTc2j7dlRfE+9dyIHs7Zu4/rf/qE=
Received: by 10.52.167.230 with SMTP id zr6mr16203094vdb.6.1299978335552;
        Sat, 12 Mar 2011 17:05:35 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id e37sm4013276vbm.15.2011.03.12.17.05.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 12 Mar 2011 17:05:34 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <AANLkTi=8Q+gNSY2jzgMMtPX-JHUy4MUEGNTeK85Ddvys@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168953>

On Fri, 11 Mar 2011, Ryan Sun wrote:

> I want to rebase the current branch B1 from origin/A1 to origin/A2
> so I want to use this command
> git --onto origin/A2 origin/A1 B1
> 
> Q1: is this command right? (A2 is based on A1, current branch is B1,
> B1 is already pushed to origin, a remote repo, and I think I will
> force push B1 after rebase)

Yes, it is correct (except that the "rebase" is missing, of
course). Since A2 is based on A1, you could even use "git rebase
origin/A2 B1".

> but I accidentally typed
>  git --onto origin/A2 origin/A1 origin/A2
> and git says
> ----
> First, rewinding head to replay your work on top of it...
> Fast-forwarded origin/base to origin/base.
> ----

I assume "origin/base" is what you called "origin/A2" above. The
output is a bit confusing in this case.

I tried "git rebase [--onto origin/pu] origin/pu origin/master". That
printed

Fast-forwarded origin/master to origin/pu.

which is even incorrect. It didn't (and shouldn't) update
origin/master, so it obviously shouldn't say that it did
either. Should be easy enough to fix. I will have a look at that when
I get some time.

> Q2:I assume this command is safe and it didn't change anything right?

It detached your HEAD at origin/A2, but no commits, nor refs would
have been changed or lost. You can safely checkout out B1 again if you
want.


/Martin
