From: David Michael <fedora.dm0@gmail.com>
Subject: Re: [PATCH 2/3] Makefile: Reorder linker flags in the git executable rule
Date: Sun, 26 Oct 2014 14:54:56 -0400
Message-ID: <CAEvUa7nMYn1EJhrX+Yo-T53-tqB80p_ym9i+Ua6PMLqZrAFmQw@mail.gmail.com>
References: <87mw8iag72.fsf@gmail.com>
	<CAPig+cRUxXw4b2z1Gu4p6GKjnYrt_70h3kbR+jzbMP_jY24Sjg@mail.gmail.com>
	<20141026183530.GA18144@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 26 19:55:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiSy0-000064-KZ
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 19:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbaJZSy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 14:54:57 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:48998 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbaJZSy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 14:54:57 -0400
Received: by mail-pd0-f172.google.com with SMTP id r10so4297182pdi.31
        for <git@vger.kernel.org>; Sun, 26 Oct 2014 11:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=thYTSKUbuUGGXbyvxQ5MCqWjFrBa5Kp8QoBTsNKDJ7Y=;
        b=YIxMNStH7YRVhkMzuJZWDbw33vRw/5AyBtiqnkiV38JrBlb4771L1lKomvu9wKqCpp
         wwJYl7Zzpu4d0vnbbGP8Q4GU26LKRJSHBnFVy7duYIu9YRfY6DuE0lcPFEJDKiVdAXOf
         8Y6+F5dY+kpWqtBIHHhxIvhg5juXUFsi64NAVJkWrtjFZTKPw+bwYypYwNOu7XAhYngl
         hKZlLvj6UeZCp2gYrfiE+U4gVfMdZ9YKaQAsewO8cwi9yC1r3eBEwessZR4FiZEXZNCJ
         kYossq7y1HIoCrm3z+6BxS3OLr0iU1aZnf48odEBdNjJhDtpZ2SuNCb9s0gj7k+BLH19
         TdhA==
X-Received: by 10.70.22.69 with SMTP id b5mr17747366pdf.68.1414349696543; Sun,
 26 Oct 2014 11:54:56 -0700 (PDT)
Received: by 10.70.84.9 with HTTP; Sun, 26 Oct 2014 11:54:56 -0700 (PDT)
In-Reply-To: <20141026183530.GA18144@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 26, 2014 at 2:35 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Oct 26, 2014 at 01:45:10PM -0400, Eric Sunshine wrote:
>
>> On Sun, Oct 26, 2014 at 1:33 PM, David Michael <fedora.dm0@gmail.com> wrote:
>> > The XL C compiler can fail due to mixing library path and object
>>
>> Can you explain in the commit message the actual nature of the failure
>> so that readers can understand more precisely how this change helps?
>
> Based on past experience, it is probably "the compiler complains and
> refuses to run" (or optionally "the compiler silently ignores your
> LDFLAGS" depending on how irritating it wants to be). But it would not
> hurt to be specific.

Yes, the compiler refuses to run by default when a "-L" option occurs
after a source/object file.  It tries to interpret it as another file
name and fails.

I believe I can work around the error with an "export _C89_CCMODE=1",
but I thought I'd send the patch since this is the only occurrence of
the problem, and the argument order is inconsistent with other linker
commands in the file.

IBM documentation has this to say on the noted environment variable:
"The default behavior of the c89/cc/c++ command is to expect all
options to precede all operands. Setting this variable allows
compatibility with historical implementations (other cc commands).
When set to 1, the c89/cc/c++ command operates as follows: Options and
operands can be interspersed. [...]"

Do you want me to resend the patch and reference the IBM documentation
in the message?

Thanks.

David
