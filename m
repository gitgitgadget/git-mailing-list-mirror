From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] completion: avoid "words" as variable name for zsh portability
Date: Wed, 27 Apr 2011 12:49:53 +0300
Message-ID: <BANLkTi=3T2B=Gtyk7V_3DB3V+GkbXAaqPw@mail.gmail.com>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
	<20110427013534.GA14286@elie>
	<7v62q0b8e0.fsf@alter.siamese.dyndns.org>
	<20110427064033.GB4226@elie>
	<BANLkTinA5hfddqpGwOBjk+2oFDpwqORrSg@mail.gmail.com>
	<20110427091140.GB14849@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stefan Haller <lists@haller-berlin.de>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Mark Lodato <lodatom@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 11:50:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF1Nz-0001Zk-6V
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 11:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112Ab1D0Jt5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 05:49:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54479 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757313Ab1D0Jtz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 05:49:55 -0400
Received: by fxm17 with SMTP id 17so1005562fxm.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 02:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HrjiBlBbBKKe5H6BDKWMKYnNXuR3pQ4s/mV5Ke9yX7s=;
        b=BUWjbc4X1vSVU6pQ2fYg51ILYLaT6l0aS5naCGfJFnH9PHn+2ktsejt6A8P8NlPUZK
         Wl6FCczadzw9PAOvWLsmofa18ar4tUIQoHdEzXS1G4keYUGjlB50CRJClpm7mtN62HeW
         gokzUgmHW2NZTPCjwIRRjwIIkmNWQtiaxn0bw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=o5+g185gVbRsjWV171alY8nE+bcaRGYrhiaXoIM4gyIUisGpoDQhpjUB8T/qMXLjtu
         pNcAEFvazUA9AipgXWmzRYp2behREMs/7s6svaKQ4BZHD7VX6cMD/0ruak6EzVK8ZgR0
         DTlEf7FLWbL0nRs0F/Z+Mp0UK8KO/obzoNEqA=
Received: by 10.223.73.133 with SMTP id q5mr2125393faj.127.1303897793952; Wed,
 27 Apr 2011 02:49:53 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Wed, 27 Apr 2011 02:49:53 -0700 (PDT)
In-Reply-To: <20110427091140.GB14849@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172209>

On Wed, Apr 27, 2011 at 12:11 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Felipe Contreras wrote:
>> On Wed, Apr 27, 2011 at 9:40 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>
>>> Sorry, I got carried away (I am happy to see someone has made some
>>> headway in investigating this old bug). =C2=A0How about this?
>>
>> What's wrong with my patch?
>
> As mentioned at
> http://thread.gmane.org/gmane.comp.version-control.git/172142/focus=3D=
172157
> it breaks the tab completion in the common case that the user uses
> the standard bash completion library (usually provided at
> /etc/bash_completion) and git uses its _get_comp_words_by_ref
> function. =C2=A0You can test like so:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0% bash
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ . /etc/bash_completion
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ . contrib/completion/git-completion.bash
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git fetch origin <TAB>

Where does that 'bash_completion' file comes from? I don't have it on
my system. Do we really need to use _get_comp_words_by_ref from there?
Can't we have our own _get_comp_words_by_ref?

> I also made a small cosmetic change which is less important (sorry, I
> should have mentioned it before): the patch I sent spells out
> comp_words instead of writing cwords to avoid a false analogy between
> the array of all completion words (cwords) and the current word index
> (cword).

I don't see how cword can be confused with cwords. Besides, I prefer
uniformity, so if you use comp_words, cword should be cur_word, or
word_index, or something like that.

>>> There is still a "for unknown reasons" in the above explanation.
>>
>> I'm asking zsh guys:
>> http://www.zsh.org/mla/workers/2011/msg00515.html
>
> Thanks. =C2=A0It looks like to get the semantics I expect from "local=
"
> in zsh, one needs to use "typeset -h" (which bash does not support,
> unfortunately). =C2=A0Probably it is best to steer clear of zsh's spe=
cial
> variables anyway.

Hmm, interesting, maybe we should try to find a way to replace those
'local' with 'typeset -h'.

--=20
=46elipe Contreras
