From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: enable platform-specific authentication
Date: Wed, 18 May 2011 12:57:10 -0700
Message-ID: <20110518195710.GA10697@dcvr.yhbt.net>
References: <1305708320-8614-1-git-send-email-grddev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Edward Rudd <urkle@outoforder.cc>,
	Matthijs Kooijman <matthijs@stdin.nl>,
	Carsten Bormann <cabo@tzi.org>
To: Gustav Munkby <grddev@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 18 21:57:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMmrt-0004HP-IV
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 21:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926Ab1ERT5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 15:57:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51877 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527Ab1ERT5L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 15:57:11 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE3281F404;
	Wed, 18 May 2011 19:57:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1305708320-8614-1-git-send-email-grddev@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173898>

Gustav Munkby <grddev@gmail.com> wrote:
> Use the platform-specific authentication providers that are
> exposed to subversion bindings starting with subversion 1.6.

This came up several months ago, I understand there were some issues
with the SVN Perl bindings.  Cc-ing interested parties.

>  sub _auth_providers () {
>  	[
> +	  $SVN::Core::VERSION lt '1.6' ? () :
> +	    @{SVN::Core::auth_get_platform_specific_client_providers(
> +	      undef,undef)},

I think it needs to take into account the config from
SVN::Core::config_get_config, otherwise people with non-standard SVN
configurations could get locked out.  I seem to recall this was the
broken part in the SVN Perl bindings, but one of the Cc-ed parties would
know for sure.

-- 
Eric Wong
