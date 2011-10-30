From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/WIP 05/11] symbolize return values of tree_entry_interesting()
Date: Sun, 30 Oct 2011 16:17:43 +0700
Message-ID: <CACsJy8BshQT=iZRHXLaaVaohYRX5tYvCvVZSPPVbVuMX2gSW9w@mail.gmail.com>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 <1319438176-7304-6-git-send-email-pclouds@gmail.com> <7vbot2z3gf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 30 10:18:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKRX3-0003FJ-Lr
	for gcvg-git-2@lo.gmane.org; Sun, 30 Oct 2011 10:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472Ab1J3JSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Oct 2011 05:18:16 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36730 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110Ab1J3JSP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2011 05:18:15 -0400
Received: by bkbzt4 with SMTP id zt4so1410049bkb.19
        for <git@vger.kernel.org>; Sun, 30 Oct 2011 02:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2SmxNpvDe9zLkAK7XWIBTU8l8fVJA5QHfKInrqGuuPA=;
        b=MHqWN/fTcRIPE9IglKald8cGjWtxCYM3m8/bISdSKbM/TAuyiOC+pP6G+uDrJT+zMc
         JKfIICRFeprMnVzJsLh9eDmzXPHViHdUbWBtLww1WAxnD2tk9W7woCfNk6FOZY9Se0Rr
         nWfj5Jq9yAnbFCQpzVuY/gzQGRZCWdM4fy3kc=
Received: by 10.204.147.215 with SMTP id m23mr7061613bkv.84.1319966294213;
 Sun, 30 Oct 2011 02:18:14 -0700 (PDT)
Received: by 10.204.114.2 with HTTP; Sun, 30 Oct 2011 02:17:43 -0700 (PDT)
In-Reply-To: <7vbot2z3gf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184469>

MjAxMS8xMC8yOCBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2JveC5jb20+Ogo+PiDCoHN0YXRp
YyB2b2lkIHNraXBfdW5pbnRlcmVzdGluZyhzdHJ1Y3QgdHJlZV9kZXNjICp0LCBzdHJ1Y3Qgc3Ry
YnVmICpiYXNlLAo+PiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
c3RydWN0IGRpZmZfb3B0aW9ucyAqb3B0LCBpbnQgKm1hdGNoKQo+PiArIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RydWN0IGRpZmZfb3B0aW9ucyAqb3B0LAo+PiAr
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZW51bSBpbnRlcmVzdGlu
ZyAqbWF0Y2gpCj4+IMKgewo+PiDCoCDCoCDCoCB3aGlsZSAodC0+c2l6ZSkgewo+PiDCoCDCoCDC
oCDCoCDCoCDCoCDCoCAqbWF0Y2ggPSB0cmVlX2VudHJ5X2ludGVyZXN0aW5nKCZ0LT5lbnRyeSwg
YmFzZSwgMCwgJm9wdC0+cGF0aHNwZWMpOwo+PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoKm1h
dGNoKSB7Cj4+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKCptYXRjaCA8IDAp
Cj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKCptYXRjaCA9PSBhbGxfZW50
cmllc19ub3RfaW50ZXJlc3RpbmcpCj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHQtPnNpemUgPSAwOwo+PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBicmVhazsKPj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgfQo+Cj4gVGhlIGNhbGxlciBvZiB0
aGlzIGZ1bmN0aW9uIG5lZWRzIHRvIGJlIHVwZGF0ZWQgYXMgd2VsbC4KClllYWgsIHRoYW5rcy4K
Cj4gQnV0IEkgaGF2ZSB0byB3b25kZXIgd2h5IHRoaXMgc2tpcF91bmludGVyZXN0aW5nKCkgZG9l
cyBub3QgcGVlayB0aGUKPiBvcmlnaW5hbCB2YWx1ZSBvZiAqbWF0Y2ggYW5kIHNraXAsIHdoaWNo
IGlzIHRoZSBsb29wIHN0cnVjdHVyZSB0aGUgb3RoZXIKPiBjYWxsZXIgb2YgdHJlZV9lbnRyeV9p
bnRlcmVzdGluZygpIGluIHRoaXMgZmlsZSBoYXMuCgpQcm9iYWJseSBiZWNhdXNlIG5vIG9uZSBh
c2tlZCB0aGF0IHF1ZXN0aW9uIGJlZm9yZS4gSSB0aGluayBpdCBtYWtlcwpzZW5zZSBmb3Igc2tp
cF91bmludGVyZXN0aW5nKCkgdG8gc2tpcCB0X2VfaSgpIHdoZW4gKm1hdGNoID09IC0xIG9yIDIu
ClRoYW5rcy4KLS0gCkR1eQo=
