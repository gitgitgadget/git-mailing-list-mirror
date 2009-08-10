From: Geoffrey Irving <irving@naml.us>
Subject: Re: bug with .git file and aliases
Date: Mon, 10 Aug 2009 16:22:01 -0400
Message-ID: <7f9d599f0908101322i46384247m303e28955f88bbb@mail.gmail.com>
References: <7f9d599f0907200654q2e068e6aq3051c122f6596053@mail.gmail.com> 
	<20090720152117.GB5347@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00163628372ed8b7680470cf57b9
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 22:22:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MabO2-0007ru-Mq
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 22:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbZHJUWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 16:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752619AbZHJUWV
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 16:22:21 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:49291 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbZHJUWU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 16:22:20 -0400
Received: by vws2 with SMTP id 2so2928518vws.4
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 13:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type;
        bh=YAJ6ZQjvhLm8lyJyd8dZECv/QzgvRc8UMenApLKUVnk=;
        b=Nuu7P18yGhw9p32l+9yCdjpkMZm7iqgwQHPebJhYoK11bUFBkuR6nQVgorFIhDpy4P
         qdtiUrDJI1RXbQsTNILYF4FGd0//vxVl6eNAtdm4egu1mcwVvy8xsY4ikC0Tf1IsZvhS
         xpAjoc0lyM9YzooieSlI9DxRBuwhwGWL8PMkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=PKZ+xhVO+huyWsMfA565Bu4Owa2wGNeldRCIMilVrwaALrDFlJyHJ0O+EFAz88OY4V
         F0/9RkgHZxch9bsn9KpesuMTgvnT/a2fLVp3tx1xpq1uaU42LPdIKkkBGfHHGLwFq2Xf
         QSz6vm0ZfcDKld/nYQgbnvPc0cmEQejOyntec=
Received: by 10.220.83.210 with SMTP id g18mr5279239vcl.65.1249935741203; Mon, 
	10 Aug 2009 13:22:21 -0700 (PDT)
In-Reply-To: <20090720152117.GB5347@coredump.intra.peff.net>
X-Google-Sender-Auth: a9bad1983915c5b9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125499>

--00163628372ed8b7680470cf57b9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2009 at 11:21 AM, Jeff King<peff@peff.net> wrote:
> On Mon, Jul 20, 2009 at 09:54:12AM -0400, Geoffrey Irving wrote:
>
>> git 1.6.3.3 has a bug related to .git file support and aliases.
>> Specifically, if you make an alias for status and call it from a
>> subdirectory, git status chdirs into the true .git dir but then
>> chdir's back to the wrong place in order to run the lstats for status.
>> =A0The result is that git status thinks all files have disappeared.
>
> Yeah, this is a known problem. The problem is that the 'git' wrapper
> sets up the environment only partially when running aliases, and then
> the resulting command ends up confused about where the worktree is. I
> really don't remember the specifics, but you can probably find some
> discussion in the list archives. =A0Fixing it, IIRC, required some
> refactoring of the setup code (which I had hoped to get to at some
> point, but I am way behind on my git todo list).

The attached patch fixes the bug for me.  I'll leave it to others to
determine whether this is a good way to fix the problem.

Thanks,
Geoffrey

--00163628372ed8b7680470cf57b9
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-setup.c-fix-work-tree-setup-for-.git-files-and-alias.patch"
Content-Disposition: attachment; 
	filename="0001-setup.c-fix-work-tree-setup-for-.git-files-and-alias.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fy7ne2z50

