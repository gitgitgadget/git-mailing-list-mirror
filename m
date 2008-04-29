From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 13:05:46 +0200
Message-ID: <bd6139dc0804290405w4a7a94a7s15a85285b2122f2f@mail.gmail.com>
References: <200804281829.11866.henrikau@orakel.ntnu.no>
	 <alpine.LNX.1.00.0804281515480.19665@iabervon.org>
	 <200804282329.21336.henrikau@orakel.ntnu.no> <4816C26D.9010304@op5.se>
	 <f9d2a5e10804290009p17d291d5wf14e2bb58bedca63@mail.gmail.com>
	 <4816CC80.9080705@op5.se>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Russ Dill" <russ.dill@gmail.com>,
	"Henrik Austad" <henrikau@orakel.ntnu.no>,
	"Daniel Barkalow" <barkalow@iabervon.org>, git@vger.kernel.org
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Apr 29 13:06:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqnfQ-0001xQ-4I
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 13:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889AbYD2LFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 07:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753828AbYD2LFr
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 07:05:47 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:2736 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477AbYD2LFr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 07:05:47 -0400
Received: by wf-out-1314.google.com with SMTP id 28so4458831wff.4
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 04:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=O4z1WxZiWgKF9hcykJHIb6CnwTjJP2Rg+qMOxKA4AbU=;
        b=usbAlj/Qjt7CNQYbuWyb8eAjco7DNpGnndnYy/Inikgctr82d0gorDw8r2qVHMIx3OOsXBnfLg8PWg9oVtCkBA/OEFGyN6ctAE3Awi54WsVhdC3UAgr4CdczS6B79CW2abHRGQY3ZvbReYfPMb0SsmnrxOV0QuCJc0ybqGVBtVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uQiQtAwEJF7vcF/AfrLouGHx1QIBjV+0wgjKQO/2TQm1+OVv1g54BiFXXrywSl7V9GSWE+PTim/L2AenKV6h+aYNpbRIK6e+CiTBXiICITIsXTH1X8HBRSxMda33jh0Qq96dBiH+vs1jzObzxaIl9wvAuH066PA5Wox28M6VJjk=
Received: by 10.143.2.19 with SMTP id e19mr455226wfi.90.1209467146662;
        Tue, 29 Apr 2008 04:05:46 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Tue, 29 Apr 2008 04:05:46 -0700 (PDT)
In-Reply-To: <4816CC80.9080705@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80677>

On Tue, Apr 29, 2008 at 9:21 AM, Andreas Ericsson <ae@op5.se> wrote:
> Russ Dill wrote:
>  If the server is hacked and objects are replaced, they will either
>  no longer match their cryptographic signature, meaning they'll be
>  new objects or git will determine that they are corrupt, or they

We were assuming here that once SHA-1 is broken really determined
hackers will be able to come up with objects that -do- match the
SHA-1, so the above is not relevant.

>  *will* match an existing object, but then that object won't be
>  propagated to other repositories since git refuses to overwrite
>  already existing objects. [...]

What about new users cloning the repo? They're just out of luck? I
don't think this argument holds, if we want to 'advertise' that git is
cryptographically secure we can do so only as long as our hashing
algorithm is. (As such, should SHA-1 ever be fully broken we'd need to
either switch to another algorithm or stop advertising being
cryptographically secure.)

>  [...] Either way, gits refusal to overwrite
>  objects it already has plays a part in making malicious actions
>  futile, since malicious code is only worth something if it's
>  propagated and actually used.

Of course this is true, it makes it a lot harder to do damage, but it
doesn't eliminate the problem, it's just a free 'extra protection'.
Yes, malicious code is only worth something if it's propagated and
actually used, no, it is not impossible to do so in git if/when SHA-1
turns out to have collisions every other file.

-- 
Cheers,

Sverre Rabbelier
