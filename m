From: Zachary Turner <zturner@chromium.org>
Subject: Re: Make the git codebase thread-safe
Date: Fri, 14 Feb 2014 17:15:20 -0800
Message-ID: <CAAErz9gO3NrAF5Zhu277NLqBv-4otQVWGBP6fX00x2OJ3v0_fg@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>
	<CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>
	<CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com>
	<CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com>
	<CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com>
	<52FBC9E5.6010609@gmail.com>
	<loom.20140213T193220-631@post.gmane.org>
	<52FD4C84.7060209@gmail.com>
	<CAHOQ7J8syoQLGwwkwPEX3wZir8sWDQ+k8sgHAKn=n_-Q_S8ipA@mail.gmail.com>
	<CAAErz9hzeiJ9f9tJ+Z-kOHvrPqgcZrpvrpBpa_tMjnKm4YWSXA@mail.gmail.com>
	<52FE68C9.3060403@gmail.com>
	<CAAErz9g7ND1htfk=yxRJJLbSEgBi4EV_AHC9uDRptugGWFWcXw@mail.gmail.com>
	<CAAErz9j=_FpWLSyUk43pp8A6e7Ej0crT8ghW5-yxBEbGkd6O+A@mail.gmail.com>
	<CACsJy8Dzj5iyaUseNyU76ojG1C0VYR=v7xsc=6TSGxTh=Xh3Ag@mail.gmail.com>
	<CAHOQ7J-gGbnADQ+3TGy6b6LJSLH8jvAbdTrc20Ybh=p0D2FmsQ@mail.gmail.com>
	<CACsJy8AQNmmW40R-H7kz1dmwiaSKVgu+GP=Jt1qTKgfbZoMkMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Zager <szager@google.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 15 02:16:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WETrT-0004Be-6x
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 02:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322AbaBOBPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 20:15:33 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:58773 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753303AbaBOBPW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 20:15:22 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so5088251ier.4
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 17:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=B+HYl+qIT+DN1XPmYQy+OJIVSwxM0h7bkqdM1Eh+3lA=;
        b=b/tRMtAqolY7ibC0RwzGGx3pz231kW6ZEHDyBvvVfsWXLClIcuQnP2ISeb8bxpKWVb
         aRSwCWkYD99Vx9GVHDVVlXdu+pmT3+evzEuzPqDeS9XJnfPYsq+vf149ihHgg1zrGr7X
         Gyt+txyGsKfOTYZrW7tiE+nBOh6UG26nsY0lXX6CrDcwOtJyA3al0RkweOOCblZdqFMC
         K3oXOaEYGDKAsHVGs19u6/P6TT+iVwLpMgPVc3OD9Z68mXGM61eWTHjYrxuudQMNk5lY
         zKxi+Mxf94dmmsO+Av9lKylTIoEhwW/79dHJ8tkhJqR5QHeyEfM/JyyY0GJooR7oJqMB
         oViw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=B+HYl+qIT+DN1XPmYQy+OJIVSwxM0h7bkqdM1Eh+3lA=;
        b=c6moiHUsgFCdVvd0oH1JLoPfSah+8/GTGdXm+QBs3XPbpcfA3phzg+d0rLHOQu4OCo
         si7BqTUym6IhSJQw2eUU+es4B4YU1sE5udryqDXSVvWBnAQIg8TKfXdyr/9nHsvp5zS4
         jgPgO+/dikvmWWdkcIF0ISWUk2QnV15lMwPZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=B+HYl+qIT+DN1XPmYQy+OJIVSwxM0h7bkqdM1Eh+3lA=;
        b=O4fnQ+PZ0POG7hVxRLyKRjPaiclye5Sv94ja86yco4AtzxfiXMAT3nhUowsrAp16VB
         P95G+rgJG+4vlb+4TSLBoCgM1EoPZYS4ciJWzXPV1mJ423lcQbnPv9TsyAZpguTA82MS
         7rvoYv/fQyvCb+UAKrfXBcThn7gmV5fw8XTwvS7bnK6RFyVzqhYSeXBZWm2SICZK0tE5
         zPLQ8FWitePpCUAbBN6WgrxdQrGYWDCJRP23CtF7YXJdN2AJfUFYKTNUrhLBy8j6v2Ev
         5ixzXfBb+DRU8SfTrI6tpAD654Bfaatg6LKxfGoQmcvNeGy3bDQVYoDMlD7Z3pDmMxfv
         sglA==
X-Gm-Message-State: ALoCoQmvvnjX1bEjgHssTFm2rwbw2CPchHtxjbO+uB00gsipnLs+TFEHNvs9GHN0qPz0MCMgIUh40k4RGHZ24CQXN52seLbcLn8PmJ/O8dxcgfwgmc1p2DESRzF2qMh0gWRLjAnn3/jgNgx3NMnKSb6THikyUe0k5CNGNJND8hf6KCp0dB7x8+tgz/tUkBvqIyhAdA8T981u
X-Received: by 10.50.111.79 with SMTP id ig15mr5754100igb.14.1392426920242;
 Fri, 14 Feb 2014 17:15:20 -0800 (PST)
Received: by 10.64.23.9 with HTTP; Fri, 14 Feb 2014 17:15:20 -0800 (PST)
In-Reply-To: <CACsJy8AQNmmW40R-H7kz1dmwiaSKVgu+GP=Jt1qTKgfbZoMkMA@mail.gmail.com>
X-Google-Sender-Auth: 35IorjoZmHAOOxDN_tme8ShaZNo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242169>

Even if we make that change to use TLS for this case, the
implementation of pread() will still change in such a way that the
semantics of pread() are different on Windows.  Is that ok?

Just to summarize, here's the viable approaches I've seen discussed so far:

1) Use _WINVER at compile time to select either a thread-safe or
non-thread-safe implementation of pread.  This is the easiest possible
code change, but would necessitate 2 binary distributions of git for
windows.
2) Use TLS as you suggest and have one fd per pack thread.  Probably
the most complicated code change (at least for me, being a first-time
contributor)
3) Use Karsten's suggested implementation from earlier in the thread.
Seems to work, but it's a little confusing from a readability
standpoint since the implementation is not-thread safe except in this
specific usage context.

On Fri, Feb 14, 2014 at 4:56 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Feb 15, 2014 at 7:50 AM, Stefan Zager <szager@google.com> wrote:
>> On Fri, Feb 14, 2014 at 4:45 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Sat, Feb 15, 2014 at 2:16 AM, Zachary Turner <zturner@chromium.org> wrote:
>>>> (Gah, sorry if you're receiving multiple emails to your personal
>>>> addresses, I need to get used to manually setting Plain-text mode
>>>> every time I send a message).
>>>>
>>>> For the mixed read, we wouldn't be looking for another caller of
>>>> pread() (since it doesn't care what the file pointer is), but instead
>>>> a caller of read() or lseek() (since those do depend on the current
>>>> file pointer).  In index-pack.c, I see two possible culprits:
>>>>
>>>> 1) A call to xread() from inside fill()
>>>> 2) A call to lseek in parse_pack_objects()
>>>>
>>>> Do you think these could be related?  If so, maybe that opens up some
>>>> other solutions?
>>>
>>> For index-pack alone, what's wrong with open one file handle per thread?
>>
>> Nothing wrong with that, except that it would mean either using
>> thread-local storage (which the code doesn't currently use); or
>> plumbing pack_fd through the call stack, which doesn't sound very fun.
>
> Current code does use thread-local storage (struct thread_local and
> get_thread_data). Adding a new file handle when NO_THREAD_SAFE_PREAD
> is defined is simpler imo.
> --
> Duy
