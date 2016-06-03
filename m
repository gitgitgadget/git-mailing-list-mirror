From: Stefan Beller <sbeller@google.com>
Subject: Re: RFC: have a config option for running submodule update after
 checkout <revision>
Date: Fri, 3 Jun 2016 16:30:16 -0700
Message-ID: <CAGZ79kYC9Pub1RhcedLBqxK+pBunmN1DwjmWf83MUbY9pdvwhQ@mail.gmail.com>
References: <CAGZ79kb9xHNYysb6gS9nPWvFW3cgcW-ey+5qyfTHTPGkT0fNfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 01:30:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8yXn-0005Hr-IU
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 01:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbcFCXaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 19:30:19 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:32984 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbcFCXaS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 19:30:18 -0400
Received: by mail-qk0-f173.google.com with SMTP id n63so63378181qkf.0
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 16:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=7SvNWpnllnBHhbsmEGDs5KyXHItDk1y/7txKYP3acxc=;
        b=H0qETiUblwZ3Of90/qnWPMVMUiSkjpDF0YOLiR8hcf6JledkaUcixzThv+OlSGv2BM
         n/KE/i6Y4OSdhehYjS06i0FuRGZhoMLwFO7Ap5IgrvoNlEaTN90K32uZ8fuRKDiWE/U4
         hoI5cXqlfSrWox88i3UUjZH0KWrLzURYGIcelbPFADNwP3AWVnT6IJxm3yaNbw9VTZFi
         IGWbfgaqc+qUjQOcZP5npBFXw3YOGW3lHXtNTJ7+1MCIDTO9VmGm2e1BlH/oM3DwvtQ7
         jdOX9Y+snrC22MYho9NmFUK+hB4m9tQRr8tgfHMAWmOqIBrL4CwvyqKtJ9H1xG1Noasn
         vzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=7SvNWpnllnBHhbsmEGDs5KyXHItDk1y/7txKYP3acxc=;
        b=IhqzoxJccfY6rNf6uerzVp14lkS6yu2KODMlvIhxhrOPkQQ0q31Mio5HxlLz7f7IMA
         t+kZQuOD7ETpi0qhd5nazM6o+TWt7L2DnoJm05ujfTyRoB/F9HNy6rlkoGr5NY3MZstM
         Esjh3w5ZeOpZqs3fE4YmZklC5oGpR8dAUbKFJUa24FFN2yvFUYA0nF13qGF02M5iTjKt
         YiltjM4JXykRMXPFqnbmfIxNgOqFDCsUo3/m0NfvYZ0Z58sEwVji/kiR2T6w0cf/u5aG
         RLbh/QLdP3I5J6Y1Brl1Q5rfLd1C9lSNc41HQ01Jz8wC44gjGtZKyZQc82So2Ecmdg7h
         XNRA==
X-Gm-Message-State: ALyK8tJ6ZNVaNGH5zkRdtB8KLRAyBUa6qwoRQyJSb5g2qBHKNXoTplLQ5un9If7H1SEeYMRFfI47JPgexBpZnhdw
X-Received: by 10.233.223.5 with SMTP id t5mr4815245qkf.35.1464996616805; Fri,
 03 Jun 2016 16:30:16 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Fri, 3 Jun 2016 16:30:16 -0700 (PDT)
In-Reply-To: <CAGZ79kb9xHNYysb6gS9nPWvFW3cgcW-ey+5qyfTHTPGkT0fNfw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296428>

On Fri, Jun 3, 2016 at 3:53 PM, Stefan Beller <sbeller@google.com> wrote:
> disadvantages:
> * it's not `done right`, i.e. dealing with gitlinks in read-tree/unpack-tree
>    but just another command chained after checkout, so we would do that
>    for pull too eventually?

Well one argument against the disadvantage is that we have `pull`
already, which is
essentially fetch and merge as a chain of commands and nobody bothers
about having
a chain of commands.

>
> What do you think?
>
> Thanks,
> Stefan
