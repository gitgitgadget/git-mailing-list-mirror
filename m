From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [RESEND PATCH] fast-import: Cleanup mode setting.
Date: Wed, 14 Jan 2009 04:46:35 +0200
Message-ID: <94a0d4530901131846u2121e433ka8620fbb37c8470b@mail.gmail.com>
References: <1231897027-16197-1-git-send-email-felipe.contreras@gmail.com>
	 <alpine.DEB.1.00.0901140308200.3586@pacific.mpi-cbg.de>
	 <20090114021751.GW10179@spearce.org>
	 <alpine.DEB.1.00.0901140326530.3586@pacific.mpi-cbg.de>
	 <20090114022933.GX10179@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_12335_19873980.1231901195634"
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "Miklos Vajna" <vmiklos@frugalware.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 14 03:48:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMvnY-0006vR-Id
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 03:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244AbZANCqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 21:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbZANCqi
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 21:46:38 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:64911 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbZANCqh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 21:46:37 -0500
Received: by fg-out-1718.google.com with SMTP id 19so183595fgg.17
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 18:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type:references;
        bh=rFoXtI2lktrNw4BQKOruHJXqPA7AxBHpGeOIdsdvAIc=;
        b=H/n6OAWg0ghxc78gT8/Uxv7OH2zTFBysqX55xXIZTVt8msfaLUk6/UvS7SB2LDtpih
         Ab7FoH3+WN4PtKn/J61G4yraqjBqAugD31wFuzOgeXyvU8pHsafT2HukFFNEz6YZKGOs
         aA7Qht44nH5OV0xJVEXLJArlG30W+QRNM1ngU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:references;
        b=MCDgeV07E+Vy3xe7qn4to8ajMaxeesdM/h/jnAJvx1HYLfiNWd2jg2UfE0ja1KlkpW
         jMeTCPr9t6ovyLxYNlpYEjXWR+S6s9pzU5mFae5HdzdTucjJcaVW8/28usJhsdRRC8kO
         /gNszoyuNlO7UEeOkDn2ZhiFcz93kbnKL+pK4=
Received: by 10.86.3.4 with SMTP id 4mr325762fgc.44.1231901195645;
        Tue, 13 Jan 2009 18:46:35 -0800 (PST)
Received: by 10.86.51.18 with HTTP; Tue, 13 Jan 2009 18:46:35 -0800 (PST)
In-Reply-To: <20090114022933.GX10179@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105578>

------=_Part_12335_19873980.1231901195634
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, Jan 14, 2009 at 4:29 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> On Tue, 13 Jan 2009, Shawn O. Pearce wrote:
>> >
>> > It cleans up the code to make it more readable.
>> >
>> > It makes no sense to be doing S_IFREG | S_IFLINK, which happens when
>> > the input is for a symlink.  It doesn't break anything to do that |
>> > operation, but it also looks damn odd when reading the function.
>>
>> Imagining myself reading the commit message 6 months from now, in all
>> likeliness I will have wished that those two paragraphs were in there.
>> Verbatim.
>
> Maybe Junio or Felipe can copy it into the message.
>
> Or you can use a git note now to attach it to the commit Junio
> hasn't yet created, so you can look it up in the future.  :-)

How about the attached patch?

"S_IFREG | mode" probably is only required for 0644 and 0755.

It doesn't make sense to do S_IFREG | S_IFLINK (0100000 | 0120000),
since no bits are changed.

-- 
Felipe Contreras

------=_Part_12335_19873980.1231901195634
Content-Type: application/octet-stream;
 name=0001-fast-import-Cleanup-mode-setting.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fpxe4l0g0
Content-Disposition: attachment;
 filename=0001-fast-import-Cleanup-mode-setting.patch

