From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: do not truncate exported marks file
Date: Tue, 17 May 2016 20:59:47 -0700
Message-ID: <CAPc5daVJCfnEfA1sHrAGsXaA-80kFV4_4Hd0tLOMocE+qVV=-Q@mail.gmail.com>
References: <1463521223-14565-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq1t50uxy1.fsf@gitster.mtv.corp.google.com> <CAMP44s1WDzRAFV8iNj_RYiiRwJdBcuUDVR-Ew5FF37qdpEO5Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git-fc <git-fc@googlegroups.com>, Git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 18 06:00:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2sed-0006fA-Ae
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 06:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbcEREAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 00:00:09 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35392 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbcEREAI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 00:00:08 -0400
Received: by mail-yw0-f193.google.com with SMTP id v81so5023898ywa.2
        for <git@vger.kernel.org>; Tue, 17 May 2016 21:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=sDlh5lhnprk2Rw2gwiPVBf24VbGX9SRRyxZhh2nyf/M=;
        b=lIYRXAiFEvQnq4MHWpOJJ7HmXjrcTKicI/ePDKVPa4Chj8i3zWYn3w59eui4XIjJh0
         KsIySD+KAiDhYBKN+8uK2Xiz+NBcIr5IRLZtd8DGaJkGxe1tHxpVF7uY7p9KC0N7nBpr
         b2F2ueUd9kxnuqqv3u/jHOPnxPbEnpAHT+IKme1w8fpx549q13F/G2MAoDcfmEkdWI2T
         N6/WGmhCIIhVfjllMirZu8pq4Q51fkXamIIgVxp1H8iXGwFDEQajbsR6HEWd/sYSO2q7
         9MEFzB8PmrjB5A2AMTd8vNuRl/x6pDf5114DjMEgjB5OOVJRZ4qqhKmn5gq4gpO2NV7J
         pNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=sDlh5lhnprk2Rw2gwiPVBf24VbGX9SRRyxZhh2nyf/M=;
        b=ctAezbS987ZIcvrxLJNadHbxLSYOS0H6sOZvTN4oOpNVoQegCdqWruRoJyv5JZuTUx
         lXa9bCkve0KIjQvroBs7jCgC8bZDvt3l8TE7a09GX7KJ04IWUn5yn/VTals1OjcbGfsW
         hnWW57UWDwVZ+/QNfXWCQNBIrcZnWPBL6Am25uLfFJIEjQR+NwKB8hJITxziUgxFa/Dn
         rZUfXymSRoJYOIfZ1+GdcrLGCS1O2bzA+e/WOiK60DL4BL0Uzlk9fu09fNYTgQyMsz7I
         NJJT76yCvmEuGW/oB+UyQWPQhynWdklbyS5kF5c7HIZHu7Im1gWAx5yJPUNMxoaeBTyl
         twWw==
X-Gm-Message-State: AOPr4FXbCJmzaZ32suu3UmMSwtRtA7wGhYctjdc+O5aAob5pJWRPkwAUnqvzHVPDfvsL+QOP/p9vYwH89MpWsA==
X-Received: by 10.37.59.132 with SMTP id i126mr2596052yba.151.1463544006902;
 Tue, 17 May 2016 21:00:06 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Tue, 17 May 2016 20:59:47 -0700 (PDT)
In-Reply-To: <CAMP44s1WDzRAFV8iNj_RYiiRwJdBcuUDVR-Ew5FF37qdpEO5Mg@mail.gmail.com>
X-Google-Sender-Auth: -bpqxnDM1dFJldBln5SLyRjg_X8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294930>

On Tue, May 17, 2016 at 8:31 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, May 17, 2016 at 5:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>  - Even if we are reading from somewhere, export_marks_file can
>>    point at a completely new file that is different from
>>    import_marks file, in which case, we are not really losing any
>>    information by freshly creating a new marks file, no?
>
> Right, we are not losing any information, but we are not gaining much
> either: it's a truncated version of the import marks.

Ah, if we finished reading from the marks file and then die elsewhere,
the new conditional that says "don't clobber if we haven't finished reading"
would not have any effect, right. We'll see the imported ones plus some
of the new ones.

And if we didn't read anything but have export defined, then we can overwrite
the existing marks file, but that is nothing new.

>>  - Even if we did not read from any existing marks file, if we are
>>    given export_marks_file that names an existing file, wouldn't we
>>    want to avoid corrupting it with a dump from this aborted run?
>
> If we don't run from an existing marks file, this patch has no effect.

Yes, that is exactly what I was wondering if we may want to improve
while at it.
