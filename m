From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/6] t1510 (worktree): fix '&&' chaining
Date: Thu, 8 Dec 2011 11:12:13 -0600
Message-ID: <20111208171213.GF2394@elie.hsd1.il.comcast.net>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323349817-15737-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 18:12:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYhWA-0007zN-Mo
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 18:12:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826Ab1LHRMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 12:12:18 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49259 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244Ab1LHRMR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 12:12:17 -0500
Received: by ghbz2 with SMTP id z2so1715272ghb.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 09:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=xGBRijv4TQ8a+IvEY/vi+Tsk0HEyTIRoX00jnFcZUXo=;
        b=dMcFc9oEX5RFPVYLIu2evZh01uPE3Fc0XAkKSVjd4WO9WRA62CvPBZHkRolb1IU3a3
         Y5BbyTJjtXMYvU9PtxWT6U0IORvr2GAuwOrG1PLaVRXrZg6VGEIbYFtqrU92QSUdXz9J
         QCLPvlYDOLbBpEBbs6Qtc5pHVMfjPe2h26qig=
Received: by 10.236.197.2 with SMTP id s2mr5756969yhn.123.1323364336661;
        Thu, 08 Dec 2011 09:12:16 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id a7sm16056887ana.5.2011.12.08.09.12.15
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 09:12:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323349817-15737-8-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186577>

Ramkumar Ramachandra wrote:

> Breaks in a test assertion's && chain can potentially hide failures
> from earlier commands in the chain.  Fix these breaks.
>
> Additionally, note that 'unset' returns non-zero status when the
> variable passed was already unset on some shells: change these
> instances to 'safe_unset'.

This is also not "Additionally", as in "As a separate change that
maybe should have been another patch but I am too lazy".  Rather, it
is a necessary change that is part of the same task.  So I would
write:

	Breaks in a test assertion's && chain can potentially hide failures
	from earlier commands in the chain.  Fix these breaks.

	'unset' returns non-zero status when the variable passed was already
	unset on some shells, so now that the status is tested we need to
	change these instances to 'safe_unset'.

Erm, sane_unset, not safe_unset.  Did you even test this?

>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t1501-worktree.sh |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

For what it's worth, after those changes,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
