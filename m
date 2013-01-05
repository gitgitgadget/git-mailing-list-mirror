From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Add getenv.so for catching invalid getenv() use via LD_PRELOAD
Date: Sat, 5 Jan 2013 18:37:54 +0700
Message-ID: <CACsJy8A-Q8uDC0fJzspU8khCtWnMgmz66L2G9hLmsRYFYLaumw@mail.gmail.com>
References: <CAEvUa7niTJVfp8_kuWs50kvhfZ59F-yAuAmeOXEduHXOq-tRFA@mail.gmail.com>
 <1357376146-7155-1-git-send-email-pclouds@gmail.com> <20130105103900.GA4200@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	David Michael <fedora.dm0@gmail.com>
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Sat Jan 05 12:38:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrS5M-0002Gz-VD
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 12:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465Ab3AELi0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jan 2013 06:38:26 -0500
Received: from mail-oa0-f48.google.com ([209.85.219.48]:54439 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab3AELiZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jan 2013 06:38:25 -0500
Received: by mail-oa0-f48.google.com with SMTP id h2so15535914oag.7
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 03:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=w8PETSzIhuM28yQbvuunXK64MT7C8TYMzh3IpGaIm0c=;
        b=RdPVpb7nexPkEGxA2gCzGgS8P5rqkaRjqAVBALlk1tc9dRZtdchf/XnK1Dao8Hf+B0
         E9uybH7MQlaSR775m/o+PlDiwpOL4PUeHwzL83fYFIXejGtT+H79LFMd0p/Wrkkx1W/c
         z9DGkxvt3WNQ7ZQRGR2Fmh4LWQk5rw7IJ2b+3KH/KXouezLzLUebyjgwdozGD2UEqmBC
         hMqZ6wyvNfFqfGuANOnN/yuVKIua0ZiNvV4CYMsDZ2UBHcnx/WzsfIP+qIrsgtJeqKuo
         aBqcKdoJ11cQF056qSqZpbOq0S2qrhJP2Ih01y5tJ8b+1gi0TXdHw56+k+VfGGu2mYS5
         iEzw==
Received: by 10.60.8.134 with SMTP id r6mr30149616oea.53.1357385904502; Sat,
 05 Jan 2013 03:38:24 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Sat, 5 Jan 2013 03:37:54 -0800 (PST)
In-Reply-To: <20130105103900.GA4200@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212688>

On Sat, Jan 5, 2013 at 5:39 PM, Matt Kraai <kraai@ftbfs.org> wrote:
> On Sat, Jan 05, 2013 at 03:55:46PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>>  Perhaps this will help the getenv bug hunting (I assume we do the
>>  hunting on Linux platform only). So far it catches this and is stuc=
k
>>  at getenv in git_pager().
>
> It seems like a static analysis tool might be able to detect these
> problems.  Is there a way to do so using sparse?

That was my first thought. But this may involve flow analysis and I
don't think sparse is up to it. ccc-analyzer is still pretty basic.
And between static analysis and runtime check, I prefer the latter as
it's more reliable as long as you have a good coverage test.

>
>> +             n =3D backtrace(buffer, 100);
>> +             symbols =3D backtrace_symbols(buffer, n);
>> +             if (symbols) {
>> +                     for (i =3D 0;i < n; i++)
>
> s/;i/; i/

Thanks. I will fix it later if people actually want this.
--=20
Duy
