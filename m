From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v6 2/2] mergetools: add winmerge as a builtin tool
Date: Wed, 20 May 2015 22:20:09 +0200
Message-ID: <CAHGBnuPyhG4y5ooR7KH0KrEhRYFu9BB+HKnnn+XhU5xL2TnL=w@mail.gmail.com>
References: <1432112843-973-1-git-send-email-davvid@gmail.com>
	<1432112843-973-2-git-send-email-davvid@gmail.com>
	<xmqqtwv7m2hw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Aguilar <davvid@gmail.com>, Phil Susi <phillsusi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 20 22:20:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvATP-0000SG-Ru
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 22:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754373AbbETUUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 16:20:11 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35891 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbbETUUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 16:20:09 -0400
Received: by iepj10 with SMTP id j10so48183271iep.3
        for <git@vger.kernel.org>; Wed, 20 May 2015 13:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LQo48wJCP2zG/yZMykvNI2DnkgmnNNttHurANVo3oOY=;
        b=WekgYb0431Ui/WzBfxW1IttuQ61Hn79a+JD3gX1EUYTPw1qXY6chgUjAV5ioNsB5TQ
         rVSWy2NPd0vkOM0MiMovC0057EfJ3gW6LVBqnfIRR1hh57hk81fq/RDWketVGYA9Nb5X
         ghUTS4Vq5t1Q/+syrPBwJXKSjUs34DffjD5IAT6275/77xAa0KfE7vzSUgZQouO6ZVmF
         SN71bQvpYL6bOdzsS626EO7U7QRU1EPwuCPhLs7P3TzOWbkTGj7q9D8LcreMXw+X3lUU
         TB9bC3Z9GgOVil2DEx+/GUR0oa74kj8Nk6IDtOhaNwnNbzNwXTA/GWxDT6xgxBXcfE2F
         UnRA==
X-Received: by 10.50.79.202 with SMTP id l10mr15587746igx.7.1432153209320;
 Wed, 20 May 2015 13:20:09 -0700 (PDT)
Received: by 10.107.29.149 with HTTP; Wed, 20 May 2015 13:20:09 -0700 (PDT)
In-Reply-To: <xmqqtwv7m2hw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269516>

On Wed, May 20, 2015 at 10:13 PM, Junio C Hamano <gitster@pobox.com> wrote:

> David Aguilar <davvid@gmail.com> writes:
>
>> +     for directory in $(env | grep -Ei '^PROGRAM(FILES(\(X86\))?|W6432)=' |
>> +             cut -d '=' -f 2- | sort -u)
>
> Is the final "sort" really desired?  I am wondering if there are
> fixed precedence/preference order among variants of %PROGRAMFILES%
> environment variables that the users on the platform are expected
> to stick to, but the "sort" is sorting by the absolute pathnames of
> where these things are, which may not reflect that order.

I did add the sort (and -u) by intention, to ensure that "C:\Program
Files" (which is what %PROGRAMFILES% expands to by default) comes
before "C:\Program Files (x86)" (which is what %PROGRAMFILES(X86)%
expands to by default), so that programs of the OS-native bitness are
preferred.

-- 
Sebastian Schuberth
