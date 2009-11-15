From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Make Gitweb behave like Apache mod_userdir
Date: Sun, 15 Nov 2009 11:04:03 +0100
Message-ID: <7fce93be0911150204h259b7424md251c54186d05b7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636988b67552f1c0478660366
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 15 11:04:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9by0-0001nA-P4
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 11:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551AbZKOKD7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 05:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536AbZKOKD7
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 05:03:59 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:56988 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbZKOKD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 05:03:59 -0500
Received: by ywh40 with SMTP id 40so2383693ywh.33
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 02:04:04 -0800 (PST)
Received: by 10.101.177.13 with SMTP id e13mr6267934anp.95.1258279444753; Sun, 
	15 Nov 2009 02:04:04 -0800 (PST)
X-Originating-IP: [82.233.66.33]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132926>

--001636988b67552f1c0478660366
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

I contact you because I spent quite some time to make something pretty
basic with gitweb.
I made gitweb behave a bit like UserDir module will in apache.
In fact it's only configuration but I think it could be useful to others.

Basicly it allows users of your server who use git to be able to use
gitweb to browse their own root project. E.G. :

Alice's private repos :

/home/alice/git/product_a.git (cloned from /var/git/product_a.git)
/home/alice/git/product_b.git (cloned from /var/git/product_b.git)
/home/alice/git/product_c.git (cloned from /var/git/product_c.git)

Alice's links to her repos which she wants to be able to browse with gitweb=
 :

/home/alice/gitweb/product_a -> /home/alice/git/product_a.git/.git
/home/alice/gitweb/product_c -> /home/alice/git/product_c.git/.git

Bare repos :

/var/git/product_a.git
/var/git/product_b.git
/var/git/product_c.git
/var/git/product_d.git

/etc/gitweb.conf :

$projectroot =3D $ENV{'GITWEB_PROJECTROOT'} || "/var/git/";

Apache configuration :

RewriteRule ^/~([^\/]+)/?$=A0 /cgi-bin/gitweb.cgi
[QSA,E=3DGITWEB_PROJECTROOT:/home/$1/gitweb/,L,PT]

So now all users with a gitweb folder in their home will be able to
browse all git repos in it through http://<host>/~<user>.

You will find a patch enclosed which try to describe best what I did
and why in the gitweb/README.

Regards.

--001636988b67552f1c0478660366
Content-Type: application/octet-stream; name="userdirstyle.patch"
Content-Disposition: attachment; filename="userdirstyle.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g21n1ts00

ZGlmZiAtLWdpdCBhL2dpdHdlYi9SRUFETUUgYi9naXR3ZWIvUkVBRE1FCmluZGV4IDY2YzZhOTMu
LjZmNzMzZTYgMTAwNjQ0Ci0tLSBhL2dpdHdlYi9SRUFETUUKKysrIGIvZ2l0d2ViL1JFQURNRQpA
QCAtMzA2LDggKzMwNiwxMCBAQCByZXBvc2l0b3JpZXMsIHlvdSBjYW4gY29uZmlndXJlIGFwYWNo
ZSBsaWtlIHRoaXM6CiAgICAgRG9jdW1lbnRSb290IC9wdWIvZ2l0CiAgICAgU2V0RW52CUdJVFdF
Ql9DT05GSUcJL2V0Yy9naXR3ZWIuY29uZgogICAgIFJld3JpdGVFbmdpbmUgb24KKwogICAgICMg
bWFrZSB0aGUgZnJvbnQgcGFnZSBhbiBpbnRlcm5hbCByZXdyaXRlIHRvIHRoZSBnaXR3ZWIgc2Ny
aXB0CiAgICAgUmV3cml0ZVJ1bGUgXi8kICAvY2dpLWJpbi9naXR3ZWIuY2dpCisKICAgICAjIG1h
a2UgYWNjZXNzIGZvciAiZHVtYiBjbGllbnRzIiB3b3JrCiAgICAgUmV3cml0ZVJ1bGUgXi8oLipc
LmdpdC8oPyEvPyhIRUFEfGluZm98b2JqZWN0c3xyZWZzKSkuKik/JCAvY2dpLWJpbi9naXR3ZWIu
Y2dpJXtSRVFVRVNUX1VSSX0gIFtMLFBUXQogPC9WaXJ0dWFsSG9zdD4KQEAgLTMzMiw2ICszMzQs
MjAgQEAgc29tZXRoaW5nIGxpa2UgdGhlIGZvbGxvd2luZyBpbiB5b3VyIGdpdHdlYi5jb25mIChv
ciBnaXR3ZWJfY29uZmlnLnBlcmwpIGZpbGU6CiAgICRteV91cmkgPSAiLyI7CiAgICRob21lX2xp
bmsgPSAiLyI7CiAKK0lmIHlvdSB3YW50IGdpdHdlYiB0byBhY3QgYSBiaXQgbGlrZSBVc2VyRGly
IG1vZCBpbiBhcGFjaGUsIGtub3dpbmcsIGh0dHA6Ly88aG9zdD4vfjx1c2VyPiAKK3dpbGwgbGlz
dCBhbGwgZ2l0IHJlcG9zIG9mIDx1c2VyPiBsb2NhdGVkIGluIGEgc3BlY2lhbCBkaXJlY3Rvcnkg
aW4gaGlzIGhvbWUgKC9ob21lLzx1c2VyPi9naXR3ZWIvKSwgCitkbyB0aGUgZm9sbG93aW5nIHN0
ZXBzIDoKKworQWRkIHRoaXMgdG8gdGhlIFZpcnR1YWxIb3N0IHNlY3Rpb24gb2YgeW91ciBhcGFj
aGUgY29uZmlndXJhdGlvbiBmaWxlIDoKKworICAgUmV3cml0ZVJ1bGUgXi9+KFteXC9dKykvPyQg
IC9jZ2ktYmluL2dpdHdlYi5jZ2kgW1FTQSxFPUdJVFdFQl9QUk9KRUNUUk9PVDovaG9tZS8kMS9n
aXR3ZWIvLEwsUFRdCisKK01vZGlmeSB5b3VyIGdpdHdlYi5jb25mIGZpbGUsIGxvY2F0ZWQgYXQg
L2V0Yy9naXR3ZWIuY29uZiBpbiB0aGlzIGV4YW1wbGUsIHdpdGggOgorCisgICAkcHJvamVjdHJv
b3QgPSAkRU5WeydHSVRXRUJfUFJPSkVDVFJPT1QnfSB8fCAiL3BhdGgvdG8vdGhlL2RlZmF1bC9w
cm9qZWN0L3Jvb3QiOyAKKworVGh1cywgZWFjaCB1c2VyIHdpdGggYSBnaXR3ZWIgZm9sZGVyIGlu
IGhpcyBob21lIHdpbGwgYmUgYWJsZSB0byBicm93c2UgaXQgd2l0aCBnaXR3ZWIuCisvIVwgVGhl
IGdpdHdlYiBmb2xkZXIgYW5kIHVzZXIncyBob21lIGZvbGRlciBtdXN0IGJlIHJlYWRhYmxlIGJ5
IHRoZSB3ZWJzZXJ2ZXIgdXNlci4KIAogUEFUSF9JTkZPIHVzYWdlCiAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQo=
--001636988b67552f1c0478660366--
