From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Sat, 25 May 2013 14:35:50 +0200
Message-ID: <CALWbr2xmaaE3udrYPWULiHpfSMvCWPu597hPhkumaPC+D6Uxfg@mail.gmail.com>
References: <1369405177-7855-1-git-send-email-artagnon@gmail.com>
	<1369405177-7855-2-git-send-email-artagnon@gmail.com>
	<CALWbr2yuEczF-G7uJ0r-teUJrZowrY8mYm+xwJmv4+CT6NgDPA@mail.gmail.com>
	<CALkWK0=16dmz548TQoj5YKp0dai7p1dpYAdXiWnnpiQdzyYHQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 25 14:35:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgDhU-0001JN-HA
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 14:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203Ab3EYMfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 08:35:51 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:35336 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819Ab3EYMfv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 08:35:51 -0400
Received: by mail-qc0-f170.google.com with SMTP id s11so2895936qcw.29
        for <git@vger.kernel.org>; Sat, 25 May 2013 05:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aSaZDnDE6gIF5Un2Jn2MRRSIxB69mcRz0cstZV2w5f0=;
        b=bpmlC4aILrD7wy2B923MWdKONKWUtt8YJuoCDCWLYVwl2xThg/8N+HSLkLnT3nQCMG
         MsbWjS+U9jqGCnezzFECgvLj7qjJZTvbK9OMrh0BQUPGuoYC9aIr6zPRjNK0x5vhZFgr
         asW+a2t/e2FpjabO9edz2EkMNoJ1njf11TfzUOGmv+3VgppF31DGwQcDu4MY01wQqZLK
         w7TErdBRVti3T5+xKv4CQq+QoU5t9dVbh5GfWO/g2/cquo/6PZ6bWCCBW3KMr2+ytssx
         qWJknP4rEUu9VPVDN+srnTuV8+J50BlWpE7BQvMvHbHjRESKYfQrx6xqw98G6AnYCXZU
         +T9w==
X-Received: by 10.229.150.20 with SMTP id w20mr7201597qcv.139.1369485350429;
 Sat, 25 May 2013 05:35:50 -0700 (PDT)
Received: by 10.49.81.99 with HTTP; Sat, 25 May 2013 05:35:50 -0700 (PDT)
In-Reply-To: <CALkWK0=16dmz548TQoj5YKp0dai7p1dpYAdXiWnnpiQdzyYHQg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225526>

On Sat, May 25, 2013 at 1:50 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Antoine Pelisse wrote:
>> Is it not possible for "color" to be used uninitialized here ?
>
> My compiler didn't complain; what am I missing?  Doesn't the
> declaration char color[COLOR_MAXLEN]; initialize an empty string?

As John said, this is allocated on the stack.
What do you want it to be initialized to ?
Filled with zeros ? That's overkill because only the first char needs
to be zeroed.
The compiler can't know what to do and it lets you to take the best action.

> More importantly, aren't there numerous instances of this in the
> codebase?

I think Valgrind would be mad at us if there was many instances of
this. By the way Ramkumar, could you check if Valgrind complains with
your patch ?
