From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 4/4] format-patch: add format.cover-letter configuration
Date: Sun, 7 Apr 2013 03:48:14 -0500
Message-ID: <CAMP44s0rsWCZE=MyW3zuBoVM5ZtEGQQb+deQJB5-i6tBzFdTfw@mail.gmail.com>
References: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
	<1365318630-11882-5-git-send-email-felipe.contreras@gmail.com>
	<7v4nfi92q1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 10:48:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOlGw-0001bi-6j
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 10:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932982Ab3DGIsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 04:48:17 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:61192 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932978Ab3DGIsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 04:48:16 -0400
Received: by mail-lb0-f171.google.com with SMTP id v10so4831678lbd.2
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 01:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=mgZVgzxNc1dBhsGxTPHDDHLZdlF5RSnPI4B7b2z06zY=;
        b=YpGPz5eZspXuH1V5ymnf4znA8o6kmAUpn43fiNfxKKmnOEOY6cDthm1uv3S5W7r0TM
         d/4AF2bnWTWUz8Hv3HKyfhW405mrQ1ek1Q2b5YV2XHo8oJ72UREbLPimTTpRSlHVukKz
         ubFphwubcEeOSVTF7jy4INV24Q9j0ibdK6cBpN6zMQe6jz7xtulfFFoqgQGDod9CsXbj
         j/On4ZSWuv65VAt0BSuFgnhVUIIO4shhJWYhT/6vTEFeJ5Sg1S81oueTdeGbWbSUrM1G
         OiNxvlTMfNwi+eanZ4Ix336cYSoJnOQxnqd/IPOEgvpbeDnClLZZc5HsGAwLtv0xy14p
         LRJA==
X-Received: by 10.112.59.68 with SMTP id x4mr500876lbq.121.1365324494463; Sun,
 07 Apr 2013 01:48:14 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Sun, 7 Apr 2013 01:48:14 -0700 (PDT)
In-Reply-To: <7v4nfi92q1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220297>

On Sun, Apr 7, 2013 at 3:14 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Also, add a new option: 'auto', so if there's more than one patch, the
>> cover letter is generated, otherwise it's not.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  Documentation/config.txt           |  6 ++++++
>>  Documentation/git-format-patch.txt |  5 +++--
>>  builtin/log.c                      | 22 ++++++++++++++++------
>>  3 files changed, 25 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index c8e2178..c10195c 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1092,6 +1092,12 @@ format.signoff::
>>      the rights to submit this work under the same open source license.
>>      Please see the 'SubmittingPatches' document for further discussion.
>>
>> +format.cover-letter::
>
> I thought I saw somebody already pointed out that this was wrong.

Yeah, I forgot.

>> +     Allows to configure the --cover-letter option of format-patch by
>> +     default.
>> +     In addition, you can set it to 'auto' to automatically
>> +     determine based on the number of patches (generate if there's more than
>> +     one).
>
> I find this somewhat a strange phrasing.  It _sets_ the default for
> the cover-letter option, either to true or false or auto, so there
> is no "in addition" about it.

There's no --cover-letter=auto.

> Perhaps
>
> format.coverLetter::
>         Setting this variable to `true` (or `false`) tells the
>         `format-patch` command to pretend the `--cover-letter` (or
>         `--no-cover-letter`) was given from the command line.  When
>         set to `auto`, `format-patch` assumes `--cover-letter` if
>         and only if it is working on more than one commit.

I prefer the wording suggested by Ramkumar with a minor modification:

A boolean that controls whether to generate a cover-letter when
format-patch is invoked, but in addition can be set to "auto", to
generate a cover-letter only when generating more than one patch.

> or something?
>
> It also is somewhat strange why the command line argument does not
> accept `--cover-letter=auto` option.  In general, a configuration
> variable should not be more flexible mechanism than what the command
> line could give the user.  As I already said, I think that would be
> a better longer-term default, and that makes it even more stand-out.

Users know how to count, if the default is no cover-letter, then doing
--cover-letter=auto is basically --cover-letter, unless they don't
know how to count and thought --cover-letter=auto would do something.
The same is true is they configured coverletter=true.

I don't see any value in doing that.

> This part is nicely done, thanks to the previous two steps.  You
> might even want to remove the call to the find_branch_name() helper
> function from here, and instead call it from make_cover_letter()
> when branch_name is not yet there.

True. We can also move the 'head' variable inside make_cover_letter() as well.

> We would need tests to make sure future changes will not break this.

Sigh. All right.

-- 
Felipe Contreras
