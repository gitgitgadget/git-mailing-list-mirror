From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v5 0/3] interactive git clean
Date: Sat, 4 May 2013 09:06:39 +0800
Message-ID: <CANYiYbG5q7g-Gn-EGtsgS4XYLbQJuY6Pr_6FgKknADTD5_KoTg@mail.gmail.com>
References: <cover.1367551846.git.worldhello.net@gmail.com>
	<CAPig+cQALgr_VXwG5jBiFVTM627se8zQz7vsmF=A9OLcp_GT9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat May 04 03:06:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYQw1-0004pw-6E
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 03:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545Ab3EDBGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 21:06:41 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:48357 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762800Ab3EDBGk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 21:06:40 -0400
Received: by mail-wi0-f179.google.com with SMTP id l13so1116892wie.6
        for <git@vger.kernel.org>; Fri, 03 May 2013 18:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Rh22JHmQkus3Cr6vpuJcniKwWfFbGadmUvTFOfY2FHg=;
        b=WS+SWOu2YoT2y+LwM00+U5p2eOziz8B9m9MdD6/55aOk093765mn6jr99zJOE+6TkP
         vAE1FtwUxiR3qIEUG8VdQLDKdrlo0kQEQTFvNQzejqOgATrKRC9Xs1Hap7WCUlAhMhMa
         ZeamMSOyNVoySsAXi++I81h3vrOJD2eIrqbOcyoVu3S4ww5soSKAPmJ3RTEwIHxOtSzu
         0ReBAwCnFSl83GDn0CqaXiGPh/Z1OPge/9uKKzI2HMYc8Xe1ePTh5l6300LJXPT4tNEI
         EWOKQoK7yyxrh++QE68Xuv8v/sjJwtnCv8J2tWxcQifeOOb898NbtpnOo+OEakLMxdA7
         JWDg==
X-Received: by 10.194.133.198 with SMTP id pe6mr16652363wjb.9.1367629599263;
 Fri, 03 May 2013 18:06:39 -0700 (PDT)
Received: by 10.194.175.72 with HTTP; Fri, 3 May 2013 18:06:39 -0700 (PDT)
In-Reply-To: <CAPig+cQALgr_VXwG5jBiFVTM627se8zQz7vsmF=A9OLcp_GT9A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223348>

2013/5/3 Eric Sunshine <sunshine@sunshineco.com>:
>>     WARNING: The following items will be removed permanently. Press "y"
>>     WARNING: to start cleaning, and press "n" to abort the cleaning.
>>     WARNING: You can also enter the "edit" mode, and select items
>>     WARNING: to be excluded from the cleaning.
>
> The user intended for files to be removed when invoking git-clean,
> therefore WARNING that git-clean will do what was requested explicitly
> seems overkill. Along the same lines, the user asked explicitly for an
> interactive session (via --interactive), hence the above paragraph is
> effectively redundant since it does little more than tell the user (in
> a lengthy fashion) what he already knows (that the session is
> interactive). The short prompt printed after the listed files says the
> same thing (more succinctly), thus this warning paragraph is
> essentially superfluous.

I will try to make the header short, and not too scary.

>> In this confirmation dialog, the user has three choices:
>>
>>  * Yes: Start to do cleaning.
>>  * No:  Nothing will be deleted.
>>  * Edit (default for the first time): Enter the edit mode.
>
> What about the user who desires more traditional "rm -i" behavior in
> which he is prompted for each file? Should that be supported with a
> "Prompt [each]" option in the above menu?

I'd like to have a try. Maybe I can borrow code/interface from
git-add--interactive.perl to support both (batch exclude and confirm
one by one). For example:

*** Would remove the following item(s) ***

    files to be removed...     files to be removed...
    files to be removed...     files to be removed...
    files to be removed...     files to be removed...

*** Commands ***
    1. [y]es, clean    2. [n]o, quit    3. batch [e]xclude
4.[c]onfirm one by one
What now> e

input ignore patterns>> * ![a-c]*
    files to be removed...     files to be removed...
    files to be removed...     files to be removed...
Input ignore patterns>> ENTER

*** Would remove the following item(s) ***

    files to be removed...     files to be removed...
    files to be removed...     files to be removed...

*** Commands ***
    1. [y]es, clean    2. [n]o, quit    3. batch [e]xclude
4.[c]onfirm one by one
What now> y

Removing ...
Removing ...

> More generally, is this sort of modal edit mode desirable and
> convenient? Can the edit operation be combined with the top-level
> prompt? For example:
>
>   % git clean -i
>   file1 file2 file3
>   file4 file5 file6
>   Remove ([y]es, [n]o, [p]rompt, exclusion-list)? file[4-6]
>   file1 file2 file3
>   Remove ([y]es, [n]o, [p]rompt, exclusion-list)? p
>   file1 (y/n/q/!)? y
>   file2 (y/n/q/!)? n
>   file3 (y/n/q/!)? y

What If there is a file named 'y', and the user want to exclude it,
and press 'y' as a pattern.

--
Jiang Xin
