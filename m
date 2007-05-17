From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH] Don't use patches/<branch>/current
Date: Thu, 17 May 2007 13:43:35 +0100
Message-ID: <b0943d9e0705170543g4d8c7542p6b44a4e6fa54676a@mail.gmail.com>
References: <20070506150852.8985.98091.stgit@yoghurt>
	 <b0943d9e0705150856n771cb696h6e8225a0bbd5d43d@mail.gmail.com>
	 <20070515182549.GB17851@diana.vm.bytemark.co.uk>
	 <b0943d9e0705151301r7412109qd73a6008b888f8bc@mail.gmail.com>
	 <20070516071130.GB7453@diana.vm.bytemark.co.uk>
	 <b0943d9e0705160507h2b3c4a34xe9895d007c41d91a@mail.gmail.com>
	 <20070516194002.GA17805@diana.vm.bytemark.co.uk>
	 <20070516204029.GB17805@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_50511_403031.1179405815689"
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu May 17 14:43:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HofKY-0004ny-PY
	for gcvg-git@gmane.org; Thu, 17 May 2007 14:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114AbXEQMni (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 08:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754082AbXEQMni
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 08:43:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:2032 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114AbXEQMnh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 08:43:37 -0400
Received: by ug-out-1314.google.com with SMTP id 44so322077uga
        for <git@vger.kernel.org>; Thu, 17 May 2007 05:43:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=lYbT7ulyPAzXmHuWBYVGAWKZHubT9ve8R8HwtczoEumjaD2/Tiyny5kf2NKNnHDvSVCEhRdynZPcNGFFCPcRCxz7EJ98MxS6wMw1LszYloODJHp4OJeFz5jOzAHRVTRszCJppOcvlfVb+71KvaOWLq2bdXEHR5MF0JjLoLNk+Q4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=qhTTrLrCjt1JF9c+jgS/ptRYNKO0yhBVKelOWOUT1dEYJq2/ft69ydkltmrt5qcXWE1bAJ+FCLRvub3Giknma3Gy4a5wvn5kNZDWjUINVUp9clmM775qjGDKESgQykx8EMa1S2ZgVSM775otmFqcf5ESwo0lCh1PrUpkka8H7P8=
Received: by 10.67.96.1 with SMTP id y1mr258170ugl.1179405815742;
        Thu, 17 May 2007 05:43:35 -0700 (PDT)
Received: by 10.67.27.11 with HTTP; Thu, 17 May 2007 05:43:35 -0700 (PDT)
In-Reply-To: <20070516204029.GB17805@diana.vm.bytemark.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47516>

------=_Part_50511_403031.1179405815689
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 16/05/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> I set up a kernel repository with 100 applied and 100 unapplied
> patches:
[...]
> Then repeatedly:
>
>   $ time stg series >/dev/null

I ran 'git repack -a -d' and 'git prune'. There are no other objects
apart from the generated pack:

$ du -sh .git
211M    .git

And then repeatedly 'time stg series > /dev/null':

real    0m1.638s
user    0m1.422s
sys     0m0.088s

real    0m2.542s
user    0m1.436s
sys     0m0.078s

real    0m2.916s
user    0m1.424s
sys     0m0.083s

real    0m2.940s
user    0m1.425s
sys     0m0.081s

real    0m1.614s
user    0m1.421s
sys     0m0.081s

real    0m1.587s
user    0m1.423s
sys     0m0.081s

real    0m2.653s
user    0m1.427s
sys     0m0.075s

> But my kernel repository is _much_ smaller than yours:
>
>   $ du -sh .git
>   183M    .git
>
> Do you perchance have a bunch of loose objects in there?

It got smaller after repacking but it is still bigger than yours.
Maybe the reason is that I have 14 branches with various patches, some
of them just for historical reasons but going back to 2.6.12. There
are also several commits generated for the patch logs.

The CPU is a P4 at 2.5GHz and the 'stg series' operation seems to be
CPU bound rather than IO. I'm also using Python 2.3 on this PC and for
this reason I changed 2 generator constructs (x for x in ...) with
list comprehension (see the attached patch).

--=20
Catalin

------=_Part_50511_403031.1179405815689
Content-Type: text/x-patch; name=list-comprehension.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1t7qhrp
Content-Disposition: attachment; filename="list-comprehension.patch"

Y29tbWl0IGY3Y2MxZjdmYTZiMmVlNGY0MmU4MTI5NzA3NjBiYTVkYjVkMmNhZmMKQXV0aG9yOiBD
YXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0BnbWFpbC5jb20+CkRhdGU6ICAgV2VkIE1h
eSAxNiAxMzowODo0NSAyMDA3ICswMTAwCgogICAgcmVmcmVzaAliNTAwM2FhN2JiNWVjMzg0ZTFk
YmUyODg3YzA3ODg1YTc5MTM4NGMyCgpkaWZmIC0tZ2l0IGEvc3RnaXQvc3RhY2sucHkgYi9zdGdp
dC9zdGFjay5weQppbmRleCAxM2ViNjkyLi4wZWYyNmI4IDEwMDY0NAotLS0gYS9zdGdpdC9zdGFj
ay5weQorKysgYi9zdGdpdC9zdGFjay5weQpAQCAtMzQ5LDggKzM0OSw4IEBAIGRlZiB1bmFwcGxp
ZWRfcGF0Y2hlcyhyZWYyaGFzaCk6CiAgICAgdW5hcHBsaWVkID0gU2V0KCkKICAgICBmb3IgbGlu
ZSBpbiBnaXQuX291dHB1dF9saW5lcygKICAgICAgICAgJ2dpdC1yZXYtbGlzdCAtLXN0ZGluJywK
LSAgICAgICAgKCclcyVzXG4nICUgKFsnJywgJ14nXVtyZWYgPT0gTm9uZV0sIHNoYTEpCi0gICAg
ICAgICBmb3IgcmVmLCBzaGExIGluIHJlZjJoYXNoLml0ZXJpdGVtcygpKSk6CisgICAgICAgIFsn
JXMlc1xuJyAlIChbJycsICdeJ11bcmVmID09IE5vbmVdLCBzaGExKQorICAgICAgICAgZm9yIHJl
Ziwgc2hhMSBpbiByZWYyaGFzaC5pdGVyaXRlbXMoKV0pOgogICAgICAgICBmb3IgcmVmIGluIGhh
c2gycmVmcy5nZXQobGluZS5zdHJpcCgpLCBbXSk6CiAgICAgICAgICAgICB1bmFwcGxpZWQuYWRk
KHJlZikKICAgICByZXR1cm4gdW5hcHBsaWVkCkBAIC0zNjQsNyArMzY0LDcgQEAgZGVmIHNvcnRf
YXBwbGllZF9wYXRjaGVzKHJlZjJoYXNoKToKICAgICAgICAgaWYgciAhPSBOb25lOgogICAgICAg
ICAgICAgaGFzaDJyZWZzLnNldGRlZmF1bHQoaCwgU2V0KCkpLmFkZChyKQogCi0gICAgbWlzc2lu
ZyA9IFNldChyZWYgZm9yIHJlZiBpbiByZWYyaGFzaC5pdGVya2V5cygpIGlmIHJlZiAhPSBOb25l
KQorICAgIG1pc3NpbmcgPSBTZXQoW3JlZiBmb3IgcmVmIGluIHJlZjJoYXNoLml0ZXJrZXlzKCkg
aWYgcmVmICE9IE5vbmVdKQogICAgIGlmIG5vdCBtaXNzaW5nOgogICAgICAgICByZXR1cm4gW10K
ICAgICBhcHBsaWVkID0gW10K
------=_Part_50511_403031.1179405815689--
