From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: rsync a *bunch* of git repos
Date: Tue, 10 Jan 2012 22:00:50 -0000
Organization: OPDS
Message-ID: <25207BDC675840DEA94AA2B04D6783BD@PhilipOakley>
References: <20120110211548.GD10255@titan.lakedaemon.net> <201201102124.q0ALOowL026941@no.baka.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Jason" <git@lakedaemon.net>,
	"Seth Robertson" <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Tue Jan 10 23:00:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkjkV-00027F-F9
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 23:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756590Ab2AJWAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 17:00:50 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:47704 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756357Ab2AJWAt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 17:00:49 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqUIANizDE9cHIYU/2dsb2JhbABDhQ+FTaBzgQiBBoFtAQQBAQQBCAEBGRUeAQEhCwIDBQIBAxUBBAIFIQICFAEEGgYHFwYBCQkIAgECAwEKhS0HgiIJAqVJkSqBL4lOM2MEjTiaDg
X-IronPort-AV: E=Sophos;i="4.71,489,1320624000"; 
   d="scan'208";a="523861813"
Received: from host-92-28-134-20.as13285.net (HELO PhilipOakley) ([92.28.134.20])
  by out1.ip06ir2.opaltelecom.net with SMTP; 10 Jan 2012 22:00:47 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188295>


From: "Seth Robertson" <in-gitvger@baka.org> Sent: Tuesday, January 10, 2012 
9:24 PM
> In message <20120110211548.GD10255@titan.lakedaemon.net>, Jason writes:
>
>    The nuts and bolts of this aren't difficult, the problem is I don't 
> have
>    a complete understanding of how git stores data.  I've heard in the
>    past that it uses a lot of hardlinks and softlinks.  I need to make
>    sure, that once I transfer the data, and reboot the machine with the 
> new
>    partition mounted under /home, that all my git repos will be okay.
>
> Under most circumstances, git will do the right thing.  Only if you
> use specific flags on clone (like --shared or --reference) might
> something go wrong, and as the manual page explains, you can use
> git-repack to undo these.

I think there is an exception for certain git submodule setups with local 
repos, where the gitdir link is hard coded to the absolute machine path. 
There has been some discussion on the list recently about trying to cover 
this case.

>
> The real solution is, after you rsync, to:
>
> for f in */.git; do (cd $f; git fsck >&/dev/null || echo "$f is BAD!!"); 
> done
>
> If you get no output, you should be golden.  If you get output, check
> to make sure the repo you are copying from is good as well.
>
> -Seth Robertson
