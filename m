From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: [PATCH] Remove useless if-before-free tests.
Date: Sat, 23 Feb 2008 08:30:42 -0500
Message-ID: <118833cc0802230530l104acc72k20ceb4b5adcff937@mail.gmail.com>
References: <871w7bz1ly.fsf@rho.meyering.net> <47B995CC.2000809@gmx.ch>
	 <87skznhqk6.fsf@rho.meyering.net>
	 <7vzlts9ag8.fsf@gitster.siamese.dyndns.org>
	 <87ir0gx5bn.fsf@rho.meyering.net>
	 <7vskzk99fd.fsf@gitster.siamese.dyndns.org>
	 <87tzk0tzjz.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Jean-Luc Herren" <jlh@gmx.ch>, "git list" <git@vger.kernel.org>
To: "Jim Meyering" <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sat Feb 23 14:31:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSuTb-0003d4-WD
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 14:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbYBWNao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 08:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753633AbYBWNao
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 08:30:44 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:40040 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbYBWNan (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 08:30:43 -0500
Received: by fg-out-1718.google.com with SMTP id e21so575039fga.17
        for <git@vger.kernel.org>; Sat, 23 Feb 2008 05:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Z1wqvqVMDbqKZtVnMDmkjtihlPZuCyK+itX0vY/ApQ0=;
        b=SWTYYe3pi61aQz57xcrdThD5FhfhXJ5Mx9RdmefYPhBtfOHkyWLWUQbGxdJIds0dMfSgjjouhZVMoaGBErTFSH3pDVkWxGAQmMy0N6rj7Cwj9Cqa4fDMo07C7iUuHwBlFlk/cZG8s0vz6dGWjShCZo1snJVD4T3gaU3rmdhc2Ps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Py2pal9ERb8HhmYkaStbhTWm/gfcZ/HkEZ1roBCCIfwO3BqMjks3RmJXA9qDqvpqPf9HYo4aBNpVjXyzlVAFaRVob8R1tGOLkFkHANrrjRzx/uPQ4ZM8IT4ubCuQDRRmRwnbUxCdt3PWEQApwMjnJ1My5IeNNR4H747vvZAfiaQ=
Received: by 10.86.26.11 with SMTP id 11mr397493fgz.74.1203773442502;
        Sat, 23 Feb 2008 05:30:42 -0800 (PST)
Received: by 10.86.52.6 with HTTP; Sat, 23 Feb 2008 05:30:42 -0800 (PST)
In-Reply-To: <87tzk0tzjz.fsf@rho.meyering.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74823>

> +inline void gitfree(void *ptr)
>  +{
>  +       if (ptr)
>  +               free(ptr);
>  +}
>  +#define free gitfree
>  +#endif

I am wondering why you do it this way.  "#define free gitfree" is just
not valid in a C program that includes the relevant standard header.
"free" is a reserved symbol.

To stay within the standard, do the define the other way and use
gitfree everywhere.

Morten
