From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 6/9] Completely move out worktree setup from setup_git_directory_gently()
Date: Thu, 28 Feb 2008 19:52:02 +0700
Message-ID: <fcaeb9bf0802280452h1180c4f2gdc92874a3627d0c5@mail.gmail.com>
References: <cover.1204130175.git.pclouds@gmail.com>
	 <20080227163934.GA28084@laptop>
	 <alpine.LSU.1.00.0802281124420.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 28 13:53:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUiG9-00069M-TA
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 13:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbYB1Mwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 07:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752260AbYB1Mwc
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 07:52:32 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:52326 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583AbYB1Mwb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 07:52:31 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2703401fga.17
        for <git@vger.kernel.org>; Thu, 28 Feb 2008 04:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Y+lMBN0C6DXQ4pKKqb7/3i0L5iECcMig7do0bgbu5g8=;
        b=lSRNB8umx2nxLA4NYO168H5cNIGu5L2TWSWIedigsXAdLt/YAPxVSjDjx2Pppm4s/ucNJew26i46fUKh/eIfGl973doxL8mqiCl3TbbQSnvTeJXVvO2meY18TrgdInB87JKY3whLGjTrsjUsGe6SAxxlPiRmY7gJwKQJ85soo4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MytkMhv/zGNvy2K/1Z96CflcCNI+CcX1giC/ytztPBJPa5sOL7sRNqXYmAy7zCAmIiDA8D4CSauMd7Rurkn9HtddTKmxAbTqfOZwAe9ps0Xqvhrj1adohdfCoYB/CUs3TiAEXCujb4yjHAo1KtTga2Q7r0aFSRvX+NJ6A9iz7H4=
Received: by 10.86.84.5 with SMTP id h5mr8117197fgb.53.1204203150225;
        Thu, 28 Feb 2008 04:52:30 -0800 (PST)
Received: by 10.86.83.3 with HTTP; Thu, 28 Feb 2008 04:52:02 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802281124420.22527@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75394>

T24gVGh1LCBGZWIgMjgsIDIwMDggYXQgNjoyNiBQTSwgSm9oYW5uZXMgU2NoaW5kZWxpbgo8Sm9o
YW5uZXMuU2NoaW5kZWxpbkBnbXguZGU+IHdyb3RlOgo+IEhpLAo+Cj4KPiAgT24gV2VkLCAyNyBG
ZWIgMjAwOCwgTmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eSB3cm90ZToKPgo+ICA+IFRoaXMgd2Fz
IGltcG9zc2libGUgZWFybGllciBiZWNhdXNlIGdpdF9kaXIgY2FuIGJlIHJlbGF0aXZlLiBOb3cg
dGhhdAo+ICA+IGdpdF9kaXIgaXMgYWJzb2x1dGUsIEkgc2VlIG5vIHJlYXNvbiBmb3Igd29ya3Ry
ZWUgc2V0dXAgaW5zaWRlCj4gID4gc2V0dXBfZ2l0X2RpcmVjdG9yeV9nZW50bHkoKS4KPgo+ICBJ
IGRvIHNlZSBpdCwgdGhvdWdoLiAgV2h5IG1ha2UgdGhlIHVzZXJzIHdvcmsgaGFyZGVyPwoKVG8g
bWFrZSBjbGVhciBzZXBhcmF0aW9uIG9mIHdvcmt0cmVlIHVzYWdlPyBJIHRoaW5rIGl0J3MgZ29v
ZCB0byBhZGQKc2V0dXBfd29ya190cmVlKCkgd2hlcmUgeW91IHJlYWxseSBuZWVkIGl0LiBSaWdo
dCBub3cgaW4gY29tbWFuZHMgdGhhdAp1c2Ugc2V0dXBfZ2l0X2RpcmVjdG9yeV9nZW50bHkoKSwg
aXQgaXMgKHRvIG1lKSByZWFsbHkgaGFyZCB0byB0ZWxsCndoZXRoZXIgYW4gb3B0aW9uIHJlcXVp
cmUgd29ya3RyZWUuCgpBbm90aGVyIHBvaW50IG9mIHJlbW92aW5nIHdvcmt0cmVlIHNldHVwIGZy
b20gX2dlbnRseSgpOiB3b3JrdHJlZQpzZXR1cCBjYW4gZGllKCkgd2hpbGUgX2dlbnRseSgpJ3Mg
cHVycG9zZSBpcywgd2VsbCwgZG8gaXQgZ2VudGx5LiBJZgppdCdzIG5vdCBzYWZlLCBsZXQgdGhl
IGNhbGxlciBkZWNpZGUuCgpBbHNvIGhhdmluZyB0byBkZWFsIHdpdGggcHJlZml4IHdoaWxlIHlv
dSBkb24ndCBuZWVkIHdvcmt0cmVlIGF0IGFsbAppcyBhIGJpdCBvZiB3b3JrIHRoYXQgY2FuIGJl
IGVsaW1pbmF0ZWQgd2l0aCB0aGlzIHNlcmllcy4KCj4gIElmIHlvdSB3YW50IHRvIGdldAo+ICB0
aGUgZ2l0IGRpcmVjdG9yeSwgY2hhbmNlcyBhcmUgdGhhdCB5b3Ugd2FudCB0byB3b3JrIHdpdGgg
YSB3b3JrdHJlZSwgdG9vLgoKWWVzLiBUaGF0J3Mgd2h5IEkga2VlcCB3b3JrdHJlZSBzZXR1cCBp
biBzZXR1cF9naXRfZGlyZWN0b3J5KCkuCgo+ICBBbmQgeW91IHJlYWxseSBjYW5ub3QgcHJvcGVy
bHkgc2VwYXJhdGUgd29ya3RyZWUgZGV0ZWN0aW9uIGZyb20gZ2l0Cj4gIGRpcmVjdG9yeSBkZXRl
Y3Rpb246IGluIG1vc3Qgb2YgdGhlIGNhc2VzLCB5b3Ugd2lsbCBmaW5kIHRoZW0gYXQgdGhlCj4g
IF9zYW1lXyB0aW1lIChpZiAuZ2l0LyBpcyB0aGUgZ2l0IGRpcmVjdG9yeSwgdGhlIHdvcmtpbmcg
ZGlyZWN0b3J5IGlzIC4pLgoKTm8gSSBkb24ndCBzZXBhcmF0ZSB3b3JrdHJlZSBkZXRlY3Rpb24u
IEkgb25seSBhdm9pZCBtb3ZpbmcgdG8Kd29ya3RyZWUgdW5sZXNzIG5lY2Vzc2FyeS4gUmlnaHQg
YWZ0ZXIgX2dlbnRseSgpIHlvdSBjYW4gdGVsbCBpZiB5b3UKaGF2ZSBhIHdvcmt0cmVlIGFuZCB3
aGVyZSBpdCBpcy4KCj4gIFNvIEkgYW0gbWlsZGx5IG5lZ2F0aXZlIG9uIHRoZSB0aHJ1c3Qgb2Yg
eW91ciBwYXRjaCBzZXJpZXMuCj4KPiAgQ2lhbywKPiAgRHNjaG8KPgoKCgotLSAKRHV5Cg==
