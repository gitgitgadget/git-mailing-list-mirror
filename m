X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/2] move Git.pm build instructions into perl/Makefile
Date: Mon, 4 Dec 2006 10:56:49 +0100
Message-ID: <81b0412b0612040156w794a276cqaa37f1734ba7a1ca@mail.gmail.com>
References: <20061121225911.GA24201@steel.home>
	 <81b0412b0611300827h64722fa0i7e32808994a97a51@mail.gmail.com>
	 <7vvektyi7n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_29469_30281405.1165226209019"
NNTP-Posting-Date: Mon, 4 Dec 2006 09:56:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=FiXNqsgt/9yNPvyNKqt4aZpv3icESoi+Be9GzSmlGwx0AqwCGwXJDslzYqdkeXpVfAlMAwFMlagjvMKKXKB4bdAntJ4i6U9p3/Sk/4tbYt1BNLj6M3Tbl67xm7v0qiCO6yS4X53Df0kvBwILbUUpTT/TS06L5VoOBqhgUjExgPM=
In-Reply-To: <7vvektyi7n.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33178>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrAZC-00045a-Ob for gcvg-git@gmane.org; Mon, 04 Dec
 2006 10:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935193AbWLDJ4w (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 04:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935390AbWLDJ4w
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 04:56:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:42788 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S935193AbWLDJ4v
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 04:56:51 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2945143uga for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 01:56:49 -0800 (PST)
Received: by 10.78.149.15 with SMTP id w15mr7484751hud.1165226209069; Mon, 04
 Dec 2006 01:56:49 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Mon, 4 Dec 2006 01:56:48 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

------=_Part_29469_30281405.1165226209019
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 12/3/06, Junio C Hamano <junkio@cox.net> wrote:
> > This is the first patch, just rebased upon current master.
> > The ActiveState-related parts follow
>
> diff --git a/perl/.gitignore b/perl/.gitignore
> index e990cae..98b2477 100644
> --- a/perl/.gitignore
> +++ b/perl/.gitignore
> @@ -1,4 +1,5 @@
> -Makefile
> +perl.mak
> +perl.mak.old
>  blib
>  blibdirs
>  pm_to_blib
>
> This, and perl/Makefile not cleaning perl.mak.old, are wrong.

How is this wrong, and the previous (for when there weren't
Makefile at all) Makefile-in-.gitignore is not?
These are generated files, what do you want to preserve them for?

> "make && make clean" after a fresh checkout should leave the
> working tree the same state is it were.

oh, right. Missed it (never seen it generated, BTW. Just took
from Pasky's code that it happens).

Updated patch attached.

------=_Part_29469_30281405.1165226209019
Content-Type: text/x-diff; name=perl-makefile.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: file0
Content-Disposition: attachment; filename="perl-makefile.patch"

QXV0aG9yOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRlOiBNb24gRGVjIDQg
MTA6NTA6MDQgMjAwNiArMDEwMApTdWJqZWN0OiBNb3ZlIEdpdC5wbSBidWlsZCBpbnN0cnVjdGlv
bnMgaW50byBwZXJsL01ha2VmaWxlCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJpZXNlbiA8cmFhLmxr
bWxAZ21haWwuY29tPgoKZGlmZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggZGUz
ZTlmMy4uM2U2ODI1YiAxMDA2NDQKLS0tIGEvTWFrZWZpbGUKKysrIGIvTWFrZWZpbGUKQEAgLTUz
OSw2ICs1MzksOSBAQCBlbmRpZgogaWZkZWYgTk9fQUNDVVJBVEVfRElGRgogCUJBU0lDX0NGTEFH
UyArPSAtRE5PX0FDQ1VSQVRFX0RJRkYKIGVuZGlmCitpZmRlZiBOT19QRVJMX01BS0VNQUtFUgor
CWV4cG9ydCBOT19QRVJMX01BS0VNQUtFUgorZW5kaWYKIAogIyBTaGVsbCBxdW90ZSAoZG8gbm90
IHVzZSAkKGNhbGwpIHRvIGFjY29tbW9kYXRlIGFuY2llbnQgc2V0dXBzKTsKIApAQCAtNTY4LDgg
KzU3MSw4IEBAIGV4cG9ydCBwcmVmaXggVEFSIElOU1RBTEwgREVTVERJUiBTSEVMTF9QQVRIIHRl
bXBsYXRlX2RpcgogCiBhbGw6ICQoQUxMX1BST0dSQU1TKSAkKEJVSUxUX0lOUykgZ2l0JFggZ2l0
ayBnaXR3ZWIvZ2l0d2ViLmNnaQogCi1hbGw6IHBlcmwvTWFrZWZpbGUKLQkkKE1BS0UpIC1DIHBl
cmwKK2FsbDoKKwkkKE1BS0UpIC1DIHBlcmwgUEVSTF9QQVRIPSckKFBFUkxfUEFUSF9TUSknIHBy
ZWZpeD0nJChwcmVmaXhfU1EpJyBhbGwKIAkkKE1BS0UpIC1DIHRlbXBsYXRlcwogCiBzdHJpcDog
JChQUk9HUkFNUykgZ2l0JFgKQEAgLTYwMiw3ICs2MDUsMTEgQEAgJChwYXRzdWJzdCAlLnNoLCUs
JChTQ1JJUFRfU0gpKSA6ICUgOiAlLnNoCiAJY2htb2QgK3ggJEArCiAJbXYgJEArICRACiAKLSQo
cGF0c3Vic3QgJS5wZXJsLCUsJChTQ1JJUFRfUEVSTCkpOiBwZXJsL01ha2VmaWxlCiskKHBhdHN1
YnN0ICUucGVybCwlLCQoU0NSSVBUX1BFUkwpKTogcGVybC9wZXJsLm1haworCitwZXJsL3Blcmwu
bWFrOiBHSVQtQ0ZMQUdTCisJJChNQUtFKSAtQyBwZXJsIFBFUkxfUEFUSD0nJChQRVJMX1BBVEhf
U1EpJyBwcmVmaXg9JyQocHJlZml4X1NRKScgJChARikKKwogJChwYXRzdWJzdCAlLnBlcmwsJSwk
KFNDUklQVF9QRVJMKSk6ICUgOiAlLnBlcmwKIAlybSAtZiAkQCAkQCsKIAlJTlNUTElCRElSPWAk
KE1BS0UpIC1DIHBlcmwgLXMgLS1uby1wcmludC1kaXJlY3RvcnkgaW5zdGxpYmRpcmAgJiYgXApA
QCAtNzk2LDcgKzgwMyw3IEBAIGluc3RhbGw6IGFsbAogCSQoSU5TVEFMTCkgJChBTExfUFJPR1JB
TVMpICckKERFU1RESVJfU1EpJChnaXRleGVjZGlyX1NRKScKIAkkKElOU1RBTEwpIGdpdCRYIGdp
dGsgJyQoREVTVERJUl9TUSkkKGJpbmRpcl9TUSknCiAJJChNQUtFKSAtQyB0ZW1wbGF0ZXMgREVT
VERJUj0nJChERVNURElSX1NRKScgaW5zdGFsbAotCSQoTUFLRSkgLUMgcGVybCBpbnN0YWxsCisJ
JChNQUtFKSAtQyBwZXJsIHByZWZpeD0nJChwcmVmaXhfU1EpJyBpbnN0YWxsCiAJaWYgdGVzdCAn
eiQoYmluZGlyX1NRKScgIT0gJ3okKGdpdGV4ZWNkaXJfU1EpJzsgXAogCXRoZW4gXAogCQlsbiAt
ZiAnJChERVNURElSX1NRKSQoYmluZGlyX1NRKS9naXQkWCcgXApAQCAtODY2LDggKzg3Myw3IEBA
IGNsZWFuOgogCXJtIC1mICQoaHRtbGRvY3MpLnRhci5neiAkKG1hbnBhZ2VzKS50YXIuZ3oKIAly
bSAtZiBnaXR3ZWIvZ2l0d2ViLmNnaQogCSQoTUFLRSkgLUMgRG9jdW1lbnRhdGlvbi8gY2xlYW4K
LQlbICEgLWYgcGVybC9NYWtlZmlsZSBdIHx8ICQoTUFLRSkgLUMgcGVybC8gY2xlYW4gfHwgJChN
QUtFKSAtQyBwZXJsLyBjbGVhbgotCXJtIC1mIHBlcmwvcHBwb3J0LmggcGVybC9NYWtlZmlsZS5v
bGQKKwkkKE1BS0UpIC1DIHBlcmwgY2xlYW4KIAkkKE1BS0UpIC1DIHRlbXBsYXRlcy8gY2xlYW4K
IAkkKE1BS0UpIC1DIHQvIGNsZWFuCiAJcm0gLWYgR0lULVZFUlNJT04tRklMRSBHSVQtQ0ZMQUdT
CmRpZmYgLS1naXQgYS9wZXJsLy5naXRpZ25vcmUgYi9wZXJsLy5naXRpZ25vcmUKaW5kZXggZTk5
MGNhZS4uOThiMjQ3NyAxMDA2NDQKLS0tIGEvcGVybC8uZ2l0aWdub3JlCisrKyBiL3BlcmwvLmdp
dGlnbm9yZQpAQCAtMSw0ICsxLDUgQEAKLU1ha2VmaWxlCitwZXJsLm1haworcGVybC5tYWsub2xk
CiBibGliCiBibGliZGlycwogcG1fdG9fYmxpYgpkaWZmIC0tZ2l0IGEvcGVybC9NYWtlZmlsZSBi
L3BlcmwvTWFrZWZpbGUKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uYmQ0ODNi
MAotLS0gL2Rldi9udWxsCisrKyBiL3BlcmwvTWFrZWZpbGUKQEAgLTAsMCArMSwzOSBAQAorIwor
IyBNYWtlZmlsZSBmb3IgcGVybCBzdXBwb3J0IG1vZHVsZXMgYW5kIHJvdXRpbmUKKyMKK21ha2Zp
bGU6PXBlcmwubWFrCisKK1BFUkxfUEFUSF9TUSA9ICQoc3Vic3QgJywnXCcnLCQoUEVSTF9QQVRI
KSkKK3ByZWZpeF9TUSA9ICQoc3Vic3QgJywnXCcnLCQocHJlZml4KSkKKworYWxsIGluc3RhbGwg
aW5zdGxpYmRpcjogJChtYWtmaWxlKQorCSQoTUFLRSkgLWYgJChtYWtmaWxlKSAkQAorCitjbGVh
bjoKKwl0ZXN0IC1mICQobWFrZmlsZSkgJiYgJChNQUtFKSAtZiAkKG1ha2ZpbGUpICRAIHx8IGV4
aXQgMAorCSQoUk0pIHBwcG9ydC5oCisJJChSTSkgJChtYWtmaWxlKQorCSQoUk0pICQobWFrZmls
ZSkub2xkCisKK2lmZGVmIE5PX1BFUkxfTUFLRU1BS0VSCitpbnN0ZGlyX1NRID0gJChzdWJzdCAn
LCdcJycsJChwcmVmaXgpL2xpYikKKyQobWFrZmlsZSk6IC4uL0dJVC1DRkxBR1MgTWFrZWZpbGUK
KwllY2hvIGFsbDogPiAkQAorCWVjaG8gJwk6JyA+PiAkQAorCWVjaG8gaW5zdGFsbDogPj4gJEAK
KwllY2hvICcJbWtkaXIgLXAgJChpbnN0ZGlyX1NRKScgPj4gJEAKKwllY2hvICcJJChSTSkgJChp
bnN0ZGlyX1NRKS9HaXQucG07IGNwIEdpdC5wbSAkKGluc3RkaXJfU1EpJyA+PiAkQAorCWVjaG8g
JwkkKFJNKSAkKGluc3RkaXJfU1EpL0Vycm9yLnBtOyBcCisJY3AgcHJpdmF0ZS1FcnJvci5wbSAk
KGluc3RkaXJfU1EpL0Vycm9yLnBtJyA+PiAkQAorCWVjaG8gaW5zdGxpYmRpcjogPj4gJEAKKwll
Y2hvICcJZWNobyAkKGluc3RkaXJfU1EpJyA+PiAkQAorZWxzZQorJChtYWtmaWxlKTogTWFrZWZp
bGUuUEwgLi4vR0lULUNGTEFHUworCSckKFBFUkxfUEFUSF9TUSknICQ8IEZJUlNUX01BS0VGSUxF
PSckQCcgUFJFRklYPSckKHByZWZpeF9TUSknCitlbmRpZgorCisjIHRoaXMgaXMganVzdCBhZGRl
ZCBjb21mb3J0IGZvciBjYWxsaW5nIG1ha2UgZGlyZWN0bHkgaW4gcGVybCBkaXIKKyMgKGV2ZW4g
dGhvdWdoIEdJVC1DRkxBR1MgYXJlbid0IHVzZWQgeWV0LiBJZiBldmVyKQorLi4vR0lULUNGTEFH
UzoKKwkkKE1BS0UpIC1DIC4uIEdJVC1DRkxBR1MKKwo=
