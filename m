From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/6] Add string comparison functions that respect the
 ignore_case variable.
Date: Sun, 29 Aug 2010 19:39:34 +0000
Message-ID: <AANLkTimtmudtWccRS==LrO_JrPmAJ7HzA6CU0ALbDZcV@mail.gmail.com>
References: <cover.1281985411.git.j6t@kdbg.org>
	<4C6C01A9.4080306@workspacewhiz.com>
	<AANLkTinwQqwjmeNfiUE6LiZtbBhEEFyisZXUgF9_b+2Q@mail.gmail.com>
	<201008182032.40375.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Aug 29 21:39:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpnjC-0000Ro-0U
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 21:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992Ab0H2Tjg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 15:39:36 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51532 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897Ab0H2Tjf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 15:39:35 -0400
Received: by ywh1 with SMTP id 1so1411751ywh.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 12:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AiEBBafKZMlqXk4TdtKP7z4FeaUpTCxNS+mAR/EghyI=;
        b=o1p37x1hESzI9K5zRE6wObcUgvbEFDUPz1qkfxhTA2ANBlLvWgXWR/g8o+LLJvzgw1
         lplgJfpQLO5paFvfh2nmF96sU5v7ruk+RwnmR6sftiD1eniwKTQ1684wLtbNkIkvMUyG
         QFtJ9H15GqN4Nh8Wjh4ShPcrCB+9EIfI9JFpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wVnIT4zuMYSz5OunHY/gsvakufpG0T7WJ4Rx69ZxNbPYNr/k4yGYdSwdV8EfO6sXEa
         rKvqOlQZYKpzHjlf4vlHu1naEQ5jqo4VQng1wp3Z4I3/xQkQTlr615UE3u7f5CXL6a0V
         WTpELWPhk5T2XoILapZ0avn+inc6d1YvTeGZI=
Received: by 10.100.31.14 with SMTP id e14mr3486872ane.46.1283110775040; Sun,
 29 Aug 2010 12:39:35 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sun, 29 Aug 2010 12:39:34 -0700 (PDT)
In-Reply-To: <201008182032.40375.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154706>

On Wed, Aug 18, 2010 at 18:32, Johannes Sixt <j6t@kdbg.org> wrote:
> On Mittwoch, 18. August 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
wrote:
>> According to some further research at least FreeBSD and NetBSD have
>> copied this GNU extension. You may find their versions easier to
>> integrate.
>
> We already have a GNU fnmatch in compat/fnmatch.

Do you have any plan to deal with this? I currently have this
monkeypatch to build on Solaris:

    diff --git a/Makefile b/Makefile
    index 62d526a..079fae5 100644
    --- a/Makefile
    +++ b/Makefile
    @@ -863,2 +863,4 @@ endif
     ifeq ($(uname_S),SunOS)
    +       COMPAT_OBJS =3D compat/fnmatch/fnmatch.o
    +       COMPAT_CFLAGS =3D -Icompat -Icompat/fnmatch
            NEEDS_SOCKET =3D YesPlease

One way to deal with it would be a new NONGNU_FNMATCH=3DUnfortunatelyYe=
s
flag, or the fnmatch_icase() suggestion above which we could bundle
and always use. But having next build on systems without GNU
extensions would be preferrable.
