From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: t5150-request-pull.sh fails on newest master in Debian
Date: Wed, 9 Jul 2014 02:52:49 +0200
Message-ID: <CAA787r=Q5B7R1sxiVhRgobPHHPro6D5YyqVO+P_MZC=aGa+ZHw@mail.gmail.com>
References: <CAA787r=78UWio3E==s+J2PbVqshQdWXpS9hiJrmNz+F0vLiuGg@mail.gmail.com>
	<1404505370.3109.15.camel@stross>
	<CAA787rmf36V1=Sd8TZrc7DboTkeJDYKuEGgCe90mZLLKSp6=tw@mail.gmail.com>
	<1404525502.3109.25.camel@stross>
	<CAA787rnMonCuON+C0U5FDXKzjTBdpOusCpGLeWytDWaA1torEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 09 02:52:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4g7z-0003Ad-AT
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 02:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbaGIAwv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2014 20:52:51 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:40075 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150AbaGIAwu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2014 20:52:50 -0400
Received: by mail-lb0-f182.google.com with SMTP id c11so4436127lbj.41
        for <git@vger.kernel.org>; Tue, 08 Jul 2014 17:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=BpjwQi5zCEqlgJ7PdGpCNAz8WNZZ23mjTafBgGO/ymM=;
        b=kg5w/7xS7hLUBPX3RaFGIcbcXGK6KIKitAsKL95WRR9JLlReFqOmG8duYah4F7nnL3
         XgrRhyPR2ClssH415iLvWPJkGujl3B5aEgvbfsmXMnJj+14TQevqqDf0rJBeXq3XR5B9
         vHjA6CcV9FdqsGD3j4sueDF5RZ6REyILg1eoFjxTbA724P/VPU15Cp0vgJZ1p1mtsS0g
         dkMAGSZPdbFdlLY1Vsmjlp9xCFhQPxFg6uvZRjffeVWBOM1bppbypNtorT8Irv3EnKET
         CR/LvPEL8XLkxD6F7vNBEt8iZFOxFmkTj0WAZ6YPdSad2jUmYIngw403n2AafGuI0Qda
         Uasw==
X-Received: by 10.152.120.195 with SMTP id le3mr30219086lab.16.1404867169488;
 Tue, 08 Jul 2014 17:52:49 -0700 (PDT)
Received: by 10.112.142.7 with HTTP; Tue, 8 Jul 2014 17:52:49 -0700 (PDT)
In-Reply-To: <CAA787rnMonCuON+C0U5FDXKzjTBdpOusCpGLeWytDWaA1torEw@mail.gmail.com>
X-Google-Sender-Auth: hLYXO1DC8R9PKyx4kt_2UA8v_E0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253057>

On 3 July 2014 23:55, =C3=98yvind A. Holm <sunny@sunbase.org> wrote:
> When compiling newest master (v2.0.1-472-g6f92e5f) on Debian 7.5
> (64-bit), t5150-request-pull.sh fails when compiling with
>
> $ make configure
> $ ./configure --prefix=3D/usr/local/varprg/git.master.v2.0.1-472-g6f9=
2e5f
> $ make prefix=3D/usr/local/varprg/git.master.v2.0.1-472-g6f92e5f
> $ cd t
> $ ./t5150-request-pull.sh

=46YI, t5150-request-pull.sh passes all tests now on newest master
(v2.0.1-474-g72c7794) in Debian. There are two new commits on master
since I wrote this, and the commit that makes things work again is
4602f1a ("diff-tree: call free_commit_list() instead of duplicating
its code"). Reverting this commit brings the failure back.

The whole thing is still a mystery to me, though. I can't see why this
should have anything to do with the use of ./configure --prefix. I
tested several variants with and without ./configure --prefix, all
tests were run several times and were reproducible every time. Was
this --prefix thing just a red herring, or is it linked to this in
some way?

Also, the only file this commit touches is builtin/diff-tree.c, and
this file hasn't been modified since 2011. Does anyone know what's
going on here?

Cheers,
=C3=98yvind
