From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 1/2] advice: extract function to print messages with prefix
Date: Fri, 7 Sep 2012 23:09:58 +0200
Message-ID: <CAN0XMO+jbZeO=2NHisPizHfNwR62ebkC06KVZ8xOhgmRoAT4nw@mail.gmail.com>
References: <7vhar9ybgk.fsf@alter.siamese.dyndns.org>
	<1347044705-17268-1-git-send-email-ralf.thielow@gmail.com>
	<1347044705-17268-2-git-send-email-ralf.thielow@gmail.com>
	<7v1uidy6ga.fsf@alter.siamese.dyndns.org>
	<CAN0XMOK5QnNn8471RF4y7u_X0rfda=-J-KrCtyMsgCGHXNrwVw@mail.gmail.com>
	<7vfw6two6o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, worldhello.net@gmail.com, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 23:10:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA5ok-0000yS-Pl
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 23:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757028Ab2IGVKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 17:10:00 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:63510 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755534Ab2IGVKA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 17:10:00 -0400
Received: by weyx8 with SMTP id x8so14524wey.19
        for <git@vger.kernel.org>; Fri, 07 Sep 2012 14:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uzh36gOcvP2Q98S6hoFo8zp4yttQZ2SDg56+D4bPxxg=;
        b=hYWnC250XCBMRTnCeBOiJJU34tvyjvSWz/3etCD8Q3i+/8MMiFuVtmFexE1Sv66h9A
         B64oLtVwOC9ZnVrTudbPraHtMkS9domSeicuHgZDSklnYC7Gq4K3c/Nu/qVnYqxT98bv
         45fPMLO3te87QSMAirTcQ09Ih1zwcOn8UAF6MutPyM19h9qYLpuBlmICHbDkw5z4wI3g
         fieMmx5LS1lONSCjf2mmGz7U7jmSFBCVJYc8UaI5rag6Aoz+D+a0Gzgi5lp1aKy0vfPo
         GYSR2SmraHillVcZ01cfmQwFYoUn+HT3sECJ/pN1SZKc1/dMNaWKf0Tp7+0AcPW9fGbg
         GZwg==
Received: by 10.216.255.146 with SMTP id j18mr3659672wes.163.1347052198871;
 Fri, 07 Sep 2012 14:09:58 -0700 (PDT)
Received: by 10.194.23.201 with HTTP; Fri, 7 Sep 2012 14:09:58 -0700 (PDT)
In-Reply-To: <7vfw6two6o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204999>

On Fri, Sep 7, 2012 at 10:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ralf Thielow <ralf.thielow@gmail.com> writes:
>
>> On Fri, Sep 7, 2012 at 9:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>>> -             fprintf(stderr, _("hint: %.*s\n"), (int)(np - cp), cp);
>>>> +             fprintf(stderr,  "%s %.*s\n", prefix, (int)(np - cp), cp);
>>>
>>> Hrm, naively, printf("%s: %.*s\n", _("hint"), ...) might look more
>>> natural, but I vaguely recall that the current code places _()
>>> around the entire "hint: %.*s\n" on purpose.  IIRC, it was to allow
>>> translations that flow from RTL e.g. ".siht od t'nod :tnih".
>>>
>>> Doesn't this patch break it?
>>
>> Sorry but I don't know what you mean with "translations that flow
>> from RTL e.g. ".siht od t'nod :tnih"." so I can't check this.
>> As far as I can see the callers only put a simple message in it,
>> e.g. advise(_("Commit your changes or stash them to proceed."));
>> So I don't think that this patch would break anything.
>
> Your patch would not allow target languages that want to put the
> _("hint") at the *tail* end of each line of the message.  With the
> original, with something like this:
>
>         msgid "hint: %.*s\n"
>         msgstr "%.*s :tnih\n"
>
> you could do that if you wanted to.
>

Is there a need actually?
It's easy to add a "_(...)" around this string, but then we'll have a
msgid in "git.pot" without ever having a sensible translation. Not?