RnJvbSBlYzQ3YWEwOWU1YmM4ZDlhOGMwN2NjYTlmOGVmMTdhOTg5ODgxOWMxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHZW9mZnJleSBJcnZpbmcgPGlydmluZ0BuYW1sLnVzPgpEYXRl
OiBNb24sIDEwIEF1ZyAyMDA5IDE1OjU5OjIxIC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gc2V0dXAu
YzogZml4IHdvcmsgdHJlZSBzZXR1cCBmb3IgLmdpdC1maWxlcyBhbmQgYWxpYXNlcwoKV2hlbiAu
Z2l0LWZpbGVzIGFuZCBhbGlhc2VzIGFyZSB1c2VkIHRvZ2V0aGVyLCB0aGUgc2V0dXAgbWFjaGlu
ZXJ5CmdldHMgY29uZnVzZWQgYW5kIGVuZHMgdXAgd2l0aCB0aGUgd3Jvbmcgd29ya190cmVlLiAg
U3BlY2lmaWNhbGx5LApnaXRfd29ya190cmVlX2NmZyBpcyBzZXQgdG8gdGhlIGNvcnJlY3QgdmFs
dWUgZmlyc3QsIGJ1dCBzZXRfd29ya190cmVlCnJlc2V0cyBnaXRfd29ya190cmVlX2NmZyB0byB0
aGUgY3VycmVudCBkaXJlY3RvcnksIHdoaWNoIChhdCBsZWFzdCBpbgp0aGlzIGNhc2UpIGlzIGlu
Y29ycmVjdC4KCnNldF93b3JrX3RyZWUgbm93IGRldGVjdHMgdGhpcyBjYXNlIGJ5IGNoZWNraW5n
IHRvIHNlZSBpZgpnaXRfd29ya190cmVlX2NmZyBpcyBhbHJlYWR5IHNldC4gIElmIHNvLCBpdCBs
ZWF2ZXMgZ2l0X3dvcmtfdHJlZV9jZmcKdW5jaGFuZ2VkIGFuZCBpbnN0ZWFkIHVzZXMgdGhlIGN1
cnJlbnQgZGlyZWN0b3J5IHRvIGNvbXB1dGUgYW5kIHJldHVybgp0aGUgY29ycmVjdCBwcmVmaXgg
KHdoZXJlIHdlIGFyZSByZWxhdGl2ZSB0byB0aGUgd29yayB0cmVlKS4KClNpZ25lZC1vZmYtYnk6
IEdlb2ZmcmV5IElydmluZyA8aXJ2aW5nQG5hbWwudXM+Ci0tLQogc2V0dXAuYyB8ICAgMTUgKysr
KysrKysrKysrKy0tCiAxIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvc2V0dXAuYyBiL3NldHVwLmMKaW5kZXggZTM3ODFiNi4uOTdm
N2ViMSAxMDA2NDQKLS0tIGEvc2V0dXAuYworKysgYi9zZXR1cC5jCkBAIC0xOTgsMTMgKzE5OCwy
NCBAQCBpbnQgaXNfaW5zaWRlX3dvcmtfdHJlZSh2b2lkKQogc3RhdGljIGNvbnN0IGNoYXIgKnNl
dF93b3JrX3RyZWUoY29uc3QgY2hhciAqZGlyKQogewogCWNoYXIgYnVmZmVyW1BBVEhfTUFYICsg
MV07CisJc2l6ZV90IG9mZnNldDsKIAogCWlmICghZ2V0Y3dkKGJ1ZmZlciwgc2l6ZW9mKGJ1ZmZl
cikpKQogCQlkaWUgKCJDb3VsZCBub3QgZ2V0IHRoZSBjdXJyZW50IHdvcmtpbmcgZGlyZWN0b3J5
Iik7Ci0JZ2l0X3dvcmtfdHJlZV9jZmcgPSB4c3RyZHVwKGJ1ZmZlcik7CiAJaW5zaWRlX3dvcmtf
dHJlZSA9IDE7CiAKLQlyZXR1cm4gTlVMTDsKKwlpZiAoIWdpdF93b3JrX3RyZWVfY2ZnKSB7CisJ
CWdpdF93b3JrX3RyZWVfY2ZnID0geHN0cmR1cChidWZmZXIpOworCQlyZXR1cm4gTlVMTDsKKwl9
IGVsc2UgeworCQlvZmZzZXQgPSBzdHJsZW4oZ2l0X3dvcmtfdHJlZV9jZmcpOworCQlpZiAobWVt
Y21wKGdpdF93b3JrX3RyZWVfY2ZnLCBidWZmZXIsIG9mZnNldCkKKwkJCXx8IChidWZmZXJbb2Zm
c2V0XSAmJiBidWZmZXJbb2Zmc2V0XSAhPSAnLycpKQorCQkJZGllICgiZmF0YWw6IG5vdCBpbnNp
ZGUgd29yayB0cmVlIChzaG91bGQgbm90IGhhcHBlbikiKTsKKwkJaWYgKCFidWZmZXJbb2Zmc2V0
XSB8fCAhYnVmZmVyW29mZnNldCsxXSkKKwkJCXJldHVybiBOVUxMOworCQlyZXR1cm4geHN0cmR1
cChzdHJjYXQoYnVmZmVyICsgb2Zmc2V0ICsgMSwgIi8iKSk7CisJfQogfQogCiB2b2lkIHNldHVw
X3dvcmtfdHJlZSh2b2lkKQotLSAKMS42LjMuMwoK
--00163628372ed8b7680470cf57b9--
