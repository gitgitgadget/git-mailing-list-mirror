From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Fri, 2 Nov 2012 17:41:34 +0100
Message-ID: <CAMP44s1P5Y_H24=ZKS5n_rUORf1dTiqg3qXm3bHcOiQ8K12PUQ@mail.gmail.com>
References: <alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
	<CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
	<alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
	<CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
	<5090EFCA.7070606@drmicha.warpmail.net>
	<CAMP44s2a7fmxFmdn0CAcVtX8NxVtPdBKH9RY+i_Og53jb1Ju5Q@mail.gmail.com>
	<509149D9.3070606@drmicha.warpmail.net>
	<CAMP44s2oKMog5GygrAag8SOdwhQJr4gCZxZAwWUo-ERDzni0ag@mail.gmail.com>
	<CAMP44s0KFJW2F3gbO_Xd9QKrZ1OoxvUCvecU084-zH2UDqXKag@mail.gmail.com>
	<CAMP44s3UHQE69O__EVK29uN_VPdZN=a0-Gczeh-Tbjp1ZAAbJw@mail.gmail.com>
	<20121102144827.GB11170@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 02 17:41:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUKJY-0001Ay-HU
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 17:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760168Ab2KBQlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 12:41:36 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:55434 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759823Ab2KBQlf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 12:41:35 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so3826120oag.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 09:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fU0FtTdA9/F1mZd/pc2aX7t991KfA1ueQM7ZUfUBiZM=;
        b=DX1lYwiGC4f4qGqBbpA+y5WkrcKXjTKechfLxnKfNRt8OFMxtCbPG76I5lj6/w3l+4
         lyQL52a4q40GR9pBt+8XUNqqNhQ1jrH+LegZhpAp0eCzptSBUtYy18z0z6ZzSD3uXIsL
         LfgXAmg+EgWtNP9kDN+HvnqMpfxvHdgrNssydDeklY6Maax0SFjoBmXGCk27ByGIuSvy
         LT+zbiiZitTOpj26DdA0Pb2F+cNQLJqp7wLSghV2o8OGs/DN/OWJBm3VNR1sMtre1665
         Yg4BLm4/Hv/IrUJrwAQa+BtCyCx3d6Z50i9CeTMtTPQDz3vhvzyxvxHF6R5TaP3GqQle
         QiBg==
Received: by 10.60.12.233 with SMTP id b9mr1839693oec.95.1351874494925; Fri,
 02 Nov 2012 09:41:34 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Fri, 2 Nov 2012 09:41:34 -0700 (PDT)
In-Reply-To: <20121102144827.GB11170@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208962>

On Fri, Nov 2, 2012 at 3:48 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Nov 01, 2012 at 05:08:52AM +0100, Felipe Contreras wrote:
>
>> > Turns out msysgit's remote-hg is not exporting the whole repository,
>> > that's why it's faster =/
>>
>> It seems the reason is that it would only export to the point where
>> the branch is checked out. After updating the to the tip I noticed
>> there was a performance difference.
>>
>> I investigated and found two reasons:
>>
>> 1) msysgit's version doesn't export files twice, I've now implemented the same
>> 2) msysgit's version uses a very simple algorithm to find out file changes
>>
>> This second point causes msysgit to miss some file changes. Using the
>> same algorithm I get the same performance, but the output is not
>> correct.
>
> Do you have a test case that demonstrates this? It would be helpful for
> reviewers, but also helpful to msysgit people if they want to fix their
> implementation.

Cloning the mercurial repo:

% hg log --stat -r 131
changeset:   131:c9d51742471c
parent:      127:44538462d3c8
user:        jake@edge2.net
date:        Sat May 21 11:35:26 2005 -0700
summary:     moving hgweb to mercurial subdir

 hgweb.py           |  377
------------------------------------------------------------------------------------------
 mercurial/hgweb.py |  377
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 377 insertions(+), 377 deletions(-)

% git show --stat 1f9bcfe7cc3d7af7b4533895181acd316ce172d8
commit 1f9bcfe7cc3d7af7b4533895181acd316ce172d8
Author: jake@edge2.net <none@none>
Date:   Sat May 21 11:35:26 2005 -0700

    moving hgweb to mercurial subdir

 mercurial/hgweb.py | 377
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 377 insertions(+)

Cheers.

-- 
Felipe Contreras
