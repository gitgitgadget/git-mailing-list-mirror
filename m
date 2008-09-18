From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH (GIT-GUI,GITK) 1/8] git-gui: Cleanup handling of the default encoding.
Date: Thu, 18 Sep 2008 20:50:32 +0400
Message-ID: <20080918165032.GD21650@dpotapov.dyndns.org>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com> <1221685659-476-2-git-send-email-angavrilov@gmail.com> <20080918150238.GC21650@dpotapov.dyndns.org> <48D281E6.1070204@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 18 18:51:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgMjO-0008QU-Uc
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 18:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195AbYIRQum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 12:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754127AbYIRQum
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 12:50:42 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:53165 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080AbYIRQul (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 12:50:41 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1672517eyi.37
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 09:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dGFc8XlAMTaAJ5poXVBbip78GLKaBQ0BHZolkEVsd8s=;
        b=HhdwYW0qsLGjZeWBS2lU/20YAxiz0/hb0RJO9Huz+FmI4dMKdw6FV1ypGw4xAYHKBO
         PPhmuD/DdUpcvXKg5m78OWY+BATuVe8ITijiE4muDXrRsQFHutvLK4n3PYDi3KsCOwvq
         Hqt4v8/qbPhR/wrcLfmMHzMLk7QfdMRaxZmFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TV/VovpwsqCgNqNpgBwbGvoTXWM89PuYb+uQVgdoP0t9TepC8/xd6CvoWDMgBaA+PF
         d/Zkl/ZkCS7gZ6tBX82u59+A2squQW5aUNR4hpqj+BTlMLH3rVt8uNRTAyR6W0fBNXtt
         jxC/01WHCtntrKLOHghBN/UWhkYrLKXYd/4uU=
Received: by 10.103.119.19 with SMTP id w19mr2271057mum.129.1221756639039;
        Thu, 18 Sep 2008 09:50:39 -0700 (PDT)
Received: from localhost ( [85.141.191.174])
        by mx.google.com with ESMTPS id i5sm24174543mue.11.2008.09.18.09.50.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Sep 2008 09:50:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48D281E6.1070204@viscovery.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96217>

On Thu, Sep 18, 2008 at 06:29:26PM +0200, Johannes Sixt wrote:
> 
> By setting the encoding to "system", "the default" is taken from whatever
> the system's current locale is. If you are on modern Linux, your locale is
> most likely set to UTF8, and everything is fine; you won't observe a
> change in behavior.

That's right.

> But if you are on a system whose locale was not set to UTF8, then you very
> likely did *not* produce UTF8 data, and the display in git-gui was screwed
> because it assumed UTF8. With this change it uses the system's encoding,
> and it is an improvement.

It is not about how data are stored locale but what is in repository.
Even if you still have some Linux box with legacy encoding on it, you
still want to see what in repository, which is mostly likely to be in
UTF-8. Even if you do not have UTF-8 locale, all decent editors are
capable to read and store files in UTF-8 (even if it is not your locale),
and it is really make sense to store files in UTF-8, which makes sense
because you are going then on a modern Linux, you want to have all data
in the repository to be in a single encoding, and UTF-8 is the best
choice for that.

> 
> > If you have systems configured with utf-8 and others (usually old ones)
> > with legacy encoding, you will store files in utf-8 in your repo, thus
> > having utf-8 as the default makes sense for non-Windows platforms.
> 
> How can you know? For example, I've to work with systems that use "legacy
> encodings", and I can't use UTF8 in my data. Hence, the default of UTF8
> was not exactly useful. With this patch series there's now a mechanism
> that allows me to state the encoding per file, and all platforms should be
> able to show the data in the correct way.

This patch is certainly a big improvement, as it allows to choose what
encoding you want to see, but I was not sure that changing the default
from UTF-8 to the system locale is really a good idea for anything but
Windows specific projects. Anyway, I have converted all computers that
I use regularly to UTF-8, so I don't really care...

Dmitry
