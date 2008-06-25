From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] daemon: accept "git program" as well
Date: Wed, 25 Jun 2008 19:02:28 -0400
Message-ID: <20080625230228.GR11793@spearce.org>
References: <7v1w2m8ahi.fsf@gitster.siamese.dyndns.org> <7vprq66vqd.fsf_-_@gitster.siamese.dyndns.org> <20080625034538.GW11793@spearce.org> <7vk5ge6soc.fsf@gitster.siamese.dyndns.org> <20080625044409.GE11793@spearce.org> <7v8wwu6qxr.fsf@gitster.siamese.dyndns.org> <7v4p7i6qs1.fsf@gitster.siamese.dyndns.org> <7vy74u5bkk.fsf@gitster.siamese.dyndns.org> <20080625053848.GJ11793@spearce.org> <7v4p7hxhbd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@lavabit.com>,
	Miklos Vajna <vmiklos@frugalware.org>, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 01:03:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBe1l-0001uM-5I
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 01:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbYFYXCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 19:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbYFYXCp
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 19:02:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50537 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbYFYXCo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 19:02:44 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KBe0J-0004Fl-Pf; Wed, 25 Jun 2008 19:02:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2E54B20FBAE; Wed, 25 Jun 2008 19:02:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v4p7hxhbd.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86364>

Junio C Hamano <gitster@pobox.com> wrote:
> This is a step to futureproof git-daemon to accept clients that
> ask for "git upload-pack" and friends, instead of using the more
> traditional dash-form "git-upload-pack".  By allowing both, it
> makes the client side easier to handle, as it makes "git" the only
> thing necessary to be on $PATH when invoking the remote command
> directly via ssh.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Obviously correct.  Ack.  Thanks Junio.


>  So this obviously needs to be queued to 'maint' to be included in 1.5.6.1
>  and 1.6.0.
> 
>  daemon.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/daemon.c b/daemon.c
> index 63cd12c..621c567 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -586,7 +586,7 @@ static int execute(struct sockaddr *addr)
>  	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
>  		struct daemon_service *s = &(daemon_service[i]);
>  		int namelen = strlen(s->name);
> -		if (!prefixcmp(line, "git-") &&
> +		if ((!prefixcmp(line, "git-") || !prefixcmp(line, "git ")) &&
>  		    !strncmp(s->name, line + 4, namelen) &&
>  		    line[namelen + 4] == ' ') {
>  			/*

-- 
Shawn.
