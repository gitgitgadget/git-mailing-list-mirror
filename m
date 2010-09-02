From: Joshua Juran <jjuran@gmail.com>
Subject: Re: [PATCH] doc: technical details about the index file format
Date: Thu, 2 Sep 2010 02:08:57 -0700
Message-ID: <E4DDD4F7-FEDB-49CE-9515-90D64B66D7D3@gmail.com>
References: <201009012054.20482.robin.rosenberg@dewire.com> <1283351989-19426-1-git-send-email-pclouds@gmail.com> <AANLkTi=wESk38u1XSTL1rd2__eQzHfSuq-EbqooxmcVw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=UTF-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	robin.rosenberg@dewire.com, srabbelier@gmail.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 11:09:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or5nT-0002vd-DH
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 11:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089Ab0IBJJD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 05:09:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36406 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011Ab0IBJJC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 05:09:02 -0400
Received: by iwn5 with SMTP id 5so332027iwn.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 02:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=TyEGEnECue/SYn0pooG2NKtJ18Hgtp3861tJeInA3Vg=;
        b=i95ijMbqPyrhYWjUI2vjL79vUFNgLG8qJwKuCACVUzBkRyckTMOfDlxhMSSOxu/11l
         s+MfD+YpxsVGOmr/bfy8kYY99mWEDOfnSLLHoah0bwHAmleLfyd1kAsIX1FnG7wFlM+j
         32U/kIaegHR0nFbgS4hj4fK/DJJGBIJi3hbeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=CiyRdJROPJZJtQpRGWDax++bW9SWxkNnPref5vAr4XlRZAe9uiiHkqj9TqQp4aFASx
         PJrJwNACzqeAiK76SiGKTA+1bgl39c4tgR67p1KJvOZhUTroNcImz/7i84AF5U7MnxZh
         +rO77edgjn1IC2KDDJJhBztEzCyXVN4ruBTRY=
Received: by 10.231.17.11 with SMTP id q11mr10495973iba.63.1283418541521;
        Thu, 02 Sep 2010 02:09:01 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id e8sm385271ibb.8.2010.09.02.02.08.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 02:09:00 -0700 (PDT)
In-Reply-To: <AANLkTi=wESk38u1XSTL1rd2__eQzHfSuq-EbqooxmcVw@mail.gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155117>

On Sep 2, 2010, at 1:56 AM, Alex Riesen wrote:

> 2010/9/1 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
>> +=3D=3D Index entry
>> +
>> +  Index entries are sorted in ascending order on the name field,
>> +  interpreted as a string of unsigned bytes. Entries with the same
>> +  name are sorted by their stage field.
>> +
>> +  32-bit ctime seconds, the last time a file's metadata changed
>> +    this is stat(2) data
>> +
>> +  32-bit ctime nanoseconds (modulo 1G)
>> +    this is stat(2) data
>
> Maybe I'm missing something, but I failed to find where "modulo 1G" =20
> comes from.
> AFAICS (read-cache.c), the stat data are saved almost unmodified
> (casted to unsigned int).
> (BTW, is 1G the Gravitational Constant or what?)

G stands for "giga-" meaning one billion, so 1G refers to one billion =20
nanoseconds.

> I'm not sure it is safe to assume that  every system Git will be
> ported to defines
> "unsigned int" to be 32 bits. OTOH, never met one where it is =20
> something else.

DOS and early Mac compilers have used 16-bit ints, but I don't think =20
anyone cares.

Josh
