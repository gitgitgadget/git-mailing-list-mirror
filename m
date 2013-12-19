From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 07/10] builtin/replace: teach listing using short,
 medium or full formats
Date: Thu, 19 Dec 2013 17:36:16 +0100
Message-ID: <CAP8UFD1+kydjrjhTxKDSMmOa+KiOYgMGK5gyxCe-LPih02=VYQ@mail.gmail.com>
References: <20131211074147.11117.1155.chriscool@tuxfamily.org>
	<20131211074614.11117.96106.chriscool@tuxfamily.org>
	<52B196F1.3060003@gmail.com>
	<CAP8UFD3UsdcDg2D2nysMZgGAxLebYm-qQX3LZfqdwF9gNbyxgA@mail.gmail.com>
	<xmqqioumjc1n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 19 17:36:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtgaE-0007tq-4E
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 17:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771Ab3LSQgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 11:36:19 -0500
Received: from mail-ve0-f176.google.com ([209.85.128.176]:36577 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759Ab3LSQgR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 11:36:17 -0500
Received: by mail-ve0-f176.google.com with SMTP id oz11so832580veb.35
        for <git@vger.kernel.org>; Thu, 19 Dec 2013 08:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3WQTqf2F2N3UELAG/LqqwursGRnNhN1uywG5VShZynM=;
        b=cpTMlWVwiWGWceNwHTbwUUAbBnGt+9KhYgB24WhpGpsCnEIdbkeoUCaI0kCtov2L0I
         dYM0wFPcNHR9yERoIWfVcCSrnXwK6fRruhogw9jQ/M/glHrNMZxkQcX+BcqWEk9RE7e1
         RUjY7l/REuk1yKrqDEPcPOX0ryVdKz/cBD3m5I28PNjqM0ZzmvJxawcNMbLjW8JB/NI8
         FDrbImpxWCVSwBBQkUB5vt3t/mSEHHxBQquBEMnkQJ4Q+X3V1ZZTuM0Cffuzn801fEQR
         I5ktNSFyc26OmKxSMdgTgHSnI9wzKD5HaWoPiKX1INs+YSaxhmvkkPSsr+cY5YRR5xh2
         em4A==
X-Received: by 10.220.174.200 with SMTP id u8mr1529180vcz.6.1387470976964;
 Thu, 19 Dec 2013 08:36:16 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Thu, 19 Dec 2013 08:36:16 -0800 (PST)
In-Reply-To: <xmqqioumjc1n.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239524>

On Wed, Dec 18, 2013 at 6:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Wed, Dec 18, 2013 at 1:37 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
>>> Am 11.12.2013 08:46, schrieb Christian Couder:
>>>> +enum repl_fmt { SHORT, MEDIUM, FULL };
>>>
>>> SHORT is predefined on Windows, could you choose another name?
>>
>> Ok, I will change to:
>>
>> enum repl_fmt { SHORT_FMT, MEDIUM_FMT, FULL_FMT };
>
> What are these for in the first place?  Your "SHORT" conflicting
> with something totally unrelated is a sign that you should be naming
> them in a way that is more specific to your use.  SHORT_FMT is still
> not specific enough to tell what they are for.  With SHOW_REPLACE_
> prefix, perhaps?  Also perhaps give characterization better than
> their output lengths?

I am ok with SHORT_REPLACE_FMT and so on.

> My quick read of show_reference() tells me that they are "name
> only", "name and value", and something else that does not seem
> very useful unless you are debugging.

Yeah, SHORT_REPLACE_FMT is "name only" which means something like:

$ git replace --format=short
14ac020163ea60a9d683ce68e36c946f31ecc856
4b48deed3a433909bfd6b6ab3d4b91348b6af464
5c37393794868bc8e708cccd7c9d9aaa7a5e53cb
a3fb2e1845a1aaf129b7975048973414dc172173
e25dc7954f0832d962347872884aab2dffb426c5

MEDIUM_REPLACE_FMT is "name and value", like this:

$ git replace --format=medium
14ac020163ea60a9d683ce68e36c946f31ecc856 ->
4b48deed3a433909bfd6b6ab3d4b91348b6af464
4b48deed3a433909bfd6b6ab3d4b91348b6af464 ->
feae347d8510cfba5eb8c8ac80056777b07c2528
5c37393794868bc8e708cccd7c9d9aaa7a5e53cb ->
14ac020163ea60a9d683ce68e36c946f31ecc856
a3fb2e1845a1aaf129b7975048973414dc172173 ->
9af2a15082b7c95982473e32f3376558c149a7e7
e25dc7954f0832d962347872884aab2dffb426c5 ->
00ad688edb1a79423184992de45a5f0322c8bdf5

and FULL _REPLACE_FMT is "name with type and value with type", like this:

$ git replace --format=full
14ac020163ea60a9d683ce68e36c946f31ecc856 (commit) ->
4b48deed3a433909bfd6b6ab3d4b91348b6af464 (blob)
4b48deed3a433909bfd6b6ab3d4b91348b6af464 (blob) ->
feae347d8510cfba5eb8c8ac80056777b07c2528 (blob)
5c37393794868bc8e708cccd7c9d9aaa7a5e53cb (tree) ->
14ac020163ea60a9d683ce68e36c946f31ecc856 (commit)
a3fb2e1845a1aaf129b7975048973414dc172173 (commit) ->
9af2a15082b7c95982473e32f3376558c149a7e7 (commit)
e25dc7954f0832d962347872884aab2dffb426c5 (tag) ->
00ad688edb1a79423184992de45a5f0322c8bdf5 (commit)

I think this last one might be useful for people replacing objects
with objects that have another type.
And as we let people do that using --force, it could be useful for
them to have a way to easily see what they have done.

Thanks,
Christian.
