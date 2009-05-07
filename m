From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] completion: use specified file (if any) when
	completing config vars
Date: Thu, 7 May 2009 08:12:07 -0700
Message-ID: <20090507151207.GQ30527@spearce.org>
References: <1241676906-29783-1-git-send-email-bebarino@gmail.com> <1241677093-29937-1-git-send-email-bebarino@gmail.com> <1241677093-29937-2-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 17:12:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M25Gl-0005aO-3W
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 17:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbZEGPMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 11:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbZEGPMI
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 11:12:08 -0400
Received: from george.spearce.org ([209.20.77.23]:45467 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339AbZEGPMH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 11:12:07 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6E1D1381D0; Thu,  7 May 2009 15:12:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1241677093-29937-2-git-send-email-bebarino@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118486>

Stephen Boyd <bebarino@gmail.com> wrote:
> Only list the variables that can actually be affected by the command by
> searching the arguments for a config file setting.

Wow, this is a lot of magic.

Try:

  git config --global remote.gitster.url $(git config remote.o<TAB>

You'll complete against --global, not the local repository.

 
>  __git_config_get_set_variables ()
>  {
> -	for i in $(git --git-dir="$(__gitdir)" config --list); do
> +	local args="--global --system --file= -f"
> +	local config_file="$(__git_find_argument_and_value "$args")"
> +	for i in $(git --git-dir="$(__gitdir)" config $config_file --list \
> +			2>/dev/null); do

-- 
Shawn.
