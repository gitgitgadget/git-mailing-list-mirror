From: Adam Mercer <ramercer@gmail.com>
Subject: Re: Determining if a tree is clean
Date: Sat, 6 Mar 2010 14:33:22 -0600
Message-ID: <799406d61003061233w60633e26t4c2434042b7f216d@mail.gmail.com>
References: <799406d61003060712t120d7f11me6e2ab212c55271@mail.gmail.com> 
	<7vy6i5fe5h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 06 22:29:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No17K-0004YU-1G
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 22:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294Ab0CFUdo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Mar 2010 15:33:44 -0500
Received: from mail-bw0-f222.google.com ([209.85.218.222]:43603 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab0CFUdn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Mar 2010 15:33:43 -0500
Received: by bwz22 with SMTP id 22so1767507bwz.28
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 12:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=YXyVTQ4nH4IbmryYTUFVn1gbso+xBeLoJmYTswr4u74=;
        b=hNP+R7xiwzJh6dRrazon+0Tkxf0ce7uDrV9URYwNyNLhRzQ244mk/4bKnjcR2Zzlf9
         wwWYTnYAQ7e+xYH07GItlvkno1JIM2pJ6+E7s1hN3Mt210bz7bXn6JIwBschKr8g8bXn
         uEylDm3fLBNsG86W56Yiln93LfBtEuJ0aIPro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CrrGkXK2Z2+z1m+fuXiKm1GlZvNkp96EcaU7GBP9J/RfgLeB4ZzmDciOIeh0qV5a/K
         csIEa35HZ+jIlbILRLfPOhyQITGbe3vt5IH4TTwvMhSSMU6Mf2xYpgxN2xxDAlY3ENKM
         GzhR4qWeIy2IwOkJs9Ty/7px81jNWmLUv8h8s=
Received: by 10.204.9.151 with SMTP id l23mr191227bkl.76.1267907622088; Sat, 
	06 Mar 2010 12:33:42 -0800 (PST)
In-Reply-To: <7vy6i5fe5h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 6, 2010 at 13:23, Junio C Hamano <gitster@pobox.com> wrote:

> It is expected that a Porcelain script that implements a custom featu=
re
> may call diff-files, diff-index and other plumbing commands many time=
s
> during its lifetime, and that it knows what it is doing (namely, when
> it touches the working tree itself and why).

Makes sense.

> Your Porcelain script should look something like:
>
> =A0 =A0git update-index --refresh
> =A0 =A0git diff-files -q || { echo "modified working tree"; exit 1 }
> =A0 =A0git diff-index --cached -q HEAD || { echo "modified index"; ex=
it 2 }
>
> See contrib/examples/*.sh for examples

Thanks, Junio. That does the trick, I'd recently found the
update-index command and had run into the problem (but not the
solution) that the call to diff-files addresses.

Cheers

Adam
