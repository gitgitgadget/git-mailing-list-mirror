From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH 10/15] imap-send.c: rearrange xcalloc arguments
Date: Tue, 10 Jun 2014 14:54:49 -0700
Message-ID: <20140610215449.GA1783@hudson.localdomain>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
 <1401118436-66090-11-git-send-email-modocache@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 00:18:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuU1P-0000iQ-DB
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbaFJVyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 17:54:54 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:42041 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbaFJVyy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:54:54 -0400
Received: by mail-pb0-f44.google.com with SMTP id rq2so6687982pbb.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 14:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=8GmhsoQ0Nll/gEPVEdhqTUHFcZMxUS6Be1C4tbXiyhc=;
        b=pTWG7tODs3/oranjpRBhM9zmpbr9XHMO8hl8KM6bIcdZHawv87+idI+m0gC44OdgW8
         tT4t4tTUzi3TKb98tETOjVFMNFvVBOeLy03ikWzkALOcpKogAfoANbTaopIt1OVFVW1F
         xo7cMsgHSwRc4cuLbZY68pk16ggpPhUbo6aVGkgV4PpmGbGMl4tkRKxRy84sIYQRIlUu
         UUVRkSm4ybKYhESg04bqLxDRyZ65Hd19VXUIuoLvyFd84PInhnKulI+lkh4Ojnb4PS/i
         KMcMnU7UoxE0sqaL9kLVYCo7cCI5s96RkUvR6STfr/SFtXIi/mnDiLUlafq1PqiuLKYQ
         JORw==
X-Received: by 10.68.231.229 with SMTP id tj5mr14451533pbc.101.1402437293606;
        Tue, 10 Jun 2014 14:54:53 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id zn9sm18689513pac.31.2014.06.10.14.54.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Jun 2014 14:54:52 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Tue, 10 Jun 2014 14:54:49 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Brian Gesiak <modocache@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1401118436-66090-11-git-send-email-modocache@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251267>

Brian,

On Tue, May 27, 2014 at 12:33:51AM +0900, Brian Gesiak wrote:
> xcalloc takes two arguments: the number of elements and their size.
> imap_open_store passes the arguments in reverse order, passing the
> size of an imap_store*, followed by the number to allocate.
> Rearrgange them so they are in the correct order.
> 
> Signed-off-by: Brian Gesiak <modocache@gmail.com>
> ---
>  imap-send.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/imap-send.c b/imap-send.c
> index 0bc6f7f..45230e1 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -951,7 +951,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc)
>  	char *arg, *rsp;
>  	int s = -1, preauth;
>  
> -	ctx = xcalloc(sizeof(*ctx), 1);
> +	ctx = xcalloc(1, sizeof(*ctx));
>  
>  	ctx->imap = imap = xcalloc(sizeof(*imap), 1);
                       ^^^^^^^^^^^^^^^^^^^^^^^^

Why wasn't the second instance swapped?  It is still this way in the
latest 'pu' branch.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
