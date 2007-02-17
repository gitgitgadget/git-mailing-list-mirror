From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Sat, 17 Feb 2007 18:26:03 -0500
Message-ID: <20070217232603.GB30839@coredump.intra.peff.net>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 00:26:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIYwV-00055s-Nq
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 00:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992798AbXBQX0I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 18:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992869AbXBQX0I
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 18:26:08 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3523 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992798AbXBQX0H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 18:26:07 -0500
Received: (qmail 14551 invoked from network); 17 Feb 2007 18:26:13 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 17 Feb 2007 18:26:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Feb 2007 18:26:03 -0500
Content-Disposition: inline
In-Reply-To: <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40023>

On Sat, Feb 17, 2007 at 01:12:52PM -0800, Junio C Hamano wrote:

> +	prefix = setup_git_directory_gently(&is_not_gitdir);
> +	prefix_length = prefix ? strlen(prefix) : 0;
> +	if (!is_not_gitdir) {
> +		git_config(git_apply_config);
> +		if (apply_default_whitespace)
> +			parse_whitespace_option(apply_default_whitespace);
> +	}
> +

If I read this correctly, running 'git apply' inside a git repository
will parse $GIT_DIR/config and $HOME/.gitconfig. However, outside of a
repository it will parse neither. It would make more sense to me to
still parse $HOME/.gitconfig to pick up the user's global options.

-Peff