RnJvbSAyZWVlMzQyYmIyNjEzYTMzNzhlYTA1ZDIyZWNkY2MzMWU1OGYyZTIyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGZWxpcGUgQ29udHJlcmFzIDxmZWxpcGUuY29udHJlcmFzQGdt
YWlsLmNvbT4KRGF0ZTogTW9uLCAyMiBEZWMgMjAwOCAwNDoxMzo1OSArMDIwMApTdWJqZWN0OiBb
UEFUQ0hdIGZhc3QtaW1wb3J0OiBDbGVhbnVwIG1vZGUgc2V0dGluZy4KCiJTX0lGUkVHIHwgbW9k
ZSIgcHJvYmFibHkgaXMgb25seSByZXF1aXJlZCBmb3IgMDY0NCBhbmQgMDc1NS4KCkl0IGRvZXNu
J3QgbWFrZSBzZW5zZSB0byBkbyBTX0lGUkVHIHwgU19JRkxJTksgKDAxMDAwMDAgfCAwMTIwMDAw
KSwKc2luY2Ugbm8gYml0cyBhcmUgY2hhbmdlZC4KClNpZ25lZC1vZmYtYnk6IEZlbGlwZSBDb250
cmVyYXMgPGZlbGlwZS5jb250cmVyYXNAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBTaGF3biBP
LiBQZWFyY2UgPHNwZWFyY2VAc3BlYXJjZS5vcmc+Ci0tLQogZmFzdC1pbXBvcnQuYyB8ICAgIDcg
KysrKy0tLQogMSBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZmFzdC1pbXBvcnQuYyBiL2Zhc3QtaW1wb3J0LmMKaW5kZXggYTZiY2U2
Ni4uZjBlMDhhYyAxMDA2NDQKLS0tIGEvZmFzdC1pbXBvcnQuYworKysgYi9mYXN0LWltcG9ydC5j
CkBAIC0xODcyLDEyICsxODcyLDEzIEBAIHN0YXRpYyB2b2lkIGZpbGVfY2hhbmdlX20oc3RydWN0
IGJyYW5jaCAqYikKIAlpZiAoIXApCiAJCWRpZSgiQ29ycnVwdCBtb2RlOiAlcyIsIGNvbW1hbmRf
YnVmLmJ1Zik7CiAJc3dpdGNoIChtb2RlKSB7CisJY2FzZSAwNjQ0OgorCWNhc2UgMDc1NToKKwkJ
bW9kZSB8PSBTX0lGUkVHOwogCWNhc2UgU19JRlJFRyB8IDA2NDQ6CiAJY2FzZSBTX0lGUkVHIHwg
MDc1NToKIAljYXNlIFNfSUZMTks6CiAJY2FzZSBTX0lGR0lUTElOSzoKLQljYXNlIDA2NDQ6Ci0J
Y2FzZSAwNzU1OgogCQkvKiBvayAqLwogCQlicmVhazsKIAlkZWZhdWx0OgpAQCAtMTk0NCw3ICsx
OTQ1LDcgQEAgc3RhdGljIHZvaWQgZmlsZV9jaGFuZ2VfbShzdHJ1Y3QgYnJhbmNoICpiKQogCQkJ
ICAgIHR5cGVuYW1lKHR5cGUpLCBjb21tYW5kX2J1Zi5idWYpOwogCX0KIAotCXRyZWVfY29udGVu
dF9zZXQoJmItPmJyYW5jaF90cmVlLCBwLCBzaGExLCBTX0lGUkVHIHwgbW9kZSwgTlVMTCk7CisJ
dHJlZV9jb250ZW50X3NldCgmYi0+YnJhbmNoX3RyZWUsIHAsIHNoYTEsIG1vZGUsIE5VTEwpOwog
fQogCiBzdGF0aWMgdm9pZCBmaWxlX2NoYW5nZV9kKHN0cnVjdCBicmFuY2ggKmIpCi0tIAoxLjYu
MC42LjUuZ2E2NmMKCg==
------=_Part_12335_19873980.1231901195634--
