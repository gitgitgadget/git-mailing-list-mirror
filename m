From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Do not build i18n on Windows.
Date: Fri, 13 Aug 2010 22:19:34 +0000
Message-ID: <AANLkTiku5R+idX-C8f0AcCikBLmfEb5ZEhdft+CSRzU0@mail.gmail.com>
References: <201008140002.40587.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Aug 14 00:19:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok2bF-0003U2-14
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 00:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096Ab0HMWTf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 18:19:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64765 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754935Ab0HMWTf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 18:19:35 -0400
Received: by iwn7 with SMTP id 7so239131iwn.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 15:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=t1+5aNkPGjBSJ8rrhnmm+jpJUs5zOzT0BcFWOz1j7Vo=;
        b=W2Jp6d9sGwZwzNJ1x5W84rLe5bqcUM94saC2OEcblIIuR5aZRpvR4Bc8DV2cAMZl+2
         Ldw5SUYy+W7Dym7XoQW5TAl+6NnAoJLJI17zT583STtF3HQnU49T2izZ2PfFmokXcHgr
         qYEVcw+VKIFO6XFxkmJnDIy2SlqRZvNEPtlO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nUckoNdThjbLtzD8pkBeotXllN6IKAgAyhBaNSSbJaShnpy/d693zFbf/ZdRuQP1Y/
         DyzJUYLQ9QD2igmxe51HpV182Ov3CCqpQzxa4QxWruE8RBOtry/rgGyof4JOthE/8i+1
         FYQ8N8hA44CQW/Mt1ySbHG6OjlCAyBXetjQxM=
Received: by 10.231.146.141 with SMTP id h13mr2453706ibv.1.1281737974764; Fri,
 13 Aug 2010 15:19:34 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Fri, 13 Aug 2010 15:19:34 -0700 (PDT)
In-Reply-To: <201008140002.40587.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153519>

On Fri, Aug 13, 2010 at 22:02, Johannes Sixt <j6t@kdbg.org> wrote:
> We do not have the necessary libraries and tools.

Just curious, do you mean Windows / MINGW can't build gettext, or that
you just haven't done so in your build process yet? At least
http://www.mingw.org/wiki/LibrariesAndTools seems to indicate that
libintl has been ported to Windows.

If you're just not interested in building gettext by default on
Windows I think it's completely reasonable to add it to the Makefile
(given that you're probably pretty much the only one doing so). It
would just be useful to clarify the "why".

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> =C2=A0It is necessary to move the first check for NO_GETTEXT after th=
e
> =C2=A0configuration section.
>
> =C2=A0NEEDS_LIBINTL receives a default setting before the configurati=
on
> =C2=A0section (not visible in the patch text), hence, I have to unset=
 it
> =C2=A0when NO_GETTEXT is set. Perhaps you have a better idea to arran=
ge
> =C2=A0these settings.

This seems backwards. Instead of removing the check from the LIB_OBJS
assignment and adding it in later I think we could just move the giant
"Platform specific tweaks" section so that it appears before all those
assignments, and directly after "export PYTHON_PATH".

I tried doing so locally and Git builds and tests fine, but I've only
done so on one platform, so I might have missed something.
