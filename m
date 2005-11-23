From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: gitweb on kernel.org and UTF-8
Date: Tue, 22 Nov 2005 16:59:16 -0800
Message-ID: <4383BEE4.1060800@zytor.com>
References: <7vzmnw9qo0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 02:00:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eeiz1-0005Yn-7s
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 01:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030289AbVKWA7c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 Nov 2005 19:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbVKWA7c
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 19:59:32 -0500
Received: from terminus.zytor.com ([192.83.249.54]:39566 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030289AbVKWA7c
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 19:59:32 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAN0xNSS002672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Nov 2005 16:59:24 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmnw9qo0.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12593>

Junio C Hamano wrote:
> Is it possible that the UTF-8 check in gitweb running on
> kernel.org machine is somehow too strict?
>=20
> The following two commits in git.git repository are not showing
> properly.
>=20
> I have a track record of getting peoples' names wrong, so I
> double checked my commit objects, and as far as I can tell, all
> of them are encoded in UTF-8 properly (or at least I can view
> what I expect if I throw raw bytes from the commit objects at my
> Firefox):
>=20
>         c3df8568424684bbcc7df7722eb3ec34bdae8b2d
>=20
>         This is from Yoshifuji-san; the third character in
>         author name field is mangled.
>=20
> 	bb931cf9d73d94d9940b6d0ee56b6c13ad42f1a0
>=20
> 	This is from Lukas Sandstr*m; o with Umlaut on top is
> 	showing a ?.  Incidentally, the blob that records recent
> 	version of Documentation/git-pack-redundant.txt has his
> 	name in it, which has the same ? problem, but "plain"
> 	option shows his name correctly in UTF-8.
>=20
> Interestingly enough, my name spelled in Japanese
> (Documentatino/git-lost-found.txt) is intact.  Am I getting a
> VIP treatment somehow?
>=20

I think it's missing a "binmode STDOUT, ':utf8';" somewhere...

=46or what it's worth, I looked at both the above examples and the bina=
ry=20
encoding in the git repository is undoubtedly correct; the two=20
characters are U+82F1/E8 8B B1 (=E8=8B=B1) and U+00F6/C3 B6 (=C3=B6) re=
spectively,=20
both of which are 100% valid UTF-8.

	-hpa
