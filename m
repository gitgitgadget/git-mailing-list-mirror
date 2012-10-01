From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: Re: [PATCH] more meaningful error message in gitk when git binary is not available
Date: Mon, 1 Oct 2012 15:39:28 +0200
Message-ID: <k4c6en$qq$1@ger.gmane.org>
References: <50694380.4090108@josefassad.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 01 15:40:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIgEG-00016V-TA
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 15:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361Ab2JANkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 09:40:00 -0400
Received: from plane.gmane.org ([80.91.229.3]:50670 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281Ab2JANj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 09:39:59 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TIgE3-0008Rx-FL
	for git@vger.kernel.org; Mon, 01 Oct 2012 15:39:59 +0200
Received: from dsdf-4d0a1cfd.pool.mediaways.net ([77.10.28.253])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 15:39:59 +0200
Received: from jojo by dsdf-4d0a1cfd.pool.mediaways.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Oct 2012 15:39:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dsdf-4d0a1cfd.pool.mediaways.net
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206734>

Josef Assad wrote:
> Hi. I ran across what is a decidedly trivial little issue in gitk. The
> TCL/Tk looked simple enough so I am giving you a patch anyhow in case
> you want to fix it.
> 
> When for whatever reason the git binary is unavailable, gitk would
> complain about missing git repository instead, so this patch adds a
> check for git binary availability.
> 
> In case anyone is curious, I found this issue here:
> 
> http://stackoverflow.com/q/11967110/53936
> 
> 
> 
> Signed-off-by: Josef Assad <josef@josefassad.com>
> ---
> gitk-git/gitk |    6 ++++++
> 1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index d93bd99..7e2e0a7 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -11680,6 +11680,12 @@ setui $uicolor
> 
> setoptions
> 
> +# check that the git executables are available for use
> +if [catch {set gitexists [exec which git]}] {

I believe 'which' is not portable, you could use 'type' instead.

> +    show_error {} . [mc "Cannot find a suitable git executable."]
> +    exit 1
> +}
> +
> # check that we can find a .git directory somewhere...
> if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
>     show_error {} . [mc "Cannot find a git repository here."]
