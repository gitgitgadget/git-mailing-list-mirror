From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Fix t7004 which fails with retarded sed
Date: Fri, 16 Nov 2007 19:02:54 +0100
Message-ID: <83DEF29B-4E72-4913-A77E-8C00D69B48E4@wincent.com>
References: <20071116165944.GB29272@glandium.org> <1195233971-12288-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Nov 16 19:03:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It5Xp-0003qT-2D
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 19:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbXKPSDk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2007 13:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753968AbXKPSDj
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 13:03:39 -0500
Received: from wincent.com ([72.3.236.74]:42500 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752258AbXKPSDj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2007 13:03:39 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAGI3A8Y026732;
	Fri, 16 Nov 2007 12:03:11 -0600
In-Reply-To: <1195233971-12288-1-git-send-email-mh@glandium.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65236>

El 16/11/2007, a las 18:26, Mike Hommey escribi=F3:

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 096fe33..3813f23 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1007,7 +1007,9 @@ test_expect_failure \
> test_expect_success \
> 	'message in editor has initial comment' '
> 	GIT_EDITOR=3Dcat git tag -a initial-comment > actual || true &&
> -	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
> +	grep -e "^$" actual > /dev/null 2>&1 &&
> +	grep -e "^#" actual > /dev/null 2>&1 &&
> +	! grep -e "^[^#]" actual > /dev/null 2>&1
> '

Yep, that works here, and is a much more rigourous test than what we =20
had.

Cheers,
Wincent
