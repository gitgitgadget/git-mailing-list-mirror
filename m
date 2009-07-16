From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v3] Re: git-am: fix maildir support regression: accept
	email file as patch
Date: Thu, 16 Jul 2009 04:06:32 +0200
Message-ID: <20090716020632.GD12971@vidovic>
References: <1654b578a7e045b564c46df4abb6e2196422c2b2.1247696294.git.nicolas.s.dev@gmx.fr> <7v1voheevy.fsf@alter.siamese.dyndns.org> <7vfxcxcxg1.fsf@alter.siamese.dyndns.org> <20090716010001.GC12971@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Thu Jul 16 04:06:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRGMw-0004x3-HG
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 04:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757011AbZGPCGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 22:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757008AbZGPCGi
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 22:06:38 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:27013 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756998AbZGPCGh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 22:06:37 -0400
Received: by ey-out-2122.google.com with SMTP id 9so917323eyd.37
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 19:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=JwjndPlhq+4GC/RnOgqK/89tLE5bdzon3zCeQ35rMSM=;
        b=NkmDSNvJXhaEhGwjGBa+HCDK2hCMkxywmsLtwh53dU7yDmag6eh2xXxEOwz1Fhfqjx
         Wks/16q7T8/R+GcrteWuBcz9m0SkqyLdLgCR+Sya8m2mAPAE67JSCvXxXjSE2Itj2Zum
         r73A7vsieB+rm7L3nGMLOT2m8KngrTqK96oWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eG9RD1/hlOyBPEb91D5NzulpCbsbBM/Z/YiWFPsmZP7anlkd4f3sUfoNVJETMLm8Hy
         A4H2jwf5ZzmoH9uif1AONcp4ZV9KjqH7ChxFD8LyNBTjTnAOWdCXP7cBIti6G3iNycTU
         CsUp5ydPvZPIMXkBK0pGuOApbLLSSwqz3Dnvw=
Received: by 10.210.28.4 with SMTP id b4mr8925678ebb.87.1247709996529;
        Wed, 15 Jul 2009 19:06:36 -0700 (PDT)
Received: from @ (91-164-136-30.rev.libertysurf.net [91.164.136.30])
        by mx.google.com with ESMTPS id 28sm5603665eyg.32.2009.07.15.19.06.34
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 15 Jul 2009 19:06:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090716010001.GC12971@vidovic>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123352>

The 16/07/09, Nicolas Sebrecht wrote:

> It is not about adding a new feature. It's about keeping compatibility
> with maildir. The current version _rejects_ good patches.
> 
> But, as it's very easy to move emails from a maildir _or_ have a symlink
> which links to "maildir/cur" or whatever, we really should rely on the
> content of the files.

Hum, it's not true. 

Symlink as parameter didn't work before. So, it breaks things like:

	$ git am symlink/*
	$ git am directory/{anything relying on shell globbing}
	$ git am patch1 patch2

This was traditionally permitted even if git-am was not designed to. I
wonder if we should add this feature as it could break end-user
workflows.

-- 
Nicolas Sebrecht
