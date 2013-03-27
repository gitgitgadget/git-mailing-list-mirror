From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Segfault with merge-tree on multiple Git versions
Date: Wed, 27 Mar 2013 17:05:01 +0100
Message-ID: <874nfw7rrm.fsf@linux-k42r.v.cablecom.net>
References: <51531059.8000407@atechmedia.com>
	<87boa47saw.fsf@linux-k42r.v.cablecom.net>
	<20130327155850.GN2286@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	"Charlie Smurthwaite" <charlie@atechmedia.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Mar 27 17:05:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKsr1-0008Rt-UW
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 17:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890Ab3C0QFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 12:05:05 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:47360 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391Ab3C0QFF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 12:05:05 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 27 Mar
 2013 17:04:58 +0100
Received: from linux-k42r.v.cablecom.net.ethz.ch (46.126.8.85) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 27 Mar 2013 17:05:02 +0100
In-Reply-To: <20130327155850.GN2286@serenity.lan> (John Keeping's message of
	"Wed, 27 Mar 2013 15:58:50 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219263>

John Keeping <john@keeping.me.uk> writes:

> merge-tree: fix typo in merge-tree.c::unresolved
>
> When calculating whether there is a d/f conflict, the calculation of
> whether both sides are directories generates an incorrect references
> mask because it does not use the loop index to set the correct bit.
> Fix this typo.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
>
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index e0d0b7d..bc912e3 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -245,7 +245,7 @@ static void unresolved(const struct traverse_info *info, struct name_entry n[3])
>  	unsigned dirmask = 0, mask = 0;
>  
>  	for (i = 0; i < 3; i++) {
> -		mask |= (1 << 1);
> +		mask |= (1 << i);
>  		if (n[i].mode && S_ISDIR(n[i].mode))
>  			dirmask |= (1 << i);
>  	}

Indeed, that fixes it.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
