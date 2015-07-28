From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Log messages beginning # and git rebase -i
Date: Tue, 28 Jul 2015 09:30:47 -0700
Message-ID: <xmqqr3nsfdmw.fsf@gitster.dls.corp.google.com>
References: <loom.20150727T133256-715@post.gmane.org>
	<CAPig+cRT6=YCHz+phfE+84y27ey-6ScjPxP2cHiVqumJmR6mOw@mail.gmail.com>
	<loom.20150728T115023-269@post.gmane.org>
	<vpqsi88qp6q.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ed Avis <eda@waniasset.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 28 18:30:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK7mI-0006Vu-Tz
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 18:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbbG1Qau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 12:30:50 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34130 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbbG1Qat (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 12:30:49 -0400
Received: by pacan13 with SMTP id an13so73730991pac.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=UqB9i8VNZM6160e7rhfnAcU1Oqf/P/DgLnjQ+wKEcMI=;
        b=g9hdmVqEuMO4oD2zpW2WiN03c9uzj+mqsNEq46avphqFkjcceYkDQoeH17Gp4wA3hy
         OdWPAkRupZLzAmI3Eoto4ysAX/8uGmGFrBmQ6mIXw3WqvO+HnxTv8Riv8SpNU+Hgb7ek
         u8LXZyGf9GQVpA9JJgRqw2mhzF6LxksyhhUm16umuRAGlmo6gcd4NazIrXpA3In8tUwt
         N87YyXbLnaY0FR3jHSMiHBaxAuuQnY6BH5T7SO3AaO+gODoiAMU1YVhXtPekNf7yfGT7
         3WTobC0+N6X5iD2bppeRfumlJxZ4VQqS7ghlxwwYXE2ATkN1yEgTI7M29eFaCQRleJen
         hz6g==
X-Received: by 10.66.154.131 with SMTP id vo3mr3654429pab.135.1438101049174;
        Tue, 28 Jul 2015 09:30:49 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id qb10sm2009431pab.39.2015.07.28.09.30.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 09:30:48 -0700 (PDT)
In-Reply-To: <vpqsi88qp6q.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	28 Jul 2015 17:25:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274785>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Ed Avis <eda@waniasset.com> writes:
>
>> Eric Sunshine <sunshine <at> sunshineco.com> writes:
>>
>>>>the editing for the
>>>>combined log message treats lines beginning with # as comments.  This means
>>>>that if you are not careful the commit message can get lost on rebasing.
>>>>
>>>>I suggest that git rebase should add an extra space at the start
>>
>>>'git rebase --interactive' respects the core.commentChar configuration
>>>variable, which you can set to some value other than '#'.
>>
>> I was thinking of the default configuration.  But you are right, this applies
>> to whatever the comment character is - so if commentChar is set to * for
>> example, then log lines beginning with * should get an extra space prepended
>> in git rebase --interactive so that they don't get lost.
>
> Actually, is there any reason why we do not allow a simple escaping like
>
> \# this is a line starting with #
> \\ this is a line starting with \
> # this is a comment

What are we trying to achieve?

Munging the original "# I want this line intact" to any other form
like " # I want this..." is as bad as losing it.  If the user wants
whatever she types in the resulting commit literally, there is the
"--cleanup=<choice>" option, no?
