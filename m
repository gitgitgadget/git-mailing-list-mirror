From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 03/12] MINGW: compat/mingw.h: do not attempt to redefine
 lseek on mingw-w64
Date: Mon, 28 Apr 2014 22:13:17 +0200
Message-ID: <CABPQNSZxk-cBCNhH4KwCGC2TGCQQ0TvMX=oOL31Eup=y6ZPm1A@mail.gmail.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-4-git-send-email-marat@slonopotamus.org> <535EB32B.4050209@web.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marat Radchenko <marat@slonopotamus.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:14:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerwC-0007vQ-MT
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 22:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756895AbaD1UN7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 16:13:59 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:47682 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756858AbaD1UN6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2014 16:13:58 -0400
Received: by mail-ig0-f176.google.com with SMTP id uy17so5239811igb.3
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 13:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=Ue+X+1TLvlXuHqGBhVnKvH+OMzVzSsjNQZAW/RSWsDM=;
        b=dbXsgT5tZUfcl+gPV3+rkmSpLZ2WTbdNRvFhY+k/yAxnBaLi5S/qNvBWZ7Bni3BHPQ
         9Mx+itqwksSk8t/nIJXJO6MyU3Qx9aUQY9C4W80RucY59j29VAOdTNKMjPaJgIvcmbU3
         oZE1l0wxZb/MGxt5iWmdxi/ijMxnpznLLiw17yiwwTlMa49gMGZ2/HIIn7YcWSK1xf5u
         kPDV9BFCFO4CO92XcQnOkS0i0SFotb423sYxJn0kQp10F8/bPFuvofpHJ3nA/dxHA+8/
         1puxhbLxI0WbEh+e1Zmt09qT5aW/2yGfYv8+j0MGkVArYQzK+mkE+TRPV12N9ISTtw1H
         zlcA==
X-Received: by 10.42.162.68 with SMTP id w4mr19340428icx.50.1398716037920;
 Mon, 28 Apr 2014 13:13:57 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 13:13:17 -0700 (PDT)
In-Reply-To: <535EB32B.4050209@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247438>

On Mon, Apr 28, 2014 at 9:59 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 2014-04-28 15.51, Marat Radchenko wrote:
>> mingw-w64 has lseek defined in io.h.
> []
>>  #define off_t off64_t
>> +#ifndef lseek
>>  #define lseek _lseeki64
>> +#endif
> Is the commit message in line with the code?
>
> I would have expected something in this style:
>
> #if defined(__x86_64__) && ! defined(lseek))
> #include <io.h>
> #endif

No, we want 64-bit off_t either way, to support large files. So we
need the version that takes a 64-bit argument.
