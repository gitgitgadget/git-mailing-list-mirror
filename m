From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 02/16] list-objects: limit traversing within the given 
	subtree if core.subtree is set
Date: Sun, 1 Aug 2010 22:21:17 -0600
Message-ID: <AANLkTikZrD+RRMnae0OOPU_keuu97LditFZnekcpkrYZ@mail.gmail.com>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
	<1280593105-22015-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 06:21:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfmWi-0007hp-Sy
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 06:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672Ab0HBEVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 00:21:19 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51480 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab0HBEVS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 00:21:18 -0400
Received: by wyb39 with SMTP id 39so2885636wyb.19
        for <git@vger.kernel.org>; Sun, 01 Aug 2010 21:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YVTjG8hWhQK8arRcUrtziv9LtRutuzhAL8/pqfhEcC4=;
        b=XOnrD7MxXUoBtC5sWCTL1iuk4nrv+hZo+/9A+vvR4jcZjia8UxOxuGZEbKfX+oQrbI
         suGs/O8DutIblqKNyYz3lLXImGbPs0mY3woj/bV3rGcCdY2wwMXAdBwvwFGpKskR/qwZ
         T2WDwGnLTsnk2ANwP1q0BUnFWa/yinRjpPLrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wVq756ZKetiORlzsQuxc1h8wOyGFvqAROdaOcaC+drUf8+VOjOpGRFTtWRYYddP9Ue
         A5qAnHsjrIMyxEmtH14JDJA9sOlgU/dXWup1aFaK9hPm+bbwqFc11VaGUVau8Q+2fyqy
         KAYR/m2VSqa0o4j+4VnAB0h0j74TDyLmj0Ehk=
Received: by 10.216.187.16 with SMTP id x16mr4363512wem.104.1280722877512; 
	Sun, 01 Aug 2010 21:21:17 -0700 (PDT)
Received: by 10.216.132.8 with HTTP; Sun, 1 Aug 2010 21:21:17 -0700 (PDT)
In-Reply-To: <1280593105-22015-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152389>

SGksCgoyMDEwLzcvMzEgTmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eSA8cGNsb3Vkc0BnbWFpbC5j
b20+Ogo+Cj4gU2lnbmVkLW9mZi1ieTogTmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eSA8cGNsb3Vk
c0BnbWFpbC5jb20+Cj4gLS0tCj4gwqBsaXN0LW9iamVjdHMuYyB8IMKgIDIzICsrKysrKysrKysr
KysrKysrLS0tLS0tCj4gwqAxIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDYgZGVs
ZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvbGlzdC1vYmplY3RzLmMgYi9saXN0LW9iamVjdHMu
Ywo+IGluZGV4IDg5NTM1NDguLjFiMjViNTQgMTAwNjQ0Cj4gLS0tIGEvbGlzdC1vYmplY3RzLmMK
PiArKysgYi9saXN0LW9iamVjdHMuYwo+IEBAIC02MSwxMiArNjEsMTUgQEAgc3RhdGljIHZvaWQg
cHJvY2Vzc190cmVlKHN0cnVjdCByZXZfaW5mbyAqcmV2cywKPiDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBzdHJ1Y3QgdHJlZSAqdHJlZSwKPiDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBzaG93X29iamVjdF9mbiBzaG93LAo+IMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCBuYW1lX3BhdGggKnBhdGgsCj4gLSDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnN0IGNoYXIgKm5hbWUpCj4gKyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnN0IGNoYXIgKm5hbWUsCj4gKyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNvbnN0IGNoYXIgKnN1YnRyZWUpCj4gwqB7Cj4gwqAg
wqAgwqAgwqBzdHJ1Y3Qgb2JqZWN0ICpvYmogPSAmdHJlZS0+b2JqZWN0Owo+IMKgIMKgIMKgIMKg
c3RydWN0IHRyZWVfZGVzYyBkZXNjOwo+IMKgIMKgIMKgIMKgc3RydWN0IG5hbWVfZW50cnkgZW50
cnk7Cj4gwqAgwqAgwqAgwqBzdHJ1Y3QgbmFtZV9wYXRoIG1lOwo+ICsgwqAgwqAgwqAgY29uc3Qg
Y2hhciAqc2xhc2g7Cj4gKyDCoCDCoCDCoCBpbnQgc3VidHJlZV9sZW47CgpQZXJoYXBzIHNsYXNo
IHNob3VsZCBiZSBpbml0aWFsaXplZCB0byBOVUxMPyAgT3RoZXJ3aXNlIEkgdGhpbmsgaXQKd2ls
bCBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQuCgo+Cj4gwqAgwqAgwqAgwqBpZiAoIXJldnMtPnRyZWVf
b2JqZWN0cykKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybjsKPiBAQCAtODIsMTMgKzg1
LDIxIEBAIHN0YXRpYyB2b2lkIHByb2Nlc3NfdHJlZShzdHJ1Y3QgcmV2X2luZm8gKnJldnMsCj4g
wqAgwqAgwqAgwqBtZS5lbGVtID0gbmFtZTsKPiDCoCDCoCDCoCDCoG1lLmVsZW1fbGVuID0gc3Ry
bGVuKG5hbWUpOwo+Cj4gKyDCoCDCoCDCoCBpZiAoc3VidHJlZSkgewo+ICsgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgc2xhc2ggPSBzdHJjaHIoc3VidHJlZSwgJy8nKTsKPiArIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHN1YnRyZWVfbGVuID0gc2xhc2ggPyBzbGFzaCAtIHN1YnRyZWUgOiBzdHJsZW4oc3Vi
dHJlZSk7Cj4gKyDCoCDCoCDCoCB9Cj4gKwo+IMKgIMKgIMKgIMKgaW5pdF90cmVlX2Rlc2MoJmRl
c2MsIHRyZWUtPmJ1ZmZlciwgdHJlZS0+c2l6ZSk7Cj4KPiDCoCDCoCDCoCDCoHdoaWxlICh0cmVl
X2VudHJ5KCZkZXNjLCAmZW50cnkpKSB7Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoU19J
U0RJUihlbnRyeS5tb2RlKSkKPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHBy
b2Nlc3NfdHJlZShyZXZzLAo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBsb29rdXBfdHJlZShlbnRyeS5zaGExKSwKPiAtIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2hvdywgJm1lLCBlbnRy
eS5wYXRoKTsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChTX0lTRElSKGVudHJ5Lm1vZGUp
KSB7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoIXN1YnRyZWUgfHwg
IXN0cm5jbXAoZW50cnkucGF0aCwgc3VidHJlZSwgc3VidHJlZV9sZW4pKQoKT25seSBvbmUgc3Vi
ZGlyZWN0b3J5IGFsbG93ZWQ/ICBXaGF0IGlmIHNvbWVvbmUgd2FudHMgYSBzcGFyc2UgY2xvbmUK
Y29udGFpbmluZyB0d28gb3IgbW9yZSBkaXJlY3Rvcmllcz8gIChBY3R1YWxseSwgdGhhdCdzIG5v
dCBzbyBtdWNoIG9mCmEgIndoYXQgaWYiIC0tIGl0J3MgZXhhY3RseSB3aGF0IEkgd2FudCBpbiBh
Ym91dCBoYWxmIG15IHVzZWNhc2VzIGZvcgpzcGFyc2UgY2xvbmVzLikKCj4gKyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBwcm9jZXNzX3RyZWUocmV2cywKPiAr
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgbG9va3VwX3RyZWUoZW50cnkuc2hhMSksCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNob3csICZtZSwg
ZW50cnkucGF0aCwKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2xhc2ggJiYgc2xhc2hbMV0gPyBzbGFzaCsxIDogTlVM
TCk7CgpJZiBJIHJlYWQgY29ycmVjdGx5LCBzbGFzaCB3aWxsIGJlIHVzZWQgdW5pbml0aWFsaXpl
ZCBoZXJlIHdoZW5ldmVyCnN1YnRyZWUgPT0gTlVMTC4K
