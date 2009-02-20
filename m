From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Sat, 21 Feb 2009 00:35:59 +0100
Message-ID: <2c6b72b30902201535q2466b8fbtce746a5263ebf320@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk> <op.uo9di902a8ed4e@dellschleppa>
	 <2c6b72b30902121424o5d4ac0d7u67a7afb3b861aa19@mail.gmail.com>
	 <op.uo9hiqqqa8ed4e@dellschleppa>
	 <2c6b72b30902151547q5bf183f2q1e846f261825671c@mail.gmail.com>
	 <op.upgqjej6a8ed4e@dellschleppa>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tilo Schwarz <tilo@tilo-schwarz.de>
X-From: git-owner@vger.kernel.org Sat Feb 21 00:37:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Laew1-0003YP-4J
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 00:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249AbZBTXgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 18:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753995AbZBTXgE
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 18:36:04 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:39515 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbZBTXgC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 18:36:02 -0500
Received: by bwz5 with SMTP id 5so3125201bwz.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 15:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FrEXgGjZiDSMbTas939OBZEiTu0dWzZSyDWTeLB2NeA=;
        b=jD+46DQTRnaUqg/tUbLh39gV5/qF33VEKpd4iVO2FAhNd9KnPKQrTh1Nv3eHY74+9c
         D2/NjJrFths9KWWoavv57g+783UOU3DkTmdCHzCCgTW4bz/Oey6S+LjT1I3SRvmfehqU
         1uHNOh7/ddNOjUlsvjVme9fVI5bnkU/dHhssc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mHyKryBwU5+vMfTuP8jwNaP82wwBJ/2Vfc8GiVkBbfYaT1pNksX9EvDQRxNef3G2z3
         FJwQ/GjHd4eu0OzzoTqMKvovXKVMATkry9vN2OgL9L6bBA3ZykXUKqiZasuH6J/rjIYd
         daBYFYTSH4RNIYTJBaq58eMDifucEbwQd/LFo=
Received: by 10.181.197.6 with SMTP id z6mr453623bkp.119.1235172959783; Fri, 
	20 Feb 2009 15:35:59 -0800 (PST)
In-Reply-To: <op.upgqjej6a8ed4e@dellschleppa>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110906>

On Mon, Feb 16, 2009 at 22:12, Tilo Schwarz <tilo@tilo-schwarz.de> wrote:
> On Mon, 16 Feb 2009 00:47:05 +0100, Jonas Fonseca <jonas.fonseca@gmail.com>
> wrote:
>
>> I have thought about it. The question is if a separate view is
>> necessary or if the main view would do.
>
> I'm not sure if I understood it correctly. Do you mean, only commits are
> shown, which are heads of some branch? If so, what if more than one head
> points to the same commit?

True, it is not very intuitive with more than one branch perhaps.
However, I still think there is some overlap between a branch view,
the main view and possible also the status view. From the status view
you might want to create a new branch based on changes, and in the
main view you might want to create a branch to help backport a bugfix.

> I think I would prefer a branch view, because then one could also have a
> branch-view keymap with specialized commands. One possibility would be (just
> as example):

Maybe it is best to keep it simple and focus on your idea first and
make tig at least aware of branches. And yes, it makes sense with an
new keymap.

> The view shows something like this (here an example from the tig git
> repository)
>
>  master
> * my_feature_bar
> X my_feature_foo
>  origin/HEAD
>  origin/master
>  origin/release

OK, I have added the begining structure for a branch view, bound to
'H' by default. It does not support any actions besides refreshing and
viewing the branch history. So there is still some work to achieve the
easy access to branch commands.

>> bind main A !git branch %(prompt:^wip/[a-z-]+$:Name) %(commit)
>
> Ahh, ok, so tig would issue a prompt and ask me for the name?

Yeah, I don't know if it will be useful.

> BTW, is the git list the right list to discuss bugs / patches for tig?

Yes please.

-- 
Jonas Fonseca
