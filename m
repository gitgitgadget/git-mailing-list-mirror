From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] branch.c: simplify chain of if statements
Date: Mon, 17 Mar 2014 04:08:41 -0400
Message-ID: <CAPig+cTff4gDuUieqDkOxbFtk2vLX+fMgCFA_7ZHTMYK2rAuQA@mail.gmail.com>
References: <1395004962-18200-1-git-send-email-dragos.foianu@gmail.com>
	<vpqsiqhz3sz.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dragos Foianu <dragos.foianu@gmail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 17 09:08:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPSbJ-0005EH-0w
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 09:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbaCQIIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 04:08:44 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:59124 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932175AbaCQIIm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 04:08:42 -0400
Received: by mail-yk0-f177.google.com with SMTP id q200so14129036ykb.8
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 01:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Nx8+rHK5RM+WM2RUT6/4PhspP8pCOqS4z8wjuewrZ0Y=;
        b=iCNIFQsQhOqIGZntaFHJKH3vYQCM1OPb5x9ea+RkYVskE+oAVq6rR9ogRYGB83PwSI
         0xxajmW54LQdiLRGBHRkARnQrS073HcbMXMVQ1e0lIk5jvZt4tPB+b6N/lbPBAZTU/yM
         R19LTwvcVPfQh1PR7LIGlEwIs1NLGaraXPRQ30FLc9gEyw0RaiZEZrXs8cr1FjAPgHvB
         2TPofC27E/radr1XnUdf+R2wq1+fUhLC5CRIA0AyGuAQMj3ZcVO0rrakaXZE3kG5vWCU
         N+VQifs5RbXScennrn4Q0v3IfnmIrBM/an2Jt2GF1p3MzSaIoXlJMF9Bt8kxW1+W6Wi3
         50dw==
X-Received: by 10.236.132.48 with SMTP id n36mr11421yhi.149.1395043721792;
 Mon, 17 Mar 2014 01:08:41 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Mon, 17 Mar 2014 01:08:41 -0700 (PDT)
In-Reply-To: <vpqsiqhz3sz.fsf@anie.imag.fr>
X-Google-Sender-Auth: R8ZDjVoXw9dM0aMOsvyZeHgxABA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244231>

On Mon, Mar 17, 2014 at 3:23 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Dragos Foianu <dragos.foianu@gmail.com> writes:
>
>> +     const char *verbose_prints[4] = {
>> +             "Branch %s set up to track remote branch %s from %s%s",
>> +             "Branch %s set up to track local branch %s%s",
>> +             "Branch %s set up to track remote ref %s%s",
>> +             "Branch %s set up to track local ref %s%s"
>> +     };
>> +     char *verbose_rebasing = rebasing ? " by rebasing." : ".";
>> +
>
> This seems to be a "lego construct" that makes translation harder: are
> you sure that the "by rebasing" will be at the end of the sentence in
> any languages?

Read this thread [1] for more details about why this approach is problematic.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243793/focus=243824

> Also, this lacks the _() on verbose_rebasing, which isn't translatable
> anymore after your patch.
>
> I personnally think that the table-driven approach is wrong here, it
> makes the code shorter but much harder to read.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
