From: Stefan Beller <sbeller@google.com>
Subject: One whitespace breaks sending mail (using mailrc aliases wit send-emal)
Date: Wed, 16 Mar 2016 18:28:59 -0700
Message-ID: <CAGZ79kbRdPMkbs_-BGhCQ44hOsccG3aX16RJpE3ZHcBmDz40zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 17 02:29:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agMkM-0007Fq-I4
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 02:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756118AbcCQB3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 21:29:01 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:34626 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbcCQB3A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 21:29:00 -0400
Received: by mail-io0-f180.google.com with SMTP id m184so81486055iof.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 18:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=b/d0cGuxkY4CPZ6gX+xg4SaRghfLwkw/IBluJMj3qG4=;
        b=Xt6fStfH97j+gDOVb8RxisB0sOE4CVJdBgNfNJaK+P3AVx6MMmizaqQIkdTCOs/3O6
         FwdHd887NSV/2MiTtnDTCYDnglUAWwHC/Ndw7aklE1bI0oFeEAWSrRduyqLARgrwTf9G
         Oy6jYQxgynm24xNfyMMfb8L7xsRWJ7LYupQ/cq9PZ66TvPIrIUUAL1OIW7O2GH/sHVNq
         SWPv1EGnI8UTNw618L62PE7E3r1qVsbkZOggjmngT8OTIFY0PlCTLgL5Z9TomJbcK/oH
         vD/lhVuB2YEAu420S8oUxNQthNWgMpZUzIv0ToTyJ8+9wCWuC6OTZIcEizx2/Un4m9OG
         Wo1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=b/d0cGuxkY4CPZ6gX+xg4SaRghfLwkw/IBluJMj3qG4=;
        b=RZqo4pPCQk4u1kHGdSw9BCoEKUQML25HelSHkzyTHmi9OIfqwlBs36xQNJmWzaqNIQ
         7USOWU86z+9fooBC6oK5xpTKUt7XohF7crjVLrw8kcUIQaR8DtI19M1sfBzn2JFzUd6L
         shYg7KaaUlT7Men68Fm/V0ZteEwUcWFHJ86rovbbabKBbhTJfZ0ge58+S2BjSS/smo80
         FUYMpaUtTOxVmTYBxdFmuNz/Pc43uRR7J+kp71UIbTC9r3x8UiMV3524lprCVfkyHPUo
         TytjAsbzdIXVAqIL6qkI50uSPmcd7NGH9Nnfck5nqTn7wslpgDdDf1uY4cKRXvmoLnxB
         hBnA==
X-Gm-Message-State: AD7BkJJhUodqMBxZ31bRLeVJouVwilrIxpjEwmfWoHhIXx2Wb1vos91k8+KJl9p8XqSHpeSOrBxzuOY77WbwkE88
X-Received: by 10.107.135.96 with SMTP id j93mr6840422iod.96.1458178139724;
 Wed, 16 Mar 2016 18:28:59 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Wed, 16 Mar 2016 18:28:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289068>

To reproduce:

$ git config sendemail.aliasesfile ~/.mailrc
$ git config sendemail.aliasfiletype mailrc
$ echo "alias zzz_wrong_entry jon@do.e "
# notice the white space at the end of the alias

$ git send-email 0001-rebase-x-do-not-die-without-i.patch --cc=zzz_wrong_entry
Use of uninitialized value $alias in hash element at
/usr/local/google/home/sbeller/libexec/git-core/git-send-email line
847.
Use of uninitialized value $alias in hash element at
/usr/local/google/home/sbeller/libexec/git-core/git-send-email line
850.
Use of uninitialized value $alias in hash element at
/usr/local/google/home/sbeller/libexec/git-core/git-send-email line
850.
Use of uninitialized value $alias in hash element at
/usr/local/google/home/sbeller/libexec/git-core/git-send-email line
850.
Use of uninitialized value $alias in hash element at
/usr/local/google/home/sbeller/libexec/git-core/git-send-email line
851.
Use of uninitialized value $recipient in substitution (s///) at
/usr/local/google/home/sbeller/libexec/git-core/git-send-email line
1036.
Use of uninitialized value $recipient in pattern match (m//) at
/usr/local/google/home/sbeller/libexec/git-core/git-send-email line
1038.
Use of uninitialized value $address in pattern match (m//) at
/usr/local/google/home/sbeller/libexec/git-core/git-send-email line
894.
Use of uninitialized value $address in substitution (s///) at
/usr/local/google/home/sbeller/libexec/git-core/git-send-email line
896.
Use of uninitialized value $params[0] in pattern match (m//) at
/usr/share/perl5/Email/Valid.pm line 79.
Use of uninitialized value $address in concatenation (.) or string at
/usr/local/google/home/sbeller/libexec/git-core/git-send-email line
918.
error: unable to extract a valid address from:
What to do with this address? ([q]uit|[d]rop|[e]dit):

The stack trace doesn't even show the wrong address, so debugging that was hard.
Not sure I am asking for help, as I found the problem and could fix
it, but maybe we can
improve the error message (I have no knowledge about perl, so I may
not be super helpful there)

Thanks,
Stefan
