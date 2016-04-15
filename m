From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?" 1/2] xdiff: add
 xdl_hash_and_recmatch helper function
Date: Fri, 15 Apr 2016 12:09:46 -0700
Message-ID: <CA+P7+xquEuu0aLb9vFaFhzun4YYW4PmiXycAt01HUxxUXqUuyQ@mail.gmail.com>
References: <20160415165141.4712-1-jacob.e.keller@intel.com>
 <20160415165141.4712-2-jacob.e.keller@intel.com> <xmqq60vidbsu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 21:10:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar988-00007p-QF
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 21:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbcDOTKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 15:10:08 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35058 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbcDOTKG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 15:10:06 -0400
Received: by mail-ig0-f172.google.com with SMTP id gy3so27639414igb.0
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 12:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1wEhNSOfHFQIacvHkVRec0HLt9M54gfafQcnzVWCn/4=;
        b=ZUFanjCJqZ1+RejIlZXNZDAVlYihXOahjRUIWxzqm1YHVHaJRjI2wQ7seTUmMrJkZb
         /3p5dAg+8lelhOa2c36rRXdOwIboaET5vdK04R27MvVlTWsns/5La5f0Y6V69EczttED
         ND3qtTzYsUK3kCRcymzwyPoHoXLZPUfVS9MB06OgvKpOjv/iwsFoYKatyYYKPi7g+dcV
         GiylDR/B4F5575MKGXjTWmlFqYZfbgliD0VmrC4rKNTPFco0kf1heR7+EFSYPjLbqxEg
         KD13QRS6K8Skc9YWuCkZFk30XzUOr0FlZnMChfCwUX2ZIiZvc7X45vn1KA/kRpMxHl3X
         t4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1wEhNSOfHFQIacvHkVRec0HLt9M54gfafQcnzVWCn/4=;
        b=hZw4CC4NkVrRy4NLxDiidxKkDZ12kNAc/4/8ABwrWpwSvwN0Y9ksg1yFuh3g6Gmijk
         buAYrRqPsdk5OXvbndFsqw4CtKTd57FTUTKmcvz/UsuRtcOqgikQm9sEKberCTY6rnvx
         At7zH3FX0SFyXHwmZWvpAqvUFy+gQBcHRerX6dH2lJb3Eh7mhaw2qXxWzm1B2Cl7H+rc
         XKJMMCcjyCId6mRDSIu95Pj8IeTowql247fLf1Y+Spn8FzyRsNCxwrLejUkQO6Cw065G
         w1rIo5ieDARCmE9UfVKfALsag35QE9HoIzUkHnq/ZY04TWyfMJCjYyUPYzE68/emX4zC
         Xdig==
X-Gm-Message-State: AOPr4FXyvCXY9g43QxS5X2U4J5Qje1YVy+SwDQD3S77tvA+jRZ4paHMG2M/IM1sSyrqxirYKlGuVTUr0wRMtAg==
X-Received: by 10.50.123.132 with SMTP id ma4mr6915067igb.92.1460747405848;
 Fri, 15 Apr 2016 12:10:05 -0700 (PDT)
Received: by 10.107.59.78 with HTTP; Fri, 15 Apr 2016 12:09:46 -0700 (PDT)
In-Reply-To: <xmqq60vidbsu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291637>

On Fri, Apr 15, 2016 at 10:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> It is a common pattern in xdl_change_compact to check that hashes and
>> strings match. The resulting code to perform this change causes very
>> long lines and makes it hard to follow the intention. Introduce a helper
>> function xdl_hash_and_recmatch which performs both checks to increase
>> code readability.
>
> Think _why_ it is common to check hash and then do recmatch().  What
> is the combination of two trying to compute?
>
> How about calling it after "what" it computes, not after "how" it
> computes it?  E.g.
>
>     static int recs_match(xrecord_t **recs, long x, long y, long flags)
>
> if we answer the above question "they try to see if two records match".
> We could also go s/recs/lines/.
>
> The xdl_recmatch() function appears in xutils.c, and over there the
> functions do not use arrays of (xrecord_t *), so I think we are
> better off without xdl_ prefix to avoid confusion.
>

That makes sense. I like the sound of recs_match, and it's shorter too
which is nice.

Regards,
Jake
