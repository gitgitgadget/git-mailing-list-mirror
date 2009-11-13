From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Speed up bash completion loading
Date: Fri, 13 Nov 2009 04:29:55 -0600
Message-ID: <20091113102955.GA8531@progeny.tock>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com>
 <20091111220832.GA31620@progeny.tock>
 <4AFCFF50.5080401@gmail.com>
 <20091113070652.GA3907@progeny.tock>
 <4AFD06CD.7090003@gmail.com>
 <20091113085028.GA4804@progeny.tock>
 <20091113090343.GA5355@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kirill Smelkov <kirr@mns.spb.ru>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <junio@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 11:20:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8tFy-0004Ma-WF
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 11:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755703AbZKMKTo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Nov 2009 05:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755585AbZKMKTn
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 05:19:43 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:64494 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234AbZKMKTm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 05:19:42 -0500
Received: by yxe17 with SMTP id 17so2772239yxe.33
        for <git@vger.kernel.org>; Fri, 13 Nov 2009 02:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ilY+SJ6AaoLO+2+ZrAGhG9F1urTTxLymSqEiyKplsB0=;
        b=OkfwwsUbCK9GF0Q+m87xEpNIcS0/H0glFmomwEvZP2pp7AQ9KHNMGDrtHI30LOgJOJ
         VtDztQfdfrnJvSCoxRZENginLORoOXg+YW6FpecC88NEiOLW3qrhrWGcr3ZwZZRMp2Xo
         pPFIhjQJRwxmnb5MlUeT0JIgLhBC9CxwKWPys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=UTsi7v/kyery4N3GEvGVCwXHaD9trtih3JH2FYVYvSNfjOuUFxKiD3BXIPhY+FqsXc
         s2sXWGze9kQSutwpWWuV8NJD3OHcYdOsH4Mc5yBi2omdoDnh7/6Gs7TYXk7Z9eq7UT2r
         j81hnocSiD4vlBKlQSjiRAHJWUmVYvY4XGzKk=
Received: by 10.101.152.38 with SMTP id e38mr4401140ano.117.1258107575898;
        Fri, 13 Nov 2009 02:19:35 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm402618yxe.37.2009.11.13.02.19.34
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Nov 2009 02:19:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091113090343.GA5355@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132830>

Jonathan Nieder wrote:
> @@ -1545,7 +1540,8 @@ _git_config ()
>  	pager.*)
>  		local pfx=3D"${cur%.*}."
>  		cur=3D"${cur#*.}"
> -		__gitcomp "$(__git_all_commands)" "$pfx" "$cur"
> +		__git_compute_all_commands
> +		__gitcomp "__git_all_commands" "$pfx" "$cur"
>  		return
>  		;;
>  	remote.*.*)

s/__git_all_commands/\$__git_all_commands/

Yikes.  Next patch I=E2=80=99ll let sit for a day.

Good night,
Jonathan
