From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/7] Fix tests under GETTEXT_POISON on pack-object
Date: Mon, 20 Aug 2012 22:17:06 -0700
Message-ID: <20120821051706.GA55686@mannheim-rule.local>
References: <1345523464-14586-1-git-send-email-pclouds@gmail.com>
 <1345523464-14586-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: =?utf-8?B?Tmd1eeG7IG4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 07:16:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3gpY-0003TY-Ii
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 07:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab2HUFQh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Aug 2012 01:16:37 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53074 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab2HUFQe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 01:16:34 -0400
Received: by pbbrr13 with SMTP id rr13so7960350pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 22:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=p64R7h8N+iR7pB0RPNmrv1Dopgn3ssicwx5VAZeiaZ4=;
        b=xzalpNasstuzmq3eQsUYTU3NLLL3w10ySRpsIf/3LlRGODeyxTmHzS5qRXqWwA5h9h
         7DJkTOKtvQe6Rb+Mx34MoqWw7TO4H4vwHebMCwXgaVJMcjx9VpsmvKGI9KE4YKiHBU78
         FmY0yQDdoDb3HK4PR5gU4/cd/Qij17pvn6yJSYkM01jcwdawpnPF6gTFtATFta1Xr6XP
         fy6mkd4DaXoGyzKjFZclpaXINiA0VYF6XgkP/UKAFEqAibOoWvuHkdbuOiQHnlBCKiFc
         CPyJqSzdghvo09wBkYbghfINHlAxrsDVMCOxp/WqToGURjgCivZZa5HFQEysaOW1rOri
         MAcQ==
Received: by 10.66.79.198 with SMTP id l6mr2344558pax.55.1345526193660;
        Mon, 20 Aug 2012 22:16:33 -0700 (PDT)
Received: from mannheim-rule.local (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id mu8sm659451pbc.49.2012.08.20.22.16.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 22:16:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1345523464-14586-6-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203936>

Hi,

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> From: Jiang Xin <worldhello.net@gmail.com>
>
> Use i18n-specific test functions in test scripts for pack-object.

Thanks for resending, and sorry I haven't made time to polish the
translation-based poison implementation you sent before (which seemed
very useful and pleasant to work with).

[...]
> --- a/t/t5530-upload-pack-error.sh
> +++ b/t/t5530-upload-pack-error.sh
> @@ -35,7 +35,7 @@ test_expect_success 'upload-pack fails due to error=
 in pack-objects packing' '
>  	printf "0032want %s\n00000009done\n0000" \
>  		$(git rev-parse HEAD) >input &&
>  	test_must_fail git upload-pack . <input >/dev/null 2>output.err &&
> -	grep "unable to read" output.err &&
> +	test_i18ngrep "unable to read" output.err &&
>  	grep "pack-objects died" output.err

Wouldn't it make sense to change the second "grep" of output intended
for humans to test_i18ngrep while at it?

With or without that change, this and the rest of the series looks
good.

Hope that helps,
Jonathan
