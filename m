From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] get_sha1: support relative path "<obj>:<sth>" syntax
Date: Thu, 11 Nov 2010 08:30:42 +0700
Message-ID: <AANLkTimxR1YV+D2HBHUr8bCbrT7XyHfKoMN71raUZ3Jx@mail.gmail.com>
References: <m3eiatfbg2.fsf@localhost.localdomain> <1289407021-30287-1-git-send-email-pclouds@gmail.com>
 <7veiatht1b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, jnareb@gmail.com, dirson@bertin.fr,
	kevin@sb.org, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 02:31:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGM0Q-0007b7-Me
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 02:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139Ab0KKBbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 20:31:08 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55400 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078Ab0KKBbH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 20:31:07 -0500
Received: by wwb39 with SMTP id 39so1469763wwb.1
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 17:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5G/gbwb/IvvhGv4JcTgWyA9oKxCJpuLrzNnJrDX0ujY=;
        b=faPLkLC6pdZE7pVhob0v48FrmlAxlGKtZ97A0V8DZeBam9pnKUa1GUvhpx7qN4GeA5
         V5WTSeu8rrSjgs2soa7tAx+Qaj1Cu8g50J7OSmGTCd/oDW2VvSZWAApAo6YAVEfHScMD
         KL/sG80HrqbWy0WJ9Ti9Ra57cFmAG+/+Xnl84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xz1gyOXOR1LIe8FYNvwbwAlamP633N9sUDXqiIr+l0v67C7kcpPX/x2dRycbBOJ8X9
         2u/tRLP+LtqPLlMjYVn0k44zYItbAGMf8g/jphOb9csjzbcMdhFHnrSGCu7lo+Ty2pQt
         96AMUjuYHrLQFDFTHOP6qKZt7EZxhwsciJTQ8=
Received: by 10.216.172.9 with SMTP id s9mr90883wel.56.1289439063613; Wed, 10
 Nov 2010 17:31:03 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Wed, 10 Nov 2010 17:30:42 -0800 (PST)
In-Reply-To: <7veiatht1b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161201>

MjAxMC8xMS8xMSBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2JveC5jb20+Ogo+IE5ndXnhu4Vu
IFRow6FpIE5n4buNYyBEdXkgwqA8cGNsb3Vkc0BnbWFpbC5jb20+IHdyaXRlczoKPgo+PiDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBpZiAobmFtZWxlbiA8IDMgfHwKPj4gwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgbmFtZVsyXSAhPSAnOicgfHwKPj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBu
YW1lWzFdIDwgJzAnIHx8ICczJyA8IG5hbWVbMV0pCj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgbmFtZVsxXSA8ICcwJyB8fCAnMycgPCBuYW1lWzFdKSB7Cj4+IMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGNwID0gbmFtZSArIDE7Cj4+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgaWYgKHN0YXJ0dXBfaW5mbyAmJiBjcFswXSA9PSAnLicgJiYKPj4gKyDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAoY3BbMV0gPT0gJy8nIHx8IChjcFsxXSA9PSAn
LicgJiYgY3BbMl0gPT0gJy8nKSkpIHsKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBuZXdfcGF0aCA9IHByZWZpeF9wYXRoKHN0YXJ0dXBfaW5mby0+cHJlZml4
LAo+PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3RybGVuKHN0YXJ0dXBfaW5mby0+cHJlZml4KSwK
Pj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNwKTsKPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBjcCA9IG5ld19wYXRoOwo+PiArIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIH0KPj4gKyDCoCDCoCDCoCDCoCDCoCDCoCB9Cj4KPiBXaGF0IGRvZXMgdGhp
cyBuZXcgY29kZXBhdGggZG8gd2hlbiB3ZSBrbm93IHdoZXJlIHRoZSB3b3JraW5nIHRyZWUgaXMg
YW5kCj4gd2UgYXJlIG91dHNpZGUgb2YgdGhlIHdvcmtpbmcgdHJlZSAoZS5nLiB3ZSBhcmUgbG9v
a2luZyBhdCB0aGUgaW5kZXggb3IgYQo+IGNvbW1pdCBpbiBhIHN1Ym1vZHVsZSBmcm9tIGFib3Zl
IHRoZSBzdXBlcnByb2plY3QpPwo+Cj4gV2hhdCBzaG91bGQgaXQgZG8/CgpQcmVmaXggaXMgTlVM
TCBpbiB0aGF0IGNhc2UuIFNvIG5vIHByZWZpeGluZywgZ2l0IHdpbGwgY29tcGxhaW4gdGhlCmdp
dmVuIHBhdGggZG9lcyBub3QgZXhpc3QgKGFsdGhvdWdoIGl0IHNob3VsZCBzYXkgIi4vIiBzeW50
YXggaXMgbm90CnVzYWJsZSB3aXRob3V0IGEgd29ya3RyZWUpLgoKcHJlZml4X3BhdGgoKSBkaWVz
IGlmIHRoZSByZXNvbHZlZCBwYXRoIGlzIG91dHNpZGUgcmVwby4gU28gbm8sIHVzZXJzCmNhbid0
IGxvb2sgdXAgZmlsZXMgaW4gc3VwZXJwcm9qZWN0IGZyb20gYSBzdWJwcm9qZWN0LiBJIHRoaW5r
IHdlIG5lZWQKdG8gZGVmaW5lIHRoZSBzdXBlcnByb2plY3Qvc3VicHJvamVjdCByZWxhdGlvbiBm
aXJzdC4gSSBoYXZlCiRIT01FLy5naXQsIGJ1dCBJIGRvbid0IHRoaW5rIGl0J3MgYSBzdXBlcnBy
b2plY3QgdG8gYW55IHJlcG9zIGluc2lkZQpteSAkSE9NRS4KLS0gCkR1eQo=
