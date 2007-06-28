From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Avoid perl in t1300-repo-config
Date: Thu, 28 Jun 2007 10:56:53 +0200
Message-ID: <81b0412b0706280156q56944862s94644917b95e892f@mail.gmail.com>
References: <81b0412b0706270545w65ca2556yaafaac6ff31b5961@mail.gmail.com>
	 <7vmyykog4e.fsf@assigned-by-dhcp.pobox.com>
	 <81b0412b0706280041i535efdf0r87e552551b796044@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_37251_7062238.1183021013920"
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Frank Lichtenheld" <frank@lichtenheld.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 10:57:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3poA-0004pC-CP
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 10:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762709AbXF1I45 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 04:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762645AbXF1I45
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 04:56:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:23248 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762709AbXF1I44 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 04:56:56 -0400
Received: by ug-out-1314.google.com with SMTP id j3so534163ugf
        for <git@vger.kernel.org>; Thu, 28 Jun 2007 01:56:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=Sh9Xf9mS2Munby6XlCcRh86lgfjXx/GMb8IC91NfBiK/hYB6JIn5cEJIrxgjXoF1FCS7CfYQo5bd2AHFn2fjJl3TzXEfXvdY21UKhfNy6CkyI9GUL5iw6LgrF/rMbQqsg6c9Ax7ICizFpu/WAV3TulIQX7q7SMuxtgB/AOYLKCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=ippJZRDODMmTgf30PlBXDigvJWAHcdW4Seqlg+YS4scoX0EVHFYv2jqcSm2NN7rwiOXcDqPFbBVGLZslaj6qRxkh3Oe5lCBQOHO0giJb1Of9dP7sFJCXWY057E7deUtDR+ZFpHwI6hAD/Reja/tIMc77LP4+BJJfY/bcHwVUOeU=
Received: by 10.78.147.6 with SMTP id u6mr745633hud.1183021013974;
        Thu, 28 Jun 2007 01:56:53 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Thu, 28 Jun 2007 01:56:53 -0700 (PDT)
In-Reply-To: <81b0412b0706280041i535efdf0r87e552551b796044@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51090>

------=_Part_37251_7062238.1183021013920
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It fixes the test on systems where ActiveState Perl is used.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 t/t1300-repo-config.sh |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

On 6/28/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> On 6/28/07, Junio C Hamano <gitster@pobox.com> wrote:
> > "Alex Riesen" <raa.lkml@gmail.com> writes:
> >
> > > It fixes the test on system where ActiveState Perl is used.
> > > It is also shorter.
> > > ...
> > > -git config --null --list | perl -0ne 'chop;($key,$value)=...
> > > +git config --null --list | xargs -n1 -0 echo 'Key:' > result
> >
> > This now makes us rely on "xargs -0", which is probably much
> > less portable than Perl isn't it?
>
> Dunno. Have yet too meet a system where it doesn't work.
> That said, SUSv6 does not mention it.
>
> > Maybe postprocess "git config -z" output with "tr '[\000]' 'Q'"
> > or something so that the comparison of the result does not have
> > to worry about NULs?  I dunno.
>
> Will try that.
>

So I did. Any idea as to how make the here-document
_without_ the trailing LF?

------=_Part_37251_7062238.1183021013920
Content-Type: text/plain; name=0001-Avoid-perl-in-t1300-repo-config.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f3h06ze2
Content-Disposition: attachment; filename="0001-Avoid-perl-in-t1300-repo-config.txt"

