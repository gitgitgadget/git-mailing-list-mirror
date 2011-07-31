From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 12/18] revert: Make pick_commits functionally act on a commit list
Date: Sun, 31 Jul 2011 14:08:39 +0200
Message-ID: <201107311408.40079.chriscool@tuxfamily.org>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com> <1311871951-3497-13-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 14:09:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnUpi-000781-1H
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 14:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399Ab1GaMIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 08:08:50 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:53255 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753377Ab1GaMIt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 08:08:49 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 67914A6225;
	Sun, 31 Jul 2011 14:08:41 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <1311871951-3497-13-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178245>

On Thursday 28 July 2011 18:52:25 Ramkumar Ramachandra wrote:
>
> @@ -780,7 +789,13 @@ int cmd_revert(int argc, const char **argv, const char
> *prefix) opts.action = REVERT;
>  	git_config(git_default_config, NULL);
>  	parse_args(argc, argv, &opts);
> -	return pick_commits(&opts);
> +
> +	/*
> +	 * Decide what to do depending on the arguments; a fresh
> +	 * cherry-pick should be handled differently from an existing
> +	 * one that is being continued
> +	 */

It is strange to me that you add this comment only here and not below in 
cmd_cherry_pick(). So I'd suggest to put it before the definition of 
pick_revisions() instead.

> +	return pick_revisions(&opts);
>  }
> 
>  int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
> @@ -791,5 +806,5 @@ int cmd_cherry_pick(int argc, const char **argv, const
> char *prefix) opts.action = CHERRY_PICK;
>  	git_config(git_default_config, NULL);
>  	parse_args(argc, argv, &opts);
> -	return pick_commits(&opts);
> +	return pick_revisions(&opts);
>  }

Thanks,
Christian.
