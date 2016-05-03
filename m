From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 69/83] builtin/apply: make add_conflicted_stages_file()
 return -1 on error
Date: Tue, 3 May 2016 16:33:57 +0200
Message-ID: <CAP8UFD3F+hXxypz+tw8fRBNS5fWwkaV71GmzDkNBUTZbJt2ENQ@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-70-git-send-email-chriscool@tuxfamily.org>
	<CAPig+cRBgj29ugY0qYS9eB09CDKcJXeBKg3KqPaoZFSzCwftZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 03 16:34:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axbOl-0004Nb-48
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 16:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932870AbcECOd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 10:33:59 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37784 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269AbcECOd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 10:33:58 -0400
Received: by mail-wm0-f47.google.com with SMTP id a17so43005851wme.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 07:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=GdXcap8aqWh4Yoytvn9y3ssgyPm9ZkYzoVvOGHfoljQ=;
        b=W1sv78C+lrVHz+W+CTglrUuY9lf4Ke3ZMBF1RzejaHGBbnL4oVr6V1nzOvjDzJgRaj
         V+iv09SpY3c6LKgGUxW5GqLKFeMBoXW16aiQjYYYXgyTNa6lsqEZxDP68e/NJFYeLItF
         yuul43BKXLu8000H75MIVFlYx06/aQYeC9yhfusYW/CDyUZDHSwcepC1ZEH2utKcSPBj
         DeTghIjhTScaIjMA6KITYvQRhDIxvmI5IZFvqb5KVB56vdTeE/KRMdAWf7qhaYjOzsZU
         12hdfCfmrjx/87vqNQXZaWCpraFJdtp6pEm4oFmSOGZnTmhUO2hfkTTCfUeal0Q4DdZ3
         P6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=GdXcap8aqWh4Yoytvn9y3ssgyPm9ZkYzoVvOGHfoljQ=;
        b=aDKgS4dTYEm2KcKxHJRT6Q+QalxCECOttahPcxmmia0zfF6adS3emlV5QABWewmiit
         bfPgpIJC0n/gsnEf0VWIgzwS/bwbRMOt3/4My8/Bb9PTIsDjmDG2Yr0RO+S26yNj71cZ
         auSGr2zzoSz3lL097yeTQW/gcTb7glQk/m8RI6Zie40ppbDBmfygAzbL4sEuL3MFzYJC
         U2R4RoLxd0aoEVHEvim+tr2Y81dbM9LTUj+E3jLIZFXkNGyPDN5zX4JGQhLTDEoyc679
         RdzUDvd8hGdagUR5XUwQ0gpBOoD5AIZ9ZaCl3vdeH1JduJVbM0Dujz7tdb8qgqD3ooiP
         bw4w==
X-Gm-Message-State: AOPr4FWYk/lIY9lnrvPRKi8WsIFygTtTURzDBaSsBPTT3EzAPBNsPDPbHZiTpfhlaVwRD9m5vY0CUAUGtgVMtg==
X-Received: by 10.28.151.133 with SMTP id z127mr3628822wmd.79.1462286037144;
 Tue, 03 May 2016 07:33:57 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Tue, 3 May 2016 07:33:57 -0700 (PDT)
In-Reply-To: <CAPig+cRBgj29ugY0qYS9eB09CDKcJXeBKg3KqPaoZFSzCwftZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293400>

On Mon, May 2, 2016 at 9:36 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Apr 24, 2016 at 9:34 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> @@ -4234,8 +4234,11 @@ static void add_conflicted_stages_file(struct apply_state *state,
>>                 ce->ce_namelen = namelen;
>>                 hashcpy(ce->sha1, patch->threeway_stage[stage - 1].hash);
>>                 if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD) < 0)
>> -                       die(_("unable to add cache entry for %s"), patch->new_name);
>> +                       return error(_("unable to add cache entry for %s"),
>> +                                    patch->new_name);
>
> Is this leaking 'ce' (which is allocated a few lines above the shown context)?

Yes, thanks.
