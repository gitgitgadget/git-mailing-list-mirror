From: Jim Cromie <jim.cromie@gmail.com>
Subject: Re: feature request - telling git bisect to skip, from inside a commit
Date: Tue, 29 Mar 2011 11:00:00 -0600
Message-ID: <AANLkTin+0yScj2ejVgPSMmY6Q+Qk0MM+W+EqqLGphCrz@mail.gmail.com>
References: <AANLkTinCiM9uqK8Yr=pKaeKytWXqpWF898AeTwvHKg4-@mail.gmail.com>
 <20110328163153.GA18774@sigill.intra.peff.net> <7vipv31943.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 19:00:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4cHd-0006SJ-D1
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 19:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460Ab1C2RAf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 13:00:35 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45784 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab1C2RAe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 13:00:34 -0400
Received: by wya21 with SMTP id 21so309487wya.19
        for <git@vger.kernel.org>; Tue, 29 Mar 2011 10:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=zdgRp2Eb3riboFAvThUj5pLzjr+yZvX6vdbvgML34Bk=;
        b=Zj4juFAsmFOpaxcHxfMaBJlRNMVetD7wKAKtP4ZQ3lZ6PV/TTCPiGczPoIlvFAjlZt
         UlNudjqcVsc8YrC1E8f7aUZbHJd3Svg8guGXWSD7kPDj8JD8Vq05PhI+RnI/5yb7RTB7
         1YXJ3li3eu2iAUm5Wb4IpZJXY6AeJcK4rzbAw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=HgVI+KEEMgfu9Jcf9XbI52DB6XGvt60fsVRM4t6IP1MEHJLRJMF8nC02wThNiTuIr8
         13LWELZGwnV1zAai/BKfTHTskUL7s7adEak8iEfpR/nLUR0fSTCRmFGeUcQ+s0NZsrkq
         RK5GH23Afll6qGBikRJzMrE/nC6ZiRI9cTP1U=
Received: by 10.227.203.76 with SMTP id fh12mr8968wbb.110.1301418033382; Tue,
 29 Mar 2011 10:00:33 -0700 (PDT)
Received: by 10.227.142.149 with HTTP; Tue, 29 Mar 2011 10:00:00 -0700 (PDT)
In-Reply-To: <7vipv31943.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170278>

On Mon, Mar 28, 2011 at 10:51 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Jeff King <peff@peff.net> writes:
>
>> That could work, though I would spell it as a pseudo-header:
>>
>> =A0 Bisect: Skip
>>
>> at the end of each commit.

I like this generically.  It is more constrained than a
/^bisect skip(.*)$/ matching, and perhaps easier to code.

Thank you for reading into my request and formulating a better version,
the discussion/explication of issues also helps.

If the pseudo-header can be added into the commit message,
it is trivial to use.

I see the merit of a skip-cache as working after-the-fact
on already published/shared patch-sets, but Im unsure how the
skip-cache can be shared currently.

>
> I think that is a saner approach, and further say it would be much sa=
ner
> to make that token something like
>
> =A0 =A0Broken: does not build

My only concern here is the negative connotation of Broken.
At least in my 1/2 change scenario, thats known to be incomplete,
its kinda pejorative.  But it certainly gets the job done.

Skip: make rc 125
Skip: 125
Skip: gcc error: no such field: foo
Skip: api change only, users must follow

Skip: has less pejorative, and closer name-association linkage
to the bisect skip command that it

>
> A commit may or may not build, a build product may work in some areas=
 just
> fine and may have known bugs in some other areas, depending on what k=
ind
> of breakage you are interested in. =A0You might even be looking for a=
 change
> that fixed a bug for cherry picking. =A0In short, "Bisect: Skip" is t=
oo
> broad a brush, and does not convey enough information.
>

agreed -  It would be interesting, 6 months after the feature is added =
(I hope),
 to search commit messages and see how the header has been used.

> And then teach the script you give to "bisect run" to grep for that
> "^Broken: " pattern to answer with exit 125 (cannot test), and you ar=
e
> done.
>

With this, nothing needs to be added.
The only advantage to bisect looking for the pseudo-header is that
a convention is supported, such that it might get used.
I suppose a 1 line addition to git bisect run documentation would
do just as well.

thanks
