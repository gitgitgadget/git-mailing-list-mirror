From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Read several objects at once with git cat-file --batch
Date: Sun, 10 Aug 2008 23:25:08 +0100
Message-ID: <b0943d9e0808101525w1e6f1e60h162a4b137d6dca6c@mail.gmail.com>
References: <20080808082728.GA24017@diana.vm.bytemark.co.uk>
	 <20080808080614.23424.28169.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 00:26:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSJMa-0008K9-Eg
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 00:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbYHJWZK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Aug 2008 18:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753396AbYHJWZK
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 18:25:10 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:63889 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbYHJWZI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Aug 2008 18:25:08 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1962659rvb.1
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=GxzC1DVEhuYyQSV/p1M2Li5wx3GSQByFlEw+kHVsMNY=;
        b=NsNMod+da/8VpNn1IYFsG99J9Cq8Mw6Oi+BAZKt/PuOT6YK56Jk+db/EgBuS7pqXl3
         xZk5WXcK/rTft8cYta6BXIx4LGfniLNZvsMUzVUl4OxiXJPFOIVXJHeZ7s+AC4zYCZyN
         EHij9DMndN94ks++p76zhwL3kNGqTtpSr21Z8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=x2vekVl/qvq9+Ean0eWeNWxaQ5J/EueDv0ifEtVLDKnJJWmEtXwpBhCv+Fxo4i5XnY
         wsI5k9zrnaRaEGYndsUU5hy71J1yExMpsAH1xwJodzh3gZEHtwLoIO4sCgTy1VU31/dP
         l9tOBYagLV8a3HqAdI7juQZsZGX097frSc2ls=
Received: by 10.114.147.7 with SMTP id u7mr2995461wad.188.1218407108313;
        Sun, 10 Aug 2008 15:25:08 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Sun, 10 Aug 2008 15:25:08 -0700 (PDT)
In-Reply-To: <20080808080614.23424.28169.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91893>

2008/8/8 Karl Hasselstr=F6m <kha@treskal.com>:
> Instead of spawning a separate cat-file process for every blob and
> commit we want to read. This speeds things up slightly: about 6-8%
> when uncommitting and rebasing 1470 linux-kernel patches (perftest.py
> rebase-newrebase-add-file-linux).

Which version of Git got the --batch option to git-cat-file? It might
be possible that default Git in Debian (testing) or Ubuntu doesn't
have this option. Maybe we could still have the original behaviour as
a fallback.

Otherwise, the patch looks allright. It took me a bit of time to see
why we need the new run_background() function (but in my current Git,
1.5.3.4.206.g58ba4, there wasn't such an option; I had to upgrade).

Thanks.

--=20
Catalin
