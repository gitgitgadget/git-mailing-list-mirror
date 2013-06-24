From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] commit: make it work with status.short
Date: Mon, 24 Jun 2013 21:09:41 +0530
Message-ID: <CALkWK0=2cJZDZTirZqYrfc9yTWaX8x=2G2xC_fhW53+GDDZ+BQ@mail.gmail.com>
References: <1372077912-18625-1-git-send-email-artagnon@gmail.com>
 <1372077912-18625-3-git-send-email-artagnon@gmail.com> <7v38s7czc9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 17:40:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur8sV-0003TP-22
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 17:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182Ab3FXPkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 11:40:22 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50680 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab3FXPkW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 11:40:22 -0400
Received: by mail-ie0-f174.google.com with SMTP id 9so25219999iec.33
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 08:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5ae2BnlwA4fBxLZ6Oi5DejZgxD8mQOibqrAEP8v61AE=;
        b=z6BkJI5ZmxapVr3ouNaHK4K+zpzcf6/3nx7x9PU57zTaiiFYDrsTiENaplm5fkTVZI
         rcHRO1Cob6vgZxRuulZrGjoFAVD5kwm7z+QMM/7f6jzDZG5WE2Jqfdo6ZuJLA51gWAPy
         TsK0xvsmIB4K5cLeHMiAZmj6MhvcEB5+0dlji8WDoIgJCW8KnYRvNvf3jLSaOVms5Xvw
         sKLjD/3Vai6ObJdF1Q/6/ukPdkl6Z3JEET3kDXVkP0zlC2Hes82zA/B5Mdhg9hFTFjH8
         tH0+4Yr435F8twhV7XMbMVjqrRWKkk3F4piNGmWCXyxGLhA6XwQ1XlptTF2bPN1NC3Er
         2TWw==
X-Received: by 10.42.190.74 with SMTP id dh10mr11975021icb.35.1372088421721;
 Mon, 24 Jun 2013 08:40:21 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 24 Jun 2013 08:39:41 -0700 (PDT)
In-Reply-To: <7v38s7czc9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228840>

Junio C Hamano wrote:
> As I said in the other message, I'll revert the merge of the topic
> branch from 'master' for now, and queue this on top of the topic so
> that we will have the preventive fix when the topic is in a better
> shape for the other possible breakage on the "--branch" thing.

Thanks, a quick revert is probably the best way to go.

> That is, "git commit --short/--porcelain/-z" has these three
> possibilities:
>
>  - work (ignoring these options);
>
>  - work (showing the template in some kind of "short" format); or
>
>  - error out (clearly indicating that we did *not* make a commit).

Actually, I had a different idea: to make short (and porcelain, by
extension) set s->commitable correctly.  From a quick analysis, it
shouldn't be a hard problem.  Then, we can make

  $ git commit

display short-form status when there is nothing to commit.
