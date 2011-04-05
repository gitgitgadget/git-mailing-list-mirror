From: Antriksh Pany <antriksh.pany@gmail.com>
Subject: Re: [PATCH 4/5] tree-walk: unroll get_mode since loop boundaries are well-known
Date: Tue, 5 Apr 2011 16:55:24 -0700
Message-ID: <BANLkTin9P-OdTQhPTwcvgvpDoBg7E+va5Q@mail.gmail.com>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
 <1301535481-1085-4-git-send-email-dpmcgee@gmail.com> <7v7hba9csn.fsf@alter.siamese.dyndns.org>
 <BANLkTi==M=N+Z3qcsYk+tHap8A1Y41QfLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 01:56:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7G6W-0005sb-Si
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 01:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639Ab1DEX4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 19:56:08 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42629 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab1DEX4F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 19:56:05 -0400
Received: by gyd10 with SMTP id 10so374948gyd.19
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 16:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=/4Temg26lxsLyJCOVmw8NcbNiPAwIoMjxQbUxf1Xqpw=;
        b=VD9d8bbLb0/5Y0p6KXKaaS/MSAXRZ5wMhO7ZYBL5EpIoxlgJCE4Jst6VLqEMk5znEx
         KakO+LciwzqgW9T+XexfTK+uPImqx2lDFKIXwD6V62PFt+IOT+JZXarQzdyFbUch/y+L
         7FPzCnrCHg9kOkpksV26ew4aUfOR6sW6+DBao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ekX+Rj5i6lDn/qTQZ1p6U/EVb+iGf4wlx15SuztxdtB90ZVIIW6gj5LFDE9ha8DIrx
         gwAWu9HddnZzNo+tFXnkdfuyuaN2vmxEivH9hpALN4uJ5V+p6H0jar7PJ0ObIKoRRS1C
         2tghJyZJ2/RWkcZT5mzO0tPDJXp5HN2VawJYw=
Received: by 10.236.95.169 with SMTP id p29mr390269yhf.293.1302047764117; Tue,
 05 Apr 2011 16:56:04 -0700 (PDT)
Received: by 10.236.105.176 with HTTP; Tue, 5 Apr 2011 16:55:24 -0700 (PDT)
In-Reply-To: <BANLkTi==M=N+Z3qcsYk+tHap8A1Y41QfLw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170943>

On Mon, Apr 4, 2011 at 10:33 PM, Dan McGee <dpmcgee@gmail.com> wrote:
> ....
> Totally agree; I should have tried to do it this way in the first
> place. However, compiling the fixed-length 0 to 5 loop does not
> produce fully-unrolled assembly for me with CFLAGS="-march=native
> -mtune=native -O2 -pipe -g" on x86_64. I see two copies of the loop
> only, and even worse is the (lack of) performance (each is the mode of
> 3 runs). Compilers are stupid apparently.
> ....

Can you try -O3? Or an explicit '-funroll-loops'?
gcc I think does not do aggressive speed optimizations at the cost of
space when at O2.

Cheers
Antriksh
