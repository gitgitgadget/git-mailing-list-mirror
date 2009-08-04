From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/5] grep: skip files outside sparse checkout area
Date: Tue, 4 Aug 2009 20:14:08 +0700
Message-ID: <fcaeb9bf0908040614r6c1ba65dw98c63a48b82df0aa@mail.gmail.com>
References: <1248850154-5469-1-git-send-email-pclouds@gmail.com> 
	<1248850154-5469-2-git-send-email-pclouds@gmail.com> <1248850154-5469-3-git-send-email-pclouds@gmail.com> 
	<7vljm4st0w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 15:14:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYJqg-0001cN-CA
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 15:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466AbZHDNO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 09:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755287AbZHDNO2
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 09:14:28 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:65213 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754383AbZHDNO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 09:14:28 -0400
Received: by yxe5 with SMTP id 5so2887656yxe.33
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 06:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=27xk23dcz7oefg1koMPoS7vgj60+AsGBlpj7d2V9im8=;
        b=tvi89u+oxecxZiRq5dRyWPCFJtFjTEqAN8uOPG3QwkZ/DRfGOLDEKMHiLxeBLegKAH
         0f6DK1uYbw0MvU+ZPaN9AMqTlEywY3sL+PDASeRnRZ1NEfnwwoBSsmEwQTow2XMPrYAV
         gfARk6Yryxnr+TCTvMDYDk2KM9iXSfYbPhrgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vf4kHelO/YUPCK7dMVtscgrRj6s9Rgcpx4gwUDwz7wtfNSbMvP4tqFGnadb+ncrELN
         hrvW5DaiN1W6O7ulntBWwBrQUCIaXWttW2icyacf7Pxh9wkbxE4RBLpkdkhl+D+m2pxk
         amZLr0HTvlYB7B5qTOU6aMD+TTJwwq7bGTpPg=
Received: by 10.100.229.14 with SMTP id b14mr9895360anh.156.1249391668238; 
	Tue, 04 Aug 2009 06:14:28 -0700 (PDT)
In-Reply-To: <7vljm4st0w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124786>

MjAwOS83LzMxIEp1bmlvIEMgSGFtYW5vIDxnaXRzdGVyQHBvYm94LmNvbT46Cj4+IEBAIC01MjIs
OCArNTI0LDExIEBAIHN0YXRpYyBpbnQgZ3JlcF9jYWNoZShzdHJ1Y3QgZ3JlcF9vcHQgKm9wdCwg
Y29uc3QgY2hhciAqKnBhdGhzLCBpbnQgY2FjaGVkLAo+PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjb250aW51ZTsKPj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgaGl0IHw9IGdyZXBfc2hhMShvcHQsIGNlLT5zaGExLCBjZS0+bmFtZSwgMCk7
Cj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIH0KPj4gLSDCoCDCoCDCoCDCoCDCoCDCoCBlbHNlCj4+
ICsgwqAgwqAgwqAgwqAgwqAgwqAgZWxzZSB7Cj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgaWYgKGNlLT5jZV9mbGFncyAmIENFX1ZBTElEKQo+PiArIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNvbnRpbnVlOwo+PiDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBoaXQgfD0gZ3JlcF9maWxlKG9wdCwgY2UtPm5hbWUpOwo+PiArIMKgIMKg
IMKgIMKgIMKgIMKgIH0KPj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKGNlX3N0YWdlKGNlKSkg
ewo+PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkbyB7Cj4+IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG5yKys7Cj4KPiBJIGRvIG5vdCB0aGlu
ayB0aGUgbmV3IGNvZGUgaW4gdGhpcyBodW5rIHdpbGwgYmUgcmVhY2hlZCBhcyB0aGUgb3RoZXIg
YXJtCj4gb2YgdGhlICJlbHNlIiBncmVwcyBpbiB0aGUgaW5kZXggd2hlbiBDRV9WQUxJRCBpcyBz
ZXQuCj4KPiBIYXMgdGhpcyBzZXJpZXMgYmVlbiB0ZXN0ZWQgb3Igc2VsZi1yZXZpZXdlZCB5ZXQ/
CgpZZXMgYW5kIG5vLiBJdCBoYWQgYmVlbiB0ZXN0ZWQgYW5kIHNlbGYtcmV2aWV3ZWQgYmFjayB3
aGVuIGl0IHdhcyBwYXJ0Cm9mIG9yaWdpbmFsIHNlcmllcy4gVGhlcmUgdGhlIG5ldyBjb2RlIHdh
cyBDRV9OT19DSEVDS09VVCBjaGVjaywgbm90CkNFX1ZBTElELiBJIGdyZXBwZWQgdGhyb3VnaCBh
bmQgcmVwbGFjZWQgd2l0aCBDRV9WQUxJRCB0byBmb3JtIGEgbmV3CmRyYWZ0IGluIG9yZGVyIHRv
IGdldCBjb21tZW50cyBhYm91dCB0aGlzIGRpcmVjdGlvbiwgdGhpcyB0aW1lIGl0IHdhcwpub3Qg
d2VsbCB0ZXN0ZWQgYmVjYXVzZSBteSBmb2N1cyB3YXMgaW4gdGhlIGxhc3QgcGF0Y2guCi0tIApE
dXkK
