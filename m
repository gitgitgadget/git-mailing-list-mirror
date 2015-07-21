From: Dave Borowitz <dborowitz@google.com>
Subject: Re: Bug: send-pack does not respect http.signingkey
Date: Tue, 21 Jul 2015 12:25:09 -0700
Message-ID: <CAD0k6qSjKnHMHXAQxJ97-dLcWVz+_ay+j6=X9j_yjx25sCwFrw@mail.gmail.com>
References: <CAD0k6qQ=ovEBZn_wje-exBhvW8brRbTgULDr68rmeiw-ZdsozQ@mail.gmail.com>
 <xmqqlhef50kz.fsf@gitster.dls.corp.google.com> <CAD0k6qS_uQk5KZVJYA7BVZ9sRPRj=cZ3rbYRfJ3vhgSh2drEMA@mail.gmail.com>
 <xmqqh9p350ad.fsf@gitster.dls.corp.google.com> <CAD0k6qSZtZN60ExQQfH0mq_rZrOA4Fw0ZeWfX_gr=2btbSYHQw@mail.gmail.com>
 <xmqq8uaf4xmo.fsf@gitster.dls.corp.google.com> <CAD0k6qSq8+JMFZgvQuVptCxUknYtMa7xrojABEDYLQAw015qvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 21:25:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHdAl-0001oQ-Ns
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 21:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933826AbbGUTZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 15:25:31 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33607 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933665AbbGUTZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 15:25:29 -0400
Received: by igbpg9 with SMTP id pg9so71752011igb.0
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2X0l4HTD2zmZNGt5/Ff9ijy+Yw08iJEXNhjKk/8pDd4=;
        b=JJHY/7qEN4cgSsEsPDZ9VQgstC9FgvFA9JNz7thu0bHuoX1BMSynrfh3V9G6lfOTWo
         4AM72gk/aHOTPP2IQzkwouOXQRtRwctHfhvyK5KfcYB6JoebxjxRK9PM6YKpwJnuHoee
         6tEIVYhLwb7HpPXAoBJdyiEG65fP9QjVGnYFXbY0p6yCCaGePpVPB67zKpC8QcjR4s5Z
         X1wm0fXi6XwRp6XsWdkhya7aKdf17s69QglNVJQX0W8ZljO8xUFtBhB6aKIF/j3IfETO
         ZSnfRrGgysu80FuciiJ+cGiTg6AcHXlSAiFPBh4WsTuy/ozXFbWg+j3d+xCgPHFFcIjs
         zopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=2X0l4HTD2zmZNGt5/Ff9ijy+Yw08iJEXNhjKk/8pDd4=;
        b=ESq8ohtHIQldWOYkWuDhaLLV6KKZvPP34nsUUFkwM2U+YEaBCuSPTJrKppU2y9KQgU
         0a2ro7dtCY1M7NfehJLlVRakfJD8ZMtvMmox1ZCs9NkKUVGsYYPZ1/XOy2EjhOfKgedc
         aur5HcXWuAv1hJtC5aOxyM1yI6C51gxHGQZesH2JrAcrL9pJeLTpkDnN0oruFPACC5W/
         lWeTS12exRXZYTgQlZV3PN9Idw1Kl/78/WFpdLrqDL3Iy0o9GxKdP8rMRy3p2sTzCRkX
         L+hyfFVClNYzKezpf3e4vrJOBYXEmZkmoaOfCzDoRgOYMmKMAoz0PuXE15PXLRK3qPl5
         lqqg==
X-Gm-Message-State: ALoCoQnjv/BY2Ct6hFtBVJKUa2h4Jwbg0qIOt7FSLeN6e133RK1N68l4B2uAonHFfu0Lu9AjcjGZ
X-Received: by 10.107.39.83 with SMTP id n80mr45384022ion.129.1437506729071;
 Tue, 21 Jul 2015 12:25:29 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Tue, 21 Jul 2015 12:25:09 -0700 (PDT)
In-Reply-To: <CAD0k6qSq8+JMFZgvQuVptCxUknYtMa7xrojABEDYLQAw015qvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274399>

On Thu, Jul 16, 2015 at 3:08 PM, Dave Borowitz <dborowitz@google.com> wrote:
> On Thu, Jul 16, 2015 at 2:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Dave Borowitz <dborowitz@google.com> writes:
>>
>>> On Thu, Jul 16, 2015 at 1:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> Dave Borowitz <dborowitz@google.com> writes:
>>>>
>>>>> On Thu, Jul 16, 2015 at 1:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>>
>>>>>> Perhaps something like this?
>>>>>
>>>>> Seems like it should work.
>>>>>
>>>>> Jonathan had suggested there might be some principled reason why
>>>>> send-pack does not respect config options, and suggested passing it in
>>>>> as a flag. But that would be more work, certainly, as it would also
>>>>> have to get passed through git-remote-http somehow.
>>>>
>>>> I actually was wondering about exactly the same thing as Jonathan,
>>>> and that is where my "Perhaps" came from.
>>>
>>> I will say, though, as the maintainer of a handful of custom remote
>>> helpers, I would prefer a solution that does not involve changing the
>>> implementation of those just to pass this configuration through.
>>
>> That is not a controversial part ;-)
>>
>>> So my
>>> vote would be for send-pack to respect the normal config options.
>>
>> The thing is what should be included in the "normal" config options.
>>
>> The "something like this?" patch was deliberately narrow, including
>> only the GPG thing and nothing else.  But anticipating that the ref
>> backend would be per repo configuration, and send-pack would want to
>> read from refs (and possibly write back tracking?), we may want to
>> prepare ourselves by reading a bit wider than "GPG thing and nothing
>> else", e.g. git_default_config() or something like that.
>
> Ah, now I understand the question. I have no opinion other than that
> we shouldn't let discussion about future features prevent us from
> fixing this obvious signed push bug :)

Should I formally send a patch with your configuration one-liner?
