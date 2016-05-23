From: Per Cederqvist <cederp@opera.com>
Subject: Re: git log: invert --author and --committer
Date: Mon, 23 May 2016 23:21:32 +0200
Message-ID: <CAP=KgsSNgKY5gR3uSSMZdOxZ1687YRnQRQFsV22UwCXqmdfB9g@mail.gmail.com>
References: <CAP=KgsSdX3pCRzeUVobrFWVGOGGSrwkO0MjFhUWruiajAxn38Q@mail.gmail.com>
	<xmqqmvngaedn.fsf@gitster.mtv.corp.google.com>
	<xmqq37p8a84y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 23:21:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4xIB-0000Zf-Mv
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 23:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbcEWVVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 17:21:35 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34684 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbcEWVVd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 17:21:33 -0400
Received: by mail-qk0-f173.google.com with SMTP id y126so82364944qke.1
        for <git@vger.kernel.org>; Mon, 23 May 2016 14:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opera-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=/XLLw94pmnhFyq3b3UtQUh6lTb9svOdxU6olSubiRTo=;
        b=e927vBJCc0MY4HA4Qck/XEdFL7pH26G2DgFWBf9JSmMXKs4QTVp1KSB3Jgqh3EvxAD
         euAcyliV8My0oL910NO86hvqoU0djAZCk3EopEuovclmHIppCu35jXpa4xDwu2/arAR5
         T/nWylnWfT8FyiXIqFFz1PF2c5pNOQBstnf8P4zTUuvOTcmw8z1EQ41FhM+mku7Mywac
         ZBiYmZJbTfLe9r6C9DbzTt1ggYdEPF+XPS1JMymk3z9b2aCJXel5yRbubL8dyuco+d8g
         39QIVUK3JPQ/xGpSISTip0F7ALOM58UUKCtTQy85H+/q0egrEdxH42Po2Huq476ehV6B
         ZL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=/XLLw94pmnhFyq3b3UtQUh6lTb9svOdxU6olSubiRTo=;
        b=UkwoBLBsnm+EKxEprrVihUSe6U+cBsFre/8FwppUp8hN0wGSFPltKnj0yVIRl35eMN
         gGvZ9bjmkixbqyZ7Wiz1FmY/mSuJgARpEV+jtKTiP348Lk5ip75jYytLeL/wTkj+FgqG
         6IZ5QWmau5PLAuyoM2gnp0P/63PI4EOFWjYjPpCCTXrKIfc8CoQe8BjAnBu9+griWJZf
         H915KFA7y7tnyWlRxP49s/ATeHIsIgRgt6G46BmeLvOOGo/ng6CF8tuxLHRfDnjemx3m
         Oka+Cxzg48cRroKnIQfMuMUYgdVzBJFBZ6iy1X6pajmAGzdtbAw/D/QzCaQuiPOvGuqU
         caLw==
X-Gm-Message-State: ALyK8tL7izzaF35ad8DFOOIYCir4uyVOYdY6GHuxAOoz3zFNCllmdi8kowr4n2+jEVCjf6lxXjpulut+xXCQ6fwW
X-Received: by 10.237.52.199 with SMTP id x65mr993468qtd.27.1464038492227;
 Mon, 23 May 2016 14:21:32 -0700 (PDT)
Received: by 10.55.184.70 with HTTP; Mon, 23 May 2016 14:21:32 -0700 (PDT)
In-Reply-To: <xmqq37p8a84y.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295393>

On Mon, May 23, 2016 at 9:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Per Cederqvist <cederp@opera.com> writes:
>>
>>>     git log --invert-grep --author cibot
>>...
>> Yeah, the author/committer search piggy-backs the more generic "grep
>> in the log" machinery, but it is quite hidden and the document
>> failed to tell the end users that is what is going on.  Mentioning
>> that invert (or any tweak that works on the grep machinery) affects
>> author/committer search is a good idea.
>>
>> Does "-i/--regexp-ignore-case" also need the same treatment?
>
> It seems it does.
>
> How about making this clarification not about --invert-grep but
> about --committer/--author option, perhaps like this?
>
>  Documentation/rev-list-options.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 4f009d4..3fca366 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -44,6 +44,10 @@ endif::git-rev-list[]
>         expression).  With more than one `--author=<pattern>`,
>         commits whose author matches any of the given patterns are
>         chosen (similarly for multiple `--committer=<pattern>`).
> ++
> +Options that affect how a regular expression match is performed
> +(such as `-i`, `-E`, `--invert-grep`) can also be used affect these
> +options.
>
>  --grep-reflog=<pattern>::
>         Limit the commits output to ones with reflog entries that

"can also be used to affect", right? (I think the word "to" is missing.)

I think it does make sense to document this with the --author/--committer
options.

That wording would however make me assume that --all-match could also
be used, so that

    git log --all-match --author ceder --author cibot

would list nothing (since there are no authors that match both
"ceder" and "cibot" in this codebase).  That isn't the fact, though.
It seems to list all commits that have either ceder or cibot as author,
just as if I had not used --all-match.

As a reader of the man-page, I would prefer to have the exact list
of options in the documentation.  (I realize that it will make it harder
to maintain.)

    /ceder
