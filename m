From: nathdwek <nathdwek@ulb.ac.be>
Subject: __git_ps1_colorize__gitstring() in git_prompt.sh: colors are hardcoded?
Date: Fri, 17 Oct 2014 19:30:52 +0200
Message-ID: <5441524C.6040302@ulb.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 17 19:41:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfBWb-00017n-0K
	for gcvg-git-2@plane.gmane.org; Fri, 17 Oct 2014 19:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbaJQRlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2014 13:41:08 -0400
Received: from mxin.ulb.ac.be ([164.15.128.112]:42453 "EHLO mxin.ulb.ac.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638AbaJQRlH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2014 13:41:07 -0400
X-Greylist: delayed 607 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Oct 2014 13:41:06 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApMBAKdRQVRtgazZ/2dsb2JhbAANToc/0jUBhSlVJRECBRYLAgsDAgECAVgIAQHANniPEIYCgSyPPoJhgVQFkwaSI4UUjTqDNQEBAQ
Received: from 217.172-129-109.adsl-dyn.isp.belgacom.be (HELO [192.168.1.2]) ([109.129.172.217])
  by smtp.ulb.ac.be with ESMTP/TLS/DHE-RSA-AES128-SHA; 17 Oct 2014 19:30:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

It seems to me that the colors used to indicate the repo's state in the
prompt are hardcoded although the top comment says otherwise.

>From contrib/completion/git-contrib.sh:

[83]# If you would like a colored hint about the current dirty state, set
# GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based on
# the colored output of "git status -sb" and are available only when
# using __git_ps1 for PROMPT_COMMAND or precmd.

[228]__git_ps1_colorize_gitstring ()
{
	if [[ -n ${ZSH_VERSION-} ]]; then
		local c_red='%F{red}'
		local c_green='%F{green}'
		local c_lblue='%F{blue}'
		local c_clear='%f'
	else
		# Using \[ and \] around colors is necessary to prevent
		# issues with command line editing/browsing/completion!
		local c_red='\[\e[31m\]'
		local c_green='\[\e[32m\]'
		local c_lblue='\[\e[1;34m\]'
		local c_clear='\[\e[0m\]'
	fi
	local bad_color=$c_red
	local ok_color=$c_green
	local flags_color="$c_lblue"

	local branch_color=""


As expected upon seeing this snippet, the color.status.<slot> entries in
the git config file do modify the git status -sb output but don't modify
the colors used in the prompt.

Regards,

Nathan
