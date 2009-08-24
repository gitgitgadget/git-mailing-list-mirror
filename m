From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: [PATCH] remove ARM and Mozilla SHA1 implementations
Date: Mon, 24 Aug 2009 16:10:47 -0400
Message-ID: <eaa105840908241310m5c4007ach19f496fe294eb7ea@mail.gmail.com>
References: <alpine.LFD.2.00.0908171940540.6044@xanadu.home>
	 <alpine.DEB.1.00.0908180208160.8306@pacific.mpi-cbg.de>
	 <alpine.LFD.2.00.0908240011010.6044@xanadu.home>
	 <alpine.DEB.1.00.0908241333130.11375@intel-tinevez-2-302>
	 <alpine.DEB.1.00.0908241849160.8306@pacific.mpi-cbg.de>
	 <alpine.LFD.2.00.0908241318000.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Aug 24 22:11:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mffsj-000125-V6
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 22:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbZHXUKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 16:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbZHXUKs
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 16:10:48 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:56490 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbZHXUKq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 16:10:46 -0400
Received: by ewy3 with SMTP id 3so2738138ewy.18
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 13:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type;
        bh=BRSTRzBbO2UcWGey60G9DJB7BADTQLtxJpcmXDa8Y2M=;
        b=viENr1XPlwubsytt1UBxeRbCpJBYtEgufCzfeXY5BGSPp088mZDk8YL+gC7K06X97V
         NX3p1EgN6X5xvdcd/HSur0CgcVisGKFmtaxUJmgi9UA7seDr6RL/EqjW1VFMVeHhYCLL
         i6jH67jSiS65VjU8PhHI0S5l/NpfjPKjZoDLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=mabe97gH5OorvW4HrAD+CfZGMFMaaD37CZBKsBb6EwSd5XBE29H4IHbRmrPFRJe2rd
         4/8oxSRzKLrZQ2N/CtakhWoYsjlMjPVPT3YI5HlYMqvoVkY3nKZKjcwM7bL1iBqrj/ho
         1d5STFUGS7eZz+Vo9lFxrBaHuDfncHKlkBkn4=
Received: by 10.211.200.20 with SMTP id c20mr2519449ebq.15.1251144647043; Mon, 
	24 Aug 2009 13:10:47 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0908241318000.6044@xanadu.home>
X-Google-Sender-Auth: c7305f12734009c2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126963>

On Mon, Aug 24, 2009 at 1:27 PM, Nicolas Pitre<nico@cam.org> wrote:
>
> TRy a build with PPC_SHA1=1, and then compare with BLK_SHA1=1.
> And best is to time a fsck --full.

I happen to have an old POWER3 AIX box available.

I got tired of waiting for a fsck --full to complete on the git repo,
so I used git://anongit.freedesktop.org/git/xcb/libxcb instead. Best
of five runs:

OpenSSL:
$ time ../git-1.6.4.1/git fsck --full

real    0m4.120s
user    0m3.776s
sys     0m0.031s

BLK_SHA1:
$ time ../git-blk/git fsck --full

real    0m4.231s
user    0m3.867s
sys     0m0.026s

PPC_SHA1:

    CC ppc/sha1ppc.o
Assembler:
/tmp//ccdODWpe.s: line 8: 1252-142 Syntax error.
/tmp//ccdODWpe.s: line 9: 1252-142 Syntax error.
[same error repeated 42 times]
gmake: *** [ppc/sha1ppc.o] Error 1

Hmm. So that may not help so much after all. Let me know if there are
any other tests you would like me to run.

This machine has:
$ gcc --version
gcc (GCC) 3.3.2

$ as -v
as V5.3

$ lsattr -E -l proc0
frequency   200000000      Processor Speed       False
smt_enabled false          Processor SMT enabled False
smt_threads 0              Processor SMT threads False
state       enable         Processor state       False
type        PowerPC_POWER3 Processor type        False


Peter Harris
