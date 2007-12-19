From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Fix git-instaweb breakage on MacOS X due to the limited sed functionality
Date: Wed, 19 Dec 2007 12:28:04 +0100
Message-ID: <23306E3C-24F1-4626-A956-02531644B786@wincent.com>
References: <20071219105752.GA23932@hashpling.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Wed Dec 19 12:28:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4x6J-0006UQ-Cv
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 12:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbXLSL2K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 06:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752463AbXLSL2J
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 06:28:09 -0500
Received: from wincent.com ([72.3.236.74]:35506 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752202AbXLSL2I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 06:28:08 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBJBS5SE018632;
	Wed, 19 Dec 2007 05:28:06 -0600
In-Reply-To: <20071219105752.GA23932@hashpling.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68886>

El 19/12/2007, a las 11:57, Charles Bailey escribi=F3:

> -	sed "$script" "$1.tmp"  > "$1"
> +	# The generated scripts assume that perl is /usr/bin/perl
> +	# so the assumption here should be no more harmful
> +	/usr/bin/perl -p -e "$script" "$1.tmp"  > "$1"

I think it's a bad idea to hard-code the perl path there; the =20
generated scripts only assume /usr/bin/perl if the user hasn't =20
overridden it at build time:

	PERL_PATH=3D/foo/perl make ...

Using just this should work fine anyway:

	perl -p -e ...

Cheers,
Wincent
