From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Re: [PATCH/RFC] Fix for default pager
Date: Tue, 8 Jun 2010 10:49:51 -0300
Message-ID: <AANLkTilvvpy4TBQF6g8boQL87FRB7kFDrVfYiHvOv6xu@mail.gmail.com>
References: <1275955088-32750-1-git-send-email-soft.d4rio@gmail.com>
	<1275955270-sup-2380@pinkfloyd.chass.utoronto.ca>
	<AANLkTinydWk3GqGDww8FS7pmW16jAVazRkmT_GsRMIhy@mail.gmail.com>
	<20100608053507.GB15156@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 08 15:50:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLzBw-0003aO-UV
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 15:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325Ab0FHNtz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 09:49:55 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65264 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320Ab0FHNtx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 09:49:53 -0400
Received: by bwz11 with SMTP id 11so1166352bwz.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 06:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5RUJlK95HJzY7dauM3n/dFI1OlshiVo7eXvKzz3BJyg=;
        b=Paj2i2eiZmuEHD2Hz54MncXBC1xdzIKUHmr31m+z3ucYbXDVvAv5BgGhXlFhtby5Ns
         CDDEoUTFu85TTaduLVnx9U+nvjam/1ak0hKPDMxDSjD5Q7l+Xk+ts0wWZKhOF7R+x/z8
         vn+TDh6erwiqf3HDK6Oypke4AggD07B5wXsh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wzcn9AvJlcMQ5RC3L7qCAPV97jxu9ZdNHuw69BthmH/2oDZN42rezDX3Uhk/pAxYW6
         /83I1+dYwCw3hceM4xQ4kXiI0J54e48FkkeRMyXj5HhtiXD2iDv6MX5xakfP7c1Ovf7o
         jXx0jS7P7ZkS227XME/uaU2OnTnfq6n/uQa0Q=
Received: by 10.204.162.133 with SMTP id v5mr7762040bkx.6.1276004991655; Tue, 
	08 Jun 2010 06:49:51 -0700 (PDT)
Received: by 10.204.46.80 with HTTP; Tue, 8 Jun 2010 06:49:51 -0700 (PDT)
In-Reply-To: <20100608053507.GB15156@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148672>

On Tue, Jun 8, 2010 at 2:35 AM, Jeff King <peff@peff.net> wrote:
> If you are downloading a binary, the package compiler should do one o=
f
> two things:
>
> =A01. indicate a package dependency on 'less'
>

but... git will be uninstalled if you happen to uninstall less.

> =A02. set DEFAULT_PAGER to 'more' (or whatever is appropriate for you=
r
> =A0 =A0 system)
>

and I know it's a very nice fallback default, but you still depending
on the pager, and will display nothing and return 0 if 'more' fails to
execute.

Something needs to be changed... if the sane way is to keep default
pager (almost setting 'more') instead of auto-detection... then we
must say something to the user when the pager fails to execute. (*)
Actually 'git' display nothing... and returns 0.

> Yes, auto-detection means we can more flexibly "upgrade" to less when
> the package suddenly appears. But if you really care about your pager=
,
> why not just set $PAGER?
>

good point, I agree. But again, back to (*), we must correct
something... the other way is that if pager fails to execute, we
cannot simply return 0.

I could submit a patch for this, may be is a little bit better (or simp=
ler).
