From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFD PATCH 00/32] subtree clone v2
Date: Wed, 25 Aug 2010 16:21:25 +1000
Message-ID: <AANLkTikCa_Yfw4t1=JAOkZPE3_txof67C4CfgrELoPsh@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<20100824223741.GB2376@burratino>
	<AANLkTikipryFVf_XvvbHopWSo5Ey_mvgTevY2NAvhygQ@mail.gmail.com>
	<AANLkTinsNvVup43B6nQtU6dvJy789n8kQm6N6na0J9oa@mail.gmail.com>
	<AANLkTikkybj784PHoVCkVZyxo40q6BhdkOzFho-xBS6G@mail.gmail.com>
	<AANLkTikOtinR1EjzrzMqzR8Pn2hpDRVJrWDmx5b5tGQ_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 08:21:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo9Mb-0001pC-4B
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 08:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125Ab0HYGV1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 02:21:27 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49576 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380Ab0HYGV0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 02:21:26 -0400
Received: by wyb35 with SMTP id 35so275526wyb.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 23:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TcTW22IuWrQ8Rpf3R2cHDmTArgrShQVnawxcN/ANWyI=;
        b=BS6kWyRKuNN77AfEfEeEk4vd62ZJa6qdPMhdqEPO+mZtTIc9lq8FNUFCkzawCUPs0O
         QU5rLCHWXdeTIx9Z155V77+QCz4lpgYtVZDe2lV077PsiIMpXd1pUwUoiUrosz81ONSK
         U4pDJp2Ovo2fQaZ3liOdNOZulecbq6/LmP1JE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h90RAPew/0XxEk3OEBGaW2OySF1naCwRkwBW/WJuMQuS2fNCopN2LtVtvchOcIau63
         B7Q9l8xVG9JU8pwIkEVWqWgXnyVjvEBKdmVaFxM4RoZf4SEY8H04l9XDd/PmT4vyglaB
         VRy+f58f4Cc+3YSN5kJlx6oT3geL0FSbs3vN8=
Received: by 10.216.132.166 with SMTP id o38mr4785518wei.16.1282717285037;
 Tue, 24 Aug 2010 23:21:25 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Tue, 24 Aug 2010 23:21:25 -0700 (PDT)
In-Reply-To: <AANLkTikOtinR1EjzrzMqzR8Pn2hpDRVJrWDmx5b5tGQ_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154425>

On Wed, Aug 25, 2010 at 3:31 PM, Elijah Newren <newren@gmail.com> wrote=
:
> Sure, they will modify paths outside your subtree, but you know that
> you didn't do so. =C2=A0So if you neglect renames then the situation =
is
> pretty simple:
>
> Merge-side: ancestor =C2=A0 =C2=A0you =C2=A0 =C2=A0 =C2=A0 =C2=A0 ups=
tream
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-------- =C2=A0 =C2=A0------=
-- =C2=A0 =C2=A0--------------
> Sha1sum: =C2=A0 =C2=A0ancestor =C2=A0 =C2=A0ancestor =C2=A0 =C2=A0new=
-stuff
>
> Which could be true for either a file or a tree. =C2=A0Either way, if=
 you
> ignore renames, then the trivial merge is 'new-stuff' for any such
> blob/tree. =C2=A0(Yeah, you'd have to create a new merge algorithm th=
at
> does 'trivial' merges at tree levels in addition to file levels, but
> the concept is relatively simple at least.)
>
> After your merge, a subsequent pull would look like this at the same
> file/tree path:
>
> Merge-side: ancestor =C2=A0 =C2=A0you =C2=A0 =C2=A0 =C2=A0 =C2=A0 ups=
tream
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-------- =C2=A0 =C2=A0------=
-- =C2=A0 =C2=A0--------------
> Sha1sum: =C2=A0 =C2=A0new-stuff =C2=A0 new-stuff =C2=A0 newer-stuff
>
> For which the resolution would be 'newer-stuff' (again, ignoring the
> problems that renames could cause, which I discussed elsewhere).
>
> Unless, of course, I'm missing something still...

OK here is the story. And I could be wrong on this merge stuff.

I was deep in merge-tree.c code (which was the base for my narrow
merge) and was stuck at

"If either "you" or "upstream" is as same as ancestor (all as dirs),
then it's easy. What if neither of them is the same as ancestor? If we
have more trees, we could just descend and figure out. But we don't
because it's outside narrow area. It could be that "you" added a new
file and "upstream" added another file, which is trivial at file
level."

I was deep in code and forgot that in narrow repo, I did not allow to
change outside narrow area, so it "you" must be as same as ancestor.
But the question was, what if user decides to branch from some commit
in history? If he/she does, "you" might not be as same as ancestor. If
it's non trivial merge, merge should fail (expected).

But the "it could be that "you" added ... at file level" above
bothered me. I had a feeling that I could miss a trivial merge (at
file level) because I could not make a judgement at (shallow) tree
level. And I did not have all trees to do merge at file level.

Still puzzling thinking about this.. Did I make wrong assumptions?
--=20
Duy
