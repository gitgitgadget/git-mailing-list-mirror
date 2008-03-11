From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 06/10] Completely move out worktree setup from setup_git_directory_gently()
Date: Tue, 11 Mar 2008 22:28:53 +0700
Message-ID: <fcaeb9bf0803110828u3087ccdeqead5f2c433e08597@mail.gmail.com>
References: <cover.1204453703.git.pclouds@gmail.com>
	 <20080302103433.GA8970@laptop>
	 <alpine.LSU.1.00.0803111429380.3873@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 16:29:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ6Q6-00021C-2d
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 16:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbYCKP24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 11:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753539AbYCKP24
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 11:28:56 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:51043 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379AbYCKP2z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 11:28:55 -0400
Received: by fk-out-0910.google.com with SMTP id z23so2306035fkz.5
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 08:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=HFS3fLiLtQ7Ho2ZZCLuQvNMChDtg0MmjM6WsWcWyWHU=;
        b=jzoRpHPl46SRJ4vNRwiUdO8XcD0kpY/8RsYzxMDfY/6KEOj3unwXGzG5B1esARGL2h62jAm70jqpO5Ag0hVh4LQe4JMTMv87/cHyFOCAIWGK7bzOO8FG6LP4wPc8V6Rwmm2atFvxUi68WNTBSZbZ6uUpreml4P7a4fUW86rcDoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d3mv88f9S8c5BLJiITkIA7m3LdnAFXsakz0FNPC2NWTL66v0g2Hc5b8bIr7BZXpyroAus1W+5Ntcl9mNSgTA6rfFF+mwGI2zLWwkSt9ExABF22tv/ZP+stgsaCaLgMZOMw26ixCPBFEWD90TWggVrtKhT1P851CrlUdBfaZD+zU=
Received: by 10.82.121.15 with SMTP id t15mr16647166buc.31.1205249333333;
        Tue, 11 Mar 2008 08:28:53 -0700 (PDT)
Received: by 10.86.81.4 with HTTP; Tue, 11 Mar 2008 08:28:53 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0803111429380.3873@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76867>

T24gVHVlLCBNYXIgMTEsIDIwMDggYXQgODozMSBQTSwgSm9oYW5uZXMgU2NoaW5kZWxpbgo8Sm9o
YW5uZXMuU2NoaW5kZWxpbkBnbXguZGU+IHdyb3RlOgo+IEhpLAo+Cj4KPiAgT24gU3VuLCAyIE1h
ciAyMDA4LCBOZ3V54buFbiBUaMOhaSBOZ+G7jWMgRHV5IHdyb3RlOgo+Cj4gID4gVGhpcyB3YXMg
aW1wb3NzaWJsZSBlYXJsaWVyIGJlY2F1c2UgZ2l0X2RpciBjYW4gYmUgcmVsYXRpdmUuIE5vdyB0
aGF0Cj4gID4gZ2l0X2RpciBpcyBhYnNvbHV0ZSwgSSBzZWUgbm8gcmVhc29uIGZvciB3b3JrdHJl
ZSBzZXR1cCBpbnNpZGUKPiAgPiBzZXR1cF9naXRfZGlyZWN0b3J5X2dlbnRseSgpLiBUaGUgc2Vt
YW50aWMgaXMgbm93IGNsZWFyZXI6IGlmIHlvdSBuZWVkCj4gID4gd29ya3RyZWUsIGNhbGwgc2V0
dXBfd29ya190cmVlIHlvdXJzZWxmICh3ZWxsLCBJIHdpbGwgY2xlYW4gdXAKPiAgPiBzZXR1cF9n
aXRfZGlyZWN0b3J5KCkgcGFydCBsYXRlcikKPgo+ICBBcyBJIHNhaWQgZWFybGllciwgdGhlIHdv
cmsgZm9yIGdldHRpbmcgdGhlIHByZWZpeCBhcyBtb3N0IGxpa2VseSBiZSBkb25lCj4gIGFscmVh
ZHkgaW4gdGhlIHNlYXJjaCBmb3IgLmdpdC8uICBJIG1lYW4sIGl0IF9pc18gdGhlIGNvbW1vbiBj
YXNlIHRvIGhhdmUKPiAgYSB3b3JraW5nIHRyZWUgd2l0aCBhIC5naXQvIGluIGl0LCBhbmQgdGhh
dCdzIGl0Lgo+Cj4gIFNvIEkgYW0gcXVpdGUgY2VydGFpbiB0aGF0IGl0IGlzIG5vdCB3b3J0aCB0
aGUgY29tcGxpY2F0ZWQgYW5kIGludHJ1c2l2ZQo+ICBwYXRjaCB0byBzZXBhcmF0ZSB0aGUgbG9n
aWMuCgpJdCBkb2VzIGZvciB0d28gcHVycG9zZXM6CgogLSBMZWF2ZSBhIGNoYW5jZSBmb3IgY29t
bWFuZHMgdGhhdCBkb2VzIG5vdCBjYXJlIGFib3V0IHdvcmt0cmVlIGF0CmFsbC4gVGhvc2UgY29t
bWFuZHMgd29uJ3QgaGF2ZSB0byBjYXJlIGFib3V0IHByZWZpeCBhbnltb3JlLgogLSBDbGVhbiB1
cCB0aGUgY29kZS4gTm93IG9ubHkgc2V0dXBfd29ya190cmVlKCkgZG9lcyB3b3JrdHJlZSBzZXR1
cAp0aGluZ3MgKGxpa2UgY2hkaXIoKSkKCj4gIFBhcnRpY3VsYXJseSBzaW5jZSB3b3JraW5nIHRy
ZWUgaGFzIGEgYmFkIHJlcHV0YXRpb24gYWxyZWFkeSwgYXMgSnVuaW8KPiAgcG9pbnRlZCBvdXQ6
IHdoZW5ldmVyIHdlIHRvdWNoIGl0LCB3ZSBnZXQgYnVybnQuCgpJJ2QgcmF0aGVyIGdldCBidXJu
dCBub3cgdGhhbiBsYXRlciAod2hpY2ggbWlnaHQgYmUgcHJvYmFibHkgd29yc2UpIDopCkluIGNh
c2Ugd2UgYXJlIHRvIGJlIGJ1cm50LCB3ZSBzaG91bGQgbm90IGhhdmUgaXQgaW4gMS41LjUgOkQK
Cj4gIENpYW8sCj4gIERzY2hvCgoKCi0tIApEdXkK
