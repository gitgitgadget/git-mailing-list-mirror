From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] Allow combined diff to ignore white-spaces
Date: Thu, 14 Mar 2013 16:51:10 +0100
Message-ID: <CALWbr2yU6Nwg3_7CD6XhvruaKrhvXbRS0bO6nO+GgavjO59+jQ@mail.gmail.com>
References: <7v38wdc4ei.fsf@alter.siamese.dyndns.org>
	<1363209683-10264-1-git-send-email-apelisse@gmail.com>
	<51417773.5000401@viscovery.net>
	<7v7glayp4l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 16:51:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGARP-0002sR-Ia
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 16:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933969Ab3CNPvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 11:51:12 -0400
Received: from mail-qe0-f45.google.com ([209.85.128.45]:44118 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933961Ab3CNPvL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 11:51:11 -0400
Received: by mail-qe0-f45.google.com with SMTP id b4so1339385qen.18
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 08:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Lq4ftXiZ8RomL32G0NuTcKYPvzQ+pPSPWpDyj3f6Rn4=;
        b=eyVo6fKioh3YOys8PHb2c6N6O6MAUlpWmu331WFFOZIe+k3/qdmrMFAf9S80ftq4lc
         E70F+PX2FJhUxEcD2A1xj6L9YVizZv0vpgfwbGBDCQWFWvLrYQq8DS8PB8f97S33q3hw
         SFSppHgCLE4h3KyCMdWfWN8F2ZcewOh98fy5cM5ZirCK455hyrpDoStfzzfXE9G5AY3L
         P31Zl+nyJ8v2cYuE8/mheRbg2EsYpJNe582Gn7xNTy6seOh21jvXOq0NnVPYGSGDEGJL
         4TjS3tZXT9ME+iMFhqOWoaJe7MmzQYevjZUazmjSqlgAf67Pvqp96lP5WVr817CYf68t
         GsLQ==
X-Received: by 10.49.95.138 with SMTP id dk10mr3164402qeb.43.1363276270602;
 Thu, 14 Mar 2013 08:51:10 -0700 (PDT)
Received: by 10.49.70.163 with HTTP; Thu, 14 Mar 2013 08:51:10 -0700 (PDT)
In-Reply-To: <7v7glayp4l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218149>

On Thu, Mar 14, 2013 at 4:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> This form of 'echo' is not sufficiently portable. How about:
>>
>>       tr -d Q <<-\EOF >test &&
>>
>>       always coalesce
>>       eol space coalesce Q
>> ...
>>       EOF
>
> Much better.
>
>>> +test_expect_success 'check combined output (no ignore space)' '
>>> +    git show | test_i18ngrep "^-\s*eol spaces" &&
>>> ...
>>> +    git show | test_i18ngrep "^--\s*always coalesce"
>>
>> This loses the exit code of git show. We usually write this as
>>
>>       git show >actual &&
>>       grep "^- *eol spaces" &&
>>       grep "^- *eol space coalesce" &&
>>       ...
>>
>> (Same for later tests.)
>>
>> There is nothing i18n-ish in the test patterns. Use regular grep.
>>
>> BTW, there is compare_diff_patch() in diff-lib.sh. You can use it to
>> compare diff output to expected output. Then you do not need a grep
>> invocation for each line of the test file.
>
> All good suggestions.  Thanks.

OK Very good,
I will resubmit tonight. I was indeed not really sure about the best
way to test here. Thanks for the tips and confirmation !

Cheers,
