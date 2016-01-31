From: Aaron Gray <aaronngray.lists@gmail.com>
Subject: Re: [bug] Possible Windows 'git mv' bug
Date: Sun, 31 Jan 2016 15:38:06 +0000
Message-ID: <CANkmNDedU90cHon13HaFfE+Ok=5ZtcBOa7mEkZm-eHNMFJd5KA@mail.gmail.com>
References: <CANkmNDd8GJmKGw9zToKS1ML3tg9Cx2iYQM0E8iHCO2TuQfwmAQ@mail.gmail.com>
 <56AE1F40.8060509@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jan 31 16:38:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPu59-0006VJ-TP
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 16:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757468AbcAaPi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 10:38:28 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34451 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757454AbcAaPi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 10:38:27 -0500
Received: by mail-lb0-f181.google.com with SMTP id cl12so62650182lbc.1
        for <git@vger.kernel.org>; Sun, 31 Jan 2016 07:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ybVqwd/O+CGtaQbAOkEUdAUmAEQnBbOrWNli2n3wI64=;
        b=R4m8t9VoQne7E1KD+ogcDuXeqbnTPeKVaR/kArqAPUeUmdTkXE3mIotG85NhEQOK2R
         gdwbTia8LRMhx9HfP+9Tn7lXw60OMj591493b6zPnHJzck6c8E+tE/+8NrUyFZHxLGgy
         kcKPXGKljgZDcvxGxCEcu1KHEBodwhQkFPSLR1CJLxJvZWFrRh/JEJqU9jmrtkvHCn2f
         cM+FvlfY4+ejAek0+sB59v2oPqQEN54gdSva9HvbgSP+chRydckKFi4Sc8GXuGgLkdqZ
         KDyyhqfVpp54G8LThDx8FFHTOJ341b90Og0MU0r1gUsTs7uUNyETo7fD6YQjwPjqakDR
         RZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ybVqwd/O+CGtaQbAOkEUdAUmAEQnBbOrWNli2n3wI64=;
        b=hqFNOoJrcJwvnIOBqu2bTCpYEwJA5kEcvD7jFQEbmkpeWe8DjETbWyXuXaEn7s0RUS
         GPqSshCzVJLz896k0m5qYpZT+j93T0kldFbqjczxaFOtcZRUFT3DmrWeXjs0QyDRIvUl
         23bRh9NkWBrIxHUkZPX1tm2SUdvIr6ZX1TeYNWUOkDFri9J7Kv46Seb7pz3kE912zL97
         tn/H/nSisda5Gqq0K3AOTL5jU8fXjI4Xtz8sbKTWTx4/zZlKJKGEXdPfxcLkK+9XnS/5
         awSueim1rODlQF3lqs2TuYtUeHT18A8TrjjXxhK8ViK5aB5ye5kDtFAyHpL3qCPJdOun
         kQNw==
X-Gm-Message-State: AG10YOQ/HCKrDqAc4tRxfigfFu6LuiDtRbahPG5G6jGinRJLO4GD4m8ydDAfuW+1gDLuJavdb2KMcYgCkAwdFw==
X-Received: by 10.112.151.70 with SMTP id uo6mr6737421lbb.65.1454254706299;
 Sun, 31 Jan 2016 07:38:26 -0800 (PST)
Received: by 10.25.207.195 with HTTP; Sun, 31 Jan 2016 07:38:06 -0800 (PST)
In-Reply-To: <56AE1F40.8060509@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285152>

On 31 January 2016 at 14:50, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 31.01.2016 um 15:03 schrieb Aaron Gray:
>>
>> Hi,
>>
>> I think I have found a possible difference in behaviour between
>> Windows git commandline distro and Linux git
>>
>> basically If I do a :-
>>
>>      git mv logger.h Logger.h
>>
>> I get the following :-
>>
>>      fatal: destination exists, source=lib/logger.h,
>> destination=lib/Logger.h
>>
>> It looks and smells like a bug to me !
>
>
> Not really. When you attempt to overwrite an existing file with 'git mv',
> you get this error message on both Windows and Linux.
>
> The difference is that logger.h and Logger.h are the same file on Windows,
> but they are not on Linux. Hence, when you attempt to overwrite Logger.h on
> Windows, you see the error because it exists already (as logger.h).
>
> As a work-around, you can use -f.

Thanks Hannes !

Still a bug though IMHO

Aaron
