From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 4/5] Head reduction before selecting merge strategy
Date: Fri, 25 Apr 2008 03:31:14 -0700 (PDT)
Message-ID: <m3prsep6oy.fsf@localhost.localdomain>
References: <402c10cd0804232252g43606767r10344ebbb2a44af9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 12:32:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpLDs-000198-2N
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 12:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbYDYKbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 06:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbYDYKbS
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 06:31:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:6918 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbYDYKbR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 06:31:17 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1414445nfb.21
        for <git@vger.kernel.org>; Fri, 25 Apr 2008 03:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=mQjARrNF67JFXRCMFly/hLipaKJZnZ/PcanMcOjw1vs=;
        b=q5zyNhmAggosvy9KBmoQy9l50ex/Dg7lvP7Ve2vvj8dfgN3vFG6U0e4ywbgkRXWrK+oEChv4PgbnERHCSPIoUxXXDGqSz+4n45Vp28qBe0F3v6F9FT+/7x7Z9D6ltVa1iDsCDPM43YjGDFWvZtqntQTsyCzvXPOHx27FvLoczjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=tZeYMTdCzhAG/8WmUsqE+pLo0TLIXuO/kQvn80NHNIQ1CDJjYsIayuXRBwtptyz+r93V9qJiRfQcVoc/QlZnxTMRKE1DiChhgANRk36ZW9nQav+cjz57rdEi8Jv44Ca+KqPp9y9QBJnSPgpP2MPQE2sxTSB/W82FZtsKxeVpwqs=
Received: by 10.210.115.15 with SMTP id n15mr2170581ebc.81.1209119476402;
        Fri, 25 Apr 2008 03:31:16 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.255.239])
        by mx.google.com with ESMTPS id 32sm2501319nfu.7.2008.04.25.03.31.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Apr 2008 03:31:14 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3PAV9pH023127;
	Fri, 25 Apr 2008 12:31:10 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3PAUrCB023123;
	Fri, 25 Apr 2008 12:30:53 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <402c10cd0804232252g43606767r10344ebbb2a44af9@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80335>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> See the documentation for an explanation of this feature.

I think I get the idea now.

You want to generalize fast-forward merge, or what's equivalent make
fast-formard merge to be special case of head reduction.  This should
be written both in commit message and in documentation.  Do I
understand your goal correctly?

With head reduction comes three things:
 * the merge strategy used
 * recorded parents
 * generated merge commit message
The simplest way would be to use reduced head for all three things,
I think.

But I also think that this commit in series is the most controversial
one; is it realy needed for other commits?  I would put it then as the
last commit in series...
 
> +If more than one commit are specified on the command line, git will
> +try to reduce the number of commits used (reduced parents) by
> +eliminating commits than can be reached from other commits.  The
> +commit message will reflect the commits specified on the command line
> +but the merge strategy will be selected based on the reduced parents
> +including `HEAD`.  The reduced parents are the parents recorded in the
> +merge commit object.

Is it a correct solution, to use provided (specified) heads for
generation of merge commit message, but use reduced heads for
selecting merge strategy _and_ also as parents recorded in merge
commits?  Perhaps it is; but IMHO you should have written it in the
commit message, and defend this decision in commit message.

> +
> +The following shows master and three topic branches.  topicB is based
> +on topicA, topicA is previously branched off from master, and topicC
> +is based on the tip of the master branch:
> +
> +------------
> +                    o---o---o  topicB
> +                   /
> +          o---o---o  topicA
> +         /
> +    o---o---o---o---o---o  master
> +                         \
> +                          o---o  topicC
> +------------

I think I would start with simpler example without 'topicC', of
reduction of octopus to two-parent ordinary merge.

> diff --git a/git-merge.sh b/git-merge.sh
> index 7c34b6c..7c70c56 100755
> --- a/git-merge.sh
> +++ b/git-merge.sh
> @@ -337,11 +337,16 @@ set x $remoteheads ; shift
> 
>  find_reduced_parents "$@"
> 
> -actual_parents=$(git rev-parse "$@")

This was introduced by some of your earlier commits, isn't it?

[...]
-- 
Jakub Narebski
Poland
ShadeHawk on #git
