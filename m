From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 05/10] http-push: Avoid calling setup_git_directory() twice
Date: Tue, 11 Mar 2008 23:12:38 +0700
Message-ID: <fcaeb9bf0803110912n480d8f42kde0956609519de83@mail.gmail.com>
References: <cover.1204453703.git.pclouds@gmail.com>
	 <20080302103419.GA8957@laptop>
	 <alpine.LSU.1.00.0803111427400.3873@racer.site>
	 <fcaeb9bf0803110754v7191d8fckbde0e1313e6a69ec@mail.gmail.com>
	 <alpine.LSU.1.00.0803111604240.3873@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 17:17:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ79h-0003SJ-Em
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 17:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbYCKQP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 12:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbYCKQP1
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 12:15:27 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:30901 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbYCKQP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 12:15:26 -0400
Received: by fk-out-0910.google.com with SMTP id z23so2323553fkz.5
        for <git@vger.kernel.org>; Tue, 11 Mar 2008 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6he1yjaRKF5LSmqlSMerNZ6Rln3BqOybgY/Z6G5WyYQ=;
        b=FAblzWqBQv83do+w8vEsbJuCsm3nV8OaGyFtsY8VG3YWWrAt63b1ZBJwKNmv7vb8/MaqmHxeEzfZR7p2FplnuOQyI7CwM7tVfiNo+NZmQmlY9mxPj0othYAFu2MCb2LdTC01i7mY2QKFNkFajeFkRWBL/hM33MTMY8Q3chBwMXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PfAu+YoYvjfgrdUrio/Ias5Hubryh6T/EGDz6BRuwzbOu2opAawFOpJkBUVKiWauNXUa8tMLdf2HdfGdHqh7WhD6mZRNfSgM6bxUJBRrkn3bWbJANIEisTi+sbIRyY/0ktqHRW2RHM8AHYEMkb/DO9R1qdNfRxpg7FlmakxVUfM=
Received: by 10.82.138.6 with SMTP id l6mr16804445bud.35.1205251958057;
        Tue, 11 Mar 2008 09:12:38 -0700 (PDT)
Received: by 10.86.81.4 with HTTP; Tue, 11 Mar 2008 09:12:38 -0700 (PDT)
In-Reply-To: <alpine.LSU.1.00.0803111604240.3873@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76873>

