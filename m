From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Preallocate hash tables when the number of inserts are
 known in advance
Date: Sun, 17 Mar 2013 12:39:39 +0700
Message-ID: <CACsJy8B=KrmbsqAuvoJTVxmUVYF_fG7XNnKvu3zDVELsWcmtQg@mail.gmail.com>
References: <1363490886-29729-1-git-send-email-pclouds@gmail.com> <7vzjy2si7l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 06:40:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH6Kk-0000z3-7i
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 06:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532Ab3CQFkL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Mar 2013 01:40:11 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:63744 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab3CQFkK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Mar 2013 01:40:10 -0400
Received: by mail-oa0-f52.google.com with SMTP id k14so4572073oag.39
        for <git@vger.kernel.org>; Sat, 16 Mar 2013 22:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=amy4OAYAWbBZiSB/QgY4kNMtyL7Z/BqeaUkGJ84u26I=;
        b=ByEFpFCpRaTlPEKzE/spmOd0nSleS60bqlD4hJA3FUui4Z+smX4w9+a64poJcuqLlx
         RaujH9t2doy0sSKpmwMklCWik+3f3/QS+cSc+F86n6FtWNmyLt8cZaQvKBX9lfDIUrgl
         h2i1SeKMP2vOx5n43PNUnJDR9CXj/Zh5h+zzy3iUMXzGL+076F6Rp+RtRzfdYkQiYo2z
         vzoz1yOMUO/oRCUJGMelx2ZLmp7mhBLLfgdtT4l98/R6EjzLr2RNvTUNR53tkkk9hoh2
         JqRU7hWd/TK3FcGlqmbsXtmLwh72wBooT6sYEYnObFmlqJrb5LZEkhAzYHA7nggTe5pK
         zNLw==
X-Received: by 10.182.72.5 with SMTP id z5mr5217075obu.24.1363498810000; Sat,
 16 Mar 2013 22:40:10 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Sat, 16 Mar 2013 22:39:39 -0700 (PDT)
In-Reply-To: <7vzjy2si7l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218332>

On Sun, Mar 17, 2013 at 12:34 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> This avoids unnecessary re-allocations and reinsertions. On webkit.g=
it
>> (i.e. about 182k inserts to the name hash table), this reduces about
>> 100ms out of 3s user time.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>
> I think this is a very good idea, but I would prefer the second
> parameter to the "preallocate" to be "expected number of entries"
> and have the preallocate, which is a part of the hash API, decide
> how to inflate that number to adjust to the desired load factor of
> the hash table.  We shouldn't have to adjust the caller when the
> internal implementation of the hash table changes.

OK will do.

>> ---
>>  nd/read-directory-recursive-optim reduces the number of input (from
>>  182k to 11k on webkit) to exclude machinery that all patches in the
>>  exclude optimization series I posted seem insignificant. So I won't
>>  repost them for inclusion unless you think it has cleanup values.
>
> Sorry, without a pointer, it is unclear what "exclude optimization
> series" you are referring to.

http://thread.gmane.org/gmane.comp.version-control.git/217697/focus=3D2=
17950
--=20
Duy