RnJvbSA4NDZmY2ZlNDc5MzhlZTg5NGViNDMzYjZmM2EyNGFlNGI2NDc5ZTViIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDI3IEp1biAyMDA3IDE0OjQwOjQxICswMjAwClN1YmplY3Q6IFtQQVRDSF0gQXZvaWQg
cGVybCBpbiB0MTMwMC1yZXBvLWNvbmZpZwoKSXQgZml4ZXMgdGhlIHRlc3Qgb24gc3lzdGVtIHdo
ZXJlIEFjdGl2ZVN0YXRlIFBlcmwgaXMgdXNlZC4KClNpZ25lZC1vZmYtYnk6IEFsZXggUmllc2Vu
IDxyYWEubGttbEBnbWFpbC5jb20+Ci0tLQogdC90MTMwMC1yZXBvLWNvbmZpZy5zaCB8ICAgMjIg
KysrKysrKysrKy0tLS0tLS0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
LCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90L3QxMzAwLXJlcG8tY29uZmlnLnNoIGIv
dC90MTMwMC1yZXBvLWNvbmZpZy5zaAppbmRleCA3YTc3YmVmLi4yNzQ4NmRlIDEwMDc1NQotLS0g
YS90L3QxMzAwLXJlcG8tY29uZmlnLnNoCisrKyBiL3QvdDEzMDAtcmVwby1jb25maWcuc2gKQEAg
LTUyOSwyNSArNTI5LDIzIEBAIGNhdCA+IC5naXQvY29uZmlnIDw8XEVPRgogRU9GCiAKIGNhdCA+
IGV4cGVjdCA8PFxFT0YKLUtleTogc2VjdGlvbi5zdWI9c2VjdGlvbi52YWwxCi1WYWx1ZTogZm9v
PWJhcgotS2V5OiBzZWN0aW9uLnN1Yj1zZWN0aW9uLnZhbDIKLVZhbHVlOiBmb28KLWJhcgotS2V5
OiBzZWN0aW9uLnN1Yj1zZWN0aW9uLnZhbDMKLVZhbHVlOiAKK3NlY3Rpb24uc3ViPXNlY3Rpb24u
dmFsMQorZm9vPWJhclFzZWN0aW9uLnN1Yj1zZWN0aW9uLnZhbDIKK2ZvbworYmFyUXNlY3Rpb24u
c3ViPXNlY3Rpb24udmFsMwogCiAKLUtleTogc2VjdGlvbi5zdWI9c2VjdGlvbi52YWw0Ci1WYWx1
ZTogCi1LZXk6IHNlY3Rpb24uc3ViPXNlY3Rpb24udmFsNQorUXNlY3Rpb24uc3ViPXNlY3Rpb24u
dmFsNAorUXNlY3Rpb24uc3ViPXNlY3Rpb24udmFsNVEKIEVPRgogCi1naXQgY29uZmlnIC0tbnVs
bCAtLWxpc3QgfCBwZXJsIC0wbmUgJ2Nob3A7KCRrZXksJHZhbHVlKT1zcGxpdCgvXG4vLCRfLDIp
O3ByaW50ICJLZXk6ICRrZXlcbiI7cHJpbnQgIlZhbHVlOiAkdmFsdWVcbiIgaWYgZGVmaW5lZCgk
dmFsdWUpJyA+IHJlc3VsdAorZ2l0IGNvbmZpZyAtLW51bGwgLS1saXN0IHwgdHIgJ1tcMDAwXScg
J1EnID4gcmVzdWx0CitlY2hvID4+cmVzdWx0CiAKIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgJy0tbnVs
bCAtLWxpc3QnICdjbXAgcmVzdWx0IGV4cGVjdCcKIAotZ2l0IGNvbmZpZyAtLW51bGwgLS1nZXQt
cmVnZXhwICd2YWxbMC05XScgfCBwZXJsIC0wbmUgJ2Nob3A7KCRrZXksJHZhbHVlKT1zcGxpdCgv
XG4vLCRfLDIpO3ByaW50ICJLZXk6ICRrZXlcbiI7cHJpbnQgIlZhbHVlOiAkdmFsdWVcbiIgaWYg
ZGVmaW5lZCgkdmFsdWUpJyA+IHJlc3VsdAorZ2l0IGNvbmZpZyAtLW51bGwgLS1nZXQtcmVnZXhw
ICd2YWxbMC05XScgfCB0ciAnW1wwMDBdJyAnUScgPiByZXN1bHQKK2VjaG8gPj5yZXN1bHQKIAog
dGVzdF9leHBlY3Rfc3VjY2VzcyAnLS1udWxsIC0tZ2V0LXJlZ2V4cCcgJ2NtcCByZXN1bHQgZXhw
ZWN0JwogCi0tIAoxLjUuMi4yLjEzMDguZzU0MGI2Cgo=
------=_Part_37251_7062238.1183021013920--
