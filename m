From: Christian Himpel <chressie@googlemail.com>
Subject: Re: [PATCH] git-am: force egrep to use correct characters set
Date: Mon, 28 Sep 2009 08:55:19 +0200
Message-ID: <20090928065519.GA24773@lamagra.informatik.uni-ulm.de>
References: <215cc4f241162377b9249c2b3d74050cc77bac16.1253893253.git.chressie@gmail.com>
 <f0bd48168975c3b2328cf26f9a37a0f54b898473.1253896646.git.chressie@gmail.com>
 <20090927074015.GB15393@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Himpel <chressie@googlemail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 28 08:55:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsA90-0001fy-Ve
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 08:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbZI1GzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 02:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbZI1GzY
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 02:55:24 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:43375 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbZI1GzX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 02:55:23 -0400
Received: by fxm18 with SMTP id 18so3429161fxm.17
        for <git@vger.kernel.org>; Sun, 27 Sep 2009 23:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1BU4JqnBoCuqyTisk3N8GbvjiEaXK8d8EEy0Tc+9pmo=;
        b=P5XvAjyRT/shiqv71zv6jKvO19nWU0zim/nFliQcSQAY57x3J0EquIoixupupxeQsk
         yJaaYknmBdPTvdyVHLC50HUFB28O/zFHrsGZomwl4zlqlayh5wsCPEvk4LB0BtVtJTy7
         83Q8/HYPRXHMtReL/JuZYqqzo0+N9eIVM9uLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QXF0prdNJjfrvENtLD4XzZ3/wTmjOFZfe9fGa5HncCP69DxXhyEHu57SiwvfuqG6tt
         UV39/4j8yZWqkrmizuyzzYXgQyoBy3QPmx0YSSvMpVNHdaGdpBV+QCFGNHkfnIG1PVzp
         PmERQe1b+iTyRC2hbHEicuOoFggYENNk/3kVQ=
Received: by 10.204.19.132 with SMTP id a4mr2720202bkb.21.1254120926272;
        Sun, 27 Sep 2009 23:55:26 -0700 (PDT)
Received: from lamagra.informatik.uni-ulm.de (lamagra.informatik.uni-ulm.de [134.60.77.31])
        by mx.google.com with ESMTPS id 13sm4382726fks.50.2009.09.27.23.55.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 27 Sep 2009 23:55:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090927074015.GB15393@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129230>

On Sun, Sep 27, 2009 at 03:40:15AM -0400, Jeff King wrote:
> On Fri, Sep 25, 2009 at 06:43:20PM +0200, Christian Himpel wrote:
> 
> > According to egrep(1) the US-ASCII table is used when LC_ALL=C is set.
> > We do not rely here on the LC_ALL value we get from the environment.
> 
> Hmm. Probably makes sense here, as it is a wide enough range that it may
> pick up other stray non-ascii characters in other charsets (though as
> the manpage notes, the likely thing is to pick up A-Z along with a-z,
> which is OK here as we encompass both in our range).
> 
> There are two other calls to egrep with brackets (both in
> git-submodule.sh), but they are just [0-7], which is presumably OK in
> just about any charset.
> 
> Do you happen to know a charset in which this is a problem, just for
> reference?

No, I don't know any charset with stray ascii-chars.  I just listened
attentively, when I read the part about the mixed alphabet characters in
the grep(1) manpage.

I did some quick checks just now.  It seems the characters (' ' to '~')
are in any locale, offered by glibc, at the same place.

Maybe, we can just leave the charset as it is and ignore this patch,
until someone complains.


Regards,
chressie

> 
> -Peff