T24gVHVlLCBNYXIgMTEsIDIwMDggYXQgMTA6MDggUE0sIEpvaGFubmVzIFNjaGluZGVsaW4KPEpv
aGFubmVzLlNjaGluZGVsaW5AZ214LmRlPiB3cm90ZToKPiBIaSwKPgo+Cj4gIE9uIFR1ZSwgMTEg
TWFyIDIwMDgsIE5ndXllbiBUaGFpIE5nb2MgRHV5IHdyb3RlOgo+Cj4gID4gT24gVHVlLCBNYXIg
MTEsIDIwMDggYXQgODoyOCBQTSwgSm9oYW5uZXMgU2NoaW5kZWxpbgo+ICA+IDxKb2hhbm5lcy5T
Y2hpbmRlbGluQGdteC5kZT4gd3JvdGU6Cj4gID4KPiAgPiA+ICBPbiBTdW4sIDIgTWFyIDIwMDgs
IE5ndXnCrW4gVGjDoWkgTmfDt2MgRHV5IHdyb3RlOgo+ICA+ID4KPiAgPiA+ICA+IFNpZ25lZC1v
ZmYtYnk6IE5ndXnCrW4gVGjDoWkgTmfDt2MgRHV5IDxwY2xvdWRzQGdtYWlsLmNvbT4KPgo+ID4g
Pgo+ICA+ID4gIFRoaXMgZml4IGlzIGNvbXBsZXRlbHkgaW5kZXBlbmRlbnQgb2YgdGhlIHJlc3Qg
b2YgeW91ciBzZXJpZXMuCj4gID4KPiAgPiBOb3QgcmVhbGx5LiBJdCB3b3VsZCBoYXZlIG5vIGlt
cGFjdCAoZ29vZCBvciBiYWQpIGlmIHNlbnQgc2VwYXJhdGVseS4KPiAgPiBCdXQgaXQgaXMgcmVx
dWlyZWQgYnkgdGhlIHNlcmllcyAob3RoZXJ3aXNlIGl0IHdvdWxkIGRpZSgpIHVuZGVyIGNlcnRh
aW4KPiAgPiBjb25kaXRpb24gYmVjYXVzZSBwcmVmaXggY2Fubm90IGJlIHJlY29tcHV0ZWQgcHJv
cGVybHkpLgo+Cj4gIFdlbGwsIGl0IF9pc18gaW5kZXBlbmRlbnQuICBFaXRoZXIgeW91IHNheSAi
d2Ugd2FudCB0byBoYXZlIHRoaXMgYXMgYW4KPiAgZXhhbXBsZSB3aGVyZSB5b3UgY2FuIGNhbGwg
c2V0dXBfZ2l0X2RpcmVjdG9yeSgpIHR3aWNlIiAod2hpY2ggSSB3b3VsZCBub3QKPiAgZmluZCBh
bGwgdGhhdCBiYWQpLCBvciB5b3Ugc2F5ICJ0aGlzIHdhcyBjYWxsaW5nIHNldHVwX2dpdF9kaXJl
Y3RvcnkoKQo+ICB0d2ljZSwgZml4IHRoYXQiLgo+Cj4gIEluIGFueSBjYXNlLCBpdCBzaG91bGQg
YmUgc2VwYXJhdGUgZnJvbSB0aGlzIHNlcmllcy4KCk15IHBvaW50IHN0YW5kcyBzdGlsbC4gSXQg
aXMgbWVyZWx5IGNsZWFudXAgd2l0aG91dCBoYXJtIG9yIGdvb2RuZXNzCmlmIHNlcGVyYXRlZCBm
cm9tIHRoZSBzZXJpZXMuIFRoaXMgcGF0Y2ggZG9lcyBub3QgZml4IHRoZSByZWFsCnByb2JsZW0u
Cgo+ICBCYWNrIHRvIHRoZSBzdWJqZWN0IG9mIHRoaXMgc2VyaWVzOiBhcyBJIHN0YXRlZCBhbHJl
YWR5LCBJIGRvIG5vdCBsaWtlIHRoZQo+ICBzZXBhcmF0aW9uIG9mIHdvcmstdHJlZSBhbmQgZ2l0
IGRpcmVjdG9yeSwgYW5kIEkgZXNwZWNpYWxseSBkbyBub3QgbGlrZQo+ICBob3cgbXVjaCB5b3Ug
aGFkIHRvIHdvcmsgb3V0c2lkZSBzZXR1cC5jLiAgSSB0aGluayBjaGFuZ2luZyB0aGUgc2VtYW50
aWNzCj4gIGZvciBhbGwgY2FsbGVycyB3YXMgbm90IG5lY2Vzc2FyeSwgYW5kIGluIGZhY3QsIG5v
dCBkZXNpcmFibGUuCgpGb3Igb25lLCBzZXR1cF93b3JrX3RyZWUoKSBwcm90b3R5cGUgY2hhbmdl
IGlzIG5lY2Vzc2FyeSB0byBkZWFsIHdpdGgKKGdpdGRpciBhdXRvZGV0ZWN0aW9uICsgY29yZS53
b3JrdHJlZSArIHNldHVwX3dvcmtfdHJlZSgpKS4KCkZvciBzZXR1cF8qZ2VudGx5KCkgY2hhbmdl
cywgSSB0aGluayBJIGNhbiBtYWtlCnNldHVwX2dpdF9kaXJlY3RvcnlfZ2VudGx5KCkgcmV0YWlu
IGl0cyBjdXJyZW50IHNlbWFudGljcyBieSByZW1vdmluZwowNi8xMCBhbmQgMDcvMTAuIEJ1dCBJ
IGRvIHRoaW5rIGl0J3MgbmljZSB0byBoYXZlIHNldHVwXypfZ2VudGx5KCkKZG9lcyB0aGluZ3Mg
Z2VudGx5IF9hbmRfIGVhc2lseS1wcmVkaWN0YWJsZSAoY3VycmVudCBfZ2VudGx5KCkgc2V0dXBz
Cndvcmt0cmVlIHVuZGVyIGNlcnRhaW4gY29uZGl0aW9ucyBhbmQgbm90IG90aGVyd2lzZSwgd2hp
Y2ggSSBjb25zaWRlcgp1bmVhc2lseS1wcmVkaWN0YWJsZSkuIFBhdGNoIDA2IGFuZCAwNyBhcmUg
bWFpbmx5IGNsZWFudXAgYXMgYSByZXN1bHQKZnJvbSBfZ2VudGx5KCkgY2hhbmdlcy4gQXJlIHRo
b3NlIG1vc3QgaW50cnVzaXZlIHRvIHlvdT8KCj4gIENpYW8sCj4gIERzY2hvCj4KLS0gCkR1eQo=
