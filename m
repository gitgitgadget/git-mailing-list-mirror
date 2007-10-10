From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] git-branch: only traverse the requested refs
Date: Thu, 11 Oct 2007 01:30:42 +0200
Message-ID: <8c5c35580710101630r36cff79ax6358416dd4851f48@mail.gmail.com>
References: <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com>
	 <1192053283-2351-1-git-send-email-hjemli@gmail.com>
	 <Pine.LNX.4.64.0710102358110.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Han-Wen Nienhuys" <hanwenn@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 11 01:30:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifl0v-0006aS-F5
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 01:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756850AbXJJXao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 19:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756839AbXJJXao
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 19:30:44 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:11451 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756813AbXJJXan (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 19:30:43 -0400
Received: by wa-out-1112.google.com with SMTP id v27so409526wah
        for <git@vger.kernel.org>; Wed, 10 Oct 2007 16:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3HmEqbn7XRTlsnRVUrCzEvay/xfUT2S6xwTW5qsUvUY=;
        b=Wsk29tBGoyf+TX6xdCE9xxa28wdEPs8TmFmE1zRULh9vv045SP5IhzVT9oWoYDyxt9VYiaQzAuGDNzWmfGyCvdz3Hy9KJiuAcTR6iqyvZcyW1SJg2F9bKxib+XnETg1eAH1b881FvKqx/ucffeXWJlVBGgb8ugyacsvzvirqfRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TSEcW5f2vFtJPjZNIT+0t6uO3/uaOXmm5+NbdT09oR1tgRsXPh650PleggA4VclBmGcLiKxvDMaxNWOKxm/RiVFK0104I43+pPc60fbStAO4ezth3NNAruogF6tR68z6RgBU1EPpzRU2OLxatJpjxCi+GI6EEV4GbWi/GWr4100=
Received: by 10.114.156.1 with SMTP id d1mr1404272wae.1192059042775;
        Wed, 10 Oct 2007 16:30:42 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Wed, 10 Oct 2007 16:30:42 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710102358110.4174@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60565>

On 10/11/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 10 Oct 2007, Lars Hjemli wrote:
> > +     if (kinds & REF_LOCAL_BRANCH) {
> > +             ref_list.kinds = REF_LOCAL_BRANCH;
> > +             for_each_branch_ref(append_ref, &ref_list);
> > +     }
>
> The function for_each_branch_ref() calls do_for_each_ref(), which in turn
> calls get_loose_refs(), which calls get_ref_dir() to read all loose refs,
> if they have not yet been read.

Ok, I'll see if get_loose_refs() could take 'const char *base' and
pass this on to get_ref_dir(), which should solve the problem.

Thanks for noticing.

-- 
larsh
