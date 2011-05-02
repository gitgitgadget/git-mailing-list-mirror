From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH/RFC 1/4] grep: prepare for re-using the space of the
 regexp member in struct grep_pat
Date: Mon, 2 May 2011 10:27:28 -0300
Message-ID: <BANLkTi=5Rr2t-u9dJCg6EpcbfEALJDY4wQ@mail.gmail.com>
References: <cover.1304321122.git.bert.wesarg@googlemail.com>
	<cover.1304318972.git.bert.wesarg@googlemail.com>
	<f768ea6e107cdd229a18df0bac3bf583eb1f9fc5.1304321122.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon May 02 15:27:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGt9z-0005DU-IC
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 15:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758768Ab1EBN1a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 09:27:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59527 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757661Ab1EBN13 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 09:27:29 -0400
Received: by iwn34 with SMTP id 34so4631179iwn.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 06:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4imUwNZyuj8PKQkYWFZMGEhqJ2I7+2Y4sG9Ox5irsIM=;
        b=WekEoUTIwdzUAVEd96eZhnOvaHoerqkqs+Ikf7wb3ybFrT8ynN2Y+QT3C5g6lasep0
         0HLyKqjKRCXKlSnzu1+jaZlvLNpsg2NVSzDeudgfAuOHUancVGsUNLxaVBliPwZwlKm1
         C1hZ+F1lgnzMHqddBYn6MpNu6BJrDIsxWg2Ps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Hj50TzYBAgwd86Xb6oGp0feJMEH2SLJ+RdQ9nxMj2oViTEB6Uz5WVN4+j2J1Utc2uD
         HGxi803Jf0SqZN+JQWLC1oa0GhqkZYT4Ol0PFxROmV5hJc0WShpKYEFoxBLBUVyvDuu2
         dq0cjW8WyWr+NetrfTnCFjXBFbmmUwynXyj8I=
Received: by 10.42.77.3 with SMTP id g3mr7320574ick.6.1304342848901; Mon, 02
 May 2011 06:27:28 -0700 (PDT)
Received: by 10.42.219.8 with HTTP; Mon, 2 May 2011 06:27:28 -0700 (PDT)
In-Reply-To: <f768ea6e107cdd229a18df0bac3bf583eb1f9fc5.1304321122.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172583>

