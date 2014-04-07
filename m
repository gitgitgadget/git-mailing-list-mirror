From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] Unicode: update of combining code points
Date: Mon, 7 Apr 2014 21:34:54 +0200
Message-ID: <201404072134.55333.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 07 21:40:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXFPI-0001pR-Dp
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 21:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187AbaDGTkb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Apr 2014 15:40:31 -0400
Received: from mout.web.de ([212.227.15.3]:65188 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755161AbaDGTka convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 15:40:30 -0400
Received: from appes.localnet ([78.72.74.102]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0Md4V8-1WF1nb0PFy-00IFd2; Mon, 07 Apr 2014 21:40:29
 +0200
X-Provags-ID: V03:K0:X34RdBV6E9gZwBumrTFDSyeGF7LDCIu81RmSyjazdhQPdlEfqFX
 lbMV8Ix09QFUnFo5vcjYznBPRYCdIfkHeWc3EAjSrwtdi+YcD5pE/SNoHfjG7evFwpEpDm+
 1vYlAl1sn/fIPl2i5cFKmPAcwcSMZBEJx1gj9Qhe+oAhM0ZwjBdz+7HwPSIV4E2sOKKPDDj
 GLnc0fwmtdK2iJdvAVQ6g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245897>

Unicode 6.3 defines the following code as combining or accents,
git_wcwidth() should return 0.

Earlier unicode standards had defined these code point as "reserved":

358 COMBINING DOT ABOVE RIGHT
359 COMBINING ASTERISK BELOW
35A COMBINING DOUBLE RING BELOW
35B COMBINING ZIGZAG ABOVE
35C COMBINING DOUBLE BREVE BELOW
487 COMBINING CYRILLIC POKRYTIE
5A2 HEBREW ACCENT ATNAH HAFUKH,
5BA HEBREW POINT HOLAM HASER FOR VAV
5C5 HEBREW MARK LOWER DOT
5C7 HEBREW POINT QAMATS QATAN
604 ARABIC SIGN SAMVAT
616 ARABIC SMALL HIGH LIGATURE ALEF WITH LAM WITH YEH
617 ARABIC SMALL HIGH ZAIN
618 ARABIC SMALL FATHA
619 ARABIC SMALL DAMMA
61A ARABIC SMALL KASRA
659 ARABIC ZWARAKAY
65A ARABIC VOWEL SIGN SMALL V ABOVE
65B ARABIC VOWEL SIGN INVERTED SMALL V ABOVE
65C ARABIC VOWEL SIGN DOT BELOW
65D ARABIC REVERSED DAMMA
65E ARABIC FATHA WITH TWO DOTS
65F ARABIC WAVY HAMZA BELOW

This commit touches only the range 300-6FF, there may be more to be upd=
ated.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 utf8.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/utf8.c b/utf8.c
index a831d50..77c28d4 100644
--- a/utf8.c
+++ b/utf8.c
@@ -84,11 +84,10 @@ static int git_wcwidth(ucs_char_t ch)
 	 *   "uniset +cat=3DMe +cat=3DMn +cat=3DCf -00AD +1160-11FF +200B c".
 	 */
 	static const struct interval combining[] =3D {
-		{ 0x0300, 0x0357 }, { 0x035D, 0x036F }, { 0x0483, 0x0486 },
-		{ 0x0488, 0x0489 }, { 0x0591, 0x05A1 }, { 0x05A3, 0x05B9 },
-		{ 0x05BB, 0x05BD }, { 0x05BF, 0x05BF }, { 0x05C1, 0x05C2 },
-		{ 0x05C4, 0x05C4 }, { 0x0600, 0x0603 }, { 0x0610, 0x0615 },
-		{ 0x064B, 0x0658 }, { 0x0670, 0x0670 }, { 0x06D6, 0x06E4 },
+		{ 0x0300, 0x036F }, { 0x0483, 0x0489 }, { 0x0591, 0x05BD },
+		{ 0x05BF, 0x05BF }, { 0x05C1, 0x05C2 }, { 0x05C4, 0x05C5 },
+		{ 0x05C7, 0x05C7 }, { 0x0600, 0x0604 }, { 0x0610, 0x061A },
+		{ 0x064B, 0x065F }, { 0x0670, 0x0670 }, { 0x06D6, 0x06E4 },
 		{ 0x06E7, 0x06E8 }, { 0x06EA, 0x06ED }, { 0x070F, 0x070F },
 		{ 0x0711, 0x0711 }, { 0x0730, 0x074A }, { 0x07A6, 0x07B0 },
 		{ 0x0901, 0x0902 }, { 0x093C, 0x093C }, { 0x0941, 0x0948 },
--=20
1.9.0
