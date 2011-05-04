From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC] git-send-email: Do not encode Subject if not required (was: git-send-email and non 7bit clean message)
Date: Wed, 4 May 2011 15:50:12 +0200
Message-ID: <201105041550.16355.jnareb@gmail.com>
References: <1304099521-27617-1-git-send-email-jnareb@gmail.com> <BANLkTi=cckKr3baDZAktAjz8F=JXjQJWiA@mail.gmail.com> <201105031602.30874.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Greg Kroah-Hartman <greg@kroah.com>,
	Ryan Anderson <ryan@michonline.com>
To: =?utf-8?q?=C3=98yvind_A=2E_Holm?= <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Wed May 04 15:50:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHcTD-0002QH-KY
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 15:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537Ab1EDNuX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 May 2011 09:50:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44741 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969Ab1EDNuW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 09:50:22 -0400
Received: by fxm17 with SMTP id 17so832834fxm.19
        for <git@vger.kernel.org>; Wed, 04 May 2011 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=tTSfzbQydv6tFiShrxyAOphljQ7BjJW26/taPdjE75U=;
        b=EqamCk6dlB5C/tIYcuO4WxiA/2ZOwgmmBuWdWwKEfV4gI35v8fXyWKNjuM+6xLJ1Hm
         fFsdaksAlmm1oiQmwe2pDoEbg905Wp4iwrieZbrrHfijevbTeczdi1sw3n7CEUvir4uj
         Mm1asyyU6JEdo0SRw3/dKIHnw7oa9lps+cJCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BOm9Xgd7AUguCd8awD6yoH/40SzWZ1jBINPWtvNaAcF0H2rpTc+tOQCYYL7tzAEAVK
         N6qSO7E/PjZqwWruFA4M/Ab/jow8fTR5NcpUpnryXymSCDNlyirMndRqKJjkbOFlXJTS
         RgmeCCHN2hfHHy+yMBX4lRKqviepnmrmaJAK0=
Received: by 10.223.57.134 with SMTP id c6mr1344756fah.34.1304517020844;
        Wed, 04 May 2011 06:50:20 -0700 (PDT)
Received: from [192.168.1.13] (abvb15.neoplus.adsl.tpnet.pl [83.8.199.15])
        by mx.google.com with ESMTPS id x16sm405111fal.19.2011.05.04.06.50.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 04 May 2011 06:50:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201105031602.30874.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172742>

On Tue, 3 May 2011, Jakub Narebski wrote:
> On Sat, 30 Apr 2011, =C3=98yvind A. Holm wrote:
> > On 29 April 2011 23:31, Junio C Hamano <gitster@pobox.com> wrote:

> > > A tangent. It is curious why [PATCH 2/6] alone ended up with an e=
ncoded
> > > "Subject" header, like this:
> > >
> > > =C2=A0Subject: =3D?UTF-8?q?=3D5BPATCH=3D202/6=3D5D=3D20gitweb=3D3=
A=3D20Change=3D20the=3D20
> > > =C2=A0 way=3D20=3D22content=3D20tags=3D22=3D20=3D28=3D27ctags=3D2=
7=3D29=3D20are=3D20handled?=3D
> > >
> > > The message actually has the above as a long single line, as can =
be seen at
> > > http://article.gmane.org/gmane.comp.version-control.git/172479/ra=
w
> > >
> > > Just being curious.
> >=20
> > This seems as the same thing that I reported on 2010-04-25 23:35:49=
Z,
> > <http://thread.gmane.org/gmane.comp.version-control.git/145774>. If=
 there's a
> > character above U+007F in the log message below line #2, the Subjec=
t: line is
> > garbled. In this case it is, it's the "=C3=B6" in Uwe's name that l=
eads to this
> > error.

Note: this line was added "by hand" when editing patch, so commit messa=
ge
that git-format-patch seen did not contain any non-ASCII characters.
Otherwise fir-format-patch would add correct MIME headers itself.

> > A test to reproduce this is at <https://gist.github.com/378785>, bu=
t it seems
> > as this was fixed between v1.7.4.1-292-ge2a57aa and v1.7.4.1-343-ga=
91df69 ,
> > probably happened in dc7f96f (Merge branch 'jk/format-patch-multili=
ne-header').
> > The patch at <http://article.gmane.org/gmane.comp.version-control.g=
it/172479/raw>
> > was generated with git-1.7.3, so it would trigger the error in this=
 case.
>=20
> I have just upgraded git to 1.7.5, and unfortunately it still has the
> same bug (note that UTF-8 character was introduced while editing patc=
h,
> so git-format-patch doesn't see it):
>=20
>   5369:[gitweb/web@git]# git send-email [...] --dry-run mdir.1/*.txt
>   The following files are 8bit, but do not declare a Content-Transfer=
-Encoding.
>       mdir.1/0001-gitweb-Prepare-for-splitting-gitweb.txt
>   Which 8bit encoding should I declare [UTF-8]? <ENTER>
>   Dry-Sent [PATCHv2 0/2] gitweb: Beginnings of splitting gitweb into =
modules
>   Dry-Sent =3D?UTF-8?q?=3D5BPATCHv2=3D201/2=3D20=3D28RFC=3D3F=3D29=3D=
5D=3D20gitweb=3D3A=3D20Prepare=3D20for=3D20splitting=3D20gitweb?=3D
>   Dry-Sent [PATCHv2 2/2 (PoC)] gitweb: Create Gitweb::Util module
>=20
> Note that having
>=20
>   MIME-Version: 1.0
>   Content-Type: text/plain; charset=3Dutf-8
>=20
> is not enough[1].
=20
Perhaps something like attached patch could be beginning of fixing
this issue.
=20
> Footnotes:
> ^^^^^^^^^^
> [1]: Note that git-send-email does something strange: first, the prob=
lem
> is with Content-Transfer-Encoding, and git-send-email asks for 8bit
> encoding, suggesting UTF-8, instead of asking for transfer encoding,
> sugesting e.g. 8bit.

Actually git-send-email assumes 8bit if not stated, but it does not
parse 'Content-Type' header for encoding to be used, perhaps correctly
assuming that if required 'Content-Transfer-Encoding' is missing, then
'Content-Type' is most probably missing as well.

-- >8 ---------- >8 --
Subject: [PATCH] git-send-email: Do not encode Subject if not required

If "Subject:" header of an email does not contain non-ASCII characters,
then we don't need to RFC-2047 encode it, even if file had broken
encoding.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 git-send-email.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 98ab33a..1c6b1a8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1281,7 +1281,9 @@ foreach my $t (@files) {
 		$body_encoding =3D $auto_8bit_encoding;
 	}
=20
-	if ($broken_encoding{$t} && !is_rfc2047_quoted($subject)) {
+	if ($broken_encoding{$t} &&
+	    !is_rfc2047_quoted($subject) &&
+	    $subject =3D~ /[^[:ascii:]]/) {
 		$subject =3D quote_rfc2047($subject, $auto_8bit_encoding);
 	}
=20
--=20
1.7.5
