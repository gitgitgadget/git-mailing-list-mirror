From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] blame: simplify prepare_lines()
Date: Fri, 13 Jun 2014 14:13:39 -0700
Message-ID: <20140613211339.GL8557@google.com>
References: <539B569F.1090800@web.de>
 <539B5713.10300@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Kastrup <dak@gnu.org>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 13 23:13:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvYnH-0000QZ-Lw
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 23:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874AbaFMVNn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 17:13:43 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:43344 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856AbaFMVNm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 17:13:42 -0400
Received: by mail-pb0-f44.google.com with SMTP id md12so1659981pbc.31
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 14:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NzhhBjAFQLUxWKnFecMG8+HGZnyKd3IQW7/iCuTJzQU=;
        b=oMkLO1yvRYc+6EYXvRmGZwLzja8xDlG9uCJwQqXt6ibknYz+C32JYVLc8UVct2wW68
         R25uvZHr7FrJRmi6EyARUikflvR4q3cpYC4Lz4zHWUEnh+NICAhsur9CnyqkVu1RzUDM
         NkzYfrBoRdEPGUJrhY7/nkX6yd4rl9dkZENPxjUQCGFGz6Y9+oWcZuDEFgUAh3UIA8ks
         c0W4y8QrQ70GPMV4/VNmI/r2dYHqhhjc5DTcvBzxAbkzwk41OdMhu/DCXkhrfLOhbz4x
         K54XKwhWaQvZbduca021/uVLzdJf0RMTJ6uBjYs1J/P9yN83XL3e5R03lQYTR/7mZwpG
         ZZcA==
X-Received: by 10.69.17.66 with SMTP id gc2mr6331391pbd.90.1402694021718;
        Fri, 13 Jun 2014 14:13:41 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id wp3sm5256313pbc.67.2014.06.13.14.13.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 13 Jun 2014 14:13:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <539B5713.10300@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251638>

Ren=E9 Scharfe wrote:

> -	if (incomplete)
> -		*lineno++ =3D len;
> +	*lineno =3D len;
> =20
> -	sb->num_lines =3D num + incomplete;
> +	sb->num_lines =3D num;

This will always treat whatever comes after the last newline as an
incomplete line, even if it has zero length.  Is that safe?  (Not a
rhetorical question --- I haven't looked carefully at the caller.)

Thanks,
Jonathan
