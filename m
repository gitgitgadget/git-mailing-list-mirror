From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Tue, 9 Jun 2009 14:26:15 +0200
Message-ID: <c07716ae0906090526i714bb6c9g4e3d8cf61021af77@mail.gmail.com>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>
	 <7vskidcf9s.fsf@alter.siamese.dyndns.org>
	 <200906070932.36913.chriscool@tuxfamily.org>
	 <4A2CAA56.1030707@zytor.com> <7vws7n6vcf.fsf@alter.siamese.dyndns.org>
	 <4A2D337C.70203@zytor.com> <7vzlcixwue.fsf@alter.siamese.dyndns.org>
	 <c07716ae0906082124n4a5bfe88md80ba8076c928b76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 14:26:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME0PI-0001Nz-04
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 14:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758621AbZFIM0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 08:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758391AbZFIM0P
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 08:26:15 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:55818 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759560AbZFIM0O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 08:26:14 -0400
Received: by fxm9 with SMTP id 9so2927340fxm.37
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 05:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=m1zddJe02oXskYD5evrYN+a2b3IhdKA/Nox3f086Gpo=;
        b=T0wfc/c2+Ojk5gWeDJ7Rbhpx6IU5QVE/+jRDObJsJkqsXbwryiYd+PBVf9vNMrjMAV
         y5w/eApJ/HbHyha+THxBLbFq/14Dms4EV18hk72fYnF9xoI9XFWaXr4xpUTl9JvAuONA
         VJg+3Wk0CaVZJcOnHCHsBKwmzjqoqgqHU1Bl0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BOAf67VeI3GVCKpo5yfP3jD05VW/pB3sTsyeNjC3SVC959gDp3L5g+Ldlob0B+42R+
         U26XFtWwahgzBLoLWiaWta8iio285DvldAr2e+ruHhciK9yq7zeDUHepho6WV2+1HDd6
         6lPQQiMpEFOF2h8txNf86Bnwl1QJE4qCPNsp4=
Received: by 10.103.214.8 with SMTP id r8mr39277muq.12.1244550375938; Tue, 09 
	Jun 2009 05:26:15 -0700 (PDT)
In-Reply-To: <c07716ae0906082124n4a5bfe88md80ba8076c928b76@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121171>

On Tue, Jun 9, 2009 at 6:24 AM, Christian
Couder<christian.couder@gmail.com> wrote:
>
> So I would be ok to implement a config option or a switch to "git
> bisect start" to let people use a PRNG instead of my algorithm but I
> think something like my algorithm should be the default.

Another reason to have 2 algorithms is that when you use "git bisect
run" you might want to use the PRNG one because:

- you don't care much if the bisection use some more steps (as long as
it does not get stuck)
- you can't do much if it get stuck

On the other hand, when you bisect manually:

- you probably won't like it if you are asked to test some commits
that won't give a lot of information
- if it get stuck, you can manually use "git bisect visualize" and/or
"git bisect skip <range>" and/or some other manual commands to do
something about it

Regards,
Christian.
