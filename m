From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 14/14] pull --rebase: error on no merge candidate cases
Date: Fri, 22 May 2015 21:48:52 +0800
Message-ID: <CACRoPnR=ajnzvX42jwSpaYE1fgd2J-Ph7+_s=ch=OQJf5FRpQQ@mail.gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
	<1431961571-20370-15-git-send-email-pyokagan@gmail.com>
	<CAGZ79kbhA2+AJ1Vtz6khX5uEBCCUBUuXhpBezZApZsC_txhewA@mail.gmail.com>
	<5fcd2fa185fab4c64939ad09eb10e6d5@www.dscho.org>
	<xmqqoalg8re2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Git List <git@vger.kernel.org>,
	Stephen Robin <stephen.robin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 22 15:49:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvnJr-0000AR-JO
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 15:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422664AbbEVNsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 09:48:54 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:32866 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422655AbbEVNsy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 09:48:54 -0400
Received: by lbbzk7 with SMTP id zk7so13358664lbb.0
        for <git@vger.kernel.org>; Fri, 22 May 2015 06:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Vd6mm31J7vIAWtNdH9/znSjBJplstaA7B9UCp4274dU=;
        b=Nyn7J/VncYzmsSSSWs93LS/NX91GGgyF4q9BF9zzezmHM4HbTbZiFlg6JuD7F63k0r
         iehTh3qw9caSGmscmjUQhs3IoIcHrNIqIp1BXj7CRu9w+r7zCPTynLmYDEJpe7v/ciGZ
         2b3RlTczBg9diz/uvy1mNKN9SpI0RECgWGXvb/dXzJj9OZ1C8YkWj/qF+iW8IdLRHizY
         khs2vcbDLrjKS5RdsoekwBguhOCrF98UyiNGckjsrczeQUE1hVII8ESLMmAafORzPzaO
         SxXOS2K2R9s/nzNPD8dK8Oy6Y5sdwg6Q7gTwYO3NUlOlTj75E0yphAolxDIMzNNpwJ5/
         f9Ug==
X-Received: by 10.152.87.204 with SMTP id ba12mr6607512lab.35.1432302532590;
 Fri, 22 May 2015 06:48:52 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Fri, 22 May 2015 06:48:52 -0700 (PDT)
In-Reply-To: <xmqqoalg8re2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269717>

On Wed, May 20, 2015 at 12:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>>>> -               fprintf(stderr,
>>>> -                       _("There are no candidates for merging among the refs that you just fetched.\n"
>>>> -                       "Generally this means that you provided a wildcard refspec which had no\n"
>>>> -                       "matches on the remote end.\n"));
>>>> +               if (opt_rebase)
>>>> +                       fputs(_("There is no candidate for rebasing against among the refs that you just fetched."), stderr);
>>>
>>     The puts() function appends a <newline> while fputs() does not.
>
> Yup, so this update makes the command spew unterminated lines, which
> not something intended...

Ugh >< Will put the "\n" back.

And yes, I used fputs() because it seems wasteful to use fprintf()
which will scan the string looking for any '%' formatting units, when
we know there aren't.

I will also update 05/14 to use fputs() as well where appropriate.

Thanks,
Paul
