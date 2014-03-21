From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH][GSOC] Selection of the verbose message is replaced with
 generated message in install_branch_config()
Date: Fri, 21 Mar 2014 17:33:03 -0400
Message-ID: <CAPig+cSYieZRA-kx0PUnrLjG5E6LYi_qOFqnZiE09wqeCvN3oA@mail.gmail.com>
References: <1395050104-19152-1-git-send-email-moxobukob@gmail.com>
	<loom.20140318T124348-742@post.gmane.org>
	<lg9l22$qto$1@ger.gmane.org>
	<CAPig+cQLACyFwVypi08ZGQ14mpc0zt0fRRNhPzswRjsTaFQz2A@mail.gmail.com>
	<lgekju$u6t$1@ger.gmane.org>
	<CAPig+cRv-WvoMVY0PDgtLawywe0QfpX8oPetzNwD-9Jq6BOjyw@mail.gmail.com>
	<xmqqr45vv5q8.fsf@gitster.dls.corp.google.com>
	<532CAB89.7030303@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Aleksey Mokhovikov <moxobukob@gmail.com>,
	Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 21 22:33:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR73u-00038d-7j
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 22:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbaCUVdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 17:33:07 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:34584 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbaCUVdF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 17:33:05 -0400
Received: by mail-yk0-f173.google.com with SMTP id 10so7799993ykt.4
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 14:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=tUsMaudlnIfcKIGpHi6pN7D88nENLF61rbwQzYcPBDc=;
        b=W7ouDZVUMmulWiWVt1PijXvBBtZhti9t8JDjBp6FbceED9HlKNrGzjQy4Spd1JtQp3
         y90asbyT+hOkiSssps0F22W9Au5sHTo28esLwk10U7rVTmW6jur76gS52DLdl/jOTcZm
         kTsPcL7jAuTQy95cwUHjEFmdLrzMPJvqAkgtFX7p4a0L2isBbnGqs3diRVaLPL/4WeR5
         qhV4ZsNexYzA3MnLr0DlFx+t/BKbNLv0NUIZspYKLE+jmXa1EvhRkuDqs9xWbFaU6xYP
         BIKtOASUlJ1ZrUvIBD6A6g064dfUx0HApFjQhQbd7y5X21EwSGCWtYHU8sgsBOzWmZhb
         1HxA==
X-Received: by 10.236.75.74 with SMTP id y50mr70738652yhd.27.1395437583967;
 Fri, 21 Mar 2014 14:33:03 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Fri, 21 Mar 2014 14:33:03 -0700 (PDT)
In-Reply-To: <532CAB89.7030303@alum.mit.edu>
X-Google-Sender-Auth: R1dUYzxs6FQn4jAAN9zy2LlXtaE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244753>

On Fri, Mar 21, 2014 at 5:13 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 03/21/2014 06:09 PM, Junio C Hamano wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>> Sorry, you're right about message[0] case not being a crasher (though
>>> the assert() still seems overkill).
>>
>> Assert() often becomes no-op in production build.  I think this may
>> be an indication that "table-driven" may not be as good an approach
>> as many candidates thought.  The microproject suggestion asks them
>> to think _if_ that makes sense, and it is perfectly fine for them if
>> they answer "no, it introduces more problems than it solves".
>
> My expectation when I invented that microproject was that converting the
> code to be table-driven would be judged *not* to be an improvement.  I
> was hoping that a student would say "the 'if' statement is OK, but let's
> delete this ridiculous unreachable else branch".  Possibly they would
> convert the "if" chain into nested "if"s, which I think would allow some
> code consolidation in one of the branches.
>
> But not a single student agreed with me, so I must be in a minority of
> one (which, unfortunately, is the definition of lunacy).

Adam NoLastName did stick with the 'if' statements and removed the
unreachable branch  [1], although he didn't say if he had considered
the table-driven approach and discarded it.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243704

> The multidimensional array lookup table is not so terrible, but I
> personally still prefer the "if".
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
