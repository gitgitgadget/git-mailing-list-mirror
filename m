From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: git send-email Connection Closed
Date: Wed, 15 Jul 2015 18:00:35 -0400
Message-ID: <CANoM8SXv22_CGpK+5b7rzSstkpevPt_KmCW9ZHQNS-2wBmEEVg@mail.gmail.com>
References: <CAFow2F9ZFNcBdoc7YTCeGT_PA-UvMyfcKWE4K4ufGMyFXJd5Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Juston Li <juston.h.li@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 00:01:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFUjc-0001D6-9n
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 00:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147AbbGOWA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2015 18:00:56 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36098 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbbGOWAz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 18:00:55 -0400
Received: by oibn4 with SMTP id n4so38302924oib.3
        for <git@vger.kernel.org>; Wed, 15 Jul 2015 15:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ueZMLM51cmuhkoRkeysS1ARgIwvbVts4hJyLTf4CsyQ=;
        b=CJbQvG3bkpkc9VlvrtI15ZtVz5ZXUHU0hM6QhPcJ3jffbz4A5V3tDcgHkw1wPvMlaP
         ley3VSP3LIaKBPM2vCSW2HGsVlHyvOfkdmfYoIKS12JqusfpVztpmRvBJxTodoLO6iXi
         xnF/eheGVXIOhwSpP7YdcyGxbJzUQzKgNHj3Ef2tyldwmkISgAFlbJI0psRLLXFgcvhW
         rKkFWlbfrz91MwV83LNnWvqZNxqS11cq3AnJJ0Xf+qb+FHjr70U4+UHUVosHBlc5SRAC
         EWHjjXv4EaRdkYMcCHDmD945iSl6ZVJaqZHEsjsMFSzg9HuZ3lpD0ibZcz4g+N6jbFlw
         1BqQ==
X-Received: by 10.182.71.72 with SMTP id s8mr5968438obu.80.1436997654826; Wed,
 15 Jul 2015 15:00:54 -0700 (PDT)
Received: by 10.202.232.213 with HTTP; Wed, 15 Jul 2015 15:00:35 -0700 (PDT)
In-Reply-To: <CAFow2F9ZFNcBdoc7YTCeGT_PA-UvMyfcKWE4K4ufGMyFXJd5Uw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273999>

I believe that this is due to gmail not allowing the email.  I think
there are two ways to fix this:

1.  Temporarily enable less secure apps for your gmail account while
you send the email [see
here](https://support.google.com/accounts/answer/6010255?hl=en).
2.  Setup multi-factor authentication on your account and create an
app specific password for git-send-email [see
here](https://support.google.com/accounts/answer/185833?hl=en)

Obviously the second method is more secure.  I have had success with
both of these techniques.

On Wed, Jul 15, 2015 at 1:11 AM, Juston Li <juston.h.li@gmail.com> wrote:
> Hello
>
> Recently, I have had trouble using git send-email to send a patchset.
> After the confirmation to send the email I get the following:
> Send this email? ([y]es|[n]o|[q]uit|[a]ll): y
> [Net::SMTP::SSL] Connection closed at /usr/lib/git-core/git-send-email
> line 1320.
> fatal: 'send-email' appears to be a git command, but we were not
> able to execute it. Maybe git-send-email is broken?
>
> This message first appeared when I tried to send a 19 commit patchset
> via 'git send-email HEAD~19'. It also fails when I try to format-patch
> and send the patchset separately via 'git send-email 0001...'
> Oddly enough, it works when I send anything other than 19 commits
> for example 'git send-email HEAD~1' or 'git send-email HEAD~20'
>
> I thought it was something with the gmail servers but I was able to send
> the patchset by downgrading a couple perl packages
> warning: downgrading package perl (5.22.0-1 => 5.20.2-1)
> warning: downgrading package perl-net-ssleay (1.68-2 => 1.67-1)
>
> Note perl-net-ssleay depends on perl 5.22 so I can't isolate which
> package but I can consistently get the failure with the newest packges
> and it works fine with the downgraded packages.
>
> Running Arch Linux
> git 2.4.5
> perl 5.22.0
> perl-authen-sasl 2.16
> perl-mime-tools 5.505
> perl-net-smtp-ssl 1.03
>
> .gitconfig
> [sendemail]
>     smtpEncryption = tls
>     smtpServer = smtp.gmail.com
>     smtpUser = juston.h.li@gmail.com
>     smtpServerPort = 587
>
> Regards
> Juston
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
