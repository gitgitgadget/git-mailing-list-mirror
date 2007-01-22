From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] config_set_multivar(): disallow newlines in keys
Date: Mon, 22 Jan 2007 16:06:50 +0100
Message-ID: <81b0412b0701220706w65ed0657h1d69819e7879ed40@mail.gmail.com>
References: <200701150144.56793.jnareb@gmail.com>
	 <200701191310.32417.jnareb@gmail.com>
	 <Pine.LNX.4.63.0701191420000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <200701192344.11972.jnareb@gmail.com>
	 <7v8xfyczxi.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0701200224180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 16:07:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H90l6-0000ru-P2
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 16:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbXAVPGx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 10:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbXAVPGx
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 10:06:53 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:24900 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbXAVPGw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 10:06:52 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1074376uga
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 07:06:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PVNctnSZaBR6ZkQYS3A3x0Z4rGImDaTNyDtWYhclAKVEJH19+9VAkb3d/mVO0UOmOe2xlDEUwQwhIsQXa2KHdflcs4e03VlWhMYRjjtUWLUwqeajqP0miDBvuiBGSK7uzdkG2mV7lLIcsphTAWlvxISLMbU3uIIjgtUmmBOSqMc=
Received: by 10.82.138.6 with SMTP id l6mr5237043bud.1169478410750;
        Mon, 22 Jan 2007 07:06:50 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Mon, 22 Jan 2007 07:06:50 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701200224180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37415>

On 1/20/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> --- a/config.c
> +++ b/config.c
> @@ -661,6 +661,11 @@ int git_config_set_multivar(const char* key, const char* value,
>                                 goto out_free;
>                         }
>                         c = tolower(c);
> +               } else if (c == '\n') {
> +                       fprintf(stderr, "invalid key (newline): %s\n", key);

BTW, why config.c never uses error() or warn()?