T24gTW9uLCBNYXkgMiwgMjAxMSBhdCA4OjM5IEFNLCBCZXJ0IFdlc2FyZyA8YmVydC53ZXNhcmdA
Z29vZ2xlbWFpbC5jb20+IHdyb3RlOgo+IFNpZ25lZC1vZmYtYnk6IEJlcnQgV2VzYXJnIDxiZXJ0
Lndlc2FyZ0Bnb29nbGVtYWlsLmNvbT4KPiAtLS0KPiDCoGdyZXAuYyB8IMKgIDEyICsrKysrKy0t
LS0tLQo+IMKgZ3JlcC5oIHwgwqAgwqA0ICsrKy0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNl
cnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2dyZXAuYyBiL2dyZXAu
Ywo+IGluZGV4IDYzYzQyODAuLmI4ZWRhOWUgMTAwNjQ0Cj4gLS0tIGEvZ3JlcC5jCj4gKysrIGIv
Z3JlcC5jCj4gQEAgLTcwLDcgKzcwLDcgQEAgc3RhdGljIHZvaWQgY29tcGlsZV9yZWdleHAoc3Ry
dWN0IGdyZXBfcGF0ICpwLCBzdHJ1Y3QgZ3JlcF9vcHQgKm9wdCkKPiDCoCDCoCDCoCDCoGlmIChw
LT5maXhlZCkKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVybjsKPgo+IC0gwqAgwqAgwqAg
ZXJyID0gcmVnY29tcCgmcC0+cmVnZXhwLCBwLT5wYXR0ZXJuLCBvcHQtPnJlZ2ZsYWdzKTsKPiAr
IMKgIMKgIMKgIGVyciA9IHJlZ2NvbXAoJnAtPnUucmVnZXhwLCBwLT5wYXR0ZXJuLCBvcHQtPnJl
Z2ZsYWdzKTsKPiDCoCDCoCDCoCDCoGlmIChlcnIpIHsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGNoYXIgZXJyYnVmWzEwMjRdOwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2hhciB3aGVyZVsx
MDI0XTsKPiBAQCAtODEsOCArODEsOCBAQCBzdGF0aWMgdm9pZCBjb21waWxlX3JlZ2V4cChzdHJ1
Y3QgZ3JlcF9wYXQgKnAsIHN0cnVjdCBncmVwX29wdCAqb3B0KQo+IMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgc3ByaW50Zih3aGVyZSwgIiVzLCAiLCBwLT5vcmlnaW4pOwo+IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgZWxzZQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgd2hlcmVbMF0gPSAwOwo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmVnZXJyb3IoZXJy
LCAmcC0+cmVnZXhwLCBlcnJidWYsIDEwMjQpOwo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmVn
ZnJlZSgmcC0+cmVnZXhwKTsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJlZ2Vycm9yKGVyciwg
JnAtPnUucmVnZXhwLCBlcnJidWYsIDEwMjQpOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmVn
ZnJlZSgmcC0+dS5yZWdleHApOwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGllKCIlcyclcyc6
ICVzIiwgd2hlcmUsIHAtPnBhdHRlcm4sIGVycmJ1Zik7Cj4gwqAgwqAgwqAgwqB9Cj4gwqB9Cj4g
QEAgLTMyMCw3ICszMjAsNyBAQCB2b2lkIGZyZWVfZ3JlcF9wYXR0ZXJucyhzdHJ1Y3QgZ3JlcF9v
cHQgKm9wdCkKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNhc2UgR1JFUF9QQVRURVJOOiAvKiBh
dG9tICovCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjYXNlIEdSRVBfUEFUVEVSTl9IRUFEOgo+
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgY2FzZSBHUkVQX1BBVFRFUk5fQk9EWToKPiAtIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJlZ2ZyZWUoJnAtPnJlZ2V4cCk7Cj4gKyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZWdmcmVlKCZwLT51LnJlZ2V4cCk7Cj4gwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazsKPiDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGRlZmF1bHQ6Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVh
azsKPiBAQCAtNDY0LDcgKzQ2NCw3IEBAIHN0YXRpYyBpbnQgbWF0Y2hfb25lX3BhdHRlcm4oc3Ry
dWN0IGdyZXBfcGF0ICpwLCBjaGFyICpib2wsIGNoYXIgKmVvbCwKPiDCoCDCoCDCoCDCoGlmIChw
LT5maXhlZCkKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGhpdCA9ICFmaXhtYXRjaChwLCBib2ws
IGVvbCwgcG1hdGNoKTsKPiDCoCDCoCDCoCDCoGVsc2UKPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGhpdCA9ICFyZWdtYXRjaCgmcC0+cmVnZXhwLCBib2wsIGVvbCwgcG1hdGNoLCBlZmxhZ3MpOwo+
ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaGl0ID0gIXJlZ21hdGNoKCZwLT51LnJlZ2V4cCwgYm9s
LCBlb2wsIHBtYXRjaCwgZWZsYWdzKTsKPgo+IMKgIMKgIMKgIMKgaWYgKGhpdCAmJiBwLT53b3Jk
X3JlZ2V4cCkgewo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKChwbWF0Y2hbMF0ucm1fc28g
PCAwKSB8fAo+IEBAIC03OTQsNyArNzk0LDcgQEAgc3RhdGljIGludCBsb29rX2FoZWFkKHN0cnVj
dCBncmVwX29wdCAqb3B0LAo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHAtPmZpeGVkKQo+
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaGl0ID0gIWZpeG1hdGNoKHAsIGJv
bCwgYm9sICsgKmxlZnRfcCwgJm0pOwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZWxzZQo+IC0g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaGl0ID0gIXJlZ21hdGNoKCZwLT5yZWdl
eHAsIGJvbCwgYm9sICsgKmxlZnRfcCwgJm0sIDApOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgaGl0ID0gIXJlZ21hdGNoKCZwLT51LnJlZ2V4cCwgYm9sLCBib2wgKyAqbGVm
dF9wLCAmbSwgMCk7Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoIWhpdCB8fCBtLnJtX3Nv
IDwgMCB8fCBtLnJtX2VvIDwgMCkKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGNvbnRpbnVlOwo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKGVhcmxpZXN0IDwgMCB8fCBt
LnJtX3NvIDwgZWFybGllc3QpCj4gZGlmZiAtLWdpdCBhL2dyZXAuaCBiL2dyZXAuaAo+IGluZGV4
IDA2NjIxZmUuLjk5MTJjMTEgMTAwNjQ0Cj4gLS0tIGEvZ3JlcC5oCj4gKysrIGIvZ3JlcC5oCj4g
QEAgLTMyLDcgKzMyLDkgQEAgc3RydWN0IGdyZXBfcGF0IHsKPiDCoCDCoCDCoCDCoGNvbnN0IGNo
YXIgKnBhdHRlcm47Cj4gwqAgwqAgwqAgwqBzaXplX3QgcGF0dGVybmxlbjsKPiDCoCDCoCDCoCDC
oGVudW0gZ3JlcF9oZWFkZXJfZmllbGQgZmllbGQ7Cj4gLSDCoCDCoCDCoCByZWdleF90IHJlZ2V4
cDsKPiArIMKgIMKgIMKgIHVuaW9uIHsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJlZ2V4X3Qg
cmVnZXhwOwo+ICsgwqAgwqAgwqAgfSB1OwoKSW5zdGVhZCBvZiB1LCB3b3VsZCBiZSB3b3J0aCB0
byByZW5hbWUgaXQgdG8gc29tZXRoaW5nIG1vcmUgZGVzY3JpcHRpdmU/Cgo+IMKgIMKgIMKgIMKg
dW5zaWduZWQgZml4ZWQ6MTsKPiDCoCDCoCDCoCDCoHVuc2lnbmVkIGlnbm9yZV9jYXNlOjE7Cj4g
wqAgwqAgwqAgwqB1bnNpZ25lZCB3b3JkX3JlZ2V4cDoxOwo+IC0tCj4gMS43LjUuMzQ5LmdmZWIx
YQo+Cj4gLS0KPiBUbyB1bnN1YnNjcmliZSBmcm9tIHRoaXMgbGlzdDogc2VuZCB0aGUgbGluZSAi
dW5zdWJzY3JpYmUgZ2l0IiBpbgo+IHRoZSBib2R5IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRvbW9A
dmdlci5rZXJuZWwub3JnCj4gTW9yZSBtYWpvcmRvbW8gaW5mbyBhdCDCoGh0dHA6Ly92Z2VyLmtl
cm5lbC5vcmcvbWFqb3Jkb21vLWluZm8uaHRtbAo+Cg==
