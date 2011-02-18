From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH v2] branch/checkout --track: Ensure that upstream branch
 is indeed a branch
Date: Thu, 17 Feb 2011 19:45:59 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102171937460.14950@debian>
References: <201102151852.03881.johan@herland.net> <201102161146.23749.johan@herland.net> <7vwrkzhc7x.fsf@alter.siamese.dyndns.org> <201102170012.20964.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Feb 18 01:46:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqEU8-00019C-Kl
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 01:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757885Ab1BRAqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 19:46:07 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42556 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757805Ab1BRAqF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 19:46:05 -0500
Received: by vws16 with SMTP id 16so1559173vws.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 16:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=UHsoHFxm23XH/UDjEHY74/H+hR44EzIi61A2V34EFOg=;
        b=YFTDDivqZCmpx8MUX2xldqz6j928+jZQ3lEYlUR9UFeGxmObNFWraTtcBAyP5uE09R
         x4ufrBew7WykTW/hdhCWk+ey8ckEDc7LFJAoEd+xPxv0a+fW4ipGIu2WAqRVvK/xAjm8
         Vx78JoA3iDzd1+QwPQJEq/MktqFzZTCziARog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=wM99P3wrQXtGYatWEXgWqdM3G6f/r3ceMKfn25fzmzh+P7tq1V5MKhIqhYvVYQy8Rg
         Kcc2lCTZRRVvYsyk33LnjXZMDeyVbhjWzHMmPH+AUupfEO4E+OYtVespuPJ4tnO/On8s
         JzjXrso8aielh0H8/cYvEKL5/5h2iagjZNH+U=
Received: by 10.52.160.8 with SMTP id xg8mr153811vdb.7.1297989963014;
        Thu, 17 Feb 2011 16:46:03 -0800 (PST)
Received: from [192.168.1.100] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id u14sm766770vcr.25.2011.02.17.16.46.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 16:46:01 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <201102170012.20964.johan@herland.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167142>

On Thu, 17 Feb 2011, Johan Herland wrote:

> When creating a new branch using the --track option, we must make sure that
> we don't try to set an upstream that does not make sense to follow (using
> 'git pull') or update (using 'git push'). The current code checks against
> using HEAD as upstream (since tracking a symref doesn't make sense). However,
> tracking a tag doesn't make sense either. Indeed, tracking _any_ ref that is
> not a (local or remote) branch doesn't make sense, and should be disallowed.
> 
> This patch achieves this by checking that the ref we're trying to --track
> resides within refs/heads/* or refs/remotes/*. This new check replaces the
> previous check against HEAD.

In some workflows (e.g. Linux kernel, IIRC), it is recommended to base
your work on a tag. Is it worth considering that people might use a
tag as upstream for such cases or would that be considered abuse of
the "upstream" concept? It could make sense to set an upstream to
point to a tag for reference and to be able to use e.g. 'rebase -i
@{u}', 'git log @{u}..' and similar.


/Martin
