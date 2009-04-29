From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Workaround for ai_canonname sometimes coming back as null
Date: Wed, 29 Apr 2009 23:55:01 +0200
Message-ID: <81b0412b0904291455n47f83e9ftcbdec0ff1c0ea03@mail.gmail.com>
References: <9C355DCC-0240-4B9E-83CA-083B51C2E34C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: Augie Fackler <durin42@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 23:55:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzHkl-00040D-R4
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 23:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756940AbZD2VzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 17:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752520AbZD2VzE
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 17:55:04 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:53641 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbZD2VzC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 17:55:02 -0400
Received: by bwz7 with SMTP id 7so1455861bwz.37
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uM3OS1Tq5+tPMmvCkwU1e42I1ilTUaKo1Nx909yALAE=;
        b=AECMB/J/KYlhL4Mc0WX9+SB3Ix3VRCWnO5cBwbrBdk9TdCxY3zGp6ew5UOT+I2yHUi
         canI8q7fVc5w7Wf2CHWTksup5fCm42G0zPCAvojeiykYS4j1c4tACmGHVYQkdqIpuadf
         E1woxQjam1D63JW0adDIi/oAZUiNB4mJ+MlCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=utb5413ClvnU0VTH4fLiEQkrQcW6I4d0/+pra0HkzUUqhuHt4uy+vFLWNy4H17GbHN
         A65kvQ8N7I7L7tU50zn2OR2LzrKWZW6hINfGqFPaf7B2GDEl9jMZEYoBudvjalggaSJH
         5PDDKU1Jc3rIdWeQiRmVg9tzAuZYA3V5JjyuA=
Received: by 10.204.65.1 with SMTP id g1mr761281bki.57.1241042101441; Wed, 29 
	Apr 2009 14:55:01 -0700 (PDT)
In-Reply-To: <9C355DCC-0240-4B9E-83CA-083B51C2E34C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117959>

MjAwOS80LzI5IEF1Z2llIEZhY2tsZXIgPGR1cmluNDJAZ21haWwuY29tPjoKPiBAQCAtNDU5LDcg
KzQ1OSwxMCBAQCBzdGF0aWMgdm9pZCBwYXJzZV9leHRyYV9hcmdzKGNoYXIgKmV4dHJhX2FyZ3Ms
IGludAo+IGJ1ZmxlbikKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoGluZXRfbnRvcChBRl9JTkVULCAmc2luX2FkZHItPnNpbl9hZGRyLAo+IMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYWRk
cmJ1Ziwgc2l6ZW9mKGFkZHJidWYpKTsKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoGZyZWUoY2Fub25faG9zdG5hbWUpOwo+IC0gwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY2Fub25faG9zdG5hbWUgPSB4c3RyZHVwKGFp
LT5haV9jYW5vbm5hbWUpOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgaWYgKGFpLT5haV9jYW5vbm5hbWUpCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBjYW5vbl9ob3N0bmFtZSA9Cj4geHN0
cmR1cChhaS0+YWlfY2Fub25uYW1lKTsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIGVsc2UKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNhbm9uX2hvc3RuYW1lID0gInVua25vd24iOwoKVGhp
cyBsYXN0IGxpbmUgd2lsbCBjcmFzaCBzb21lIGxpbmVzIGRvd24sIHdoZW4gY2Fub25faG9zdG5h
bWUgaXMgZnJlZSdkOgoKCQlpbmV0X250b3AoaGVudC0+aF9hZGRydHlwZSwgJnNhLnNpbl9hZGRy
LAoJCQkgIGFkZHJidWYsIHNpemVvZihhZGRyYnVmKSk7CgoJCWZyZWUoY2Fub25faG9zdG5hbWUp
OyAvKiBDUkFTSCAqLwoJCWNhbm9uX2hvc3RuYW1lID0geHN0cmR1cChoZW50LT5oX25hbWUpOwoJ
CWZyZWUoaXBfYWRkcmVzcyk7Cg==
