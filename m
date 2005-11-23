From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb on kernel.org and UTF-8
Date: Wed, 23 Nov 2005 04:35:26 +0100
Message-ID: <20051123033526.GA24098@vrfy.org>
References: <7vzmnw9qo0.fsf@assigned-by-dhcp.cox.net> <4383BEE4.1060800@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 04:36:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EelPu-0007Gb-MD
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 04:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVKWDf1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 Nov 2005 22:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbVKWDf1
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 22:35:27 -0500
Received: from soundwarez.org ([217.160.171.123]:34530 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932495AbVKWDf1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 22:35:27 -0500
Received: by soundwarez.org (Postfix, from userid 2702)
	id 2138824CA; Wed, 23 Nov 2005 04:35:26 +0100 (CET)
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <4383BEE4.1060800@zytor.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12599>

On Tue, Nov 22, 2005 at 04:59:16PM -0800, H. Peter Anvin wrote:
> Junio C Hamano wrote:
> >Is it possible that the UTF-8 check in gitweb running on
> >kernel.org machine is somehow too strict?
> >
> >The following two commits in git.git repository are not showing
> >properly.
> >
> >I have a track record of getting peoples' names wrong, so I
> >double checked my commit objects, and as far as I can tell, all
> >of them are encoded in UTF-8 properly (or at least I can view
> >what I expect if I throw raw bytes from the commit objects at my
> >Firefox):
> >
> >        c3df8568424684bbcc7df7722eb3ec34bdae8b2d
> >
> >        This is from Yoshifuji-san; the third character in
> >        author name field is mangled.
> >
> >	bb931cf9d73d94d9940b6d0ee56b6c13ad42f1a0
> >
> >	This is from Lukas Sandstr*m; o with Umlaut on top is
> >	showing a ?.  Incidentally, the blob that records recent
> >	version of Documentation/git-pack-redundant.txt has his
> >	name in it, which has the same ? problem, but "plain"
> >	option shows his name correctly in UTF-8.
> >
> >Interestingly enough, my name spelled in Japanese
> >(Documentatino/git-lost-found.txt) is intact.  Am I getting a
> >VIP treatment somehow?
> >
>=20
> I think it's missing a "binmode STDOUT, ':utf8';" somewhere...
>=20
> For what it's worth, I looked at both the above examples and the bina=
ry=20
> encoding in the git repository is undoubtedly correct; the two=20
> characters are U+82F1/E8 8B B1 (=E8=8B=B1) and U+00F6/C3 B6 (=C3=B6) =
respectively,=20
> both of which are 100% valid UTF-8.

Should be fine now. The escapeHTML() garbled the utf8 "=C3=B6", and the
decode() failed that.

Thanks,
Kay
