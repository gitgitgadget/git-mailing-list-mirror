From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] tree.c: update read_tree_recursive callback to pass
 strbuf as base
Date: Tue, 2 Dec 2014 19:11:15 +0700
Message-ID: <CACsJy8B7G9xQerZ+6GTPQuG2v1DuJLXfsKFobuz_vyFahnXuYQ@mail.gmail.com>
References: <1417338302-8208-1-git-send-email-pclouds@gmail.com>
 <1417338302-8208-2-git-send-email-pclouds@gmail.com> <xmqqk32bp3nk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 13:11:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvmJA-0003YA-KU
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 13:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933060AbaLBMLu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Dec 2014 07:11:50 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:61801 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933050AbaLBMLq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2014 07:11:46 -0500
Received: by mail-ie0-f178.google.com with SMTP id tp5so11479287ieb.9
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 04:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=SAz6Y+R/nFxZADGPfk+GfXLtRJm2l98H/vm80cm5nlo=;
        b=mJkl0ogXbKf5u4q6ohAwWoEJec8vJhm0E0cem95nSDPMZ1c1gU1rD1rOHI8FN7ApiQ
         EsTjvd4MicHj0yyf8s7VbmAj6NzKG0fpyLHEXjJ4englZ83uyZXBCwDNCIL8g+dhDLW2
         bJgwi8pWEP7jTqHfO8dwrtINxKgeKqpIPSNMCwpNAX9YE/PQV/yEMRwKevFv34kG3LiS
         QcnEqTXbvyUwTvEZaBzmX842TJrbRTBdwuh9+2BH6BSWLkxmnnIDF4ciTmbOZFQjMtPf
         l8/gPr3M5M0+UpvufBkx65VnuxaRzAySxX+SBC0atDirz5AYh3uWo0C7SuRtYrQ7EvEL
         OwRw==
X-Received: by 10.50.47.102 with SMTP id c6mr2715444ign.27.1417522305725; Tue,
 02 Dec 2014 04:11:45 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Tue, 2 Dec 2014 04:11:15 -0800 (PST)
In-Reply-To: <xmqqk32bp3nk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260558>

On Tue, Dec 2, 2014 at 2:32 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> This allows the callback to use 'base' as a temporary buffer to
>> quickly assemble full path "without" extra allocation. The callback
>> has to restore it afterwards of course.
>
> Hmph, what's the quote around 'without' doing there?

because it's only true if you haven't used up all preallocated space
in strbuf. If someone passes an empty strbuf, then underneath strbuf
may do a few realloc until the buffer is large enough.
--=20
Duy
