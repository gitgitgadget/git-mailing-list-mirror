From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Sun, 9 Jun 2013 10:41:24 -0500
Message-ID: <CAMP44s1PkL51QQ2T7qC3uVcBGv7ftarazR+LgJtV4X0yVAcj2A@mail.gmail.com>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
	<CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
	<CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 17:41:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlhkI-0000Tb-Ie
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 17:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811Ab3FIPl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 11:41:26 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:55175 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab3FIPl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 11:41:26 -0400
Received: by mail-la0-f54.google.com with SMTP id ec20so4920033lab.41
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=M/SrIJTlF/L3fn0qHNS/objgXgmjD62hv80CCj6aH7I=;
        b=nPuxYv64BCpGTL2lBX6tC0DwS07GQkYL02wbI/TlitdttjxxLih+IwSOyVRZDQQFrH
         DC67pjQYgi/kCKHDKcPorcD13szV+CQPwWmJSaPTxpfMOAKmONDTc3iF25C/WLCOVe8T
         TQngpUFfsFcEyCWaGf5PQ41xtExFA6r1CWtCPK5+fD9CtRFGrLITN8ttvWp9GCUHr//L
         cUJR2sEomIGWv4W76kvhEBUkpWtWPMGATEZXgoxc977bfJGyX96pOL/EG3lMqdt1cOJW
         kyO2xLCcBvMuAkmKoCE6Mcybq9eV3gvYIeygeGTakg9nzSTXsA3TgJrastwxJoL5w2YA
         PQ4A==
X-Received: by 10.112.157.226 with SMTP id wp2mr4745157lbb.65.1370792484536;
 Sun, 09 Jun 2013 08:41:24 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 08:41:24 -0700 (PDT)
In-Reply-To: <CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226967>

On Sun, Jun 9, 2013 at 9:56 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> The plan is simple; make libgit.a a proper library, starting by
>> clarifying what goes into libgit.a, and what doesn't. If there's any
>> hopes of ever having a public library, it's clear what code doesn't
>> belong in libgit.a; code that is meant for builtins, that code belongs
>> in builtins/lib.a, or similar.
>>
>> Give this a try:
>>
>> --- a/sequencer.c
>> +++ b/sequencer.c
>>
>> libgit.a(sequencer.o): In function `copy_notes':
>> /home/felipec/dev/git/sequencer.c:110: undefined reference to
>> `init_copy_notes_for_rewrite'
>> /home/felipec/dev/git/sequencer.c:114: undefined reference to
>> `finish_copy_notes_for_rewrite'
>
> This is a good example: yes, I'm convinced that the code does need to
> be reorganized.  Please resend your {sequencer.c ->
> builtin/sequencer.c} patch with this example as the rationale, and
> let's work towards improving libgit.a.

I already explained this multiple times; code from ./*.o can't access
code from ./builtin/*.o.

-- 
Felipe Contreras
