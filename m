From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 3/3] git-p4: improve submit performance on new P4 servers
Date: Thu, 21 Jan 2010 21:49:48 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001212147480.1726@xanadu.home>
References: <4B590808.6010206@naughtydog.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Simon Hausmann <simon@lst.de>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Pal-Kristian Engstad <pal_engstad@naughtydog.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 03:49:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY9ar-0000Mn-LO
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 03:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886Ab0AVCtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 21:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755869Ab0AVCtu
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 21:49:50 -0500
Received: from relais.videotron.ca ([24.201.245.36]:9014 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755630Ab0AVCtt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 21:49:49 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KWM0034MNV07B00@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 21 Jan 2010 21:49:48 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <4B590808.6010206@naughtydog.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137727>

On Thu, 21 Jan 2010, Pal-Kristian Engstad wrote:

> Improve git-p4 submit performance on newer (from 2009.2) Perforce
> servers by changing "p4 diff -du" to "p4 diff -dub". This change is
> harmless since the output is only used for display purposes.
> 
> Signed-off-by: Pal-Kristian Engstad <pal_engstad@naughtydog.com>

Why is the b flag impacting performance?

And even if for display purposes, why might you wish not to see 
differences in whitespace changes?

> ---
>  contrib/fast-import/git-p4 |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index ab538b3..ec26cac 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -715,7 +715,7 @@ class P4Submit(Command):
>              submitTemplate = self.prepareLogMessage(template, logMessage)
>              if os.environ.has_key("P4DIFF"):
>                  del(os.environ["P4DIFF"])
> -            diff = p4_read_pipe("diff -du ...")
> +            diff = p4_read_pipe("diff -dub ...")
>  
>              newdiff = ""
>              for newFile in filesToAdd:
> -- 
> 1.6.5.2.6.gc3c1e.dirty
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
