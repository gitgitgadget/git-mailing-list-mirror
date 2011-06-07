From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 2/4] Add infrastructure for ref namespaces
Date: Tue, 7 Jun 2011 21:12:09 +0200
Message-ID: <BANLkTika2C9iw7E6Z-HRW=4KNstYqMbxrw@mail.gmail.com>
References: <7vsjrna2x2.fsf@alter.siamese.dyndns.org>
	<1307470885-4018-1-git-send-email-jamey@minilop.net>
	<1307470885-4018-3-git-send-email-jamey@minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 21:12:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU1hZ-0001Fw-OE
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 21:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758078Ab1FGTM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 15:12:29 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48393 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628Ab1FGTM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 15:12:28 -0400
Received: by fxm17 with SMTP id 17so23351fxm.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 12:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+XrvokkvWtFIt2lpEFayGHKEDzvQuQnNcPi6yFmMbo4=;
        b=CppVTXg98ZVL97BDagDHIGmqertI/CAfNVamweDPyWejgMjGyDFO1o8jcqzEFhEeFS
         wVz/urL16VXeIYWoFRd/NDS2iD1hHWqVDnbR0sdobYNlbAbLcP29xYxMmXYu1LBSIiUk
         rfPZ1KGiqnMWw0olpbhC+H6c0qhXrvTwCiF58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iB7MYaZ2tTXuQZ5RQsNGhCtuVSgbiHdqPY014yI/6gLOhb8sY3SmbZIbZmHdjrVG42
         7toX2dRuhqeGUpQmcfjVad9emCQJdo8M+8fRDvqvakgSW1qeY/arMXI/FmWWYkDNRISp
         69c+HXyWsU97FtYvCR8MX83GwwrPRAvW5tDEo=
Received: by 10.223.14.137 with SMTP id g9mr108387faa.2.1307473929813; Tue, 07
 Jun 2011 12:12:09 -0700 (PDT)
Received: by 10.223.87.70 with HTTP; Tue, 7 Jun 2011 12:12:09 -0700 (PDT)
In-Reply-To: <1307470885-4018-3-git-send-email-jamey@minilop.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175253>

T24gVHVlLCBKdW4gNywgMjAxMSBhdCAyMDoyMSwgSmFtZXkgU2hhcnAgPGphbWV5QG1pbmlsb3Au
bmV0PiB3cm90ZToKPiBkaWZmIC0tZ2l0IGEvZ2l0LmMgYi9naXQuYwo+IGluZGV4IDg5NzIxZDQu
Ljk4Y2JmN2IgMTAwNjQ0Cj4gLS0tIGEvZ2l0LmMKPiArKysgYi9naXQuYwo+IEBAIC0xMjYsNiAr
MTI2LDIwIEBAIHN0YXRpYyBpbnQgaGFuZGxlX29wdGlvbnMoY29uc3QgY2hhciAqKiphcmd2LCBp
bnQgKmFyZ2MsIGludCAqZW52Y2hhbmdlZCkKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoHNldGVudihHSVRfRElSX0VOVklST05NRU5ULCBjbWQgKyAxMCwgMSk7Cj4gwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpZiAoZW52Y2hhbmdlZCkKPiDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCplbnZjaGFuZ2VkID0gMTsKPiAr
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIH0gZWxzZSBpZiAoIXN0cmNtcChjbWQsICItLW5hbWVzcGFj
ZSIpKSB7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoKmFyZ2MgPCAy
KSB7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmcHJp
bnRmKHN0ZGVyciwgIk5vIGRpcmVjdG9yeSBnaXZlbiBmb3IgLS1uYW1lc3BhY2UuXG4iICk7CgpU
aGlzICdkaXJlY3RvcnknIGlzIHByb2JhYmx5IG1pc25hbWVkIGhlcmUuCgpCZXJ0Cgo+ICsgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdXNhZ2UoZ2l0X3VzYWdl
X3N0cmluZyk7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9Cj4gKyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzZXRlbnYoR0lUX05BTUVTUEFDRV9FTlZJUk9O
TUVOVCwgKCphcmd2KVsxXSwgMSk7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBpZiAoZW52Y2hhbmdlZCkKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgICplbnZjaGFuZ2VkID0gMTsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgICgqYXJndikrKzsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICgq
YXJnYyktLTsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH0gZWxzZSBpZiAoIXByZWZpeGNtcChj
bWQsICItLW5hbWVzcGFjZT0iKSkgewo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgc2V0ZW52KEdJVF9OQU1FU1BBQ0VfRU5WSVJPTk1FTlQsIGNtZCArIDEyLCAxKTsKPiArIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChlbnZjaGFuZ2VkKQo+ICsgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgKmVudmNoYW5nZWQgPSAxOwo+
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfSBlbHNlIGlmICghc3RyY21wKGNtZCwgIi0td29yay10
cmVlIikpIHsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGlmICgqYXJnYyA8
IDIpIHsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGZw
cmludGYoc3RkZXJyLCAiTm8gZGlyZWN0b3J5IGdpdmVuIGZvciAtLXdvcmstdHJlZS5cbiIgKTsK
