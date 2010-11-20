From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 10/15] vcs-svn: Reject path nodes without Node-action
Date: Sat, 20 Nov 2010 08:53:07 -0600
Message-ID: <20101120145306.GA9804@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
 <20101120005259.GK17445@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 15:57:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJosl-0004qs-TP
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 15:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781Ab0KTOxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 09:53:18 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49654 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564Ab0KTOxR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 09:53:17 -0500
Received: by yxf34 with SMTP id 34so3293167yxf.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 06:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ivZ8ZpB22SZq7xySL2qZoFI2ETFqfPAMiSrcq0BlBbU=;
        b=Y7ddUkW1XfiF5PaM8upRutLj2mbvIcQY3QvIYZBFWeCPol2cIf52QgZdAaRLDU++iW
         DHVfahtPWG0xaETtlN7hQdHywc3Z+NUzE3nZ1MhQFq/jK1QhS0i03kTp8xzymZbpGAMD
         DJwPB+kFHmJlQ1DWuNZJEjoljDedfO1m9TpWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RJWAIjHtsFjLnt57mmcudSjQUlrrdCBzbr6iqOW1ZE65owVOLpXpDZaXQ9T4xhMZ/u
         XRpoNwG8YAd0V7+amdWQkfH/V32XaCo6HcXwPF/2yfn1MkXyWWTotJAam4xOkpjTkqqC
         jtzZs9iK0EAl4Hft0yWRqBBhV4qxj8Q+YcGNk=
Received: by 10.100.168.4 with SMTP id q4mr2404932ane.255.1290264796969;
        Sat, 20 Nov 2010 06:53:16 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id d10sm3204939and.39.2010.11.20.06.53.14
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Nov 2010 06:53:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120005259.GK17445@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161827>

Jonathan Nieder wrote:

> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -174,7 +174,8 @@ static void handle_node(void)
>  
>  	if (node_ctx.srcRev) {
>  		repo_copy(node_ctx.srcRev, node_ctx.src, node_ctx.dst);
> -		node_ctx.action = NODEACT_CHANGE;
> +		if (node_ctx.action == NODEACT_ADD)
> +			  node_ctx.action = NODEACT_CHANGE;

Whitespace damage.  Here's a fixup.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 78c2de0..0af8ac6 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -175,7 +175,7 @@ static void handle_node(void)
 	if (node_ctx.srcRev) {
 		repo_copy(node_ctx.srcRev, node_ctx.src, node_ctx.dst);
 		if (node_ctx.action == NODEACT_ADD)
-			  node_ctx.action = NODEACT_CHANGE;
+			node_ctx.action = NODEACT_CHANGE;
 	}
 
 	if (mark && type == REPO_MODE_DIR)
