From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH v2 5/8] gitweb: Move HTML-formatting diff line back to
 process_diff_line()
Date: Thu, 29 Mar 2012 19:36:58 +0200
Message-ID: <20120329193658.035caa3a@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1332543417-19664-6-git-send-email-michal.kiedrowicz@gmail.com>
	<201203291814.42803.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 19:37:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDJHY-0000K7-O6
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 19:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758145Ab2C2RhE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Mar 2012 13:37:04 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57371 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab2C2RhB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Mar 2012 13:37:01 -0400
Received: by wgbdr13 with SMTP id dr13so1778441wgb.1
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 10:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=M8hYE+AagKhMgeZnz7votizKbE/xHcktPzx937F3+y0=;
        b=DWrE6T+pb/tCiU0OBXn3iVneJEgbZx77WqCsLqL82+FjEQV3YTi1eD/khGwqznflvP
         5tRlfbFYI9tGKBvGF8mVjA1o/9BCvWZoicMOrqX8nqbSO+59J5qLW7ebCMkBTWQx7vOy
         vGY8PV4Cjq5ppbGraZrBgkr2u+Bpmp87D3FMMWrwiFBhrGkEJIAfOI59PWplquM72xpg
         MBdXtMsXc/DPB61/VMzzNtUck8yAUbny+5aWp3bEbXLUCvvB0TBEBSrIAc3Y5oY4TFCG
         Ct/VN59wKtEsUSW0xJf153HGYItTO2KkvSyxqUW41YsfRgADV6eVbGFdp2z2TJ6mgBet
         nJWQ==
Received: by 10.180.88.169 with SMTP id bh9mr7782144wib.5.1333042620734;
        Thu, 29 Mar 2012 10:37:00 -0700 (PDT)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id w10sm31280787wiy.3.2012.03.29.10.36.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 10:37:00 -0700 (PDT)
In-Reply-To: <201203291814.42803.jnareb@gmail.com>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194278>

Jakub Narebski <jnareb@gmail.com> wrote:

> On Fri, 23 Mar 2012, Micha=C5=82 Kiedrowicz wrote:
>=20
> > Commit 6ba1eb51b (gitweb: Add a feature to show side-by-side diff,
> > 2011-10-31) for no special reason moved wrapping diff line in <div>=
 out
> > of format_diff_line(). Bring back old behavior.
> >=20
> I remember that originally process_diff_line was format_diff_line...=20
>=20
> > This simplifies code in git_patchset_body() and keeps formatting of=
 a
> > diff line in one place.
> >=20
> That is a good enough reason for me.
>=20
> > The more long-term purpose of this patch is to move formatting diff
> > lines down to print_diff_chunk(), to allow processing lines without
> > HTML-formatting.
> >=20
> Excuse me, but from this commit message (and from the patch itseld)
> I don't see how this commit (patch) can help with this goal (and
> don't remember details of discussion).
>=20
> Please explain it in more detail, or simply remove above paragraph.

The important part in this patch is that it removes some of HTML
formatting from git_patchset_body().  I need this because I want to
process whole chunk before formatting.  So I must push all lines in a
chunk to print_diff_chunk().=20

But I may remove this paragraph as well.

>=20
> > This is just a refactoring patch. It's not meant to change gitweb
> > output.
> >=20
> > Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
> > Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
> > ---
> [...]
