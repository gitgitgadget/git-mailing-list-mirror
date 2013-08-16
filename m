From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] rebase -i: fix cases ignoring core.commentchar
Date: Fri, 16 Aug 2013 18:19:58 -0400
Message-ID: <CAPig+cSFoKb+v5fEXnwr=94B6uo2b57vgHTRgtFMj25M+R9dUw@mail.gmail.com>
References: <1376689447-78807-1-git-send-email-sunshine@sunshineco.com>
	<CAPig+cTRc1-W7vJX52gb5S0ge4kZgKMBkHJjqWFRDgpuzTfM2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 17 00:20:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VASNL-0004Cf-0o
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 00:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223Ab3HPWUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 18:20:00 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:61041 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab3HPWT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 18:19:59 -0400
Received: by mail-la0-f50.google.com with SMTP id ek20so1951473lab.37
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 15:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=z6SzGfdMyxGgHYMQr04/bCCg7oyF0ANbwQPYHN8ky/8=;
        b=uQ/NdWVjF1RybKWYKDiOQ9iU9GzQGpHlWP7oePt9KWDGhVpTx48ktAJ205ByWt4MIN
         30rLgT5jD1rc17hnNc1Y5HdANfyg1QcUK4JBOYr+BQ3fk+tLlKm3/buxpmTuBCKDKl1c
         jaCPTlw+7x1u+7wUxDHMvjTvM/0QKWTwfmC5OabmHEXYvH9cmrYHn2Wo0+yIoFvbL+mW
         ICj7GNscLVQRBCkDVxyhp/2RJjTeJWLCOjmrz+HF+Yq8tv1OK/zrj/Q4omkZp7cTB+0W
         zISqkoygIggYzYrTdjH9TlYfuCMxy40rOHpRxSRQyrLGXFVOJUiNJLY428mUhZ5S5RKf
         /T1w==
X-Received: by 10.152.115.176 with SMTP id jp16mr3049996lab.17.1376691598239;
 Fri, 16 Aug 2013 15:19:58 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Fri, 16 Aug 2013 15:19:58 -0700 (PDT)
In-Reply-To: <CAPig+cTRc1-W7vJX52gb5S0ge4kZgKMBkHJjqWFRDgpuzTfM2g@mail.gmail.com>
X-Google-Sender-Auth: w67gcsZ1vZfwhMEIiRoEdA6xbUQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232439>

On Fri, Aug 16, 2013 at 5:55 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Aug 16, 2013 at 5:44 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> eff80a9fd990de36 (Allow custom "comment char", 2013-01-16) added general
>> core.commentchar support but forgot to update git-rebase--interactive to
>> respect it.  180bad3d10fe3a7f (rebase -i: respect core.commentchar,
>> 2013-02-11) addressed this oversight but missed one instance of
>> hard-coded '#' comment character in skip_unnecessary_picks(). Fix this.
>>
>> 9a46c25bdbf79744 (rebase: interactive: fix short SHA-1 collision,
>> 2013-08-12) added another instance of hard-coded '#' comment character
>> in transform_todo_ids().  Fix this, as well.
>>
>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>
> I forgot to mention that I wanted to add tests to t3404 for these bugs
> but couldn't figure out how to do it using the external behavior of
> rebase -i. I was able to verify the before and after behavior by
> adding temporary echo's to the code in order to observe the "internal"
> functioning.

One of the fixes in this patch addresses an oversight in
180bad3d10fe3a7f (rebase -i: respect core.commentchar, 2013-02-11)
which is already in 'maint'. Should I split this patch in two so that
the one fix can be applied to 'maint'?

(The other fix is for 9a46c25bdbf79744 in 'next'.)
