From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2012, #03; Wed, 12)
Date: Thu, 13 Dec 2012 13:06:36 -0600
Message-ID: <CAMP44s3Es-rLjwe6sgOi9OmwQouM4AbFKAbGB5UgS6sUtYRgKQ@mail.gmail.com>
References: <7vhanq257s.fsf@alter.siamese.dyndns.org>
	<CAMP44s2DAuhk5FkDm0-cYsikY0o6vuZ4FyAnXhbtsgqKQF1dpg@mail.gmail.com>
	<7vvcc6z801.fsf@alter.siamese.dyndns.org>
	<CAMP44s3uyC0V6ycTv78mG36_i7ugMLwwNk2cqNZatEJuL7Ee1w@mail.gmail.com>
	<BF9B1394-0321-4F1C-AD1B-F40D02DBE71A@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Max Horn <postbox@quendi.de>
X-From: git-owner@vger.kernel.org Thu Dec 13 20:07:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjE7X-00007z-JF
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 20:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990Ab2LMTGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 14:06:39 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38158 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436Ab2LMTGh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Dec 2012 14:06:37 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so2421394obb.19
        for <git@vger.kernel.org>; Thu, 13 Dec 2012 11:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=bKze+2TfonHGITYDZaC9I8ZCacJAitNnWI7NrOV1cCo=;
        b=pBWTPyLVTWpwPjoOI9/fVTxp/jojnc54xbvSEkJxdjdLsk1Evo/A6MrJyXlTpWuTKu
         rFxU7UaycCI0DB77x0vdypBmW+U11JyoAIhhzd3MhW9fzZsi8rKYGzV14aV/Y23+M28c
         H2GSz9ElxbaU35+UexMwv9URNlKBLLT4jVrxi6eCK7a7foT2ibBoLa9DNDjmUs4BR6pV
         Ok8rc17iqB5mnhxIWN6XTF5dbToeTPWLA7uwnJ6cQMNHDjy6Q8kr1AZ8Oy1YZUZWc6I2
         wWV4qQgdn1nssApaPU8bW7QJemS6QfDsbxklXJB1Jty7LW6wWm/kYr70eDAaqPDn+Tjx
         uX1g==
Received: by 10.60.31.131 with SMTP id a3mr2383965oei.93.1355425596974; Thu,
 13 Dec 2012 11:06:36 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Thu, 13 Dec 2012 11:06:36 -0800 (PST)
In-Reply-To: <BF9B1394-0321-4F1C-AD1B-F40D02DBE71A@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211467>

On Thu, Dec 13, 2012 at 6:04 AM, Max Horn <postbox@quendi.de> wrote:
>
> On 13.12.2012, at 11:08, Felipe Contreras wrote:
>
>> On Thu, Dec 13, 2012 at 2:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>>>> New remote helper for bzr (v3).  With minor fixes, this may be ready
>>>>> for 'next'.
>>>>
>>>> What minor fixes?
>>>
>>> Lookng at the above (fixup), $gmane/210744 comes to mind
>>
>> That doesn't matter. The code and the tests would work just fine.
>
>
> It doesn't matter? I find that statement hard to align with what the maintainer of git, and thus the person who decides whether your patch series gets merged or not, wrote just above? In fact, it seems to me that what Junio said matters a great deal...

So you think Junio knows more about remote-bzr than I do? I repeat; it
doesn't affect the tests, it doesn't affect the code, it doesn't cause
any problem. remote-bzr could be merged today, in fact, it could have
been merged a month ago.

You don't trust me? Here, look:

	cmd=<<EOF
	import bzrlib
	bzrlib.initialize()
	import bzrlib.plugin
	bzrlib.plugin.load_plugins()
	import bzrlib.plugins.fastimport
	EOF

	if ! "$PYTHON_PATH" -c "$cmd"; then
		echo "consider setting BZR_PLUGIN_PATH=$HOME/.bazaar/plugins" 1>&2
		skip_all='skipping remote-bzr tests; bzr-fastimport not available'
		test_done
	fi

All this code is a no-op, because, as Junio pointed out, cmd is null.
How is that a problem? It's not. The first version of remote-bzr
relied on the bazaar fastimport plug-in, so this check was needed, in
case you had bazaar, but not this particular plug-in, but today
remote-bzr doesn't need this plug-in, so this chunk of code should be
removed. The fact that this code does nothing (because python -c ''
does nothing) is *not a problem*.

In fact, even if that code failed 100% of the time, it wouldn't hurt
anybody, because 'make -C t' would work, everything would work, the
only thing that would fail is 'make -C contrib/remote-helpers/
test-bzr', which very very few people would consider a problem. But it
doesn't fail, it works.

Who benefits by delaying the merging of this code? Nobody. Who gets
hurt? The users, of course.

> This is a very strange attitude...
>
> In another email, you complained about nobody reviewing your patches respectively nobody voicing any constructive criticism. Yet Junio did just that, and again in $gmane/210745 -- and you replied to neither, and acted on neither (not even by refuting the points brought up), and now summarily dismiss them as irrelevant. I find that quite disturbing :-(.

I didn't say it was irrelevant, it should be fixed, but Junio said
"With minor fixes, this may be ready for 'next'." which is no true
IMO, it's ready *now*, it was ready one month ago. For 'next', this
problem doesn't matter.

The feedback is appreciated, but delaying the merging of this code for
no reason makes little sense to me. Junio, of course, can do whatever
he wants. The removal of this no-op code can wait, or it can be done
on top of v3, there's no need for re-roll, and Junio already
complained about the v3 re-roll.

And I didn't act because I was on vacations, git development is not my
only priority. And even if I had time, I don't see why I should
prioritize this fix, it's not important, the code is ready.

>>> but there may be others.  It is the responsibility of a contributor to keep
>>> track of review comments others give to his or her patches and
>>> reroll them, so I do not recall every minor details, sorry.
>>
>> There is nothing that prevents remote-bzr from being merged.
>
> Well, I think that is up to Junio to decide in the end, though :-). He wrote

No. He can decide if the code gets merged, but he is not the voice of
truth. Nothing prevents him from merging the code, except himself.
There is no known issue with the code, that is a true fact.

Cheers.

-- 
Felipe Contreras
