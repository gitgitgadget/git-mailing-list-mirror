From: "Boris 'billiob' Faure" <billiob@gmail.com>
Subject: Re: [PATCH 1/2] commit: do not cleanup template
Date: Sat, 7 May 2011 23:17:03 +0200
Message-ID: <BANLkTinvwjoa4z2JEiuPD44BV2V_m50VYQ@mail.gmail.com>
References: <1304783624-9919-1-git-send-email-billiob@gmail.com>
	<7vwri2uv4m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 07 23:17:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIosR-0001ZE-Eu
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 23:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833Ab1EGVRH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 May 2011 17:17:07 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50526 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689Ab1EGVRF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 May 2011 17:17:05 -0400
Received: by bwz15 with SMTP id 15so3211417bwz.19
        for <git@vger.kernel.org>; Sat, 07 May 2011 14:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Np2IBjvPn14xKy3BKbUuPyya00Xj9dRlW0gKLF5M7nM=;
        b=lbwd1p5TfmBKNCLytQc6jc/oqK9NDnySYNVP4upBSyD1I9Os5KbtCAPaS8gY/pzbp2
         8BzyASfpgMoILFg3qps4fS/C7sfuW5LQeM6b2np9NkD6nijWZnrXxVG9OHI5Ath9/2vx
         YmQX7FZ84B36RDeSF2ZMxJa5J3xXYMHp3xl9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mQ9WRu1vp1ueIPRh/hCSzyWlaoZAhgOVHdoVFX8cEo+TvGPAt1yRVHky8pivBVCK/H
         UO2Vz+jY7TeDAJC3M7ZMe6bYMaj6xHgBqXoO2uHHyrI9meXZ38uK6xwjbqrBUq50dHu6
         yUZfg3mBmqYFcf6NsxcEMsosHWc408tcRNyds=
Received: by 10.204.6.203 with SMTP id a11mr167385bka.15.1304803023951; Sat,
 07 May 2011 14:17:03 -0700 (PDT)
Received: by 10.204.103.141 with HTTP; Sat, 7 May 2011 14:17:03 -0700 (PDT)
In-Reply-To: <7vwri2uv4m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173067>

On Sat, May 7, 2011 at 22:13, Junio C Hamano <gitster@pobox.com> wrote:
> [=E2=80=A6]
> My gut feeling is that it is relatively easy to justify [1/2]. We pre=
pare
> the message file to be edited by the committer in sb by reading from
> different message sources, and usually we would want to clean up what=
 is
> in sb before writing it out, but you may want to enforce a particular
> format by using the template (such as having a leading whitespace) an=
d the
> way to tweak and fix that appearance should be by editing the templat=
e,
> not by automatically running stripspace() here [*1*] when the message=
 came
> from the template.

That's exactly my point of view.

I use the commit template feature mostly to show additional pieces of
information I'd use in my editor when writing the log.
It had scratched an itch because I have to insert manually a newline
to write the commit title whenever I use a commit log template.
It's a bit strange for me to have that different behavior when writing
a commit log whether the commit log template feature is used or not.
I consider the newline being part of the template since sometimes the
template could even pre-fill the commit log title.
That's the main reason I disabled the cleanup when using a template.

> I cannot tell offhand how you justify [2/2], though. What motivated y=
ou to
> remove this blank line? At this point in the codepath, it does not lo=
ok
> like it should matter if the original message came from your template=
 or
> from somewhere else.

In the way I use the commit log template, I consider that new line
inserted there as useless.

> If the blank line is unneeded after "# You may be committing a merge.=
=2E."
> for readability, wouldn't that blank line be unneeded when you took t=
he
> message from other places, no?

Maybe.

> It might make sense to move that newline before "if (whence !=3D FROM=
_COMMIT)"
> block, though, to make the logic easier to follow, regardless of the =
use
> of the template file.

Moving the newline there will not change my point of view on the
usefulness of it when using a template.

--=20
Boris Faure
