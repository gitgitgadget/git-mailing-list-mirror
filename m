From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH 2/2] Re: rebase -i: explain how to discard all commits
Date: Thu, 20 Jan 2011 20:39:23 +0100
Message-ID: <20110120193923.GA14184@vidovic>
References: <vpq62ziv788.fsf@bauges.imag.fr>
 <1281453472-29835-1-git-send-email-Matthieu.Moy@imag.fr>
 <20110116015941.GA28137@burratino>
 <20110116020207.GC28137@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	gitster@pobox.com, Kevin Ballard <kevin@sb.org>,
	Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 20 20:39:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg0M7-0003p9-6P
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 20:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238Ab1ATTje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 14:39:34 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45250 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082Ab1ATTjd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 14:39:33 -0500
Received: by wyb28 with SMTP id 28so982218wyb.19
        for <git@vger.kernel.org>; Thu, 20 Jan 2011 11:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Ev4txGFGaTLibxaILo6Xt6AMOZmdb9/sKISU70xYVTU=;
        b=IJqFR0+KYS2xDUKliZJokxT+xV0q79smWNYV9N2Knruui0wXk8HXB9l3KFl/9ueujR
         euXJGzloAE9Vdw8IDJt48R79BpGp8NJy2a32z5KFyOo0+NprMEJGPpNJJGEhwyFi7NL1
         fDnaoifsxYgqSWHilLZ91MI8xHITzP6p1w4Ik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pTEga+/OYMyR/hVYghIy/1C4RR3/hgBbf8cwPI7dVd/ebequeJ7bYvo1JvDy78Y2b3
         f89ZmCNJS7Dvg6LodLiNl6r2+c9vpnVX9i2xeZJwm8s/3IlnLSeHbk33ryxLXCvLYwkT
         10wzm6p1YKnShzW8ye35rP0k2z4NxIl0q8wdE=
Received: by 10.227.155.140 with SMTP id s12mr2838111wbw.153.1295552371827;
        Thu, 20 Jan 2011 11:39:31 -0800 (PST)
Received: from vidovic (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id m13sm6259079wbz.21.2011.01.20.11.39.27
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 20 Jan 2011 11:39:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110116020207.GC28137@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165325>

The 15/01/11, Jonathan Nieder wrote:
> Preparing a patch series for submission (as explained under
> INTERACTIVE MODE in the git rebase manual) sometimes involves
> discarding commits representing changes that turned out to be a bad
> idea.  Usually this is quite simple to do by deleting the appropriate
> "pick" lines, but if all commits are removed then the "remove
> everything means abort" logic kicks in and the rebase is cancelled.
> One can override that behavior by adding a line with the text "noop".
> 
> This is a follow-up to v1.6.0.3~21 (rebase -i: do not fail when there
> is no commit to cherry-pick, 2008-10-10).
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  git-rebase--interactive.sh |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 09aeecf..d9dfc75 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -1025,6 +1025,7 @@ first and then run 'git rebase --continue' again."
>  #
>  # If you remove a line here THAT COMMIT WILL BE LOST.
>  # However, if you remove everything, the rebase will be aborted.
> +# Use the "noop" command if you really want to remove all commits.
>  #
>  EOF

Sorry, I think it is confusing. With this help we could understand that
the "noop" will either

  (a) discard the interactive rebase

or

  (b) _really remove commits_ from that branch

I'm not sure to know how it will act myself. If (a), we could use
something like

  "However, if you remove everything or use the "noop" command, the rebase will be aborted."

but if we are in case (b), I guess it is not necessary and we should
point to the 'git reset' command.

-- 
Nicolas Sebrecht
