From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git log fails to show all changes for a file
Date: Wed, 15 Jul 2015 11:11:32 -0700
Message-ID: <CA+55aFw=PJtc7jXLUx+tJhAeVO3vpQjsd+oYW+OwCU20_Qft-w@mail.gmail.com>
References: <20150714073035.GA22707@aepfle.de>
	<20150714074508.GE1451@serenity.lan>
	<20150714075955.GA24577@aepfle.de>
	<CA+55aFzPvwAghGtA-WH8i1PcNe55XORokaXF9hNu7OUXBx++6Q@mail.gmail.com>
	<xmqq8uahxu3e.fsf@gitster.dls.corp.google.com>
	<CA+55aFy8urE+0w7mfgywcAnyoUu+6LMz-GGaOrUQYJ59gT9FfA@mail.gmail.com>
	<xmqqy4ihwbdr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Olaf Hering <olaf@aepfle.de>, John Keeping <john@keeping.me.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 15 20:11:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFR9g-0000G9-4F
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jul 2015 20:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbbGOSLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2015 14:11:34 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34205 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbbGOSLd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 14:11:33 -0400
Received: by igvi1 with SMTP id i1so83320281igv.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2015 11:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=kcRmXth8oDDgrkjQzrh5W1IPEXndR9JpCBo9TnT87Ek=;
        b=WZAV8YLQgQQYtayXgz/S+jFbj0aGIoL7wbPjmD9FRVsPNbGrXFBiGZzc9E7e69gGpE
         oXLSyRKD3JmogtxC+vzPDdupGerKV5uj9Qx0N/8+zJYdiiI5Oe25rU8IaKLeAQ1KnrVL
         1glIi9k34XioKfuulwDHrlSbKxt/Tw2sl/xRvu3WmTW61KzJYQqSp9YS2YZnmP50QfIB
         PMWjy0hV8jHXS0SXEUOp4hMB76wa1h9SAbj92dLKRZLCGFuae7Bs8DfQswLgaNPZ/opG
         So0QOiv0sR1vSjdleESo4wAOseU0O+jXzBdfjlDwZ7OtFRK+59bWrmPJwd5BQT7zINMc
         PDkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=kcRmXth8oDDgrkjQzrh5W1IPEXndR9JpCBo9TnT87Ek=;
        b=NBdE/JAXJAoihRKqeOtHQcydz1bthQkOchqcN+PpCXycY61vV4IxguTuKdn1fzOtq/
         /4uRbFMPCalnXSN9WJd36/53/C4lblwsFPy7hCXHXISj0Nu19ZUXT37JOlduTnHHUOlA
         IIA9ikxOKDktNmjEbhO1xMtxsaZW5K0ZM1TVg=
X-Received: by 10.107.129.24 with SMTP id c24mr7388561iod.158.1436983892697;
 Wed, 15 Jul 2015 11:11:32 -0700 (PDT)
Received: by 10.36.78.7 with HTTP; Wed, 15 Jul 2015 11:11:32 -0700 (PDT)
In-Reply-To: <xmqqy4ihwbdr.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 6K3H0Vb015cA2ezzSTKWLQfQTh4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273991>

On Wed, Jul 15, 2015 at 10:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>  * When '-p' is given, we show only diff with first-parent by
>    default, regardless of the traversal (i.e. --first-parent option
>    currently controls both traversal and patch display, but in the
>    new world order, it reverts back to purely a traversal option).

So this is a suggested change to "-p -m" behavior?

Yes, that sounds sane. The current "-p -m" behavior is not useful at all.

So if I understand rightly, we'd have:

 "-p" would be what is currently  "-p --cc"
 "-p -m" would be what is currently "-p --first-parent"
 "-p --no-show-merge-diffs" would be what is currently "-p"

and the rationale would be that

 (a) the current "-p" is hiding things, and while you can add "--cc",
that requires that you really understand what is being hidden, which
is a bad default (the complaint that started this discussion)

 (b) the current "-p -m" is useless crazy stuff, and you'd rather use
it for something that you actually find very common and useful

If so, I agree entirely.

              Linus
