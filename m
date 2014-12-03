From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf
Date: Wed, 3 Dec 2014 12:20:09 -0800
Message-ID: <CAGZ79kYsH3QgghjTnxczxBA85fUizgtYm-qTz28rspyhRs=big@mail.gmail.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<20141117233525.GC4336@google.com>
	<CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
	<20141118004841.GE4336@google.com>
	<CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
	<20141203050217.GJ6527@google.com>
	<20141203051344.GM6527@google.com>
	<xmqqr3wgh57t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 21:20:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwGPK-0003JO-Vr
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 21:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbaLCUUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 15:20:12 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:41086 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbaLCUUK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 15:20:10 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so17524842igb.1
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 12:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ivJPd66xnv4KPLvAttztKejNb1ZKRb+mO2aELDcddeE=;
        b=I1MzcZP8uO+mnNd/ky8bRIliLxhNyd4p/x6TzxhLSRom3mAFyfmehTA+EyYVCWooyd
         YOXhQGA0JkJ4kTKvO+rN0RzkRFJDZoSCDHUXYJmlR3idVi65krHRs1Gl7WxvbOCyxefx
         YiRwEvXHzF5yRZ4KiskkANWJhfhChUGB5y/EzyRVA5mwjFvC3DlnSfJJCiIVlj0MPx4q
         dP3BS+BZEHIyrHLaHE6Gbr5Wf6RCY7vUINJ8UtU6r7NLBG0gtxl9VhGnalTC/Tk+OHaW
         2mB/KVE+Lj59XH0RnaRkRKQy5ffk1BpAi2dvimV9PdvbbE47oRvNCeYvTdlMjNhIyQrs
         cH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ivJPd66xnv4KPLvAttztKejNb1ZKRb+mO2aELDcddeE=;
        b=JYlNVs6P4tnwxPGeCrPsvB2AFRElW7fYTk7E38ceyBrXqHavE8DoUre57gyM1vA6NO
         /tb//D3FvfaoIB8pPeJNV5mixJVyYfHUmMEGC6wmIyHA/JzNAHnojDGU8vF8Sw+HdKCm
         G7n8IwJ+KqdF33Z7+BGoUSjc1NivYMCSsjeKenTev28yFq4pIbD109XvaUby4hmJh6fQ
         /ILE7bpKm5MA8UGsluiaepcxOXulqAq15Ebe86PEUCLDwR+UyR8p9zLr5HXmHLdzuwVH
         o67RSiR0EoYaVGovUoQAPJirTm6AeO0faIKtShtXcofIRL1bKz6Wd5VBC9Aq9NjCbw/R
         pMIw==
X-Gm-Message-State: ALoCoQmpt9GYoDEcvjZV5I7AT/APJbUCzoInzpLWaqOwW7F34D4DiwUgrVrIiIGsRSFaUSdE5dpl
X-Received: by 10.43.82.72 with SMTP id ab8mr8845806icc.76.1417638009683; Wed,
 03 Dec 2014 12:20:09 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Wed, 3 Dec 2014 12:20:09 -0800 (PST)
In-Reply-To: <xmqqr3wgh57t.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260688>

On Wed, Dec 3, 2014 at 12:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> This way, callers can put the message in context or even avoid
>> printing the message altogether.
>>
>> Currently hold_lock_file_for_append tries to save errno in order to
>> produce a meaningful message about the failure and tries to print a
>> second message using errno.  Unfortunately the errno it uses is not
>> meaningful because copy_fd makes no effort to set a meaningful errno
>> value.  This change is preparation for simplifying the
>> hold_lock_file_for_append behavior.
>>
>> No user-visible change intended yet.
>>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>> The title feature.
>
> By the way, this seems to address the same thing as sb/copy-fd-errno
> topic that has been cooking in 'pu'?  Should we drop that other
> topic and use this one instead?
>

This series makes the code more readable and maintainable in the end
as we don't need to hunt down the path of when the errno is changed or
accessed.
The currently cooking sb/copy-fd-errno is more of a hot fix, while
this series is fixing the problem more at the basic level and more in
long term.

I'd be happy if this replaces the currently cooking version.
