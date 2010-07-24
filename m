From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/9] setup: split off $GIT_DIR-set case from 
	setup_git_directory_gently
Date: Sat, 24 Jul 2010 22:15:56 +1000
Message-ID: <AANLkTikvG8qUgd0p=moft1+7L+L-knVt0AZP0o=rsEmM@mail.gmail.com>
References: <1279886651-14590-1-git-send-email-pclouds@gmail.com> 
	<20100724111505.GC7150@burratino> <20100724111944.GC16054@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 14:16:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcdeQ-0006Vw-Al
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 14:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab0GXMQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 08:16:17 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:40313 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab0GXMQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 08:16:16 -0400
Received: by pxi14 with SMTP id 14so4019975pxi.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 05:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=tMNFdI+NxkaIjd2ZaA+KW7BdsCGruBY2cfXmPWyxRtk=;
        b=sxWmW4B53HGwCj8PxLHsBokJRJA1/6NH7B0wVald2NmZxPW21NiroFD3h8l9YUR3SC
         yh6QdgTKVrWtm4dDkrzM4KIuj7iTlNSWssVKcGvwyfcOxAXP9RX88crCyRyeO4SWdpoj
         0SjisD7kvkDsREzc0BBiDQnCImMnk/UjEw5Ec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nuq0Pv71HWRsWx4a0B0K/lRBdYhIRCXhpDrHF56Z0qtZmDUYMG8oBA/3BsMrAU+S5R
         pqmcTl1oeHlTrzorb9uETyBbkqLWDzSLXK0KCJU2KRKzNpzWs41L+q3ySlR/DqMbc7Qm
         VTaCoroAAGyZH/T5eWhEl7ve225ACmEC8jxnk=
Received: by 10.142.237.12 with SMTP id k12mr5786365wfh.69.1279973776105; Sat, 
	24 Jul 2010 05:16:16 -0700 (PDT)
Received: by 10.142.98.1 with HTTP; Sat, 24 Jul 2010 05:15:56 -0700 (PDT)
In-Reply-To: <20100724111944.GC16054@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151625>

MjAxMC83LzI0IEpvbmF0aGFuIE5pZWRlciA8anJuaWVkZXJAZ21haWwuY29tPjoKPiArc3RhdGlj
IGNvbnN0IGNoYXIgKnNldHVwX2V4cGxpY2l0X2dpdF9kaXIoY29uc3QgY2hhciAqZ2l0ZGlyZW52
LAo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY29uc3Qg
Y2hhciAqd29ya190cmVlX2VudiwgaW50ICpub25naXRfb2spCj4gK3sKPiArIMKgIMKgIMKgIHN0
YXRpYyBjaGFyIGJ1ZmZlclsxMDI0ICsgMV07Cj4gKyDCoCDCoCDCoCBjb25zdCBjaGFyICpyZXR2
YWw7Cj4gKwo+ICsgwqAgwqAgwqAgaWYgKFBBVEhfTUFYIC0gNDAgPCBzdHJsZW4oZ2l0ZGlyZW52
KSkKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRpZSgiJyQlcycgdG9vIGJpZyIsIEdJVF9ESVJf
RU5WSVJPTk1FTlQpOwo+ICsgwqAgwqAgwqAgaWYgKCFpc19naXRfZGlyZWN0b3J5KGdpdGRpcmVu
dikpIHsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChub25naXRfb2spIHsKPiArIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgICpub25naXRfb2sgPSAxOwo+ICsgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIE5VTEw7Cj4gKyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB9Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkaWUoIk5vdCBhIGdpdCByZXBvc2l0b3J5
OiAnJXMnIiwgZ2l0ZGlyZW52KTsKPiArIMKgIMKgIMKgIH0KPiArIMKgIMKgIMKgIGlmICghd29y
a190cmVlX2Vudikgewo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dmFsID0gc2V0X3dvcmtf
dHJlZShnaXRkaXJlbnYpOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyogY29uZmlnIG1heSBv
dmVycmlkZSB3b3JrdHJlZSAqLwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKGNoZWNrX3Jl
cG9zaXRvcnlfZm9ybWF0X2dlbnRseShub25naXRfb2spKQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgcmV0dXJuIE5VTEw7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1
cm4gcmV0dmFsOwo+ICsgwqAgwqAgwqAgfQo+ICsgwqAgwqAgwqAgaWYgKGNoZWNrX3JlcG9zaXRv
cnlfZm9ybWF0X2dlbnRseShub25naXRfb2spKQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0
dXJuIE5VTEw7Cj4gKyDCoCDCoCDCoCByZXR2YWwgPSBnZXRfcmVsYXRpdmVfY3dkKGJ1ZmZlciwg
c2l6ZW9mKGJ1ZmZlcikgLSAxLAo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
Z2V0X2dpdF93b3JrX3RyZWUoKSk7CgpOb3RlIHRvIHNlbGYsIGN3ZCBzaG91bGQgYmUgcGFzc2Vk
IHRvIHNldHVwX2V4cGxpY2l0X2dpdF9kaXIsIHRoZW4KZHJvcCBnZXRfcmVsYXRpdmVfY3dkKCkg
aW4gZmF2b3Igb2YgcHJlZml4Y21wKCkuIE9uZSBsZXNzIGdldGN3ZCBjYWxsLApidWZmZXIgd2ls
bCBub3QgYmUgbm90IG5lZWRlZC4gQW5kIHByb2JhYmx5IGVhc2llciB0byB1bmRlcnN0YW5kLgot
LSAKRHV5Cg==
