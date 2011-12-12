From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] test-terminal: give the child an empty stdin TTY
Date: Mon, 12 Dec 2011 17:25:03 -0600
Message-ID: <20111212232503.GA12366@elie.hsd1.il.comcast.net>
References: <b97d14da67bd6097e5b04f6ae3057c0f1d536a0b.1323713230.git.trast@student.ethz.ch>
 <7vfwgp4niu.fsf@alter.siamese.dyndns.org>
 <20111212191602.GA14061@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 13 00:25:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaFFH-0005Ng-8n
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 00:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285Ab1LLXZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 18:25:14 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:43956 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab1LLXZN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 18:25:13 -0500
Received: by qcqz2 with SMTP id z2so4073116qcq.19
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 15:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Yl6OCek9RvA7RO2qHH/zYnYrpxN4X3CR7582LPFxRS0=;
        b=DHiU4zBR5wen3w743r1KJHWmI3+43qEpmzbD56nixF5VAd5Mj+IFzYNeigK8n7Jv/m
         HrIK4g2Oufo6NHegU8jkKuFSVtUO9vcsXnYOtTvl7pgXSoTetgQd/I3iiC2XxzznrSgX
         U3Gne2Hz2HxwaxiKnSqCd9+fAQgdnpfzbNUxw=
Received: by 10.101.135.32 with SMTP id m32mr37576ann.43.1323732313077;
        Mon, 12 Dec 2011 15:25:13 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id n24sm11752939yhj.13.2011.12.12.15.25.11
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Dec 2011 15:25:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111212191602.GA14061@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186971>

Jeff King wrote:

> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -198,6 +198,9 @@ else
>  	exec 4>/dev/null 3>/dev/null
>  fi
>
> +exec 6<&0
> +exec 0</dev/null
> +
>  test_failure=0
>  test_count=0
>  test_fixed=0

Independently of the changes to explicitly pass HEAD to "git shortlog"
in t7006 (we should) and make test_terminal make stdin into a tty, too
(if tests still make sure "git log --stdin" launches a pager with
stdin not a tty, then it should be a fine change), this looks good to
me.
