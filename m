From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v3 16/19] pathspec.c: move reusable code from builtin/add.c
Date: Sat, 29 Dec 2012 00:40:12 +0000
Message-ID: <CAOkDyE_XiMV+apb4mo1T6Ukp72YSdh6LgbnXsxQb-i19Lu+kOg@mail.gmail.com>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
	<1356575558-2674-17-git-send-email-git@adamspiers.org>
	<7v8v8hj4t0.fsf@alter.siamese.dyndns.org>
	<CAOkDyE8vSyT=eJ4FxRwYgz7Jzqu1+0LSzxtq9iSSzJEgTD1M0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 01:40:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TokTZ-0004zd-QF
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 01:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126Ab2L2AkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 19:40:15 -0500
Received: from mail-we0-f170.google.com ([74.125.82.170]:57698 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077Ab2L2AkO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 19:40:14 -0500
Received: by mail-we0-f170.google.com with SMTP id r1so5139716wey.15
        for <git@vger.kernel.org>; Fri, 28 Dec 2012 16:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=2j4d2EEMDoXS4kgnfYaqyF6p2RC6OCgvrsDgr6hbXWU=;
        b=W+XBTVJ1g6FmCZOYZVXsL+pBBAzxkC2HAzQUgT2LtY/TCWCFdQECPEln2RWAo8nKKX
         KvxEnOQsakVHdwWya4n6JOlTbCNf+0KsC+kUdPlDsP7uLokEqAUnml05CVRATxcoR2L4
         6OKZDShwkqROcQuhyunSA+9AYsRBAc51uXOJ2nt/BMhEWau9tgjZnspDgvEOmsnFRmra
         P/SI7SLJVL7RRyrx8xhKp2tsahlAyzRSrdjzSnW+WsSwWpxIRfeOPnof2abjWAPKufFG
         2PgVPL/5MdBx2tjs8h9lUlzUvVqtB+HqOX4BM+yLVxDqqdfexv2GTG9PNj+A7uc3glto
         t75g==
Received: by 10.180.8.130 with SMTP id r2mr47746878wia.28.1356741612805; Fri,
 28 Dec 2012 16:40:12 -0800 (PST)
Received: by 10.194.84.97 with HTTP; Fri, 28 Dec 2012 16:40:12 -0800 (PST)
In-Reply-To: <CAOkDyE8vSyT=eJ4FxRwYgz7Jzqu1+0LSzxtq9iSSzJEgTD1M0g@mail.gmail.com>
X-Google-Sender-Auth: lCqSdbbwlgTvhKu1Xl2_c6y0XFo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212277>

On Fri, Dec 28, 2012 at 8:45 PM, Adam Spiers <git@adamspiers.org> wrote:
> On Fri, Dec 28, 2012 at 8:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Adam Spiers <git@adamspiers.org> writes:
>>
>>> diff --git a/pathspec.h b/pathspec.h
>>> new file mode 100644
>>> index 0000000..8bb670b
>>> --- /dev/null
>>> +++ b/pathspec.h
>>> @@ -0,0 +1,5 @@
>>> +extern char *find_used_pathspec(const char **pathspec);
>>> +extern void fill_pathspec_matches(const char **pathspec, char *seen, int specs);
>>> +extern const char *treat_gitlink(const char *path);
>>> +extern void treat_gitlinks(const char **pathspec);
>>> +extern const char **validate_pathspec(const char **argv, const char *prefix);
>>
>> Protect this against multiple inclusion with "#ifndef PATHSPEC_H".
>
> Yep good idea, how should I submit this?  It will cause a trivially
> resolvable conflict with the next patch in the series (17/19):
>
>   pathspec.c: extract new validate_path() for reuse

I was wrong about that - it didn't cause a conflict, although it does
marginally change the context at the end of the pathspec.h hunk in the
above patch.

> but I'd prefer not to re-roll 16--19 when just 16 and 17 are sufficient.

Based on your other feedback, all of 16--19 require changes, and as
things stand, conveniently nothing earlier in the series does, so I'll
re-roll those four once the outstanding issues are all resolved.
