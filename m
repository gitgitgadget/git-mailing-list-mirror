From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v6 31/44] run-command: make dup_devnull() non static
Date: Sat, 11 Jun 2016 12:18:29 +0200
Message-ID: <CAP8UFD02QN95UyRFBL23uLu_XmPupAs4qBfOjGs30K5=nUBTZQ@mail.gmail.com>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
 <20160610201118.13813-32-chriscool@tuxfamily.org> <575BC92B.4080401@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jun 11 12:18:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBfzv-00006q-QB
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jun 2016 12:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbcFKKSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jun 2016 06:18:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34170 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbcFKKSb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2016 06:18:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id n184so3743574wmn.1
        for <git@vger.kernel.org>; Sat, 11 Jun 2016 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PhT0CXhzp2CSYloK38bFO44+YFuIsJ+DVlZSuUTtFAc=;
        b=hdrXZEvuZNCy4t/2o76MEmM2vQuMpCNbVM5qaiYq2ojBJqQN3djoe04EohlV7evjDK
         DmtJod9xpwsLb5toxP1/9DdXB5sP0TJSzHbnme0MHjeGdHPW8cuT49ZgIi1VnTsH0ph3
         iKyxvFstNwYTBr5bcebluCvhruVHdQ2q4xcJAmoLL3uOBYzqjihsitbeGAuv/MllW9Ls
         Ahg0C72E3p7eDOReX2LO1rP1kAkmJyr8c/LeMh86lqZqZQE6TF5U3t/rTH1gVnD7e6Re
         pKg0F4bUoIkqWx4jRy2Cp4arwB/+YXrRVxjS4jqhY4NmWVBaRN+jjMhg8iTPpW4Uuitn
         GkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PhT0CXhzp2CSYloK38bFO44+YFuIsJ+DVlZSuUTtFAc=;
        b=c/WfiWR8k9Ql9Ob5OHlElUSM9ISXTtRbF/sH5LVv99Y3XWf1moYhi7du9TT7QYDiX3
         +q67eZEKNyL4+XhWLEwtC/0cGSXCaWLeRgo+wuJ2ytFPMUkeziTUAyjRUvCg5d6H+jja
         emeBdyKybjgXICQeftroA/BLYLFFQm8VVy9wlNDXSn+fHIAVqRiQKN+XK1rg+iM3IJXK
         9rm5osBC6djNLx6zyLVhYyfjyABYVoaZgC01gBKIKGtubVq3SPuFG8r12bgIejzWGO12
         JTTAWAQ/5cSdqK+/Ct4+qXY10Bep4kIuQYad2D/wZyKziWaogEgQLdFQfarjSh/B8Zqi
         ZY/g==
X-Gm-Message-State: ALyK8tK7MHYlTP5US9hH+gPbbDW2Uo9PkdO22InOE5SQBj/7uvIiVNxIWc9aVV3CnyZzV4BnbroFa+mGAHtc8w==
X-Received: by 10.195.17.138 with SMTP id ge10mr6557732wjd.94.1465640309821;
 Sat, 11 Jun 2016 03:18:29 -0700 (PDT)
Received: by 10.194.25.197 with HTTP; Sat, 11 Jun 2016 03:18:29 -0700 (PDT)
In-Reply-To: <575BC92B.4080401@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297094>

On Sat, Jun 11, 2016 at 10:17 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 10.06.2016 um 22:11 schrieb Christian Couder:
>>
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -85,7 +85,7 @@ static inline void close_pair(int fd[2])
>>   }
>>
>>   #ifndef GIT_WINDOWS_NATIVE
>> -static inline void dup_devnull(int to)
>> +void dup_devnull(int to)
>
>
> I'm not adding arguments to what we've heard on whether to use /dev/null in
> this series or not. But if the outcome is to keep this patch, please remove
> the #ifndef that we see in the context lines (and the matching #endif), too.
> Otherwise, the build fails on Windows for each patch in the series until
> this change is reverted in patch 42/44.

Ok, I will find a way to avoid that build failure, though I don't test
on Windows.

Thanks,
Christian.
