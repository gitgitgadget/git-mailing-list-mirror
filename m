From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 14:16:20 +0200
Message-ID: <BANLkTikKUuBMDR2-OBYXw7jzs_+1wGacuA@mail.gmail.com>
References: <20110427225114.GA16765@elte.hu>
	<7voc3r5kzn.fsf@alter.siamese.dyndns.org>
	<20110428062717.GA952@elte.hu>
	<BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>
	<20110428093703.GB15349@elte.hu>
	<BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com>
	<4DB93D16.4000603@cs.helsinki.fi>
	<BANLkTimD7KZz4fS0QynPui7-JQS10AkLtg@mail.gmail.com>
	<4DB941CD.2050403@cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: kusmabite@gmail.com, Ingo Molnar <mingo@elte.hu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
X-From: git-owner@vger.kernel.org Thu Apr 28 14:16:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFQ8y-000539-4u
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 14:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879Ab1D1MQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 08:16:23 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46793 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab1D1MQV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 08:16:21 -0400
Received: by bwz15 with SMTP id 15so2233075bwz.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 05:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=d3h5ckeSuS9pPp2G4moSp3e9aS+oG1/2fsxqDlwc+Bk=;
        b=k+Ok6PoHUgSiNJPtTppiJmzLG2yjcYag5Q6rN3CsPJ0s/7CMD4wWleb1HOZnaJP8nn
         xD3lSE9XFlDZH6MYYMOdQf8SxTHx/UEfGB3+/cMYH5dGxwvO5E87t7np25hL2aNOJOkE
         tI9POep0ONfvOolyVBgl9WxMv7bA59Y4IPvnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=I/ybkp8vCeSa8I+SQHwtjYNa8G/ma4LWjh2s/w5PMfwrqfbL/7eXQu5XRtdr33bBmy
         PiNbRNju//z9DvkkoseDs3Hjdkf75qvy0Ty+oqrRZlnkmlP/2t5h+/z8aF8F1cP4pgbA
         yVlZa+8BmbGzH2YIXg+DRnCHbIo1gOMPYd6G8=
Received: by 10.204.83.82 with SMTP id e18mr455463bkl.71.1303992980404; Thu,
 28 Apr 2011 05:16:20 -0700 (PDT)
Received: by 10.204.51.133 with HTTP; Thu, 28 Apr 2011 05:16:20 -0700 (PDT)
In-Reply-To: <4DB941CD.2050403@cs.helsinki.fi>
X-Google-Sender-Auth: h6--SBSHrZ01BUxAPs-I7LTxcTM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172358>

On Thu, Apr 28, 2011 at 12:30, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> Hi,
>
> On 4/28/11 1:19 PM, Erik Faye-Lund wrote:
[alignment issues]
>
> Yes, ARM is a problem and I didn't try to claim otherwise. However, it's not
> "impossible to fix" as you say with memalign().

MIPS (e.g. SGI machines) also bus-errors on non-aligned data.

-Tor
