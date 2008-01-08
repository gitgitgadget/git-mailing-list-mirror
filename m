From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] git branch: Use color configuration infrastructure
Date: Tue, 8 Jan 2008 06:23:28 -0500
Message-ID: <20080108112328.GA19941@coredump.intra.peff.net>
References: <1199542226.6209.34.camel@futex> <1199542299-12082-1-git-send-email-mk@spinlock.ch> <1199542299-12082-2-git-send-email-mk@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org,
	Matthias Kestenholz <matthias@spinlock.ch>
To: Matthias Kestenholz <mk@spinlock.ch>
X-From: git-owner@vger.kernel.org Tue Jan 08 12:24:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCCYo-00013X-TA
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 12:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbYAHLXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 06:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbYAHLXc
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 06:23:32 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1610 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213AbYAHLXb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 06:23:31 -0500
Received: (qmail 16819 invoked by uid 111); 8 Jan 2008 11:23:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 08 Jan 2008 06:23:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Jan 2008 06:23:28 -0500
Content-Disposition: inline
In-Reply-To: <1199542299-12082-2-git-send-email-mk@spinlock.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69865>

On Sat, Jan 05, 2008 at 03:11:37PM +0100, Matthias Kestenholz wrote:

> --- a/builtin-branch.c
> +++ b/builtin-branch.c
> [...]
> -static int branch_use_color;
> [...]
>  	if (!strcmp(var, "color.branch")) {
> -		branch_use_color = git_config_colorbool(var, value, -1);
> +		git_use_color = git_config_colorbool(var, value, -1);
>  		return 0;
>  	}

If I read this right, you are getting rid of the individual "use color"
variables with a single static git_use_color. This will break if two
different color "zones" get used in the same program (e.g.,
color.branch and color.diff, but only one is supposed to be set). I
don't think this is a problem currently, but it seems like a step
backwards in terms of libification.

-Peff
