X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Seek back to current filepos when mmap()ing with NO_MMAP
Date: Wed, 15 Nov 2006 20:06:01 +0100
Message-ID: <81b0412b0611151106k45ee03ekd8a3a04173f618c3@mail.gmail.com>
References: <Pine.LNX.4.63.0611151727000.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_48394_25111807.1163617561981"
NNTP-Posting-Date: Wed, 15 Nov 2006 19:06:51 +0000 (UTC)
Cc: junkio@cox.net, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=EnUwC95dmaWD+iPZmSHYNhXW2KLqxxi6MEkrrPcu5S0HIq0LrkkJtZtnQTbzaI9af22MMJtMr87Rr9RH4jKYub2S552ZpOiHf+OPj2VU8Fp0jdEIbZd0gxDZmHygmvyqpBWArRfr69Afm3Csd0zlVch6KUx5U8gQRmyGZx7DquQ=
In-Reply-To: <Pine.LNX.4.63.0611151727000.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31470>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkQ5f-0005ll-JF for gcvg-git@gmane.org; Wed, 15 Nov
 2006 20:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030898AbWKOTGH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 14:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030896AbWKOTGH
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 14:06:07 -0500
Received: from wr-out-0506.google.com ([64.233.184.227]:6295 "EHLO
 wr-out-0506.google.com") by vger.kernel.org with ESMTP id S1030898AbWKOTGD
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 14:06:03 -0500
Received: by wr-out-0506.google.com with SMTP id i22so146840wra for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 11:06:03 -0800 (PST)
Received: by 10.78.138.6 with SMTP id l6mr542044hud.1163617562164; Wed, 15
 Nov 2006 11:06:02 -0800 (PST)
Received: by 10.78.135.19 with HTTP; Wed, 15 Nov 2006 11:06:01 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

------=_Part_48394_25111807.1163617561981
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 11/15/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> "git-index-pack --fix-thin" relies on mmap() not changing the current
> file position (otherwise the pack will be corrupted when writing the
> final SHA1). Meet that expectation.
>

Thanks! I was wondering for some considerable time why the
hell t5500-fetch-pack fails.

BTW, I extended error handling in that mmap.  Dunno why.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

------=_Part_48394_25111807.1163617561981
Content-Type: text/x-diff; name="lseek-compatmmap.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="lseek-compatmmap.patch"
X-Attachment-Id: file0

Y29tbWl0IDQwZWQwNjQ0Y2E4ZDI1MGY3MTZmNDlhNWMzZTAyN2FhMmMxZDMxNjcKQXV0aG9yOiBB
bGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRlOiAgIFdlZCBOb3YgMTUgMTk6NTU6
MDYgMjAwNiArMDEwMAoKICAgIFNlZWsgYmFjayB0byBjdXJyZW50IGZpbGVwb3Mgd2hlbiBtbWFw
KClpbmcgd2l0aCBOT19NTUFQLCBlaCBpbXByb3ZlZAogICAgCiAgICAiZ2l0LWluZGV4LXBhY2sg
LS1maXgtdGhpbiIgcmVsaWVzIG9uIG1tYXAoKSBub3QgY2hhbmdpbmcgdGhlIGN1cnJlbnQKICAg
IGZpbGUgcG9zaXRpb24gKG90aGVyd2lzZSB0aGUgcGFjayB3aWxsIGJlIGNvcnJ1cHRlZCB3aGVu
IHdyaXRpbmcgdGhlCiAgICBmaW5hbCBTSEExKS4gTWVldCB0aGF0IGV4cGVjdGF0aW9uLgogICAg
CiAgICBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBTY2hpbmRlbGluIDxKb2hhbm5lcy5TY2hpbmRl
bGluQGdteC5kZT4KICAgIFNpZ25lZC1vZmYtYnk6IEFsZXggUmllc2VuIDxyYWEubGttbEBnbWFp
bC5jb20+CgpkaWZmIC0tZ2l0IGEvY29tcGF0L21tYXAuYyBiL2NvbXBhdC9tbWFwLmMKaW5kZXgg
NTVjYjEyMC4uYzZkNWNmZSAxMDA2NDQKLS0tIGEvY29tcGF0L21tYXAuYworKysgYi9jb21wYXQv
bW1hcC5jCkBAIC02LDcgKzYsOCBAQAogCiB2b2lkICpnaXRmYWtlbW1hcCh2b2lkICpzdGFydCwg
c2l6ZV90IGxlbmd0aCwgaW50IHByb3QgLCBpbnQgZmxhZ3MsIGludCBmZCwgb2ZmX3Qgb2Zmc2V0
KQogewotCWludCBuID0gMDsKKwlpbnQgbiA9IDAsIGVyciA9IDA7CisJb2ZmX3QgY3VycmVudF9v
ZmZzZXQgPSBsc2VlayhmZCwgMCwgU0VFS19DVVIpOwogCiAJaWYgKHN0YXJ0ICE9IE5VTEwgfHwg
IShmbGFncyAmIE1BUF9QUklWQVRFKSkKIAkJZGllKCJJbnZhbGlkIHVzYWdlIG9mIGdpdGZha2Vt
bWFwLiIpOwpAQCAtMTgsOCArMTksOCBAQCB2b2lkICpnaXRmYWtlbW1hcCh2b2lkICpzdGFydCwg
c2l6ZV90IGxlCiAKIAlzdGFydCA9IHhtYWxsb2MobGVuZ3RoKTsKIAlpZiAoc3RhcnQgPT0gTlVM
TCkgewotCQllcnJubyA9IEVOT01FTTsKLQkJcmV0dXJuIE1BUF9GQUlMRUQ7CisJCWVyciA9IEVO
T01FTTsKKwkJZ290byB1bnNlZWs7CiAJfQogCiAJd2hpbGUgKG4gPCBsZW5ndGgpIHsKQEAgLTMx
LDE0ICszMiwyMiBAQCB2b2lkICpnaXRmYWtlbW1hcCh2b2lkICpzdGFydCwgc2l6ZV90IGxlCiAJ
CX0KIAogCQlpZiAoY291bnQgPCAwKSB7Ci0JCQlmcmVlKHN0YXJ0KTsKLQkJCWVycm5vID0gRUFD
Q0VTOwotCQkJcmV0dXJuIE1BUF9GQUlMRUQ7CisJCQllcnIgPSBFQUNDRVM7CisJCQlnb3RvIHVu
c2VlazsKIAkJfQogCiAJCW4gKz0gY291bnQ7CiAJfQogCit1bnNlZWs6CisJaWYgKGN1cnJlbnRf
b2Zmc2V0ICE9IGxzZWVrKGZkLCBjdXJyZW50X29mZnNldCwgU0VFS19TRVQpKQorCQllcnIgPSBF
SU5WQUw7CisKKwlpZiAoZXJyKSB7CisJCWZyZWUoc3RhcnQpOworCQlzdGFydCA9IE1BUF9GQUlM
RUQ7CisJCWVycm5vID0gZXJyOworCX0KIAlyZXR1cm4gc3RhcnQ7CiB9CiAK
