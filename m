From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 63/83] builtin/apply: make apply_all_patches() return -1
 on error
Date: Sun, 1 May 2016 20:32:31 +0200
Message-ID: <CAP8UFD3c6YHi33kwu=yB60oRqv91GLDm7J4zb5nxcVi6XNJo9A@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-64-git-send-email-chriscool@tuxfamily.org>
	<CACsJy8CRiAhHqYDrJifhfarqzarEnuuJm4rw18zxnC9xaBwKNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 01 20:32:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awwAY-00065E-UA
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 20:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbcEASce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 May 2016 14:32:34 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37507 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbcEAScd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 14:32:33 -0400
Received: by mail-wm0-f51.google.com with SMTP id a17so111956890wme.0
        for <git@vger.kernel.org>; Sun, 01 May 2016 11:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=oLJuwXhjqJmMwmWwdmpZbZHqwwq2B3qMVMgjsaw48KA=;
        b=Nxo79i/i5luGIDlyvyftgyNTuCvacSUoF87WmrmR+R2mNiaXuVmkTCVSKOqkrCLDrP
         yk8YDNabFLcRL4PcD86m/iTYTSi4qlfDfZKVbsD1Vp8JyXk7GSkBwW+sx3mQuF57TwQN
         M/+SVNPwd9P3XzHRJhiK1hoUQjsijIDLPDtxPbc443M23QwYK4bDmBnoUahrg4VswfFG
         C37BIkh0kGbztLpN44PNOmNrM7M23zx6grs0p0gnj+9Mkops3kNO2sjs/Sk4zIA87aSN
         fxKI0R77qM4oDwOWm6tr+qmUxdLrVPZ4Qvuy34TNdSihCTyNWYgnMmlRJWt2LOJ8maJT
         nx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=oLJuwXhjqJmMwmWwdmpZbZHqwwq2B3qMVMgjsaw48KA=;
        b=if5QHoI7dbc4q6KPovMzT9dDU41c1vAtsaZ56ZCceS4hP3pnIBwKpW67tjmC/zaWHe
         5eh/2hYkrvHBH9d7kgX33Ioo0jHGZNnUjVA94mBAPgShqYWRgQZaKeFxt1BLIwbaMKYQ
         AwfMZbnUjvfmT1Dz3Bo8jgj+T7iYrqRzJPnop3ly9CveMsGKob0e21WUNrZRuCaympjj
         EZBuEQ9/qpdVbVO4ouCMeVWffMCjO2UoR2c4IIb5WMV2MrEX0jv11MRFYdUm5UvqUSyO
         lXJlk2jHa5oa7vWkWezQ8gLKshV1ueZwhmDwZAIM8gie77gXRwfZkAsrPN4XsSHVvKW4
         fdiw==
X-Gm-Message-State: AOPr4FVwRTuB/tvFqbBQMXUDGWgoMMjqrDixJmSRsJan+YUbhm0mRG09gG4yYkWOtu8xo4YUwNHmhZF/7M9nAw==
X-Received: by 10.28.128.83 with SMTP id b80mr15666969wmd.89.1462127551948;
 Sun, 01 May 2016 11:32:31 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Sun, 1 May 2016 11:32:31 -0700 (PDT)
In-Reply-To: <CACsJy8CRiAhHqYDrJifhfarqzarEnuuJm4rw18zxnC9xaBwKNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293203>

On Mon, Apr 25, 2016 at 3:30 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Apr 24, 2016 at 8:34 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>>         if (state->update_index) {
>>                 if (write_locked_index(&the_index, state->lock_file, COMMIT_LOCK))
>> -                       die(_("Unable to write new index file"));
>> +                       return error(_("Unable to write new index file"));
>>         }
>>
>>         return !!errs;
>> @@ -4698,5 +4698,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
>>         if (check_apply_state(&state, force_apply))
>>                 exit(1);
>>
>> -       return apply_all_patches(&state, argc, argv, options);
>> +       if (apply_all_patches(&state, argc, argv, options))
>> +               exit(1);
>
> Abusing exit() too much? This is cmd_apply(). A return should be
> enough and you can do the !! trick that is used in
> apply_all_patches(), shown just a little bit above.

Ok, I will use:

    return !!apply_all_patches(&state, argc, argv, options);

Thanks,
Christian.
