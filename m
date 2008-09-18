From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH (GIT-GUI,GITK) 1/8] git-gui: Cleanup handling of the default encoding.
Date: Thu, 18 Sep 2008 21:00:07 +0400
Message-ID: <bb6f213e0809181000l52c55e8ctdfa49a59002e60cf@mail.gmail.com>
References: <1221685659-476-1-git-send-email-angavrilov@gmail.com>
	 <1221685659-476-2-git-send-email-angavrilov@gmail.com>
	 <20080918150238.GC21650@dpotapov.dyndns.org>
	 <48D281E6.1070204@viscovery.net>
	 <20080918165032.GD21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Paul Mackerras" <paulus@samba.org>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 19:01:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgMsb-0003u6-Ri
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 19:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749AbYIRRAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 13:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754745AbYIRRAM
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 13:00:12 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:61347 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588AbYIRRAK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 13:00:10 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1674157eyi.37
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 10:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=hgZI9OdK/SMuJVq6t3XlypoyFZmEP/yONlWYpqpzGzk=;
        b=IZH8BXs3xDVmCNxtsPADVFKwJdegNBT0ZdtAKQEP3WQghRkKyZchnUAM8t4oiJUsBs
         PlkwFqpV51iRRq0FsjKR+KWpNoxChACE5g+fHtYuyr/Ol68PZ+7zxoDHYkmOlYwyu+Hu
         EZEfivW+CzHS82THCE7p8kyJql4Hv4bnd/huo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nmc1B9jlgj5rErOab2o3Cn6gta8utpQSaA2uw/IYE8k4g75UudRM6NmsnUzP4dLtUN
         g2rlx1M+YD1/JqF2fib66AYebwHw0u+Y5onxduaOFIj+dAYCf2me7lZB6aM+tpVbC+6z
         +xZhQMiWWJoPP6zOntMasH60d1VEgXzYAiD9I=
Received: by 10.103.18.19 with SMTP id v19mr3077043mui.113.1221757207985;
        Thu, 18 Sep 2008 10:00:07 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Thu, 18 Sep 2008 10:00:07 -0700 (PDT)
In-Reply-To: <20080918165032.GD21650@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96219>

On Thu, Sep 18, 2008 at 8:50 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> It is not about how data are stored locale but what is in repository.
> Even if you still have some Linux box with legacy encoding on it, you
> still want to see what in repository, which is mostly likely to be in
> UTF-8. Even if you do not have UTF-8 locale, all decent editors are
> capable to read and store files in UTF-8 (even if it is not your locale),
> and it is really make sense to store files in UTF-8, which makes sense
> because you are going then on a modern Linux, you want to have all data
> in the repository to be in a single encoding, and UTF-8 is the best
> choice for that.

A new user would expect to see his files properly, and they are likely
to be in the locale encoding. And if you know about utf-8, you can
open the Options dialog, and select it explicitly from a menu. And if
you commit a .gitattributes file with encoding specifications to the
repository, it will be used automatically wherever you check it out.

> This patch is certainly a big improvement, as it allows to choose what
> encoding you want to see, but I was not sure that changing the default
> from UTF-8 to the system locale is really a good idea for anything but
> Windows specific projects. Anyway, I have converted all computers that
> I use regularly to UTF-8, so I don't really care...

You are here missing the fact, that the actual current default for
git-gui is not utf-8, but 'binary', essentially equivalent to
ISO-8859-1. UTF-8 was suggested by a patch that has been around in the
'pu' branch since January, and which I took as a base for my series.
Gitk on the other hand uses the locale encoding.

Alexander
