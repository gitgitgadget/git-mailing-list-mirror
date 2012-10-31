From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/4] fast-export: don't handle uninteresting refs
Date: Wed, 31 Oct 2012 02:03:40 +0100
Message-ID: <CAMP44s1ftDijYpZW_Reu5qNi1T_L52_353ngNaRW3W1gz+k9jw@mail.gmail.com>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
	<1351617089-13036-4-git-send-email-felipe.contreras@gmail.com>
	<20121030185914.GI15167@elie.Belkin>
	<CAMP44s3LP65XOYFg-tBe_rzT1+gXp=714C-u14mkwxY26r4b=g@mail.gmail.com>
	<CAMP44s1tFhh3Xqe9tqoDAdtwnGc=kFT6OmAreeP1nbTstweaQQ@mail.gmail.com>
	<20121030214531.GN15167@elie.Belkin>
	<CAMP44s1b+E8a0kdSgREbGzRTFy+nCw4VcjHadd3soQAXRkNzZw@mail.gmail.com>
	<20121030220717.GO15167@elie.Belkin>
	<CAMP44s3ArAQXH+-EbH4MHYaV6fTAWdwGzBdZwzn_qtCABHyonQ@mail.gmail.com>
	<20121030235506.GT15167@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 02:03:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTMin-0005Mc-QY
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 02:03:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934470Ab2JaBDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 21:03:41 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46599 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933152Ab2JaBDl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 21:03:41 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so925527obb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 18:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6241kB+zo7qB9lgcm4M8PHX5TNYpacVapxQtPj8Eyg0=;
        b=I+i8gyvHh0qgOddeJvN7qiCm6pIdmN57QExr7CkA5VP47CksztE3qtYiedJh6uPZHu
         ZF4e1edrdI9Kr9vhUErsqvTLkUXYW82bHzTJGLjWg1cwUVWWDh5OGRWk0pefKhB+qyM3
         /kroiZDcvkmnYKoGd6Lz1/ZNhvQflyIdYEEYMIgn8OZZK7ZmKKtb/c6QfeTf658IqssN
         c+2gJtztMVn3BE2VEiuaogOszbd7O/2v+1qQwKAf1nCVa1uJHciA0LU5PIkIOlw6D0q0
         rCwlSpR6zsFo01hKNvpTAdOL1HEQh6d2EFHeo0Kyh8Ui/q8ShH7P6VHnJxhhQ/DmFu5C
         9J/w==
Received: by 10.60.27.201 with SMTP id v9mr21039840oeg.85.1351645420180; Tue,
 30 Oct 2012 18:03:40 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 18:03:40 -0700 (PDT)
In-Reply-To: <20121030235506.GT15167@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208775>

On Wed, Oct 31, 2012 at 12:55 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>> On Tue, Oct 30, 2012 at 11:07 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>
>>> Nope.  I just don't want regressions, and found a patch description
>>> that did nothing to explain to the reader how it avoids regressions
>>> more than a little disturbing.
>>
>> I see, so you don't have any specific case where this could cause
>> regressions, you are just saying it _might_ (like all patches).
>
> Yes, exactly.  The commit log needs a description of the current
> behavior, the intent behind the current code, the change the patch
> makes, and the motivation behind that change, like all patches.
> Despite the nice examples, it doesn't currently have that.
>
> The patch description just raises more questions for the reader.  From
> the description, one might imagine that this patch causes
>
>         git fast-export <mark args> master
>
> not to emit anything when another branch that has already been
> exported is ahead of "master".

This is already the case.

I don't see what part of my patch description would give you the idea
that this would change in any way how the objects are flagged, or how
get_revision() decides how to traverse them.

I clearly stated that this doesn't affect *the first* ref, which is
handled properly already; this patch affects *the rest* of the refs,
of which you have none in that command above.

> If I understand correctly (though
> I haven't tested), this patch does cause
>
>         git fast-export ^next master
>
> not to emit anything when next is ahead of "master".  That doesn't
> seem like progress.

Again, this is already the case RIGHT NOW.

And nothing in my description should give you an idea that anything
would change for this case because the 2nd ref (*the first* doesn't
get affected), is not marked as UNINTERESTING.

Not only you are not reading what is in the description, but I don't
think you understand what the code actually does, and how it behaves.

Let me give you some examples:

% git fast-export ^next next
reset refs/heads/next
from :0

% git fast-export ^next next^{commit}
# nothing
% git fast-export ^next next~0
# nothing
% git fast-export ^next next~1
# nothing
% git fast-export ^next next~2
# nothing
...
# you get the idea

The *only time* when this patch would have any effect is when you
specify more than *one ref*, and they both point to *exactly the same
object*.

Additionally, and this is something I just found out; when the are
pure refs (e.g. 'next'), and not refs to objects (e.g.
'next^{commit}').

In any other case; *there would be no change*.

After my patch:

% git fast-export ^next next
# nothing
% git fast-export ^next next^{commit}
# nothing
% git fast-export ^next next~0
# nothing
% git fast-export ^next next~1
# nothing
% git fast-export ^next next~2
# nothing
...
# you get the idea

> But in the long term it is much easier to understand
> and maintain a patch series that does not introduce regressions in the
> first place

It does not introduce regressions.

I don't think it's my job to explain to you how 'git fast-export'
works. Above you made too many assumptions of what get broken, when in
fact that's the current behavior already... maybe, just maybe, you are
also making wrong assumptions about this patch as well.

-- 
Felipe Contreras
