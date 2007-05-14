From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-add: allow path limiting with -u
Date: Mon, 14 May 2007 02:50:22 +0200
Message-ID: <200705140250.22478.jnareb@gmail.com>
References: <20070512064159.GA7471@coredump.intra.peff.net> <200705131235.25281.jnareb@gmail.com> <20070514003910.GA6689@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 14 02:45:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnOh9-0003E0-Qp
	for gcvg-git@gmane.org; Mon, 14 May 2007 02:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758301AbXENApo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 20:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758339AbXENApo
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 20:45:44 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:30979 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757696AbXENApn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 20:45:43 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1233817uga
        for <git@vger.kernel.org>; Sun, 13 May 2007 17:45:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=aMMI7TE+hoq5Z73FteA2v0PXeYhtSxlBI4KfMPMuEDmb2d4cYIWwyjfHdYJ070YnHBGueECbYzb+bAh12MwP5ggItnSJdkXaw8EypqG1sB87z/zi2Suvr2Fip2DExYaOGW3+Pc+rCtDr/A4ABzIhHeki2FuDuPelkmM4tVrz4EE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LHPCrup8vHc56vq6chpHTE7FzNhWAramDz/xM+IGmO2WS7szoDkzC7y5Kmd2ftvhYMghtrxzmwK8jcC8FaWqpLJrb8BG2lIoRgFfWODbvDRvM97w5wI8Dseb8SBGRC2RHL9RRZDuL/27bM7vnff6riorLigT7QGoQg3nzEKihrA=
Received: by 10.66.222.9 with SMTP id u9mr4504662ugg.1179103542491;
        Sun, 13 May 2007 17:45:42 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id 13sm10364767ugb.2007.05.13.17.45.40;
        Sun, 13 May 2007 17:45:41 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070514003910.GA6689@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47208>

Jeff King wrote:

> If you are concerned about the latter, do you mean something like this:
> 
> -- >8 --
> Documentation/git-add: clarify -u with path limiting
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index ea27018..27b9c0f 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -57,8 +57,11 @@ OPTIONS
>  	the index.
>  
>  -u::
> -	Update all files that git already knows about. This is what
> -	"git commit -a" does in preparation for making a commit.
> +	Update only files that git already knows about. This is similar
> +	to what "git commit -a" does in preparation for making a commit,
> +	except that the update is limited to paths specified on the
> +	command line. If no paths are specified, all tracked files are
> +	updated.
>  
>  \--::
>  	This option can be used to separate command-line options from
> 

That is very nice and needed, but I actually thought about correcting
SYNOPSIS to read:

@@ -7,7 +7,9 @@ git-add - Add file contents to the changeset to be committed next
 
 SYNOPSIS
 --------
-'git-add' [-n] [-v] [-f] [--interactive | -i] [-u] [--] <file>...
+'git-add' [-n] [-v] [-f] [--] <file>...
+'git-add' [-n] [-v] [-f] -u [[--] <file>...]
+'git-add' (--interactive | -i)
 
 DESCRIPTION
 -----------

This ensures that while git-add without -u needs explicit paths
(even if it is '.'), git-add with -u can have explicit paths but
doesn't need them.
-- 
Jakub Narebski
Poland
