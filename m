From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Fri, 15 Feb 2008 02:07:46 +0100
Message-ID: <200802150207.47095.jnareb@gmail.com>
References: <200802081828.43849.kendy@suse.cz> <200802142300.01615.jnareb@gmail.com> <alpine.LSU.1.00.0802142334480.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Nicolas Pitre <nico@cam.org>, Jan Holesovsky <kendy@suse.cz>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brian Downing <bdowning@lavos.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 15 02:08:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPp4H-0004Ju-4u
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 02:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756750AbYBOBIG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Feb 2008 20:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756683AbYBOBIE
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 20:08:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:56863 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756541AbYBOBIB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 20:08:01 -0500
Received: by nf-out-0910.google.com with SMTP id g13so333364nfb.21
        for <git@vger.kernel.org>; Thu, 14 Feb 2008 17:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=aw9AyuRt/H1uKJ/FP81NC/b6Jm22LFkEgfrhoWVfxds=;
        b=YLHcDU3TifB0HxKALHgvls9p2YPzaBLP9kahFZW7S7lyEk0nyYrPDvD6krQ+enKpAW9b53N6LK7ZJgpMDrQ8zcGzlocyoUL5/NLop7HKWFJmbyxdAcyj4XgdkWbQr9d9snvL63Q1jSeltGYKsupjgOJHIKqPbnY0t7o1SgQdN+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oUxx/nsFfPOorN+nE9DcstwZWpFMKWetyyk5Qxw1DLYK6teZa3OYYYaH3yMhMXLA8aGfB6JA/Ylj8wX79GxGIT/tr9i7Mh0C5ksZuzOZGCOKPu8e/kAhKpvQJiAeexT8GmKA+ILJMI2eLuYNlS2fseDH6xzCd0VfaiM3XK1WchU=
Received: by 10.78.161.4 with SMTP id j4mr2368593hue.25.1203037679644;
        Thu, 14 Feb 2008 17:07:59 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.219.2])
        by mx.google.com with ESMTPS id 2sm1231533nfv.5.2008.02.14.17.07.56
        (version=SSLv3 cipher=OTHER);
        Thu, 14 Feb 2008 17:07:57 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0802142334480.30505@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73935>

Dnia pi=B1tek 15. lutego 2008 00:38, Johannes Schindelin napisa=B3:
> Hi,
>=20
> On Thu, 14 Feb 2008, Jakub Narebski wrote:
>
>> I wonder if proper subdivision into submodules (which should
>> encourage better code by the way, see TAOUP), and perhaps
>> _partial checkouts_ wouldn't be better solution than _lazy clone_.
>> But it is nice to have long discussed about feature, even if at
>> RFC stage, but with some code.=20
>=20
> I think partial checkouts are wrong.  If you can work on partial=20
> checkouts, chances are that what you work on should be a submodule.
>=20
> Having said that, I can understand if some people do not want to have
> the hassle of test^H^H^H^Husing submodules...

IMHO there is place for submodules, there is place for partial=20
checkouts, and perhaps there is even place for the combination of two.

=46or example while Documentation/ isn't a good candidate for a submodu=
le,=20
because as you add new feature yuou want to add to documentation, if=20
you change some feature you want to change documentation: there are=20
whole-tree commits which contain changes outside Documentation/.
Nevertheless there are some people (technical writers) which are=20
interested only in Documentation; perhaps only in few files there.
They would want to have partial checkout, I guess.

On the other hand cgit and msysgit use submodules, and I think it is=20
good solution. I wonder if Sourcemage Linux distro uses submodules...=20
In the case of cgit I think having git.git or its clone/fork as=20
submodule is a good idea, but perhaps even better would be to checkout=20
only part of it: libgit or libgitthin

--=20
Jakub Narebski
Poland
