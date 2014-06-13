From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] blame: factor out get_next_line()
Date: Fri, 13 Jun 2014 14:05:42 -0700
Message-ID: <20140613210542.GK8557@google.com>
References: <539B569F.1090800@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Kastrup <dak@gnu.org>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 13 23:08:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvYht-0004WL-LN
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 23:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753190AbaFMVFq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 17:05:46 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:47499 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836AbaFMVFp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 17:05:45 -0400
Received: by mail-pd0-f169.google.com with SMTP id w10so2503507pde.0
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 14:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=w0rT5dkf+w1y4XscfaI08VIMtoFmIrFOpAgnuLuWQR4=;
        b=gmk3yZ0BDiWdhgzzou9O8a0c8I+uaL7t2jbrxfDVt+AWMrpFDd9GBzW0i2T978avBV
         OPu7qpL3wLrOLtgPXc68otw13dfb6M+Z+Md/Xm6XvAefEYFHgHXw8ZT+T7Ixw+wzxdDp
         ic0oTa6JmGzRlneyFc2OBgmQtiXrXm+ja4tRwwJxqWymdQcTdeirdERh1qarTCquzSp2
         FPRMEZIKRoWSj2049+K3oIguNf3VSl+GeVQ4vRh8NG5Xe1pdOj6MEjsqu8ToZS1/oK34
         ZbVT2rZ/1n2zKBvtOGJ1LwP2RruCKEUutI8n6wiQ03B82MI0OKirVKpBwLVGjU14LjWG
         h4Jg==
X-Received: by 10.68.95.225 with SMTP id dn1mr6243738pbb.126.1402693545443;
        Fri, 13 Jun 2014 14:05:45 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id sv10sm26476836pab.32.2014.06.13.14.05.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 13 Jun 2014 14:05:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <539B569F.1090800@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251635>

Ren=E9 Scharfe wrote:

> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/blame.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

[...]
> +	for (p =3D get_next_line(buf, end); p; p =3D get_next_line(p, end))
> +		num++;

This could say something like

	for (p =3D buf; p =3D get_next_line(buf, end); ) {
		num++;

or

	p =3D buf;
	while ((p =3D memchr(p, '\n', end - p))) {
		p++;
		num++;
	}

but what you have seems more readable.

Thanks,
Jonathan
