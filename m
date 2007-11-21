From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH RFC] Use "git fetch" when cloning
Date: Wed, 21 Nov 2007 16:04:53 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711211601540.27959@racer.site>
References: <1195659613-5290-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1223936540-1195661093=:27959"
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 17:05:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ius4f-0004sA-Tq
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 17:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755797AbXKUQE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 11:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755835AbXKUQE4
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 11:04:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:37246 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752811AbXKUQEz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 11:04:55 -0500
Received: (qmail invoked by alias); 21 Nov 2007 16:04:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp005) with SMTP; 21 Nov 2007 17:04:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19l60pkCPFlR9HQQ3roXdWvhybuEUddwTuenwYBqs
	20pxw1vHs5/gH5
X-X-Sender: gene099@racer.site
In-Reply-To: <1195659613-5290-1-git-send-email-sbejar@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65671>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1223936540-1195661093=:27959
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 21 Nov 2007, Santi Béjar wrote:

> 1) It always use "git fetch" even if local. So now it checks the validity
>    of the new repo, in particular it does not create a broken repository
>    when there are too many nested alternates.

I doubt that this is a good change.  It will make local clones much, much 
more expensive now.

> 2) It connects with the remote repo when fetching the branches/tags
>    and the remote HEAD.
> 
> 3) The quiet mode of "git fetch" prints the changed branches/tags, so "git clone"
>    prints always the new branches/tags.

These changes would merit a split so that we could cherry-pick what we 
want, and leave what we don't want.

> diff --git a/t/t5710-info-alternate.sh b/t/t5710-info-alternate.sh
> index 699df6e..9b7f638 100755
> --- a/t/t5710-info-alternate.sh
> +++ b/t/t5710-info-alternate.sh
> @@ -53,7 +53,7 @@ git prune'
>  
>  cd "$base_dir"
>  
> -test_expect_failure 'creating too deep nesting' \
> +test_expect_success 'creating too deep nesting' \
>  'git clone -l -s C D &&
>  git clone -l -s D E &&
>  git clone -l -s E F &&
> -- 
> 1.5.3.5.next.428.g67f5d-dirty

What on _earth_?

After thinking a bit harder about it, _and_ reading the commit message, I 
understand why it succeeds now.

But what would you _yourself_ think when reading this part of the code in 
half a year?  Exactly.

Ciao,
Dscho

---1463811741-1223936540-1195661093=:27959--
