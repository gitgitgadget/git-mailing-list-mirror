From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Add option to git-commit to allow empty log messages
Date: Sun, 4 Apr 2010 23:53:26 +0000
Message-ID: <y2j51dd1af81004041653g9a09915el60104c575dcf6481@mail.gmail.com>
References: <z2r51dd1af81004031506pc9ac1840ie9953ae6df91d01b@mail.gmail.com>
	 <1270392557-26538-1-git-send-email-avarab@gmail.com>
	 <20100404224324.GB12655@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 05 01:53:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyZdR-0002j4-E0
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 01:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961Ab0DDXx3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Apr 2010 19:53:29 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:56753 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab0DDXx1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Apr 2010 19:53:27 -0400
Received: by ewy20 with SMTP id 20so947047ewy.1
        for <git@vger.kernel.org>; Sun, 04 Apr 2010 16:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=P+49jswpL62V7V9uxtuUluOlxjxATzP8H54Z8Z1WU4I=;
        b=gutk+7TApoMeccA0isz1XUaebt98A5gI+ovYdHayiJDN5u3S44zTl3umLhpf7cECjx
         jHBlaVZ71vv1FY4Nu6AmXgb3vj8iDHQR8ah1U1aBvhO5LkIJV8NaNJXfO2pqBDknOsPr
         vsApyjyvM+ec++AWo6KzOJqHS4mNT6vWCdLNA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=T4i9o/FuW58Gv3OtaHmw5i2wZJHweFFeVJzrZ2QG4QwN/Gsey0h7mhqt4js7B7hiJt
         pkmbzM8rSpSAJOIMjAyzRuF45s105fohWQwk5BQdrr5b/0oEbaRsb5kidHt2TIs27HyI
         iAlYoSU/xluMEZJ1q2VQRdRzeyPtCSGgnOsL8=
Received: by 10.213.14.201 with HTTP; Sun, 4 Apr 2010 16:53:26 -0700 (PDT)
In-Reply-To: <20100404224324.GB12655@gmail.com>
Received: by 10.213.50.194 with SMTP id a2mr1138021ebg.47.1270425206446; Sun, 
	04 Apr 2010 16:53:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143962>

In retrospect I probably should have sent a [PATCH RFC], this is
obviously somewhat of a delicate subject.

On Sun, Apr 4, 2010 at 21:21, Shawn Pearce <spearce@spearce.org> wrote:
> Isn't this exactly why git-commit-tree exists?=C2=A0 I don't really s=
ee a reason
> to support scripting the porcelain git commit.

It's not so much about supporting scripting as exporting the
capabilities of the porcelain to the frontend utilities without
artificial limitations.

On Sun, Apr 4, 2010 at 22:43, David Aguilar <davvid@gmail.com> wrote:
> On Sun, Apr 04, 2010 at 02:49:16PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> Change git-commit(1) to accept a --allow-empty-message option
>> analogous to the existing --allow-empty option which allows empty
>> trees. This is mainly for compatability with foreign SCM systems.
>
> Is there any reason why the git commit-tree plumbing didn't
> suffice?

I encountered this limitation most recently while using hacking
snerp-vortex which uses git-commit(1) directly. While it should
ideally use git-commit-tree(1) or git-fast-import(1) it was easier at
the time to do:

    message ||=3D "Git made me";

I thought it was silly that I had to either do that to fix an
otherwise working piece of software or rewrite how it does commits,
hence the patch.

> It's hard enough to get co-workers to write good commit
> messages. =C2=A0I wouldn't want to encourage them to skip writing
> them altogether (by the existence of this feature).

I'm a big fan of good commit messages, that's another reason why I
think this feature is a good idea.

I've read too many commit messages from people who're obviously
determined not to write any, but are being forced to do so by their
tools. Favorites include "more updates", "some changes", "..." (the
list goes on). I'd rather get nothing at all from those people than
more meaningless drivel. It would increase the signal-to-noise ratio
of git-log(1) output.
