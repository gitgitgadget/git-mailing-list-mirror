From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 3/3] gitweb: Add support to Link: tag
Date: Wed, 4 Jul 2012 10:24:49 +0900
Message-ID: <CAM9d7ciU8j6Kt+9akyPpPiUdCJSFyL1xBbG2_c2epa79FgMmiw@mail.gmail.com>
References: <1341295377-22083-1-git-send-email-namhyung@kernel.org>
 <1341295377-22083-4-git-send-email-namhyung@kernel.org> <7vy5n0txdi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 03:25:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmELE-0001Le-DQ
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 03:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619Ab2GDBZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 21:25:11 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:33472 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932139Ab2GDBZK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 21:25:10 -0400
Received: by qaas11 with SMTP id s11so3059108qaa.19
        for <git@vger.kernel.org>; Tue, 03 Jul 2012 18:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=DLnpceAIzSuspJWvo7Ply3kKp9nOM5PHu3p8OzC3RDs=;
        b=ny+ClbQKsP+ZB4IS5mDVrUZ0f1I/2XmDB9V+/3vU4xPSkP5nHHPWLkG8mk/xg0dE0C
         aRuqqnd35WKZzRDSaMlBqIZC1i6YZmDO606+JvkwivDsZZy5OIysRDSqsIPgi77jlTQw
         sJTryKL0DgcSz7f2c9g6z2GzxpvmWIFS9KegobuhHq0rcKBgqZJKYyTd4bjPBYLrZVc8
         Jz3OPcVffdczkHSw/wGyN4tViBupmLacEpJUCvR9lCBk0Mfw2QYr2Zbn4a5KMSZgS4DA
         VmpFyd6Ib2whzZh41edpoucbt1SIgcWP6I94TxRBJl/k4wOhpiV5cqjxHiXQZzxVrai5
         D8eQ==
Received: by 10.224.178.137 with SMTP id bm9mr34824644qab.31.1341365109425;
 Tue, 03 Jul 2012 18:25:09 -0700 (PDT)
Received: by 10.229.176.217 with HTTP; Tue, 3 Jul 2012 18:24:49 -0700 (PDT)
In-Reply-To: <7vy5n0txdi.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: CK2VCLlnaphF_HAp1oXY-VGfVok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200977>

Hi,

On Wed, Jul 4, 2012 at 5:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Namhyung Kim <namhyung@kernel.org> writes:
>
>> The tip tree is the one of major subsystem tree in the
>> Linux kernel project. On the tip tree, the Link: tag is
>> used for tracking the original discussion or context.
>> Since it's ususally in the s-o-b area, it'd be better
>> using same style with others.
>>
>> Also as it tends to contain a message-id sent from git
>> send-email, a part of the line which has more than 8
>> (hex-)digit characters would set a wrong hyperlink
>> like [1]. Fix it by not using format_log_line_html().
>>
>> [1] git.kernel.org/?p=linux/kernel/git/tip/tip.git;a=commit;h=08942f6d5d992e9486b07653fd87ea8182a22fa0
>>
>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>> ---
>>  gitweb/gitweb.perl |    7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index e0701af..d07bcb7 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -4493,6 +4493,13 @@ sub git_print_log {
>>                               print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
>>                       }
>>                       next;
>> +             } elsif ($line =~ m,^ *link[ :](http://[\w/~.@%&=?+-]*),i) {
>
> Hrm, I am somewhat confused.  This catches "link:http://..." and
> "link http://...", but not "link: http://...", which looks a lot
> more natural looking at least to me.
>

Oops, right. Actually I found it after some local testing,
but forgot to update the patch. Sorry :)


> Looking at a random sample:
>
> http://git.kernel.org/?p=linux/kernel/git/tip/tip.git;a=commit;h=fe85227347738eb9b871bc163e7fb0db8b6cd2a0
>
> I see a "Buglink: " which I think deserves to be handled by this patch
> but would not.  Probably the pattern needs to be loosened
> sufficiently, e.g.
>
>         m,^\s*[a-z]*link: (https?://\S+),i
>
> to catch it as well.  Note that I am rejecting space before ":" and
> requiring a space after ":" in the above.
>

I think 'l' in 'link' should be '[Ll]'. Otherwise looks good to me.


> I also notice that "Reported-bisected-and-tested-by: " in that
> example, which is the topic of your [PATCH 2/3].  Perhaps the logic
> should catch everythinng that match "^[A-Z][-a-z]*[a-z]: ".
>

Isn't "^[A-Z][-A-Za-z]*-[Bb]y: " enough?
Just FYI, please see this too:

http://lwn.net/Articles/503829/


> As to coding style, if you end the body of if () clause with 'next',
> I tend to think it is easier to read if you structure it like this:
>
>         if (condition 1) {
>                 ... action 1 ...
>                 next;
>         }
>
>         if (condition 2) {
>                 ... action 2 ...
>                 next;
>         }
>
> instead of like this:
>
>         if (condition 1) {
>                 ... action 1 ...
>                 next;
>         } elsif (condition 2) {
>                 ... action 2 ...
>                 next;
>         }
>

Ok, I'll send v2 soon after addressing all of your comments
(including previous mails).

Thanks,
Namhyung
