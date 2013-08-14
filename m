From: Andres Perera <andres.p@zoho.com>
Subject: Re: ephemeral-branches instead of detached-head?
Date: Wed, 14 Aug 2013 02:40:39 -0430
Message-ID: <CAPrKj1ZQL0N7VFfZ3qS14Nhp8O4Kaez9QWK7AvqCXZds1Q=mRw@mail.gmail.com>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
	<7veh9z1gym.fsf@alter.siamese.dyndns.org>
	<CA+CP9O5fhyQrn3SboafocWJjaAywJHC0T-bw+AXk_8RX53hJ6Q@mail.gmail.com>
	<CACsJy8Dke6Pezqsdcjzejc_cWCgOGTGs8LifjM2h2TQJy7N4HA@mail.gmail.com>
	<7vk3jpy1qt.fsf@alter.siamese.dyndns.org>
	<520AC9A8.4030104@gmail.com>
	<7vmwolujvb.fsf@alter.siamese.dyndns.org>
	<520B2478.3000100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	David Jeske <davidj@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 09:10:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9VEC-0004X6-Mm
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 09:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426Ab3HNHKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 03:10:41 -0400
Received: from mail-ve0-f178.google.com ([209.85.128.178]:34309 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388Ab3HNHKk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 03:10:40 -0400
Received: by mail-ve0-f178.google.com with SMTP id ox1so7415894veb.37
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 00:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ZJfY/hPjlp2KB9Eu6b8GB13jM3lRmdQ+mVINagmyVrM=;
        b=SdrRuv8ifxgtK2nTJXujcWFQF8KfSiY3OjNV3AixfRUItwUMmxTMl0Gv7NDMf/mCNh
         5rDC1XuTlXAnED0SnIZxNQZFpWReab8Y5PGd+S0zDQuJ2KkuoES9QIZiOv+nAM9Fv69b
         rH/UqBPs7jytjBwvIWXj9qxc3Ha3evD9UFOXiBYoAcgt0AYfx4HpUvTkykyoR80dWXlL
         2YLkiX2477occmHk/AabYLCo5+iJBFQ3me+pMF3fYnRiZLTdUJ68surHescBqX8Mk57Q
         VkqvdxWhYYcZ0BQFDoG11Y6hNl2Rrt9NVDXti/ah+M26XYmzKFexx9M7Pbx+Ql2jzv7I
         ddEA==
X-Received: by 10.220.91.16 with SMTP id k16mr8284708vcm.21.1376464239571;
 Wed, 14 Aug 2013 00:10:39 -0700 (PDT)
Received: by 10.58.207.110 with HTTP; Wed, 14 Aug 2013 00:10:39 -0700 (PDT)
In-Reply-To: <520B2478.3000100@gmail.com>
X-Google-Sender-Auth: vq1jBEnKGPxaULP48IMzDJJkTCE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232265>

On Wed, Aug 14, 2013 at 2:02 AM, Sitaram Chamarty <sitaramc@gmail.com> wrote:
> On 08/14/2013 07:14 AM, Junio C Hamano wrote:
>> Sitaram Chamarty <sitaramc@gmail.com> writes:
>>
>>>     # all reflog entries that are not on a branch, tag, or remote
>>>     d1 = !gitk --date-order $(git log -g --pretty=%H) --not --branches --tags --remotes
>>>     # all dangling commits not on a branch, tag, or remote
>>>     d2 = !gitk --date-order $(git fsck | grep "dangling.commit" | cut -f3 -d' ') --not --branches --tags --remotes
>>>
>>> (Apologies if something like this was already said; I was not following
>>> the discussion closely enough to notice)
>>
>> Yup.
>>
>> A potential problem is that the output from "log -g --pretty=%H" or
>> "fsck | grep dangling" may turn out to be humongous.  Other than
>> that, they correctly compute what you want.
>
> I thought I mentioned that but I can't find my email now so maybe I
> didn't.
>
> In practice though, I find that, bash at least seems happy to take
> command lines as long as 7+ million characters long, so with the default
> reflog expire times, that should work out to 10,000 commits *per day*.
> [Tested with: echo {1000000..1900000}  > junk; echo `cat junk` | wc]

echo is a builtin in bash, as is the case with other shell implementations

builtins may have different limit's than exec()'s ARG_MAX

$ getconf ARG_MAX
262144
$ perl -e 'print "A" x (262144 * 2)' | wc -c
  524288
$ perl -e 'print "A" x (262144 * 2)' | sh -c 'read v; echo "$v"' | wc -c
  524289
$ perl -e 'print "A" x (262144 * 2)' | sh -c 'read v; /bin/echo "$v"' | wc -c
sh: /bin/echo: Argument list too long
       0

builtin's argument buffer limit tends to be aligned with the
implementation's lexer buffer limit
