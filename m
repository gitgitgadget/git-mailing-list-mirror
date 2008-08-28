From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix use of hardlinks in "make install"
Date: Thu, 28 Aug 2008 16:17:34 +0200
Message-ID: <81b0412b0808280717u78c5ccf8ne1413c701ed8edd9@mail.gmail.com>
References: <81b0412b0808280704h585b6cb4nf03e509de0159a91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 16:22:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYiKd-00045b-AD
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 16:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbYH1ORf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 10:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752420AbYH1ORf
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 10:17:35 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:22933 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbYH1ORe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 10:17:34 -0400
Received: by wa-out-1112.google.com with SMTP id j37so191588waf.23
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 07:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Jd0Enfa3wijsteKur0qFMefDqy1PnWtcfq61aWDuzFs=;
        b=P95A3XMWdmR1nptabHxE2dlV0UxAXbmOccApcEvS+0HZmEN/tEM0bWb+ndzKesEGUr
         wFa4zXZMzVNG/gVXA7aIVKMMQspk9xl20Y4+xekekpGOWJkXooWarcM+VviS0AQSpvrM
         5ngiHpiCdq+WGxhV2SBICIq4yTUhQhiJQMVP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=BsUun+tsQz+DLfQxX8HMdKYPLj4ul5GWDOTLc9DG+2f1wc7p9VZzeDuYopGJsGIF1f
         CZGguO8hUv0JeEgDNm1RGiZsWRVV5s5gNw+SiRp/ART+jhBYvhtRDJ8Enj7rYaTbmm92
         AHauGLTfIGlO+uzDrUauALl2StBys6J05MZK4=
Received: by 10.115.77.3 with SMTP id e3mr1376154wal.43.1219933054073;
        Thu, 28 Aug 2008 07:17:34 -0700 (PDT)
Received: by 10.114.157.9 with HTTP; Thu, 28 Aug 2008 07:17:34 -0700 (PDT)
In-Reply-To: <81b0412b0808280704h585b6cb4nf03e509de0159a91@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94061>

2008/8/28 Alex Riesen <raa.lkml@gmail.com>:
> The code tried to create a hardlink to the file ($execdir/git-add) it just
> removed, so ln failed (but because stderr was redirected into /dev/null the
> error was never seen), and the whole install ended up using "ln -s" instead.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> It created endless symlink loops on cygwin, but obviously nowhere else.
>

Sh@#! Scrap that, there is something else going on in that cygwindows thing...
