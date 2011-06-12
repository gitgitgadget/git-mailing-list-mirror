From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Best way to check for a "dirty" working tree?
Date: Sun, 12 Jun 2011 17:53:13 +0530
Message-ID: <BANLkTi=-HA1_47DvtGbVHx8twuEAxT8STQ@mail.gmail.com>
References: <4DF381BF.3050301@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Dirk_S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sun Jun 12 14:23:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVjhc-0007hy-Ag
	for gcvg-git-2@lo.gmane.org; Sun, 12 Jun 2011 14:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507Ab1FLMXf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2011 08:23:35 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41455 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475Ab1FLMXe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jun 2011 08:23:34 -0400
Received: by wya21 with SMTP id 21so2681048wya.19
        for <git@vger.kernel.org>; Sun, 12 Jun 2011 05:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=V0Tt0VcAlIowQQp/Xx6kssO8UvB5G5qUBKGhCSbEZlg=;
        b=SNeZXqJrsLjntVtQzNtckvIeSsr28iEpQrz8G/yPJbltiT+qNvy/fujXGzsnvOJEZ5
         7MpFg1l651RPm37RCgDdzEC+M8sLlo2oI+T91ijVNYxCZO+QjaDyNt165PJ2r47qhCwf
         mKXpZUpuTTbv6C8DAN8r3aAX9fcVrbDdQpQVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ainD4eZ4ubKxQ3uIZY3nK2qGM59o1B8pSoRq8gxa4NIzbRrnofKeY7RyYYIPlAgMIh
         /6nGfwVW90moBJfeSw0yfgJVIlZlIh0U8CujUKiGeFrO6frEMrJ6r78Xn5l66JXX/Is6
         OzEGRhIWNBgSMhjX0wPBD86cDbdUyY4AkW9Gw=
Received: by 10.216.212.228 with SMTP id y78mr1471034weo.95.1307881413210;
 Sun, 12 Jun 2011 05:23:33 -0700 (PDT)
Received: by 10.216.1.20 with HTTP; Sun, 12 Jun 2011 05:23:13 -0700 (PDT)
In-Reply-To: <4DF381BF.3050301@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175658>

Hi Dirk,

Dirk S=C3=BCsserott writes:
> A) if ! git diff-index --quiet HEAD -- foo.bar; then
> =C2=A0 =C2=A0 =C2=A0 dirty=3D1
> =C2=A0 fi
>
> and
>
> B) if ! git diff --quiet -- foo.bar; then
> =C2=A0 =C2=A0 =C2=A0 dirty=3D1
> =C2=A0 fi
>
> Both A) and B) work. But which one is better/faster/more reliable? Or=
 is
> there a better solution? For my purpose, I cannot see a difference
> between diff and diff-index, except the syntax.

diff is a more porcelain'ish command, while diff-index is closer to
the plumbing.  Therefore, diff contains some extra argument parsing/
pretty printing code that your script doesn't utilize -- use
diff-index.  Also, look at the various scripts in git.git to see what
they use; for example, require_clean_work_tree in git-sh-setup.sh.

-- Ram
