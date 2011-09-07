From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Git without morning coffee
Date: Wed, 7 Sep 2011 17:23:10 +0000
Message-ID: <CAMOZ1BstyMteutmK7tst=3t9djavY9_4vBKJgdj7rhUnE1Wr7w@mail.gmail.com>
References: <4E6721E3.7000207@drmicha.warpmail.net> <7vehzs47we.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 19:29:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1LwB-0001mQ-K1
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 19:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553Ab1IGR26 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Sep 2011 13:28:58 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:46378 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755532Ab1IGR25 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2011 13:28:57 -0400
Received: by yie30 with SMTP id 30so5132765yie.19
        for <git@vger.kernel.org>; Wed, 07 Sep 2011 10:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Js2OCje767Bu4l3dDm1nqa0y+fj/1J7wnUkglegeDjU=;
        b=hmseyrZr6DH/xkWRUlZHBvXDql5dEM9Y6jx78dDySW5YHU1tr6w7jxcgjv+UHsCGtk
         vVeTvqIeU8eRv/10ln+V+4NNvAQzaoK2fYVAWDLWDKfMdFs3QBNnPa4oSYHI8msDIlVB
         FX71EVUTfL2Y0dCkAPL9cyiKVPWlR9UWvPHgE=
Received: by 10.42.148.72 with SMTP id q8mr5336568icv.481.1315416220132; Wed,
 07 Sep 2011 10:23:40 -0700 (PDT)
Received: by 10.42.171.194 with HTTP; Wed, 7 Sep 2011 10:23:10 -0700 (PDT)
In-Reply-To: <7vehzs47we.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180880>

[Sorry for the repeat, Junio]

On Wed, Sep 7, 2011 at 16:46, Junio C Hamano <gitster@pobox.com> wrote:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> git merge ":/Merge branch 'jk/generation-numbers' into pu"
>> fatal: ':/Merge branch 'jk/generation-numbers' into pu' does not poi=
nt
>> to a commit
>> # Huh?
>
> Interesting.
>
>> git merge $(git rev-parse ":/Merge branch 'jk/generation-numbers' in=
to pu")
>> error: addinfo_cache failed for path 't/t7810-grep.sh'
>> Performing inexact rename detection: 100% (91476/91476), done.
>> error: addinfo_cache failed for path 't/t7810-grep.sh'
>
> Smells like another case where merge-recursive is looking at the work=
 tree
> when it shouldn't inside an inner merge or something.
>
>> I mean, I'm merging a commit from origin/pu to origin/next when the
>> latter is basically contained in the former (except for some merge
>> commits).
>
> This falls into the "side note" category, but these days 'next' and '=
pu'
> do not share any history beyond the tip of 'master'. Every time I upd=
ate
> the 'pu' branch, it is rebuilt directly on top of 'master' from scrat=
ch by
> merging the topics in 'next' (and at this point I make sure its tree
> matches that of 'next') and then merging remaining topics on top of t=
he
> result. A topic often goes through multiple iterations of fix-ups whi=
le in
> 'next', and these fix-ups result in multiple incremental merges of th=
e
> same topic into 'next'; I do not want to see an incorrect merge when =
such
> a topic is merged in a single-step into 'master', and it is one way t=
o
> ensure the health of the merge fixup machinery (including the rerere
> database) to attempt from-scratch-the-whole-topic-at-once merges and
> verify the result.
>
> The merge you attempted will have a lot of "the history leading to th=
e
> current commit added/modified in a certain way and the history being
> merged did the same modification independently" kind of conflicts tha=
t
> should resolve to no-op.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

I think it would be great if at some point you could write a detailed
tutorial of how you maintain git (using example topics, example patch
series and pull requests, and follow-along command sequences, etc.).
Most importantly, it would be nice to see an explicit description of
the maintenance properties you are trying to achieve with your
workflow.
