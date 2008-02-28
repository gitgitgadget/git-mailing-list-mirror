From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 6/9] Completely move out worktree setup from setup_git_directory_gently()
Date: Thu, 28 Feb 2008 10:31:01 +0700
Message-ID: <fcaeb9bf0802271931t559d4bd1n86bb5c644b082274@mail.gmail.com>
References: <cover.1204130175.git.pclouds@gmail.com>
	 <20080227163934.GA28084@laptop>
	 <7vy795lt89.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 04:31:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUZUj-0005Zt-Tm
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 04:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754594AbYB1DbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 22:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754687AbYB1DbE
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 22:31:04 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:54561 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470AbYB1DbC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 22:31:02 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2519755fga.17
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 19:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=hsvCIT0dlVeL8+d+V9eWF2N9nTsDA60d1fkwpQXD9iw=;
        b=aFTKHhgZ9jtQB2oLJBFkux+P3ycWj8vm/OeoItbNOALKx2xdoGpLYSQRc0YHJyawDtpdI+Bcv/2Jsy6Nf74+kfMArp0kvuaZ1+eDlzG/dNu1+apI92ghucMClVTQ1C2hB9Z12rYe8GkBqUMJGgK8H4X9/HvIQqT+Yeu+qPw79QY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IPURoAqR+Xdu6eeYuSP2wX7bH5PeI0aHXloStJ+d0Y2BMBteif9XCPn1oEek38U7v/CuBMTly42U6+3dZ6p62lM7SUhgJ/Ms686/hxAxtEwLi9fe3sPvD9iKatgVz0PpBipLam/yKFDQb8OIhPeEGBmS1RPjp/0yJiaqUE5h0nM=
Received: by 10.86.77.5 with SMTP id z5mr7235762fga.5.1204169461385;
        Wed, 27 Feb 2008 19:31:01 -0800 (PST)
Received: by 10.86.83.3 with HTTP; Wed, 27 Feb 2008 19:31:01 -0800 (PST)
In-Reply-To: <7vy795lt89.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75345>

T24gVGh1LCBGZWIgMjgsIDIwMDggYXQgOToxNyBBTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJA
cG9ib3guY29tPiB3cm90ZToKPiBOZ3V54buFbiBUaMOhaSBOZ+G7jWMgRHV5IDxwY2xvdWRzQGdt
YWlsLmNvbT4gd3JpdGVzOgo+Cj4gID4gLSAgICAgcHJlZml4ID0gc2V0dXBfZ2l0X2RpcmVjdG9y
eV9nZW50bHkoJm5vbmdpdCk7Cj4gID4gLSAgICAgaW5pdF9yZXZpc2lvbnMoJnJldiwgcHJlZml4
KTsKPiAgPiArICAgICBzZXR1cF9naXRfZGlyZWN0b3J5X2dlbnRseSgmbm9uZ2l0KTsKPiAgPiAr
ICAgICBpbml0X3JldmlzaW9ucygmcmV2LCBOVUxMKTsKPgo+Cj4KPiA+IEBAIC0yMzMsMTkgKzIz
MywyMCBAQCBpbnQgY21kX2RpZmYoaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2LCBjb25zdCBj
aGFyICpwcmVmaXgpCj4gID4gLi4uCj4KPiA+IC0gICAgIGluaXRfcmV2aXNpb25zKCZyZXYsIHBy
ZWZpeCk7Cj4gID4gKyAgICAgaW5pdF9yZXZpc2lvbnMoJnJldiwgTlVMTCk7Cj4KPiAgSG1tLiAg
SG93IGlzIHRoZSBlZmZlY3Qgb2YgdGhpcyBjaGFuZ2UgY29tcGVuc2F0ZWQgbGF0ZXIgdG8gZ2l2
ZQo+ICBwcm9wZXIgcHJlZml4IHZhbHVlIHRvIHJldi5kaWZmb3B0LnByZWZpeD8KPgoKSSBhc3N1
bWUgeW91IG1lYW50IHJldi5wcmVmaXg/IHJldi5wcmVmaXggaXMgc2V0IHJpZ2h0IGJlZm9yZQpz
ZXR1cF9yZXZpc2lvbnMoKS4gKGdyci4uIEkgdGhpbmsgSSBsZWZ0IGFuIHJlZHVuZGFudApyZXYu
ZGlmZm9wdC5za2lwX3N0YXRfdW5tYXRjaCBhc3NpZ25tZW50KQotLSAKRHV5Cg==
