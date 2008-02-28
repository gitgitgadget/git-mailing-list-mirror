From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 6/9] Completely move out worktree setup from setup_git_directory_gently()
Date: Thu, 28 Feb 2008 11:09:54 +0700
Message-ID: <fcaeb9bf0802272009s4ea773b3i6123ac5012b471a@mail.gmail.com>
References: <cover.1204130175.git.pclouds@gmail.com>
	 <20080227163934.GA28084@laptop>
	 <7vy795lt89.fsf@gitster.siamese.dyndns.org>
	 <fcaeb9bf0802271931t559d4bd1n86bb5c644b082274@mail.gmail.com>
	 <7vk5kplpj2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 05:11:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUa6p-00050n-8a
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 05:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755720AbYB1EJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 23:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755567AbYB1EJ4
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 23:09:56 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:24803 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbYB1EJz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 23:09:55 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1735879nfb.21
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 20:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=dwp1y4su87qKSflG2dsbMFShVbWYnT4N/ThyHe6BaPk=;
        b=PFPdsib7kS9Mm55MD90mAQrEMChxqJX6ZN9ULsflydFCqIlppTbNfflmo1PLFvFqqSWIb2HsBxfaPfkE81V8T7MOedzUxdqssrjLMa1Mt9jt0DRn6N12BuqvkJne/Busua+SuVgv2IX9s+IBX6UB5ZlvFYznAViGbtP71gIuKmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZxadUPzOuUmoSDtLSR8TgDEI44+Mrw/rpcSG+/qI1H1S2EnVDdzxREF3Nth0oFhpSBkcQqe3h77ZX0sKGwl16bdFjS3CBz8IcZ1tCjvqgRbSTKnr5j1n5b21xNs4ekHqKs4EcrXsi6fKlR81p0OyMZK0qB9OqUf3tUvBOm1c/8Q=
Received: by 10.86.54.3 with SMTP id c3mr7297284fga.18.1204171794290;
        Wed, 27 Feb 2008 20:09:54 -0800 (PST)
Received: by 10.86.83.3 with HTTP; Wed, 27 Feb 2008 20:09:54 -0800 (PST)
In-Reply-To: <7vk5kplpj2.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75350>

T24gVGh1LCBGZWIgMjgsIDIwMDggYXQgMTA6MzcgQU0sIEp1bmlvIEMgSGFtYW5vIDxnaXRzdGVy
QHBvYm94LmNvbT4gd3JvdGU6Cj4KPiAiTmd1eWVuIFRoYWkgTmdvYyBEdXkiIDxwY2xvdWRzQGdt
YWlsLmNvbT4gd3JpdGVzOgo+Cj4gID4gT24gVGh1LCBGZWIgMjgsIDIwMDggYXQgOToxNyBBTSwg
SnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPiB3cm90ZToKPiAgPj4gTmd1eeG7hW4g
VGjDoWkgTmfhu41jIER1eSA8cGNsb3Vkc0BnbWFpbC5jb20+IHdyaXRlczoKPiAgPj4KPiAgPj4g
ID4gLSAgICAgcHJlZml4ID0gc2V0dXBfZ2l0X2RpcmVjdG9yeV9nZW50bHkoJm5vbmdpdCk7Cj4g
ID4+ICA+IC0gICAgIGluaXRfcmV2aXNpb25zKCZyZXYsIHByZWZpeCk7Cj4gID4+ICA+ICsgICAg
IHNldHVwX2dpdF9kaXJlY3RvcnlfZ2VudGx5KCZub25naXQpOwo+ICA+PiAgPiArICAgICBpbml0
X3JldmlzaW9ucygmcmV2LCBOVUxMKTsKPiAgPj4KPiAgPj4KPiAgPj4KPiAgPj4gPiBAQCAtMjMz
LDE5ICsyMzMsMjAgQEAgaW50IGNtZF9kaWZmKGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndiwg
Y29uc3QgY2hhciAqcHJlZml4KQo+ICA+PiAgPiAuLi4KPiAgPj4KPiAgPj4gPiAtICAgICBpbml0
X3JldmlzaW9ucygmcmV2LCBwcmVmaXgpOwo+ICA+PiAgPiArICAgICBpbml0X3JldmlzaW9ucygm
cmV2LCBOVUxMKTsKPiAgPj4KPiAgPj4gIEhtbS4gIEhvdyBpcyB0aGUgZWZmZWN0IG9mIHRoaXMg
Y2hhbmdlIGNvbXBlbnNhdGVkIGxhdGVyIHRvIGdpdmUKPiAgPj4gIHByb3BlciBwcmVmaXggdmFs
dWUgdG8gcmV2LmRpZmZvcHQucHJlZml4Pwo+ICA+Pgo+ICA+Cj4gID4gSSBhc3N1bWUgeW91IG1l
YW50IHJldi5wcmVmaXg/IHJldi5wcmVmaXggaXMgc2V0IHJpZ2h0IGJlZm9yZQo+ICA+IHNldHVw
X3JldmlzaW9ucygpLiAoZ3JyLi4gSSB0aGluayBJIGxlZnQgYW4gcmVkdW5kYW50Cj4gID4gcmV2
LmRpZmZvcHQuc2tpcF9zdGF0X3VubWF0Y2ggYXNzaWdubWVudCkKPgo+ICBJIGRpZCBtZWFuIHJl
di5kaWZmb3B0LnByZWZpeCB0aGF0IGlzIGluaXRpYWxpemVkIGJ5IHRoZSBsYXN0Cj4gIGZvdXIg
bGluZXMgaW4gaW5pdF9yZXZpc2lvbnMoKSBmcm9tIHRoZSB2YWx1ZSBvZiBwcmVmaXggeW91Cj4g
IHBhc3MuCgpVbS4uIEkgbWlzc2VkIGNvbW1pdCAiZGlmZiAtLXJlbGF0aXZlIi4gVGhhbmtzIGZv
ciBub3RpY2luZy4KLS0gCkR1eQo=
