From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v2 00/31] refactor rebase
Date: Tue, 22 Feb 2011 08:58:09 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102220847500.5290@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com> <7vd3mz33xb.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1102111811300.26684@debian>
 <alpine.DEB.2.00.1102132047500.4253@debian>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 22 14:58:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prskv-000649-4w
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 14:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424Ab1BVN6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 08:58:17 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:40718 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693Ab1BVN6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 08:58:16 -0500
Received: by qyg14 with SMTP id 14so1887009qyg.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 05:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=GSoF7Qju4/i+vYrlnsnyCTci1VlEYkAcjn/qeiF6nMU=;
        b=aa6u/AXxaGPNDkNhaCiMl6sIXrfahJ+kIYnEebXUTvMbe4nV8xYChdrRhUjJgJA49i
         HGjrN5DvDSt7CnMltW6N4IbNCwgICvYjrKRBX3bbGmtz28CCX6D2wGKVgf6lmBNRN/kk
         JTWWsZXInbNE7cTTKDGev0tVnq+WQoUOFkpmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=ioOU7wpcYeUBbNK0+85zq/e1bPFtxmPSjSjUcvGaLGP7hjq/v/gKmzXvKn8KAMsf2V
         bYERR3JFpAQntw+GhqnR5r184HQwliTNU+XrqtZxmXKNKxh8Ede+e03adf4Rvgyk7dOI
         NytDYBLcipRPIrtWEmYQ7wJwT3VExXC1y1+Ws=
Received: by 10.224.19.142 with SMTP id a14mr2212092qab.194.1298383095739;
        Tue, 22 Feb 2011 05:58:15 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id t7sm4634094qcs.28.2011.02.22.05.58.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 05:58:14 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <alpine.DEB.2.00.1102132047500.4253@debian>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167545>

On Sun, 13 Feb 2011, Martin von Zweigbergk wrote:

> On Fri, 11 Feb 2011, Martin von Zweigbergk wrote:
> 
> > On Thu, 10 Feb 2011, Junio C Hamano wrote:
> > 
> > > I am not sure if forbidding "-v --continue" adds any value; would it be
> > > too much effort to allow "--continue -v" instead to achieve the same
> > > degree of consistency between the two?
> > 
> > I'll have a look at it when
> > I get some time.
> 
> This would apply on top of mz/rebase after dropping 95135b0 (rebase:
> stricter check of standalone sub command, 2011-02-06). If you agree
> with it, I will include it in a future re-roll.

Any opinions about this, anyone? I have one example: I was rebasing
some things the other day where I thought there would be no conflicts.
After applying a number of patches, it turned out there were
conflicts. I think allowing 'git rebase --continue -sours' would have
been useful in that case. It's rare enough that I don't care much,
though.

The reason I'm asking is that I have a patch that fixes the problems
with the command line parsing that Johannes Sixt pointed out in
another mail on this thread and would like to know if I should make it
apply on top of this patch or not.


/Martin
