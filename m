From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] pull --rebase: reinstate helpful message on abort
Date: Mon, 12 Oct 2015 13:33:33 -0700
Message-ID: <xmqqeggzltcy.fsf@gitster.mtv.corp.google.com>
References: <cover.1444336120.git.johannes.schindelin@gmx.de>
	<47e66f159e8929879f22504a180330e3fa020ee9.1444336120.git.johannes.schindelin@gmx.de>
	<xmqqbnc7q489.fsf@gitster.mtv.corp.google.com>
	<d2116a492e14f07c8969798ce21c78a2@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Brendan Forster <shiftkey@github.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 12 22:33:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zljmt-0001BK-Cy
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 22:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbbJLUdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 16:33:35 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35371 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbbJLUde (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 16:33:34 -0400
Received: by pabve7 with SMTP id ve7so104858712pab.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 13:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=c9eluco8cdCEZScgBIPuZhVhn/9kchVKnZimv7/CC5c=;
        b=Xc4+GL8d+Tw5xlKSZT4DMWvaRhnYcr/4MGABVPhBbLWmOev/2S0Q4uLwrc2EvgE8K1
         Li/lrWlmhRxBhDbyGX0LK65POSzONLlc6a5hlzbI78oUIWOyUdEohXLqQvY96Qy0HyE3
         H7qgm0L10dUYmZLZMgHqc84By/KVkGI4+TCM0XHj6vXEsSRbZqHYoWtjX3gs8Zwbmy9S
         ssovvjLG6j0YEuqCeoYYAXuXACOEh81Zay84Agv1wKVeMd8pvttZ7wkgnGG8IRKrV91m
         8XgxP0ZqbSRkQ+w0KwG+C8vCvbn/b0RPdRsyuxbdwckTUfKHxayuJEY1jotlKz6kFjm1
         8g0Q==
X-Received: by 10.67.1.73 with SMTP id be9mr15184145pad.35.1444682014549;
        Mon, 12 Oct 2015 13:33:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:495:58e7:6a27:bf4d])
        by smtp.gmail.com with ESMTPSA id fa14sm20088219pac.8.2015.10.12.13.33.33
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 12 Oct 2015 13:33:33 -0700 (PDT)
In-Reply-To: <d2116a492e14f07c8969798ce21c78a2@dscho.org> (Johannes
	Schindelin's message of "Mon, 12 Oct 2015 11:16:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279418>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Hi Junio,
>
> On 2015-10-09 20:36, Junio C Hamano wrote:
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>>> When calling `git pull --rebase`, things can go wrong. In such a case,
>>> we want to tell the user about the most common ways out of this fix:
>>> ...
>>>  builtin/am.c | 1 +
>>>  1 file changed, 1 insertion(+)
>> 
>> It is strange to see a patch to am that does not talk anything about
>> it, though.  And looking at the codepath, the issue does not have
>> much to do with "pull --rebase".  It doesn't even have much to do
>> with "rebase".  This is purely about "am -3" fallback codepath.
>
> I made it a habit of describing the big picture in commit messages,
> including the original motivation for the patch. Naturally, it is
> purely an implementation detail that the bug displayed by `git pull
> --rebase` is fixed by modifying `am.c`.

Yup, but that is "I happened to notice that bug first in a command
that uses another command that happens to use this buggy one".  That
may be interesting in the "peeing in the snow" sense, but not very
interesting in the big picture of ensuring the health of the entire
codebase.

The "common ways out of this" helpful message is not even coming
from "pull --rebase" or even "rebase" in the first place.  What you
are reinstating helpful message on abort is "am -3".

"This fixes am -3, hence incidentally fixes rebase and hence fixes
pull --rebase, too" would be the most useful way to describe this
change.  The initial report being about "pull --rebase" is of much
lessor importance, I would think.
