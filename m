From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 2/2] trailer: support multiline title
Date: Tue, 25 Aug 2015 23:28:36 -0700
Message-ID: <CA+P7+xqaAKckB0P5oqFS64BWU2H1OsVX8Oq=CLLW8PMJ5fdenQ@mail.gmail.com>
References: <1440557461-1078-1-git-send-email-chriscool@tuxfamily.org>
 <1440557461-1078-2-git-send-email-chriscool@tuxfamily.org> <vpqa8tetwfi.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 26 08:29:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUUCi-0007Ft-Qs
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 08:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855AbbHZG24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 02:28:56 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34784 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbbHZG24 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 02:28:56 -0400
Received: by igui7 with SMTP id i7so29708775igu.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 23:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=j2byKk71kQtzyw6trJI2JAaomK5ScVlamKkPJoYwdjY=;
        b=LBLjZHmxOWhlKzM6X5CQH586SgUkA81a8tKTJ3x8m/AANRYxG73H4hXOWnOC8ajA4E
         YLV4fo6ebVcIOZwPISrRmhEYDb424jMzdJIYs+XzwwrLTLQfX8C05cGCFfOMrsGvpfyr
         oSOTIaNAo61vDwK2GH5LisLHUhP9ff5xcCjy94jSSfzMVQnob6pNvtis0PUXKfysBZgD
         pleSOaCa/V8K/JE+SnD/G/XiJC2nW0sebUjhdzg22d3nvvdVLkrtsUvMVZyAwM7wsUDw
         msPi5ETC0tFZwoJBk8CSqUeY3SmFm1LLX//a0/FYRCoUIgr0ibHSrqWfcZpRpYwtY5ik
         NmTw==
X-Received: by 10.50.93.33 with SMTP id cr1mr1413543igb.35.1440570535490; Tue,
 25 Aug 2015 23:28:55 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Tue, 25 Aug 2015 23:28:36 -0700 (PDT)
In-Reply-To: <vpqa8tetwfi.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276598>

On Tue, Aug 25, 2015 at 11:07 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Unfortunately this does not work well when a commit is created with a
>> line break in the title, using for example the following command:
>>
>> git commit -m 'place of
>> code: change we made'
>
> I confirm that this patch fixes the behavior for me.
>
> Now, I found another issue: I still have this "interpret-trailers" in my
> hooks/commit-msg, and it behaves badly when I use "git commit -v". With
> -v, I get a diff in COMMIT_EDITMSG, and interpret-trailers tries to
> insert my Sign-off within the diff, like this:
>
>   # Do not touch the line above.
>   # Everything below will be removed.
>   diff --git a/git-multimail/README b/git-multimail/README
>   index f41906b..93d4751 100644
>
>   Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>   --- a/git-multimail/README
>   +++ b/git-multimail/README
>
> Either commit-msg should be called after stripping the diff from
> COMMIT_MSG, or interpret-trailers should learn to stop reading when the
> patch starts. I think the first option is better, since it means that
> any commit-msg hook does not have to deal with the patch stuff (my guess
> is that there are many broken commit-msg hooks out there, but people
> didn't notice because they don't use "commit -v").
>
> Thanks,
>

It's always confused me why commit -v doesn't prepend every inserted
line with "#" to mark it as a comment.

Regards,
Jake
