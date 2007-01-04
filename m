From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Thu, 4 Jan 2007 11:47:19 +0100
Message-ID: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_5216_12041767.1167907639889"
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 04 11:47:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2Q89-0006ze-Sv
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 11:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbXADKrW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 05:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbXADKrW
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 05:47:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:23022 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932372AbXADKrV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 05:47:21 -0500
Received: by ug-out-1314.google.com with SMTP id 44so5404408uga
        for <git@vger.kernel.org>; Thu, 04 Jan 2007 02:47:20 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=oulJqezcKFTmz/Hm8Av7IfM48J6YeqZCzi8Xab80q+7jYjNokNILfp+gHflNHfE59YJJCIX1u8N+/PFybaWtY5yJkyHYSxlTssLJjFfcaJQfKwigNyq+aXZWFLB+rFfLRqXR3R5gf9IxX7xR+T7kTbTdlZqtP4KEkJqBMnVUNBg=
Received: by 10.78.171.13 with SMTP id t13mr2464191hue.1167907639922;
        Thu, 04 Jan 2007 02:47:19 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 4 Jan 2007 02:47:19 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35927>

------=_Part_5216_12041767.1167907639889
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Merge-recursive is very slow in repos with lots of files,
especially if lots of them change absolutely identically.
Updating index once after all of them changes speedups
merge quite noticable.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Johannes, I remember suggesting to do index flush for all
entries instead for every entry. It is already quite time ago,
but ... was there any reasons for not doing this?
The patch speeds it up a lot and no wonder: index is 6Mb
here, and this is cygwin.

 merge-recursive.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

------=_Part_5216_12041767.1167907639889
Content-Type: text/plain; 
	name=0001-Speedup-recursive-by-flushing-index-only-once-for-all-entries.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: file0
Content-Disposition: attachment; filename="0001-Speedup-recursive-by-flushing-index-only-once-for-all-entries.txt"

RnJvbSBkMGU0ZDc5MWNlZjhiMzA3YjMyOTU0YThiODBjNGFhYmQ0MTc1NWE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDQgSmFuIDIwMDcgMTE6MjI6NDcgKzAxMDAKU3ViamVjdDogU3BlZWR1cCByZWN1cnNp
dmUgYnkgZmx1c2hpbmcgaW5kZXggb25seSBvbmNlIGZvciBhbGwgZW50cmllcwoKU2lnbmVkLW9m
Zi1ieTogQWxleCBSaWVzZW4gPHJhYS5sa21sQGdtYWlsLmNvbT4KLS0tCgogbWVyZ2UtcmVjdXJz
aXZlLmMgfCAgICA1ICsrLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9tZXJnZS1yZWN1cnNpdmUuYyBiL21lcmdlLXJlY3Vy
c2l2ZS5jCmluZGV4IGJhYzE2ZjUuLjRkM2EyY2UgMTAwNjQ0Ci0tLSBhL21lcmdlLXJlY3Vyc2l2
ZS5jCisrKyBiL21lcmdlLXJlY3Vyc2l2ZS5jCkBAIC0xMDgzLDkgKzEwODMsNiBAQCBzdGF0aWMg
aW50IHByb2Nlc3NfZW50cnkoY29uc3QgY2hhciAqcGF0aCwgc3RydWN0IHN0YWdlX2RhdGEgKmVu
dHJ5LAogCX0gZWxzZQogCQlkaWUoIkZhdGFsIG1lcmdlIGZhaWx1cmUsIHNob3VsZG4ndCBoYXBw
ZW4uIik7CiAKLQlpZiAoY2FjaGVfZGlydHkpCi0JCWZsdXNoX2NhY2hlKCk7Ci0KIAlyZXR1cm4g
Y2xlYW5fbWVyZ2U7CiB9CiAKQEAgLTExMzMsNiArMTEzMCw4IEBAIHN0YXRpYyBpbnQgbWVyZ2Vf
dHJlZXMoc3RydWN0IHRyZWUgKmhlYWQsCiAJCQlpZiAoIXByb2Nlc3NfZW50cnkocGF0aCwgZSwg
YnJhbmNoMSwgYnJhbmNoMikpCiAJCQkJY2xlYW4gPSAwOwogCQl9CisJCWlmIChjYWNoZV9kaXJ0
eSkKKwkJCWZsdXNoX2NhY2hlKCk7CiAKIAkJcGF0aF9saXN0X2NsZWFyKHJlX21lcmdlLCAwKTsK
IAkJcGF0aF9saXN0X2NsZWFyKHJlX2hlYWQsIDApOwotLSAKMS41LjAucmMwLmc4YmM0Yi1kaXJ0
eQoK
------=_Part_5216_12041767.1167907639889--
