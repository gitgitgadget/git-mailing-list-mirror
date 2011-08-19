From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: Re: [PATCH] rev-parse: Allow @{U} as a synonym for @{u}
Date: Fri, 19 Aug 2011 11:54:57 -0700
Message-ID: <CAOTq_pvFLs+7QZ2CZT6TVw=m+UioKjtSkuPiBfAnCv=Mb1Q0PQ@mail.gmail.com>
References: <CAMK1S_hZkdXiQb_UTB=snLAXPmo5yrCnFaQFHZqYq5AXqOgWng@mail.gmail.com>
 <1313287071-7851-1-git-send-email-conrad.irwin@gmail.com> <7vhb5fd4zy.fsf@alter.siamese.dyndns.org>
 <CACsJy8CX7X3u4i_kXChVHkFK=Q--pRBrxmdvjxrF7wr5_SyakA@mail.gmail.com>
 <4E4CBC29.7080703@drmicha.warpmail.net> <CACsJy8Dr5q=h-9MhNV0gKtVEn13+DxWwcNn2Prem6-+DyrDmHA@mail.gmail.com>
 <4E4CDBF5.4040709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Aug 19 20:55:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuUE1-0006f7-7t
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 20:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755372Ab1HSSzU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Aug 2011 14:55:20 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63704 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755057Ab1HSSzT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2011 14:55:19 -0400
Received: by gya6 with SMTP id 6so2422852gya.19
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 11:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=qV+x7aorOG9b22YjioyvSf/f/ETP0M8eXo89Sg7m7Nw=;
        b=o/GZNoEVK6/uLK6frd618iNXNL8NJzJGOoOO3cgOK959kyw764LmaCAceNanNwCGLI
         jhsFUgTAk2a6puGe1SPGE5fo4jqWwSFTH56I+9bUOmUEhN8zi+CyyfHcZTxndugXaWvx
         1XCC7FHqIeyD48NJ+2R9hg19QY+Q5dAHWXAK4=
Received: by 10.236.153.98 with SMTP id e62mr648992yhk.40.1313780117228; Fri,
 19 Aug 2011 11:55:17 -0700 (PDT)
Received: by 10.236.95.131 with HTTP; Fri, 19 Aug 2011 11:54:57 -0700 (PDT)
In-Reply-To: <4E4CDBF5.4040709@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179718>

On Wed, Aug 17, 2011 at 3:53 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Currently, we use @{...} for:
>
> =C2=A0- Negative integers are "-N branch-switching ago" (only without=
 any ref
> =C2=A0 on the left);
> =C2=A0- Non-negative integers "The tip of the named ref before it was=
 changed N
> =C2=A0 times";
> =C2=A0- An approxidate that is case insensitive; or
> =C2=A0- "u" and "upstream".
[snip]
> The only remotely semi-plausible enhancement I could think of is perh=
aps
> to allow @{/regexp} to find a reflog entry that matches the given pat=
tern,
> and in such a use case we would certainly want to take the pattern in=
 a
> case sensitive way. This change closes the door to that, and that is =
the
> only downside I can think of right now.

I'm reasonably convinced by this argument as a refutation of the
consistency argument I proposed above. Given that the date format will
always be insensitive, and any enhancements added would probably want
to be case-sensitive (I can think of a few other things I'd "like",
but which are pretty silly: @{merge-base <commits>*}, @{octopus-base
<commits>*}); this syntax is always going to be inconsistent.
Additionally, as pointed out elsewhere in the thread, the most-similar
existing syntax (^{tree}) is already case-sensitive.

Given all of the above, I think that allowing @{upstream} to be
case-insensitive is certainly wrong, as it's slightly confusing and
not very useful.

Given that @{upstream} should be case-sensitive, it would be bizarre
to allow @{U} as a synonym, so I think I'm convinced that this is not
worth it, despite the convenience it brings.

On Thu, Aug 18, 2011 at 2:31 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>>> As a simpler case, a user could tailor to her keyboard layout with
>>>
>>> git config revalias.=E2=86=93 u
>>

Hmm, this opens up interesting ideas:

git config revalias.base =3D '! git merge-base -a "$@"'
git show HEAD@{base master}

but that seems like it's a bit over-the-top for some reason :).

Conrad
