From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 2/4] remote: simplify remote_is_configured()
Date: Mon, 15 Feb 2016 21:38:46 +0100
Message-ID: <20160215203846.GD13775@hank>
References: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com>
 <1455558150-30267-3-git-send-email-t.gummerer@gmail.com>
 <20160215182113.GF26443@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 21:38:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVPud-0005yc-VZ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 21:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbcBOUiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 15:38:24 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33358 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbcBOUiX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 15:38:23 -0500
Received: by mail-wm0-f68.google.com with SMTP id c200so17504615wme.0
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 12:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JultWUfbpg2ImJRj96Y54jnvP6GpY2t6rrBRkXM3Ld8=;
        b=PbZpS4MoWXQnyxpmL/fDQQYjBfbJ2cw6KLZCqMeuouApPAQcPcePMaQcxBldjDleLl
         dHQSg961Xi9cKtQB+wDKmdA0Tg4RkI2yFERTHWVGHMLI/1bPFIUrcr5VwCT4IW0OWImf
         BNz2VJqpd2oYlwiosrsRE/S8mjTfEKU04NTt3HpGAznb1/cMBWyWn4y7Id25w3Y5gLcx
         QpFkLwdyKgcrgchpiPbf+NmWq2JqXfPGENCXutsbkoY+uKEUSH8CygPbiw75KTEOIf4Q
         lIiPkv6C0UclbdxJw81F8r83/6kdPkG2yt1EsrWLlQqr2gwKxUXEMmXhK6c7jObxrZVK
         6viQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=JultWUfbpg2ImJRj96Y54jnvP6GpY2t6rrBRkXM3Ld8=;
        b=P2HQ9wCqM8NqS32D2t37JOITb5JDnLhVS1tM2I/ACItaW2CZh2zVndhM6ypd1Q6OME
         oai/XgvlMJA+QIwPyy865seb5g2kxjUJUxX7o7kbiIhxmwUieE3sj/TrrWIllbR3IK44
         JQToDCvXV6K8aPCVnujlqWxRBA/gL84gVOyRLpal2eikca5K9txcUQYKdV3Cwq467lfK
         kNgS2h3h6N3YGXAR7AZwryY1qLXsbApJRFSav5n+B0ffesj2KK5mN9b7VP4hv6IhtLTG
         qtiyqJ9g6rQTLsnTxztMuc+P97nSZC9fy/QK+80UxnZenH8ZswKLJCmprmgDLWjSCSYZ
         mk7g==
X-Gm-Message-State: AG10YOTP01R7XrdEqpuiIylhjx5zXAHLK+jyeoea9/lLjXjj/SIf0wsMKgof/62IiueZPA==
X-Received: by 10.194.57.138 with SMTP id i10mr18401327wjq.104.1455568702336;
        Mon, 15 Feb 2016 12:38:22 -0800 (PST)
Received: from localhost (host186-106-dynamic.41-79-r.retail.telecomitalia.it. [79.41.106.186])
        by smtp.gmail.com with ESMTPSA id lz5sm99484wjb.5.2016.02.15.12.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 12:38:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160215182113.GF26443@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286237>

On 02/15, Jeff King wrote:
> On Mon, Feb 15, 2016 at 06:42:28PM +0100, Thomas Gummerer wrote:
>
> > The remote_is_configured() function allows checking whether a remote
> > exists or not.  The function however only works if remote_get() wasn't
> > called before calling it.  In addition, it only checks the configuration
> > for remotes, but not remotes or branches files.
> >
> > Make use of the origin member of struct remote instead, which indicates
> > where the remote comes from.  It will be set to some value if the remote
> > is configured in any file in the repository, but is initialized to 0 if
> > the remote is only created in make_remote().
>
> Makes sense. I wonder if we would want to give this an explicit slot in
> the enum. I.e.:
>
> > diff --git a/remote.h b/remote.h
> > index 4fd7a0f..7a5ee77 100644
> > --- a/remote.h
> > +++ b/remote.h
> > @@ -5,7 +5,7 @@
> >  #include "hashmap.h"
> >
> >  enum {
> > -	REMOTE_CONFIG,
> > +	REMOTE_CONFIG = 1,
> >  	REMOTE_REMOTES,
> >  	REMOTE_BRANCHES
> >  };
>
> Add in "REMOTE_UNCONFIGURED = 0" here. It makes no difference to
> correctness, but is perhaps documents what is going on a bit better.

Agreed, will change.  Thanks.

>
> -Peff
