From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 63/94] builtin/apply: make apply_all_patches() return
 -1 on error
Date: Wed, 8 Jun 2016 18:37:38 +0200
Message-ID: <CAP8UFD2jA7ydsYTkQLbQJTW7NFRpkmJwgJQp=UZ0-8-7njSawA@mail.gmail.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
 <20160511131745.2914-64-chriscool@tuxfamily.org> <CAPig+cQAM8i2sFY9UUYfN23PRGgFacG7KiTD6mZwnm=PgKBL7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 18:37:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAgUP-0001bv-C4
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 18:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757167AbcFHQhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 12:37:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36205 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbcFHQhl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 12:37:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id m124so4318156wme.3
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 09:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T5JkDLaibCXjEIRN/gmVw3Pciv5rs4qKZKMF3byVFhE=;
        b=bBbzE/MaYXSz35EIJfIWCIosykA+DWs15vGrEEpj7+oruOvI4VFOyEFejaNkPtHCC8
         Tp2posExYAhi48jXEClYAz1sWpk0P12FKZe0PUhrsYkxZ+EyExCHL0p5YlrcfHgbGs5m
         xeUgzbId9tPVyvA7h2v/Z7+hpL4mqWy+HDO0Y/2rvK299UfRPyz/LaPwlhg8apghgwN8
         JbZDHMBqer5QgQHwpQrwO74YLPV2J4bLJ1+IAJa9L4QqXNA/pCjfp8XkxMRhFa2NkJCS
         ORHVq75W4at/dayW2Fy8pCXv3pvZp7hwPNsm2BfDsmYQIQLbZ+Q8o/lQWSocsAZZD/uQ
         +xVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T5JkDLaibCXjEIRN/gmVw3Pciv5rs4qKZKMF3byVFhE=;
        b=UkfWaJI8pRf3ojLf0Cr6zu+MtkdvflNweL30og8GjPvNjHigIPKLa1CMtb0xROUeV/
         IajZSG+uJ93aLM59ODtIjut8s/+JADxHdIBhJ6uLk+OU0LDm+9l6DJNJkmDO/dqjyrru
         mb1u6uy7rbZopa4wSfaP0/r842zXFzXmNUcE4Yjfi3B6zFwZK8h4OcuKqL5WInO17wH5
         zYAmnzR1/9rS/8OLArRzbkPupSplHIM2D4V7rPc66nH+tjCQwcc6bTN/aTw5tz9VVuNY
         NKUWWH+2yINSU7tMJYDwezEsO3wB0mHRhLs6tl8WRi2IBtVloaxJbuGjNCSSHjYItx9Y
         OMAQ==
X-Gm-Message-State: ALyK8tJh/Rv5mm1A9NjJZ6ALEZCM8RIno8d05o7Zh3/6+RDBVjEIMYQHONbH9nhMyNHMH09TrUz8QaAVg792QQ==
X-Received: by 10.28.23.143 with SMTP id 137mr6069263wmx.89.1465403859494;
 Wed, 08 Jun 2016 09:37:39 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Wed, 8 Jun 2016 09:37:38 -0700 (PDT)
In-Reply-To: <CAPig+cQAM8i2sFY9UUYfN23PRGgFacG7KiTD6mZwnm=PgKBL7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296810>

On Mon, May 16, 2016 at 5:44 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, May 11, 2016 at 9:17 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> To finish libifying the apply functionality, apply_all_patches() should not
>> die() or exit() in case of error, but return -1.
>>
>> While doing that we must take care that file descriptors are properly closed
>> and, if needed, reset a sensible value.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> @@ -4613,9 +4613,10 @@ static int apply_all_patches(struct apply_state *state,
>>         }
>>
>>         if (state->update_index) {
>> -               if (write_locked_index(&the_index, state->lock_file, COMMIT_LOCK))
>> -                       die(_("Unable to write new index file"));
>> +               res = write_locked_index(&the_index, state->lock_file, COMMIT_LOCK);
>>                 state->newfd = -1;
>
> Does write_locked_index() unconditionally close the file descriptor
> even when an error occurs? If not, then isn't this potentially leaking
> 'newfd'?
>
> (My very cursory read of write_locked_index() seems to reveal that the
> file descriptor may indeed remain open upon index write failure.)

You are right, it is leaking newfd if write_locked_index() fails.
The solution to that is to call `rollback_lock_file(state->lock_file)`
and the following patch was supposed to do that:

[PATCH v2 82/94] apply: roll back index lock file in case of error

but it would do that only if `state->newfd >= 0` so we should set
state->newfd to -1 only if write_locked_index() succeeds.

I will fix this.

I am also going to add a comment to this patch saying that this patch
needs a following patch to call rollback_lock_file(state->lock_file)
in case of errors.

Or if you prefer, I can squash the patch that call
rollback_lock_file(state->lock_file) in case of errors into this
patch.

Thanks,
Christian.
