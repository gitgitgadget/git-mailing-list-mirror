From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 19:02:22 +0700
Message-ID: <BANLkTikf2Q81otJxOWoAs+EFA5_4wf7fyQ@mail.gmail.com>
References: <20110427225114.GA16765@elte.hu> <7voc3r5kzn.fsf@alter.siamese.dyndns.org>
 <20110428062717.GA952@elte.hu> <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>
 <20110428093703.GB15349@elte.hu> <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com>
 <20110428101902.GA17257@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Apr 28 14:03:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFPvz-0005oZ-Cm
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 14:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570Ab1D1MC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 08:02:59 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64750 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab1D1MC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 08:02:58 -0400
Received: by bwz15 with SMTP id 15so2222807bwz.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 05:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Czi+J0u8lip59ECZPaDAOVV0Ew9GBtr0BwVKndxgZ8k=;
        b=DKLWypsxi4eqCz2kgEmnwgqWhhv+AqgwZDj9dtxtmSyQ/aO/84ep0CP4bdYh2X8wWC
         yT5mnsBdMl7/BMd8yFRd4EkfNWotBZzylrBrY5LkBj1PYDwQ2TbTSaJlGfzls0w7RPkQ
         AK6KoMTiWLLgcv0qKraqgPupFt/N9+AAru4Po=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=eVnQJ1Ba0Sh5F6g2X2258Pl/wZKdHkOUZzBhGdQJ4XDeQYZYpaMOltko9xWye4REmJ
         6bEJs0lw59DKmleeq7TXstTJ24Ppel+zVa/6melrRB278Sqmq1x+jzWGssOd9Y/QznA3
         +At2BLXHXH9mLNhg1KrW/Brp15zvh07K/2xc8=
Received: by 10.204.20.143 with SMTP id f15mr994021bkb.173.1303992176678; Thu,
 28 Apr 2011 05:02:56 -0700 (PDT)
Received: by 10.204.17.14 with HTTP; Thu, 28 Apr 2011 05:02:22 -0700 (PDT)
In-Reply-To: <20110428101902.GA17257@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172355>

2011/4/28 Ingo Molnar <mingo@elte.hu>:
> If you'd like to see other things tested please suggest a testcase that you
> think uses these hashes extensively, i don't really know what the slowest (and
> affected) Git commands are - git gc is the one *i* notice as being pretty slow
> (for good reasons).

git clone
-- 
Duy
