From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: improve recipients_cmd()
Date: Mon, 29 Apr 2013 00:32:09 -0500
Message-ID: <CAMP44s3QkiQhYr7pKHgKFoXH5m9_ZHLHmwC4c9WC2OGjv7LHdg@mail.gmail.com>
References: <1367101561-14671-1-git-send-email-felipe.contreras@gmail.com>
	<7vbo8yqxas.fsf@alter.siamese.dyndns.org>
	<CAMP44s0x8fK-6vbY20eKA9QjWqhiOCvx+KFOgKOZ8q58bwk8Tw@mail.gmail.com>
	<7vd2tdoqna.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Joe Perches <joe@perches.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 07:32:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWghW-00065l-01
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 07:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643Ab3D2FcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 01:32:17 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:51399 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505Ab3D2FcO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 01:32:14 -0400
Received: by mail-la0-f45.google.com with SMTP id el20so2163830lab.32
        for <git@vger.kernel.org>; Sun, 28 Apr 2013 22:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=fuRG6d22YRtCfH/KCL5ciNWNlJYimJoVGy5JSUsNcIA=;
        b=vke5W/UugvTyHh5SM+i7XW9RybxqMmYCUOg7H2LiR8EYkUxhMWuFqXg3C/TvBOtGtA
         pbqhncXLqP0VM1R15aivLEJlnDdIpa+DQa9qqds0mkQUMVcxWosr2Ezif4ABW1xZDGq1
         +3gSk5xZhN47FhaiGZvO8igSyXVN+CZWR5ZKw/7WyHqHyhCPuNqePrxUbdw2nOhoULUI
         y7MEPNAHOHgV1LWD4uuwe5jIP54mxFOmDX13Za7P4ZsaWViVQEdvqSMlxmPJ5IoPzPyK
         RDsHDOsv/yEzffngnwgS7cRGezAm8FCXV7m3VDJ9ZsAxN6iJO0ugK23sNp3p+G75QV0+
         kgKQ==
X-Received: by 10.152.87.69 with SMTP id v5mr933009laz.24.1367213529172; Sun,
 28 Apr 2013 22:32:09 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Sun, 28 Apr 2013 22:32:09 -0700 (PDT)
In-Reply-To: <7vd2tdoqna.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222773>

On Mon, Apr 29, 2013 at 12:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>>         open $fh, "-|", qw(sh -c), $cmd, @args
>>
>> That doesn't seem to work for me.
>
> My fault.  It needs to form a command line like this:
>
>         sh -c 'cccmd --frotz --nitfol "$@"' - a r g s
>
> [jc: goes and tries
>         $ sh -c 'echo X Y "$@"' - a r g s
>         X Y a r g s
> ]
>
> so if we want to get rid of \Q\E, it would be:
>
>         open $fh, '-|', qw(sh -c), "$cmd " . '"$@"', '-', @args
>

I don't know if that would be better, or converting @args to a list of
quoted strings, essentially keeping the current behavior.


-- 
Felipe Contreras
