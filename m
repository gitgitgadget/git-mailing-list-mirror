From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6] blame: add support for --[no-]progress option
Date: Sat, 12 Dec 2015 19:37:01 -0500
Message-ID: <CAPig+cQjWgTR9Sd-CutkbuBa1Czp5YApsYoFXc9HS1H08cno7A@mail.gmail.com>
References: <1449964625-27737-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cQq2Y0m0UJVCMb-9B8qrGNXV7ecf5hDETdgX5w4oUuAvw@mail.gmail.com>
	<CAOc6etar5DU0w_RFRgUAzK39R43cP=eSwT_=0u2NbgKhdPi8Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 01:37:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7ufG-0001fN-Nv
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 01:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbbLMAhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2015 19:37:11 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:36602 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbbLMAhC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2015 19:37:02 -0500
Received: by vkay187 with SMTP id y187so135818681vka.3
        for <git@vger.kernel.org>; Sat, 12 Dec 2015 16:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Q9b+6nR+85kfcZKe30/NOL34NyuC4NgDm0Qmn+ea0sw=;
        b=VAAevQkgV9HTVqbROuvSu5mXkDmKAuMpTFEPx4/JWa0nX720Nn1nwbJxY8noL6efe1
         35b9wElfTneoqNXD7Lr7MTq7clYau9X92bqETePeKbt+65zyo0uv4YvTcy8VoSxp6LU2
         FbXAV/DO0sZUIyMsGGao2Kw3x19Wz+9YiWPfBLaOVfWB6JPPxCf/V1zAv57BdGb9pgx/
         6qB6jQNeEh9MCsJQo98+KkUc/EmqZ+EX39m9XGXypzVJQbV297bnB9w+5ab/j5VrY7yF
         U+AjEpn5RL5KsMzNEQVzEUQe5yNToZVEtA8ePpR49lOs2Qm9KxfAzDjX1N9FET6v7s3f
         gJvQ==
X-Received: by 10.31.182.129 with SMTP id g123mr19681804vkf.45.1449967021571;
 Sat, 12 Dec 2015 16:37:01 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 12 Dec 2015 16:37:01 -0800 (PST)
In-Reply-To: <CAOc6etar5DU0w_RFRgUAzK39R43cP=eSwT_=0u2NbgKhdPi8Sg@mail.gmail.com>
X-Google-Sender-Auth: FrnetHYqmksgbEf3p1ZkdtmP3c8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282310>

On Sat, Dec 12, 2015 at 7:30 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> On Sat, Dec 12, 2015 at 6:17 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> The 'show_progress = 0' seems unnecessary. What if you did something
>> like this instead?
>>
>>     if (show_progress > 0 && (incremental ||
>>             (output_option & OUTPUT_PORCELAIN)))
>>         die("--progress can't be used with...");
>>     else if (show_progress < 0)
>>         show_progress = isatty(2);
>>
>>>         if (0 < abbrev)
>>>                 /* one more abbrev length is needed for the boundary commit */
>>>                 abbrev++;
>
> Because, if the user didn't provide --[no-]progress option, then the
> value in show_progress will move forward being -1 and then in
> assign_blame, there will be progress output if you chose --incremental
> or porcelain. So, if you chose --incremental or porcelain, we better
> set the value to 0 to make sure there will be _no_ progress. Agree?

Yeah, I was thinking of that and had the correct interpretation in
mind when reading the code, but then blocked it out of my brain for
some reason when actually composing the response.
