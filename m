From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 49/83] builtin/apply: move 'lock_file' global into 'struct apply_state'
Date: Sat, 30 Apr 2016 21:39:19 +0200
Message-ID: <CAP8UFD1bDj2bnRSpo3Gp5B4Du6fNGSUfXv6dLL6Cs4KsJTw5Zg@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-50-git-send-email-chriscool@tuxfamily.org>
	<CAPig+cRSe8oOjo2h6SuJQyD+he_Q7zHfF4TivZ0amhAu4HLQ+g@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Apr 30 21:39:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awaji-0007PT-NB
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 21:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbcD3TjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Apr 2016 15:39:22 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34972 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbcD3TjV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2016 15:39:21 -0400
Received: by mail-wm0-f50.google.com with SMTP id e201so64075379wme.0
        for <git@vger.kernel.org>; Sat, 30 Apr 2016 12:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=97ePgSQ279CCXSmRRr3+ZdLW4K+XUaTEj5GTaMcnsQM=;
        b=Itli7yg5YrSv0Xuwh9f1fhyjs5in/qLRSeKano+BhOw6ubYzY+RyB0CbAmVQXRlD2e
         1laLp1recBexBRSulBm4LmziovM8XcVKF0RWkLekbdH3/m7P0HWSd7Itaf5A2Qxs9Tur
         5A20Jbkyn23Kdc2LkPnbh6ymUALVr3w5cqC5rQXA4S5lJu4zy6FXYJRnGNlbwXfjnD6R
         Qgwernlnc6wkOVb0F3HEw1T1WHQF8NkjvCidjuxfCoNIxLT+K+QJhVu9Z6cf3TfIuVdS
         paCxFLx4RKJ4I3nNz0woaJbFlsCIaIZnSFpwpfPxjDMAFcuEAxOQoB4vnUp4JxM+TZc5
         knAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=97ePgSQ279CCXSmRRr3+ZdLW4K+XUaTEj5GTaMcnsQM=;
        b=dRiZ2WtrvRZ+A6QLMOHCY3toaxw0EWaOYSd1BOBosTwRaAP/XUZss2C/UqunFeIWN9
         igqz4QLVl1RL7zDOnlbmSza3V/ugbE2RhZ5hZJYg92D7N9xWonJP21qLRrG0ITS8XGhA
         bGFsnsiz/66thgXkzjhGTfcWAobYyaS1h15YDOcDgomryOMNJr1cNOGzakVWSXP5SYfT
         /PkbpeMvi6z3TcVOfjR39GP6tJKjsdaDEXRK5VtCSUKiztomI+vwJpyVIInJMC6rswMh
         0gVBqPejl73w+VLd0ZRRKMAmGo7W3+UCMtsAGrBYAGEX1H5GfWnJecT2VtcD2aKi/htK
         cniQ==
X-Gm-Message-State: AOPr4FXf+7Skl6zxo8PcUHHl1SwFOKdxOd8FyFPz/aSSCWLwZWd+dr52fosjnQ87hNOx+SO3PfKOj0MBlDhXGw==
X-Received: by 10.28.129.22 with SMTP id c22mr11249651wmd.89.1462045159715;
 Sat, 30 Apr 2016 12:39:19 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Sat, 30 Apr 2016 12:39:19 -0700 (PDT)
In-Reply-To: <CAPig+cRSe8oOjo2h6SuJQyD+he_Q7zHfF4TivZ0amhAu4HLQ+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293125>

On Mon, Apr 25, 2016 at 9:50 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> @@ -4515,8 +4521,6 @@ static int write_out_results(struct apply_state *state, struct patch *list)
>>         return errs;
>>  }
>>
>> -static struct lock_file lock_file;
>
> Does the static lock_file in build_fake_ancestor() deserve the same
> sort of treatment? (I haven't traced the code enough to answer this.)

Maybe yes we could do the same thing for this static lock_file, but
this can be done later, and it could be a bit involved, so I prefer to
not touch that for now.

We are using the lock_file like this in build_fake_ancestor():

    hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
    if (write_locked_index(&result, &lock, COMMIT_LOCK))
        return error("Could not write temporary index to %s", filename);

so it looks like it is safe to call build_fake_ancestor() many times
as long as it is not called by different threads.
