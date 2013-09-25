From: Jona Christopher Sahnwaldt <jc@sahnwaldt.de>
Subject: Re: "git checkout foo" is getting confused by folder named "foo"
Date: Wed, 25 Sep 2013 21:36:52 +0200
Message-ID: <CAEQewpoRhGGnc7HMES1nNbduiRP-qLF4hKBJhRKy7CjMzXnGNg@mail.gmail.com>
References: <CAEQewpqLcDJPo2gUWPk-xc3OitdTC4gH2tnyqaURiQ77BApNog@mail.gmail.com>
 <CAJDDKr64ou+gO7WJLFZ4zOSv+VCbkiW7nKuZa9=5_fiSqGUeyQ@mail.gmail.com>
 <CAEQewpqbf-sWSt0GS9eXQNi0yFz5-23NcO2JWKO4OgSFv3SXdA@mail.gmail.com>
 <vpqzjr1ujyn.fsf@anie.imag.fr> <CAEQewpoD2VRVtpEyG121TqAptoYfEXxt57CCthBX_EfN7LU0fQ@mail.gmail.com>
 <vpqzjr0pvfn.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Aguilar <davvid@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 25 21:37:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOutj-0003W8-Oo
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 21:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708Ab3IYThN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Sep 2013 15:37:13 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:64309 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab3IYThM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Sep 2013 15:37:12 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so116498pdj.34
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 12:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=FZVVY7HziyCSFrhQ63foX9ZSPrC00niByo5drASp/AU=;
        b=psWycxH9r6iguvszRwGBOJh4ZfY7jGm3XqzpZLd5E+eB2n8qCgvhzAnuytGLu4HKu1
         PTgPa272laoN94SzSqQzDIgA7HMsot8CuKblNbvPwjkvLaxQgt/pfRoM3N94b/XpK2hR
         Gr2GvTdIJes9NDSxk8LCdmv+pBuu3ZUIDWcPL5PbRLWaOeEqLdWvzVM3uzxv+HnBmZPG
         RmfjpP6cXM+j8GKwL6kYYcH9pcm2bxKilc8T1S01PGKpSsCMxvnOJ/BBhAbTJbtdRzoI
         xwCqp7sY1zAb1wi/B5PAheqsWSgga2OxR2Pyriyp7zzVwEgILC28vxXUfLMlI3Y7qhCs
         Zjuw==
X-Received: by 10.66.146.42 with SMTP id sz10mr1060308pab.100.1380137832099;
 Wed, 25 Sep 2013 12:37:12 -0700 (PDT)
Received: by 10.66.229.70 with HTTP; Wed, 25 Sep 2013 12:36:52 -0700 (PDT)
In-Reply-To: <vpqzjr0pvfn.fsf@anie.imag.fr>
X-Google-Sender-Auth: TTN4OVqtTnwMWI1pV5rZB0h66G4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235371>

On 25 September 2013 21:12, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> Jona Christopher Sahnwaldt <jc@sahnwaldt.de> writes:
>
>> Hi everyone,
>>
>> tl;dr: The short form "git checkout foo" is a mess. There's simply too
>> much "DWIM" magic going on. There are no comprehensible rules how it
>> decides if "foo" is a pathspec or a refspec.
>
> There is a very simple rule:
>
> What's on the left hand side of -- are refs, what's on the right hand
> side are paths.
>
> When you don't use --, then Git tries to guess, and fails whenever
> there's an ambiguity.

That's the case I'm concerned with. And I think the guessing confuses
users in many cases. It certainly has confused me.

>
>>> OK, what happens is that "git checkout wiktionary" is actually a
>>> shorthand for "git checkout -b wiktionary --track origin/wiktionary".
>>
>> No, it isn't.
>
> What I meant was that the short form advised by people were _meant_ to
> be a shorthand.
>
>> Let's consider several scenarios:
>
> I don't get your point. Is the overly long list a way of complaining?

It's a way of showing that human beings can't understand git's
guesswork. :-) It was also a (failed) attempt to understand the rules
of this heuristic. And an attempt to show the developers that the
rules have gotten out of hand.

> Are you suggesting a change?

Yes, I think the rules for the "short form" (the guessing when there's
no --) should be made simpler, or maybe the guessing should be dropped
altogether. I don't know. I don't know git well enough to be able to
be more specific. I just find the current behavior very confusing.

> What do you think about the change I'm proposing?

I don't know. It looks like it's not really addressing my specific
problem, because as far as I understand it only applies when there is
a --. But again, I don't know git well enough.

Anyway, thanks for your work. I'm sorry I can't provide more useful
input. This "short form" of checkout is just a small feature. I guess
I'm bikeshedding here.

Cheers,
JC


>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
