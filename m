From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] merge-recursive: separate message for common ancestors
Date: Sun, 5 Aug 2012 20:55:57 +0200
Message-ID: <CAN0XMO+j08fV-5+nNrVQAteB3VStBjqvvjMzRq=6wcbg8OR+xg@mail.gmail.com>
References: <1344189398-27127-1-git-send-email-ralf.thielow@gmail.com>
	<7vehnl41r2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, worldhello.net@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 20:56:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy5zq-0000Xg-HY
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 20:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859Ab2HESz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 14:55:59 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:62175 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754844Ab2HESz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 14:55:59 -0400
Received: by wibhm11 with SMTP id hm11so1052823wib.1
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 11:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bAn3ulpcTXAu8r8t/k9jcp5UDT7tHOMyO6OD25OMwU8=;
        b=gij4vdvpFTcO55oVUrqvScTWhahVb1y6xFcwvuVRSsYo0Y4wJlX4Qj8T597Ec1ERAD
         hW6OcbRHIu/Mo9kSnS9+CkWsH7Uh6y4BhVOQ4DVedU55VzPa7V8hyqDL2ruFnMR6KfaD
         9UQ5G46rdAHzEl2YZsphlxZODb6WNtM5TwwQ9ANXuHq2J3Ym8J9rNXmTAq0i1ykl4pMV
         AhHvaICb3AjueeP53+824LAeyXcTPwZz1J5oF8ONXQf9oB4yY6V6WKsiX9bojH3hZlbH
         hfat0ECEUbhkAZexFffFX3gtc5p/BCUDniaq26Bn7LhHdgJIzBhYfO4GhV5H4DpcCoxm
         FIrQ==
Received: by 10.216.42.65 with SMTP id i43mr4313482web.208.1344192957542; Sun,
 05 Aug 2012 11:55:57 -0700 (PDT)
Received: by 10.194.26.33 with HTTP; Sun, 5 Aug 2012 11:55:57 -0700 (PDT)
In-Reply-To: <7vehnl41r2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202916>

It would be nicer for translators to have two messages.
In the end it's just a separation for singular and plural as it's
done in diff.c (e.g. Q_(" %d file changed", " %d files changed", files)).

On Sun, Aug 5, 2012 at 8:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> The function "merge_recursive" prints the count of common
>> ancestors as "found %u common ancestor(s):". At least for
>> better translation, we should use a singular and a plural
>> form of this message.
>>
>> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>> ---
>
> Thanks.
>
> In your "At least" above, I am getting an impression that either (1)
> you think the updated two-message solution is still not ideal for
> some reason, or (2) you think the change not only helps translation,
> it also helps something else.  But I cannot quite guess which.  If
> it is (1) I am not sure what you are not exactly happy about, if it
> is (2) I am not sure what other problem the change helps.
>
> I am a bit puzzled by the log message, but the change makes sense to
> me otherwise.
>
>>  merge-recursive.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/merge-recursive.c b/merge-recursive.c
>> index 8903a73..39b2e16 100644
>> --- a/merge-recursive.c
>> +++ b/merge-recursive.c
>> @@ -1915,7 +1915,10 @@ int merge_recursive(struct merge_options *o,
>>       }
>>
>>       if (show(o, 5)) {
>> -             output(o, 5, _("found %u common ancestor(s):"), commit_list_count(ca));
>> +             unsigned cnt = commit_list_count(ca);
>> +
>> +             output(o, 5, Q_("found %u common ancestor:",
>> +                             "found %u common ancestors:", cnt), cnt);
>>               for (iter = ca; iter; iter = iter->next)
>>                       output_commit_title(o, iter->item);
>>       }
