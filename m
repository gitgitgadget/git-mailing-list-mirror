From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] Fix 'git clean' failure on NFS.
Date: Fri, 18 Jun 2010 14:29:38 +0200
Message-ID: <AANLkTimm1XMmDORpnezYHSNPrKFup2H5ODQLrgJivDwg@mail.gmail.com>
References: <loom.20100618T122039-876@post.gmane.org>
	<1276859235-13534-1-git-send-email-edwintorok@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?ISO-8859-1?Q?T=F6r=F6k_Edwin?= <edwintorok@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 18 14:29:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPahe-0006uA-9x
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 14:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761151Ab0FRM3l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jun 2010 08:29:41 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:37650 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758377Ab0FRM3k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jun 2010 08:29:40 -0400
Received: by wwb22 with SMTP id 22so101065wwb.19
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 05:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=0WaRRod3WoK30Gcaw78kDQ+xq6PSgh/quWDZP6eCCOs=;
        b=chVdKJWsdR4+h24SOVb1IbqL2JNKkVBSIGVNC9y3iXahNCZ+gxA9npJPR8DLg2mCEd
         rxEE8qgQzN1EEWnwyyCWuI+Uk2pMiVhWrLFYSvPinASez6abnKLv4E4ZX4dz6QNKOVDb
         A/IgFkcbG5WJeZwz+g49NNsceQLzBRFPYPsy4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=t3Wl2zI0u9b7llQkK2Vcobckfmj3BMx+yTVqXFVkNWWy/EAd3L0PpQNSzVICthwvDE
         AA1Qykhz2uSqDaA61U1J4d4AmydRKUutH97DrP8CgAs4AiUXolGiEIyJvjLoOL/n2G3q
         UkrdVc71Lw5qCe0ny9gmmWdp7UyM3w6pscLx8=
Received: by 10.216.90.18 with SMTP id d18mr124546wef.79.1276864178325; Fri, 
	18 Jun 2010 05:29:38 -0700 (PDT)
Received: by 10.216.53.132 with HTTP; Fri, 18 Jun 2010 05:29:38 -0700 (PDT)
In-Reply-To: <1276859235-13534-1-git-send-email-edwintorok@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149343>

2010/6/18 T=F6r=F6k Edwin <edwintorok@gmail.com>:
> readdir() used to do a single pass, which is not always enough.
> If you unlink some files/rmdir some subdirs then there might be some
> files you haven't seen yet *before* the readdir cursor (files get rea=
rranged
> in the directory, etc.).
>
> The fix is to do an additional readdir() pass if we unlinked/rmdired =
something.
> This is easily accomplished by using rewinddir.
>

Won't this break on Windows? mingw_readdir() doesn't seem to have a
maching mingw_rewinddir() in compat/mingw.c/h....

--=20
Erik "kusma" Faye-Lund
