From: Alexey Borzenkov <snaury@gmail.com>
Subject: Re: [PATCH 04/14] Set _O_BINARY as default fmode for both MinGW and 
	MSVC
Date: Tue, 15 Sep 2009 23:01:43 +0400
Message-ID: <e2480c70909151201t2b23698xb0925fbbebf55ce5@mail.gmail.com>
References: <cover.1253021221.git.mstormo@gmail.com>
	 <213f3c7799721c3f42ffa689498175f0495048eb.1253021728.git.mstormo@gmail.com>
	 <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253021728.git.mstormo@gmail.com>
	 <cover.1253021728.git.mstormo@gmail.com>
	 <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253021728.git.mstormo@gmail.com>
	 <badc5d24387c28c752a45f75e8aec6bce64f81fe.1253021728.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, raa.lkml@gmail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 15 21:01:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MndHj-0002ei-U0
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 21:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614AbZIOTBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 15:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753035AbZIOTBm
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 15:01:42 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:52024 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbZIOTBl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 15:01:41 -0400
Received: by bwz19 with SMTP id 19so3022441bwz.37
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 12:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=GN2KQrQfiqUO7ioi+btLTrnCWDom4QIh5eSGfTDavBE=;
        b=u6Bz9gMKNg0XYTeO1k/R1E5hPOv+hRVdKLxLxQDHI2qSr1R0cXVenG0sz4rFcIlw3U
         V0mz5IvBnM+3tNcx2XVbiWyCmSuYxVpn9wu+DJT/Cn7DBTTppv8fJj5mAvLFjHG52PMj
         PXJh+Lpmw6dSYnAbyfPgzwIlY2h8C9+tqX3BY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=EePaaFQ+N7O2rPxmgK/3FDlJDroOYiXxxa3926HmtjBsElfTAnIBUNBqlWPElnT/a0
         IxufbVtHw6rYiGkeMsGdgRa84khIZwKShdeP8htlE7R8PV8xrz0ujd6daiiJOhAeo0Ei
         mwsO+mnc4rSFZ/m7JifRt+RaZCIYCindrzYX8=
Received: by 10.223.14.22 with SMTP id e22mr2883827faa.42.1253041303952; Tue, 
	15 Sep 2009 12:01:43 -0700 (PDT)
In-Reply-To: <badc5d24387c28c752a45f75e8aec6bce64f81fe.1253021728.git.mstormo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128580>

On Tue, Sep 15, 2009 at 5:44 PM, Marius Storm-Olsen <mstormo@gmail.com> wrote:
> +extern int _fmode;

And indeed. I just ported this patch to my custom msysgit branch
(based on v1.6.4.3) and it didn't compile:

    CC git.o
cc1.exe: warnings being treated as errors
In file included from git-compat-util.h:116,
                 from builtin.h:4,
                 from git.c:1:
compat/mingw.h:243: error: '_fmode' redeclared without dllimport
attribute: previous dllimport ignored
git.c: In function 'main':
git.c:456: error: the address of '_iob' will always evaluate as 'true'
make: *** [git.o] Error 1
