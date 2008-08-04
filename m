From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Adapt discovery of oguilib to execdir
	'libexec/git-core'
Date: Mon, 4 Aug 2008 13:00:49 -0700
Message-ID: <20080804200049.GA29485@spearce.org>
References: <1217177383-25272-1-git-send-email-prohaska@zib.de> <1217177383-25272-2-git-send-email-prohaska@zib.de> <20080727212405.GA10075@spearce.org> <AF6C526A-57ED-4386-A4CF-5260D82026B7@zib.de> <1217756103.48957bc76eda2@webmail.nextra.at> <58FBF585-377C-40A7-818E-6B47F8FD2EB8@zib.de> <1217879912.48975f6809e10@webmail.nextra.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Aug 04 22:02:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ6Fc-00010P-1u
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 22:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382AbYHDUAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 16:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755000AbYHDUAu
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 16:00:50 -0400
Received: from george.spearce.org ([209.20.77.23]:39855 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753271AbYHDUAu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 16:00:50 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id AB9EC38419; Mon,  4 Aug 2008 20:00:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1217879912.48975f6809e10@webmail.nextra.at>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91389>

Johannes Sixt <johannes.sixt@telecom.at> wrote:
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index fd3875a..fa08d49 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -52,7 +52,11 @@ catch {rename send {}} ; # What an evil concept...
>  set oguilib {@@GITGUI_LIBDIR@@}
>  set oguirel {@@GITGUI_RELATIVE@@}
>  if {$oguirel eq {1}} {
> -	set oguilib [file dirname [file dirname [file normalize $argv0]]]
> +	set oguilib [file dirname [file normalize $argv0]]
> +	if {[lindex [file split $oguilib] end] eq {git-core}} {
> +		set oguilib [file dirname $oguilib]

Isn't that what [file tail] does?

	if {[file tail $oguilib] eq {git-core}} {

But otherwise this looks good to me.  I'll apply it later tonight,
unless you agree that file tail is better here.

-- 
Shawn.
