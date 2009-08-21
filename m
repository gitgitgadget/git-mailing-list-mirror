From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: [PATCH 09/14] Avoid including windows.h in winansi.c for MSVC 
	build
Date: Fri, 21 Aug 2009 22:16:15 +0100
Message-ID: <3f4fd2640908211416i489b6e23s27cb9cae6a439ddc@mail.gmail.com>
References: <cover.1250860247.git.mstormo@gmail.com>
	 <af66de324093bbe8f500b1ef20689dd5d355abf4.1250860247.git.mstormo@gmail.com>
	 <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com>
	 <e06c143a91dc2b5b95bcaca42a419d56e25690ac.1250860247.git.mstormo@gmail.com>
	 <07846e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
	 <1c403f4a41f4a210ff15933814bba56495d812d3.1250860247.git.mstormo@gmail.com>
	 <9e8fc158b4d4331d698d1fe4ed33a61fbb011412.1250860247.git.mstormo@gmail.com>
	 <1e623b19b2df001919c83418fef89ef04d7b8dfe.1250860247.git.mstormo@gmail.com>
	 <74ca14c3a691cc9844a0dd806f5db47977317bdb.1250860247.git.mstormo@gmail.com>
	 <7vmy5sdgoc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marius Storm-Olsen <mstormo@gmail.com>, Johannes.Schindelin@gmx.de,
	msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 23:16:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MebTE-0006kT-7x
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 23:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932683AbZHUVQP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2009 17:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932602AbZHUVQP
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 17:16:15 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:41501 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932528AbZHUVQO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2009 17:16:14 -0400
Received: by vws2 with SMTP id 2so895869vws.4
        for <git@vger.kernel.org>; Fri, 21 Aug 2009 14:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7milZreLOR4g17AJv9NChxKC2C1M+Bp5WhTzfeMDZNo=;
        b=DqLn/kTvHkwgLhE6li0SuxGTQN4a/sFxbwIDk0OWJrC1akzXn1e5Q1SA+QGrxY3mjg
         j9GK3yB95IHDcTkirnSY4M2O/DLbnXkrw7W9hUQtFvUqbipQUfolin3hu3s3RjnT3Y8Y
         Kmb1l4HEzMt4EOh4eqS8zUu0RwXgS4Orj9z0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pzrkRNpl6kMvpSiUVZQNnw7GzBxT8j1uzvpV5HHpUEOH/jxWgH2L3CADN1o9Y49x2g
         NKgUh2JvuNinMkSh4ZDXTLLI0po00OIXhtqW8YGRT/FMDiTKS98DHaH+tr0m8Cg6HXDF
         4ZSZj3Ct1jxZPQNtvbGTj/5nDicGy4a+6I/Mc=
Received: by 10.220.113.211 with SMTP id b19mr1605393vcq.60.1250889375156; 
	Fri, 21 Aug 2009 14:16:15 -0700 (PDT)
In-Reply-To: <7vmy5sdgoc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126757>

2009/8/21 Junio C Hamano <gitster@pobox.com>:
> Marius Storm-Olsen <mstormo@gmail.com> writes:
>
>> From: Frank Li <lznuaa@gmail.com>
>>
>> compat/msvc.h includes winsock2.h which conflicts with windows.h.
>> msvc.h also defines the oldest Windows API version required.
>
> The first sentence sort-of makes sense; compat/msvc.h will be include=
d by
> git-compat-util.h and including <windows.h> here will bring conflicti=
ng
> definitions, so we avoid doing so when on MSC.
>
> The second sentence does not make any sense to me. =A0It may be corre=
ctly
> stating a fact (i.e. "defines required WAPI version"), but it is uncl=
ear
> what relevance it has to this change to stop including <windows.h>.

The way things are configured, windows.h is pulling in winsock.h. In
git-compat-util.h, winsock2.h is included which has conflicting
definitions of various functions and data structures.

> Having said that, the first sentence hints me that perhaps you guys s=
hould
> include (conditionally only on windows but not with MSC) <windows.h> =
not
> from this file, but from git-compat-util.h?

It would make sense for windows.h to be included in git-compat-util.h.

According to http://social.msdn.microsoft.com/Forums/en-US/windowssdk/t=
hread/4a90b143-1fb8-43e9-a54c-956127e0c579,
the following will work:

#define _WINSOCKAPI_    // stops windows.h including winsock.h
#include <winsock2.h>
#include <windows.h>

Also, if you define WIN32_LEAN_AND_MEAN, windows.h will pull in a
subset of the Windows header files (which also improves compilation
times). Adding this may prevent it from pulling in winsock.h. This
would be a better approach (and would make sense to go into
git-compat-util.h).

I don't have access to a Windows dev box at the moment, so can't
verify that this does indeed work.

- Reece
