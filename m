From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] bash-completion: Print a useful error when called in a 
	non-bash shell
Date: Thu, 29 Jul 2010 22:16:15 +0000
Message-ID: <AANLkTikxNe-+tjHkxCk-FtRxLpeyRkx-Wx109iuE+6fL@mail.gmail.com>
References: <4C50B005.1030004@pileofstuff.org>
	<7v4ofiuuf7.fsf@alter.siamese.dyndns.org>
	<4C51F2C0.8090101@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	"solsTiCe d'Hiver" <solstice.dhiver@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Fri Jul 30 00:16:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OebOo-0008Gw-CH
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 00:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755148Ab0G2WQR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jul 2010 18:16:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54623 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851Ab0G2WQQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jul 2010 18:16:16 -0400
Received: by iwn7 with SMTP id 7so654299iwn.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 15:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=roPmWSq8bCCXATuups1zzXhB9w1yEMC9bm8cRLisyWo=;
        b=lQqn3SNEuioYDMD/sriaSgH0a8b7e3OfoLtcw6LLzJH1wPW/e7TJO6u+1jHFP4Dqx/
         +opi66mzmUINVSCLg08BEU6/HKlsf56S03pDDHyz4R4rdZbZnFe8SF3SjP0v7a4WuaUM
         i11pXUmmeRG4okvmftmxRC3xSCfne8CQRVLtc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tee99RJe9Lz/j3R6rcLJvmyzv23hzBZXjmfZ59edi7kPmA+aZ7hSUD2ACggcBtMoUJ
         bWe4RREkwCPTckdRXfAWzV+IbK5XltRDWot22moEe9YYfGO7RWLv1Aw3X2zhTToZ3IQH
         KIxDJ1swJN2R10ThClFyf4gUdFwfEWrTWmJSY=
Received: by 10.231.191.6 with SMTP id dk6mr812766ibb.51.1280441775816; Thu, 
	29 Jul 2010 15:16:15 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Thu, 29 Jul 2010 15:16:15 -0700 (PDT)
In-Reply-To: <4C51F2C0.8090101@pileofstuff.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152205>

On Thu, Jul 29, 2010 at 21:29, Andrew Sayers <andrew-git@pileofstuff.or=
g> wrote:

> On 29/07/10 17:25, Junio C Hamano wrote:
>> This looks like a Linux-ism to me.
>
> Caught red-flippered :) =C2=A0I'll use `ps` next time.

That's also probably hard to get right on all the mutually
incompatible *nix ps(1) implementations out there.

As for this patch in general, I think solving this issue in Git's
bash-completion code isn't the right thing to do, I think the right
thing is to just ignore it and no nothing.

Any given *nix distribution will include lots of non-POSIX and
shell-specific initialization files throughout the system. Trying to
detect if the shell is running in POSIX compatibility mode in each of
these is going to be redundant and bug-prone.

Instead the user should make sure that he's invoking the shell in
non-POSIX mode before evaluating non-POSIX code.

Maybe this is a bigger potential problem than it seems, but it seems
like just a one-off error in Arch Linux. I'd be surprised if it didn't
also break dozens of other packages in Arch which included bash
extensions.

This is not a nack, if you want to pursue this and try to emit a
friendlier error message that's great. But maybe it's a bit *too* much
effort on our part.
