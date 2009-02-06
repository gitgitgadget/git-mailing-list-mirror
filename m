From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Better regexp for SHA-1 committag match
Date: Fri, 6 Feb 2009 10:12:41 +0100
Message-ID: <200902061012.42943.jnareb@gmail.com>
References: <200902022204.46651.toralf.foerster@gmx.de> <200902031204.21435.toralf.foerster@gmx.de> <alpine.DEB.1.00.0902031327340.6573@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Toralf =?iso-8859-2?q?F=F6rster?= <toralf.foerster@gmx.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 06 10:14:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVMmz-00015b-Ax
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 10:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbZBFJMy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Feb 2009 04:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbZBFJMx
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 04:12:53 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:35826 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbZBFJMv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 04:12:51 -0500
Received: by fg-out-1718.google.com with SMTP id 16so421106fgg.17
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 01:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=QUV+9WQ3/YnjwaioivTwD/ImasV38u3/4/cZhZOUVko=;
        b=wzvdVl43llblTgZ6/mghWS2KN3BkgZkyU5aRoqTiWWg03Fb3Qhpw2N6TuOYB+10vGj
         MlzwCR1NBtB3G2+NF6v4dzj9HwnZggrV/LdyEYkxYkDhfqHqr0qraYNZTqeKw5lTBNkM
         FXnjl1WsxkN86tpIoW4MU8T/16uYorc+v+sPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=tU4JkX2cRq3Yps/3WmUygwlaAcxF/skeoIne1x5B+PjWREmFkAcix6UbhAX1uqwcpT
         1/NILMmx6mssqzlGHlmislYtQXJ2y5TYAx3Oa3xRBg1a1HDE48AgE+3VsRzlXNTjYDRO
         Ha4531oSsATWG2h4OzZb1M7K0Jv+xNMIxm1EU=
Received: by 10.86.51.2 with SMTP id y2mr839407fgy.10.1233911569726;
        Fri, 06 Feb 2009 01:12:49 -0800 (PST)
Received: from ?192.168.1.13? (abuz248.neoplus.adsl.tpnet.pl [83.8.197.248])
        by mx.google.com with ESMTPS id 4sm2648463fge.44.2009.02.06.01.12.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Feb 2009 01:12:49 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.DEB.1.00.0902031327340.6573@intel-tinevez-2-302>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108665>

On Tue, 3 Feb 2009, Johannes Schindelin wrote:
> On Tue, 3 Feb 2009, Toralf F=F6rster wrote:
>> At Monday 02 February 2009 23:54:20 Jakub Narebski wrote :
>>> Toralf F=F6rster <toralf.foerster@gmx.de> writes:

>>>> As seen here
>>>> http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-2.6.27.y.=
git;a=3Dcommit;h=3D8ca2918f99b5861359de1805f27b08023c82abd2 the strings=
 [<c043d0f3>]
>>>> and firends shouldn't be recognized as git hashes, isn't it ?
>>>
>>> Gitweb, not webgit.  And gitweb considers ([0-9a-fA-F]{8,40}) i.e.
>>> from 8 to 40 hexadecimal characters to be (shortened) SHA-1.  It
>>> simply cannot afford checking if such object exists when displaying
>>> commit message (for example in 'log' view).
>>=20
>> Ah - ok, what's about expecting spaces around such SHA-1 keys ?
>=20
> Won't fly: there was a recommendation at some point that you should r=
efer=20
> to commits in such a form:
>=20
> 	2819075(Merge branch 'maint-1.6.0' into maint)
>=20
> However, gitweb being written in Perl, I think a lookbehind like (?<!=
0x),=20
> i.e. that a 0x in front of the hexadecimal characters means it is no=20
> SHA-1.
>=20
> Even better would be using word boundaries, I guess, but all that fai=
ls=20
> when you have a hexdump in the commit message.

Here you have it: anchoring SHA-1 regexp to word boundary. It would
help eliminate _some_ of false matches.

-- >8 --
Subject: [PATCH] gitweb: Better regexp for SHA-1 committag match

Make SHA-1 regexp to be turned into hyperlink (the SHA-1 committag)
to match word boundary at the beginning and the end.  This way we
reduce number of false matches, for example we now don't match
0x74a5cd01 which is hex decimal (for example memory address),
but is not SHA-1.

Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f27dbb6..bec1af6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1364,7 +1364,7 @@ sub format_log_line_html {
 	my $line =3D shift;
=20
 	$line =3D esc_html($line, -nbsp=3D>1);
-	if ($line =3D~ m/([0-9a-fA-F]{8,40})/) {
+	if ($line =3D~ m/\b([0-9a-fA-F]{8,40})\b/) {
 		my $hash_text =3D $1;
 		my $link =3D
 			$cgi->a({-href =3D> href(action=3D>"object", hash=3D>$hash_text),
--=20
1.6.1
