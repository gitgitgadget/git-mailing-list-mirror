From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 0/10] port tag.c to use ref-filter APIs
Date: Thu, 30 Jul 2015 15:43:02 +0530
Message-ID: <CAOLa=ZSBbURBhV5yq2NcVJNaCBA+1fFORN9a65OJgzObAPdCeQ@mail.gmail.com>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
 <CAPig+cQv4BWFwgx7mDHh=gNpxbEeR7auw4os-tOpf3cGah=zpw@mail.gmail.com>
 <xmqqbneu907l.fsf@gitster.dls.corp.google.com> <vpqzj2e9dyj.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 30 12:13:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKkqJ-0001RL-LQ
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 12:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755265AbbG3KNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 06:13:36 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34122 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098AbbG3KNc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 06:13:32 -0400
Received: by obre1 with SMTP id e1so27388123obr.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 03:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GK4no26qSp59nMOX7R3eMSLaPgkjcj89YcdMV7tyEb4=;
        b=Vb8iHBX+Hj45QxBLSy9ptmJSHpeVDRaV9QIhnkmdICLcAVOSZ3gsg9SWTl0CiGqPUS
         nRVW1lOygJzNqql9BJj2qze2wv5zb/sKVM0TBK3Hc5wcjuKZhlhS+G8f3qvA+hZ3pDt1
         d3zvpQ8bePOLZf2IdmFneeH/1HF7dBTAxcXM6EVJ8Pp2tzFZ75ROaqGxhHC+KvPq7Uik
         DPLJpiXA3k+GR0QeLvFuy8CfzRWjomU4zbXCPaEx1YFyUzbBrPshxIGyw4LNzocWBDBs
         uXAlik7Bu33loxso+G+E+rRRFwepAxI4Pf9oqhL5WSQlK+XXbX7iluzqdEU1IMbVoEXO
         ts1w==
X-Received: by 10.182.204.38 with SMTP id kv6mr45112128obc.70.1438251212287;
 Thu, 30 Jul 2015 03:13:32 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Thu, 30 Jul 2015 03:13:02 -0700 (PDT)
In-Reply-To: <vpqzj2e9dyj.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274979>

On Thu, Jul 30, 2015 at 3:14 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Currently we do not need it to reimplement the canned 'tag -l'
>> format" is an OK and sensible justification to stick to the current
>> implementation of %(padright:N), but we'd need to think if we would
>> want to keep this limited and strange form that applies to a single
>> atom that comes next (ignoring any literal spans) as a private
>> implementation detail between ref-filter and "git tag".  Opening it
>> up to end-users would not mean we cannot add a correctly operating
>> variant of "pad this string to the right" later, but it does mean we
>> have to maintain %(padright) in this limited form forever.
>>
>> My knee-jerk reaction is that we probably should not want to expose
>> this to the end users, and to discourage its use, perhaps name it
>> somewhat strangely (e.g. "%(x-padright:N)" or something).
>
> I disagree. The current %(padright) fits 99.9% needs. It's handy for the
> user if he wants a column-display with --format. It's consistant with
> the "git log" %<() atoms.
>
> Sure, if the user wants really advanced formatting, it's not sufficient.
> But first I believe this is a case of YAGNI, "right-pad an arbitrary
> string" is a funny coding exercice, but not very useful in real-life.
> And then, if one really has a use-case for advanced formatting, I think
> a much better approach is to dump an easy-to-parse language
> (XML/JSON/CSV/...) and pipe it to a formatter written in a real
> programming language. It will always be more powerful than having to
> chose in a limited set of %(atoms).
>

Exactly! what I was thinking, I mean this is quite useful feature in itself,
Agreed there are numerous end cases which are not satisfied, but those
are quite minimal and rarely used.

-- 
Regards,
Karthik Nayak
