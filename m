From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] send-email: Add simple email aliases format
Date: Fri, 22 May 2015 12:53:03 -0400
Message-ID: <CAPig+cTsygj1g=8sQ2b=1WYsmgAVyZmHCTW=NKTGuNyQwm3VFA@mail.gmail.com>
References: <9f88da801466c83331d02262855e8bef4164e5eb.1432266004.git.allenbh@gmail.com>
	<CAPig+cRLxk26p7DFaS+gRkKZxkRwf8g=4=j2QHX6AC2Uk5J++w@mail.gmail.com>
	<CAJ80satbXXBYva9qrgR1oA_f7LAHUeAm21=R-mGsWx+sDoQ9sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Allen Hubbe <allenbh@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 22 18:53:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvqC6-0001he-Ak
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 18:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946016AbbEVQxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 12:53:06 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38300 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945937AbbEVQxE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 12:53:04 -0400
Received: by igcau1 with SMTP id au1so37129365igc.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 09:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Hg9VY9TvD7X6vw5CY6wOgfTGiJL7y4xp7rTdsYx+h1k=;
        b=yds8VhbpBp7loameX6Nby/5moNkuGXve3WsIw0VaLnZn33P1KELF6BGl9728bVYDzG
         nk2SAOS8lDWrZ9clL40lLmM2vEfgVRwFGIgVRJq7E/ECYDyuWrKQxalIbRFSPW6hd75s
         W17/oh3MqMsmC1RLf1HQAsuVynvTpIEpMBdnv6V0JjvYTEOb96zXoOhU6w1m4mVrdiEp
         6DagWmrqLmHle8kt++D6/zoHla7U6lC3CiYiLcDgxTkYF1WEloD9i/oik4tQnXXDgGRB
         PgTcgBd7zG+4mfYhW2aFWDJ+Qz2ZYdDikg8a1fz7Sz2Ezg3sw0qf2lkOhOq/QBZ3dSrW
         vLsQ==
X-Received: by 10.42.67.80 with SMTP id s16mr10268708ici.25.1432313583714;
 Fri, 22 May 2015 09:53:03 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 22 May 2015 09:53:03 -0700 (PDT)
In-Reply-To: <CAJ80satbXXBYva9qrgR1oA_f7LAHUeAm21=R-mGsWx+sDoQ9sQ@mail.gmail.com>
X-Google-Sender-Auth: WsMHBEGlu8svQcT-mSyITZSqzaw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269735>

On Fri, May 22, 2015 at 8:12 AM, Allen Hubbe <allenbh@gmail.com> wrote:
> On Fri, May 22, 2015 at 12:29 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Thu, May 21, 2015 at 11:40 PM, Allen Hubbe <allenbh@gmail.com> wrote:
>>> +If the format is 'simple', then the alias file format is described below.
>>> +Descriptions of the other file formats to the following formats can be found in
>>> +the documentation of the email program of the same name.
>>
>> The second sentence probably needs some proof-reading.
>
> Could you be more specific?

Unable to parse "of the other file formats to the following formats".
I'm guessing that the "to the following formats" portion doesn't
belong.

> It depends what we want to do with this parser: accept existing
> sendmail aliases files in git, or enforce that git alias files are
> usable for sendmail.

Aside from these possibilities (likely or unlikely), there is also the
issue of breaking expectations. Precedence for this style 'aliases'
format was set decades ago by sendmail. People are familiar with it
and understand its strengths and weaknesses. Even if documented as not
being sendmail-compatible, because it's so similar to sendmail
'aliases', people will expect it to work the same way, thus unless
there's a good reason to diverge from that standard format, it makes
sense to be compatible with it (even if only as a proper subset).

> I really don't expect the second to ever happen.
> The first, maybe, but only if the alias file is edited to remove
> aliases of pipes and maildirs etc.  The second may not work if we have
> comments to the right, or aliases of aliases, which sendmail does not
> claim to support.

It's not clear why you say that sendmail does not claim to support
aliases of aliases. Although it's true that some sources, such as [1],
fail to mention support explicitly, other more authoritative sources
do[2]. Moreover, the 1993 "sendmail" book by Bryan Costales, with
contributions from Eric Allman (the creator of sendmail), talks
explicitly about expansion of aliases on the right-hand-side. Finally,
since time immemorial (at least the early 1980's), every /etc/aliases
file has contained the following mandatory entries:

    postmaster: root
    MAILER-DAEMON: postmaster

which indicates clearly that alias expansion on the RHS is supported.

[1]: http://www.feep.net/sendmail/tutorial/intro/aliases.html
[2]: https://www.freebsd.org/cgi/man.cgi?query=aliases&sektion=5

> I don't know what sendmail would actually do with a '#' elsewhere.  It
> only talks about having '#' at the beginning of a line, or in the
> alias name in quotes (which is not supported by this parser - proper
> handling of quoted strings is not easy).  It doesn't say what sendmail
> does with '#' if the name is not quoted, and it doesn't define a
> meaning for '#' in the definition of an alias.  If these other cases
> would be errors for sendmail, so what if they are not errors here?

All the more reason to stick with the documented standard. When you
diverge from it, you paint the format into a corner, thus closing the
door on someone who wants to bring it more in line with the standard.

>> For the same reason, I'm not convinced that "simple" is a good name.
>> "sendmail" may indeed be a more appropriate name, even if it means
>> that this early implementation documents it as (currently) a subset of
>> the richer sendmail/postfix 'aliases' format. By doing so, we leave
>> the door open so a future person can implement additional features to
>> bring it closer to that format.
>
> Or, a future person can write a sendmail parser that is closer to that format.

Yes, but git maintainers must continue to support your "simple" format
even if someone comes along later and adds a more proper sendmail-like
format alongside. That's why these questions and observations are
being raised now: not to string you along and not because your
proposal is necessarily undesirable, but because once such support
lands in git, then it remains indefinitely and must be supported for
the life of the project. Long-term project health is important, which
is why it's desirable to consider these issues early, and to avoid
painting ourselves into a corner.
