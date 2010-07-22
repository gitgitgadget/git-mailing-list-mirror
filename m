From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/7] revert: fix off by one read when searching the end
 of a commit subject
Date: Thu, 22 Jul 2010 18:00:00 -0500
Message-ID: <20100722230000.GD19745@burratino>
References: <20100722131141.2148.63850.chriscool@tuxfamily.org>
 <20100722131836.2148.57468.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jul 23 01:01:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc4lL-00025j-52
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 01:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674Ab0GVXBE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Jul 2010 19:01:04 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63106 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab0GVXBB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jul 2010 19:01:01 -0400
Received: by yxg6 with SMTP id 6so903327yxg.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 16:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=tJAxvp/8uF+xmp2HysbMYcJw/29m65ACoHdTTL5ztQo=;
        b=E7K2tQI8w73gqImhO8rMKopj5cbI9PL8Hfb2R8a3Z+3SHLcdEK6Z7N88DeN/v1REz6
         A6A/1uCE9s8uk+EOrtZGWHPoaEOKWj3fmat1fA4P8JoSYKLaoXnuVuDkkohe0f7opL0e
         5Q+vrixAxsGK3pU+QWMRVjWGiaciw+49CPv+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=hF1ISNPoTfryFAfIkdZ+Jtg5dQ+TRNgqDyEvlDYVQiDBLic9WXc3Vex+D/M/FCMIgU
         uSFJc2XrgjgQeajdzbKkoxEZcZrM6zlbZpPo6YGHDpQMKfOAA7YUq86vkyxi6UOYtlDW
         tIBWaUi3jiqWKYeAV4l1YQ3rd2Y+Y7tc6r8Rs=
Received: by 10.224.69.162 with SMTP id z34mr1846909qai.38.1279839660383;
        Thu, 22 Jul 2010 16:01:00 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h20sm31025014qcm.21.2010.07.22.16.00.58
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 22 Jul 2010 16:00:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100722131836.2148.57468.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151493>

Christian Couder wrote:

> +++ b/builtin/revert.c
> @@ -131,7 +131,7 @@ static int get_message(const char *raw_message, s=
truct commit_message *out)
>  		p++;
>  	if (*p) {
>  		p +=3D 2;
> -		for (eol =3D p + 1; *eol && *eol !=3D '\n'; eol++)
> +		for (eol =3D p; *eol && *eol !=3D '\n'; eol++)
>  			; /* do nothing */
>  	} else
>  		eol =3D p;

Good catch.  For what it=E2=80=99s worth, this and the rest of the seri=
es is

Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
