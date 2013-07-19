From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] pull: require choice between rebase/merge on
 non-fast-forward pull
Date: Fri, 19 Jul 2013 16:29:20 -0400
Message-ID: <CAPig+cQEtKc+tfDgqVWYL2JtxXc=wvS=P7_O=XJzizz1BN=n4A@mail.gmail.com>
References: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	<7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
	<20130718143009.GC2337@serenity.lan>
	<871u6v93a8.fsf@igel.home>
	<7vmwpj3g0l.fsf@alter.siamese.dyndns.org>
	<7vvc471x1s.fsf_-_@alter.siamese.dyndns.org>
	<CAPig+cTXn4hdKoCjnNXmybNxYt0Bt_QuxsfFxiA5b0J1FxUUmQ@mail.gmail.com>
	<7vy592wmcs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, John Keeping <john@keeping.me.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 22:29:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0HIs-0000Nb-Qv
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 22:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790Ab3GSU3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 16:29:23 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:42632 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab3GSU3V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 16:29:21 -0400
Received: by mail-lb0-f177.google.com with SMTP id 10so3747541lbf.36
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 13:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=zqQDeZjtkx+ZrCbolcE9yAhhGotOSXnQaYMgBsP0XMU=;
        b=QzTe/R1fDBI/92pScY4K/1MFXRZYIMKeRuSPph8cdcFwrCZ1rlEuihj5708rAadQdA
         rhk0mrNQ3r0cH357A7g8O9f00xCiS6ky+GbY44evfxLlb3LMNGsZfmt0TNYoJK4efPsc
         9gTw4aBlgrf5msy2j1Ilczt6D1sVqLCEvePrV4q1fohL3pICEyXKhBoOa8/gGN3Vv0sq
         Nv7/uuLZO9UMuV/xw3rCXnHPCm8FEnzKeblDENL2kUqJ1xb7oYv7IFx/hyweOsTtsmlQ
         3xUU15eiR3D+N2BiU7+2uVOmncyXJ0lzZ9lU3x88BhDpBhM4O3pthHdxiR4DTCSKq8Tc
         dphg==
X-Received: by 10.112.97.132 with SMTP id ea4mr7951422lbb.80.1374265760337;
 Fri, 19 Jul 2013 13:29:20 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Fri, 19 Jul 2013 13:29:20 -0700 (PDT)
In-Reply-To: <7vy592wmcs.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: aSY0E_Ng5RcdCqoNujJr1_9YhGg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230848>

On Fri, Jul 19, 2013 at 12:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> +When `git pull` that does not explicitly specify what branch from
>>> +which repository is to be integrated with your history on the
>>> +command line, recent Git will refuse to work until you specify how
>>> +that integration should happen, either with a command line option
>>> +(`--merge` or `--rebase`) or a configuration variable (`pull.rebase`
>>> +or `branch.<name>.rebase`, which is the same as `--merge`
>>> +(`--rebase`) when set to `false` (`true`) respectively.
>>
>> This paragraph-long single sentence may be intimidating. Perhaps some
>> simplification is possible:
>>
>>     As a safety measure, bare `git pull` (without repository or
>>     branch) needs to be told how to integrate pulled changes with
>>     your history; either via `--merge` or `--rebase`.  Also see
>>     configuration variables `pull.rebase` and `branch.<name>.rebase`
>>     in linkgit:git-config[1].
>>
>> I intentionally omitted the true/false explanation of the
>> configuration variables since the user can follow the link and read
>> about them. It also may make sense to drop mention of those variables
>> altogether since they are already described (including link) in the
>> description of --rebase.
>>
>> I also intentionally omitted "recent Git" since it's rather nebulous.
>
> Looks much better than the original.  I would further suggest
> dropping the "As a safety measure, bare " at the beginning.
>
>       `git pull` (without repository or branch on the command line)
>       needs to be told how to integrate the changes with your
>       history via either `--merge` or `--rebase` (see configuration
>       variables `pull.rebase` and `branch.<name>.rebase` in
>       linkgit:git-config[1]).
>
> perhaps?

That works; or without the mentioning the configuration variables at
all (assuming the reader will discover them from reading --rebase
description):

    `git pull` (without repository or branch on the command line)
    needs to be told how to integrate the changes with your history
    via either `--merge` or `--rebase`.

Dropping the parenthetical comment might improve flow slightly:

    Without repository or branch on the command line, `git pull`
    needs to be told how to integrate the changes with your history,
    via either `--merge` or `--rebase`.

With or without mention of the configuration options, either phrasing
seems pretty easy to digest.
