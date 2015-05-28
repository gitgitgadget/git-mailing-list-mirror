From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] send-email: allow multiple emails using --cc --to and --bcc
Date: Thu, 28 May 2015 10:45:06 -0700
Message-ID: <xmqq382giokd.fsf@gitster.dls.corp.google.com>
References: <1432809733-4321-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1432809733-4321-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 19:45:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy1rn-00068y-MZ
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 19:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098AbbE1RpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 13:45:11 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37399 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754029AbbE1RpK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 13:45:10 -0400
Received: by igbsb11 with SMTP id sb11so45372147igb.0
        for <git@vger.kernel.org>; Thu, 28 May 2015 10:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=PuqYrRvCqi5Sa0kLLmYBwrzXsK4m9hIcNhxngAnaGTI=;
        b=BEuq0UF6IR8OzXjGgFgcTc3AyRjRbjyQr4PEGBAEob/cdmoYJEqQ9SKaE2X8JR90sh
         W/R1XNafbvaTGeGCO92k0vso2FJYKphIXTfHhItwC/TcVzCoD3KojGa1A+lOIfVMhQ6m
         WI9YHEDNprhfXg/SbH/e5f4HwyB/8kmqmSRzUY1p9tSfZA5KSG+s72XRKmiUbtKh7Txm
         gMmBwZKkkH0XPl7735bZkcYiJ/xZzzpSu862JLsQXleSeTBBJHjCUwIpojNrGbPPSoNc
         iIoGeUFFiq2/76Q7USbqmAE1oROebFUnz/orggrTXsCt87mRkYH5fye9824t01qkFhrc
         NoGA==
X-Received: by 10.50.67.146 with SMTP id n18mr7139617igt.40.1432835109600;
        Thu, 28 May 2015 10:45:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id t7sm4781864ign.8.2015.05.28.10.45.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 May 2015 10:45:08 -0700 (PDT)
In-Reply-To: <1432809733-4321-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Thu, 28 May 2015 12:42:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270169>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> From: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
>
> Add the possibility to use a list of emails separated by commas
> in flags --cc --to and --bcc instead of having to use one flag
> per email address.
>
> The use-case is to copy-paste a list of addresses from an email.
> This change makes it so that we no longer need to cut the list.

s/Add the possibility to use/Accept/;

I am not sure "having to use" is a good characterization.

    Accept a list of emails separated by commas in flags --cc, --to
    and --bcc.  Multiple addresses can already be given by using
    these options multiple times, but it is more convenient to allow
    cutting-and-pasting a list of addresses from the header of an
    existing e-mail message, which already lists them as
    comma-separated list, as a value to a single parameter.

perhaps?

> The format of email list handled is basic for now:
> 	$ git send-email --to='Foo <foo@example.com>, bar@example.com'
> We thought it would be nice to have a "first-step" version which works

Separate displayed material from the body text with blank lines, i.e.

        The format of email list handled is basic for now:

                $ git send-email --to='Foo ...

        We thought it would be nice to have a "first-step" version which works

"We thought"?

> before handling more complex ones such as names with commas:
> 	$ git send-email --to='Foo, Bar <foobar@example.com>'

Shouldn't this example send to two users, i.e. a local user Foo and
the mailbox 'foobar' at example.com whose human-readable name is
Bar?  If so, that is a bad example to illustrate the aspiration for
the finished patch?

> This artificial limitation is imposed by 79ee555b (Check and document
> the options to prevent mistakes, 2006-06-21).

It is unclear from this sentence what you are doing with the
limitation (is it artificial?  do we have to call it artificial?).
The reader of the log message cannot tell if you are keeping it, or
if you are lifting it with this patch.

> Signed-off-by: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
> Signed-off-by: Jorge Juan Garcia Garcia <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> Contributions-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>

You touched the patch or sent it out, so you need to give your own
sign-off.

Thanks.
