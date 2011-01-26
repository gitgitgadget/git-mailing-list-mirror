From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't find the revelant commit with git-log
Date: Wed, 26 Jan 2011 10:01:23 +0100
Message-ID: <m2y668yr6k.fsf@gmail.com>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Jan 26 10:01:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pi1Fw-0005rM-8U
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 10:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306Ab1AZJBb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jan 2011 04:01:31 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36306 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802Ab1AZJBa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jan 2011 04:01:30 -0500
Received: by wyb28 with SMTP id 28so697621wyb.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 01:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:references:mail-followup-to
         :date:in-reply-to:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=5KHfA+FqPVhloAMB1yulqMIRh0YLumMHNG5Ak86KBG0=;
        b=FG+P/zssiy94EDCDyen439MljCvF1FUeJpaGjh28TT6ByZFhtVDg0vmsymuzusFMXc
         8ngT9gcGTAzPJNgJIcBcjteXsWQjRyj8N4iIioKQxh7JHTOjtYzJr7KBYEQDRg05cxMe
         Ej2bEjssAFDo+WEf2xjBZXIgKgwdN+SSuke6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:mail-followup-to:date:in-reply-to
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=gc9MEbuXk3SpLcZ64sv0ITlEQXXoP2C1aGCRHq1lDTmVbzCiX0GejcEAJ7JtrphydD
         EWQkohoTqDbBAJdii5UTDg+uFzGk0qirE4xKKqn1yGAKt1nvtaZ76tuaynzfcdmsqlrJ
         xivbvM1NH8d+hiBUUro1fUtDf5VOJtOBZvhxM=
Received: by 10.216.78.212 with SMTP id g62mr4575012wee.78.1296032489185;
        Wed, 26 Jan 2011 01:01:29 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id j49sm7645133wer.14.2011.01.26.01.01.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Jan 2011 01:01:27 -0800 (PST)
Mail-Followup-To: =?iso-8859-1?Q?Ren=E9?= Scharfe
 <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
In-Reply-To: <4D3EF650.20407@lsrfire.ath.cx> (=?iso-8859-1?Q?=22Ren=E9?=
 Scharfe"'s message of
	"Tue, 25 Jan 2011 17:12:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165508>

Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

[...]

> Hmm, seems like the function is gone since d847059.  Does all of this=
 help
> you in any way?

Sigh... one more try, one more failure...

This time I tried to use git-bisect(1) to see if I couldn't track the
change more easily.

So, here's what I did:

    $ cat ./bisect.sh
    #! /bin/sh
   =20
    if ! git grep -q -e blacklist_iommu -- drivers/pci/intel-iommu.c
    then
    	exit 1
    fi

    $ git bisect start v2.6.28 v2.6.27 -- drivers/pci
    Bisecting: 70 revisions left to test after this (roughly 6 steps)
    [a0bfb673dca8a2b4324fe11e678ec6d6a9ad67e0] Merge branch 'linux-next=
' of
    git://git.kernel.org/pub/scm/linux/kernel/git/jbarnes/pci-2.6

    $ git bisect run ./bisect.sh=20
    running /dev/shm/bisect.sh
    Bisecting: 42 revisions left to test after this (roughly 5 steps)
    [0235c4fc7fc6f621dc0dd89eba102ad5aa373390] PCI PM: Introduce functi=
on
    pci_wake_from_d3
    running /dev/shm/bisect.sh
    error: The following untracked working tree files would be overwrit=
ten
    by checkout:
       arch/x86/es7000/Makefile
       arch/x86/es7000/es7000.h
       arch/x86/es7000/es7000plat.c
       drivers/pci/dma_remapping.h
    Please move or remove them before you can switch branches.
    Bisecting: 18 revisions left to test after this (roughly 4 steps)
    Aborting
    bisect run failed:
    'bisect_state bad' exited with error code 1

Do you know what's going wrong ?

Thanks
--=20
=46rancis
