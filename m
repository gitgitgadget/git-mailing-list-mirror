From: Elijah Newren <newren@gmail.com>
Subject: Re: [RFC PATCH 0/2] Fix unnecessary updates of files during merge
Date: Sat, 26 Feb 2011 11:43:10 -0700
Message-ID: <AANLkTiknGZ-WQrwhtX9rJ=k1z7p3cYCE-j8F7rt4UL+M@mail.gmail.com>
References: <20110224115233.GA31356@sigill.intra.peff.net>
	<1298745297-25713-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 26 19:43:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtP6q-0004xi-KV
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 19:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374Ab1BZSnM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Feb 2011 13:43:12 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44047 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab1BZSnL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Feb 2011 13:43:11 -0500
Received: by fxm17 with SMTP id 17so2685102fxm.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 10:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KUP4yCGrgj3T5LBlPUk39ry21kxX0ixiBBRp5zv9Xl8=;
        b=rQEUI6JRkCFejd/+0W5e32HwiFwmEKUP9d+5pO35jwxVpAlcRegBmtUUwaLnjiqYo5
         sLAUQy3VkJkv+mI4bHCwXZT/n9RKjEenp3r9H/LTZFYzwmWmw5GetGhlNtftni+btCfE
         Irt4GpxRZHx4SUc2wCywKnocwr41dcYFUfLZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mefR7dq4Rx5DaaGLjuHG5bXV+kKtdsKxlRLtLXDJwmdeDCsSSvnSgMOXl6DRv+VtrA
         2wvWp65mjE2fpGa8tLHuinAfIm1/oP1L2OnpJYTiFoN6jmT1tVzUwN4WtSvwol2u1IJG
         qu5H8jj9ulNA+hOBQduP4uIE2UHj2Ki0FvkSM=
Received: by 10.223.74.15 with SMTP id s15mr4362687faj.28.1298745790107; Sat,
 26 Feb 2011 10:43:10 -0800 (PST)
Received: by 10.223.75.136 with HTTP; Sat, 26 Feb 2011 10:43:10 -0800 (PST)
In-Reply-To: <1298745297-25713-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167989>

Hi,

On Sat, Feb 26, 2011 at 11:34 AM, Elijah Newren <newren@gmail.com> wrot=
e:
> This patch series adds a simple testcase demonstrating the problem
> reported by Stephen Rothwell, and a fix. =C2=A0Unfortunately, there's=
 a bug
> with the fix (hence the RFC) that makes the relevant files racily cle=
an
> rather than clearly clean (i.e. 'git diff-files' will report these fi=
les
> as modified when it shouldn't).
>
> I'll try to figure out how to fix the second problem in the next few
> days. =C2=A0If anyone has some hints, I'm all ears.

And, of course, I forgot to include the cc's in my send-email command.
 Sorry about that, Stephen and Jeff.  Adding you on this email, at
least.

> Elijah Newren (2):
> =C2=A0t6022: New test checking for unnecessary updates of renamed+mod=
ified
> =C2=A0 =C2=A0files
> =C2=A0merge-recursive: When we detect we can skip an update, actually=
 skip
> =C2=A0 =C2=A0it
>
> =C2=A0merge-recursive.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A07 +++++--
> =C2=A0t/t6022-merge-rename.sh | =C2=A0 32 +++++++++++++++++++++++++++=
+++++
> =C2=A02 files changed, 37 insertions(+), 2 deletions(-)
