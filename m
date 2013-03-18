From: zero modulo <zeromodulo@gmail.com>
Subject: Re: Git build fails on `make`, undefined references in libcrypto.a.
Date: Mon, 18 Mar 2013 10:04:17 -0600
Message-ID: <CAA8xkYmcEqt3Bmd3gJvFVL+HeiJOVgYX_01YQ0FYmMc8RnDpuQ@mail.gmail.com>
References: <CAA8xkY==7021SyDmeiOcHMzXbX9L0GgG9yTTED5u1r+tfAPGqg@mail.gmail.com>
	<20130318072933.GC5434@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Mon Mar 18 17:04:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHcYK-0004My-CC
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 17:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169Ab3CRQET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 12:04:19 -0400
Received: from mail-ve0-f169.google.com ([209.85.128.169]:62586 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054Ab3CRQES (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 12:04:18 -0400
Received: by mail-ve0-f169.google.com with SMTP id 15so4458700vea.14
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 09:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=P6EGKrUfAW77F7XE/YiDWRIbx3QTtpaTdBtZg+G1xHw=;
        b=IIBQRyfau+n+ZyASssQ9GDOBNGDtgIJGgnjSZq8ArkIw1uQX2rQWmNF4t+K3eG2wQE
         +6dITuR8AS4Vg22tHFXPgkq1lhZ3qjApXiuGWdXydz2xkVdAhvPV3Uqrlwxu2Xpz1O/7
         IA2igD6OPijRjzYPEAzUe9cD1z88UHQeqtGBgM4HhkRBlXVMB5NByans6oDGWFSzNjLk
         QVQdV+yADeSAbQOIMA0kb3a9OuENerWRPKZAXL8sMrF7xcgHgz9QUGnL5HGMdFOD+GWx
         yCJhmIOIjk0ImFD14eroOb72OLsHwDm+flAuwxgyTS2X1dgAeipnL7LCcNuE06PZtnj/
         bHHA==
X-Received: by 10.52.174.201 with SMTP id bu9mr17876940vdc.45.1363622657542;
 Mon, 18 Mar 2013 09:04:17 -0700 (PDT)
Received: by 10.58.210.233 with HTTP; Mon, 18 Mar 2013 09:04:17 -0700 (PDT)
In-Reply-To: <20130318072933.GC5434@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218424>

On Mon, Mar 18, 2013 at 1:29 AM, Konstantin Khomoutov
<kostix+git@007spb.ru> wrote:
> FYI, I've already tried to answer this exact question [1] with no
> comments from the OP.
>
> 1. http://serverfault.com/a/488604/118848

It is I who posted that question. :P

I haven't made any comments yet because this issue is still a work in
progress. I re-compiled OpenSSL taking into consideration that libdl.a
probably wasn't linked properly to libcrypto.a, and have also tried
re-compiling Git afterward, but with the same errors. I have also
created a .conf file for `ld.so`, and ran `sudo ldconfig` which solved
some other issues I was having. Running `ldd msgfmt` revealed that
run-time libraries were not being found, and after running `sudo
ldconfig`, `ldd msgfmt` then showed the libgettext .so was linked. So,
I solved some of my issues, and if there was an issue with statically
linked libraries not being found, as in this case, then, I believe
re-compiling OpenSSL with the proper LDFLAGS and CPPFLAGS would have
solved the issue, but they have not.

I'm currently attempting to install GCC 4.7.2, which is having some
other issues with texinfo 5.1. I can't find the link, but I someone
said it could be the compiler version... since everything else that
seems like might be the issue isn't fixing it, I'm going to try
re-compiling OpenSSL with GCC 4.7.2 and see how that goes.
