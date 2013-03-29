From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/6] dir.c::match_pathname(): pay attention to the length
 of string parameters
Date: Fri, 29 Mar 2013 18:37:52 +0700
Message-ID: <CACsJy8AwrcbLuTnzq-y=xbXnyA-M=QCqu_S+h1of4-aWYfcN2w@mail.gmail.com>
References: <20130328214358.GA10685@sigill.intra.peff.net> <20130328214821.GD10936@sigill.intra.peff.net>
 <CACsJy8DisE8UNZzqmOFxPqw=bmFiHgE5-ao83ciGNUV9Sc9-gA@mail.gmail.com>
 <CACsJy8CT8DQEEJVMwonW05bFZNb7HjQWBdEjy3tv332xabJ=Bw@mail.gmail.com> <51557BE5.8000305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, avila.jn@gmail.com
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 29 12:38:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULXe0-0005jQ-Cl
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 12:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179Ab3C2LiX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Mar 2013 07:38:23 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:45305 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab3C2LiW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Mar 2013 07:38:22 -0400
Received: by mail-ob0-f172.google.com with SMTP id tb18so342289obb.3
        for <git@vger.kernel.org>; Fri, 29 Mar 2013 04:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=ef5nJ+bBJ/uf6Xu6qNk2QAzqBnknjKQOGvhO8+hNfbw=;
        b=hJ0Jpt/h6sq5QRi1YnnbwSliRaibFxGZ66usxt1Kn2EAHPwL9PLGsEeu1pYHrp6i7m
         qVEPtonhwRMV4FDj80i8bzQCc/Ujd6qgHmYvmsKWuRUSnufWxqhvhU3YZFQ2vOHS5b55
         B4t19jXKexZdh2PLhdBxK2uEjHPEtPzEkkjqCHeFEsyGDzJSnEN72uAEZnPJ+YdDpKne
         Sj5o8fPRLtQ1ScSgei5ISK04fFdCAdt+f7yzoK8x0/dbFF8mTLtvW+jbHpNt6cthvY7l
         pAzldXD3LMBYKKRixv3qvX+NAtkaNNSfd444sSWE+EWhSsU84jLnq4sMLuHBcf7jxKtU
         Ztrw==
X-Received: by 10.182.19.135 with SMTP id f7mr717095obe.95.1364557102419; Fri,
 29 Mar 2013 04:38:22 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Fri, 29 Mar 2013 04:37:52 -0700 (PDT)
In-Reply-To: <51557BE5.8000305@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219496>

On Fri, Mar 29, 2013 at 6:32 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
>> Just tested. t0003 and t3001 on 'pu' work for me because I have
>> USE_WILDMATCH on (which turns FNM_PATHNAME to WM_PATHNAME). Both bre=
ak
>> without USE_WILDMATCH.
>>
> Hm, tested what?

Tested t0003 and t3001 with and without USE_WILDMATCH, which is pretty
much like you patch, except that wildmatch is used instead of fnmatch.

> diff --git a/dir.c b/dir.c
> index 73a08af..0b63167 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -564,7 +564,7 @@ int match_pathname(const char *pathname, int path=
len,
>
>         return fnmatch_icase_mem(pattern, patternlen,
>                                  name, namelen,
> -                                FNM_PATHNAME) =3D=3D 0;
> +                                WM_PATHNAME) =3D=3D 0;
>  }
>
> Gives only one breakage, so we are coming closer.
>
>
> *** t3001-ls-files-others-exclude.sh ***
> [snip]
> not ok 17 - ls-files with "**" patterns
>
>
>



--=20
Duy
