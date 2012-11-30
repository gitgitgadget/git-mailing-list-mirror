From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH v5 0/2] submodule update: add --remote for submodule's
 upstream changes
Date: Thu, 29 Nov 2012 20:11:20 -0500
Message-ID: <CABURp0piLAG+hEsav-uro+nq9ZRZ9CFFjVG8VKYk3ZtYvRi8=A@mail.gmail.com>
References: <CABURp0oSo9ACFKkBEK1_qNu2mEAu1=nUJxnROaRsXiaWvHih=w@mail.gmail.com>
 <cover.1354130656.git.wking@tremily.us> <20121129191326.GC27409@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Fri Nov 30 02:12:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeF9Z-00080l-4t
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 02:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778Ab2K3BLm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Nov 2012 20:11:42 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42232 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab2K3BLm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Nov 2012 20:11:42 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so70867lbb.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 17:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MuHojS2O+azOZILOuUgLuIS4GRSF9pVRk6FWpfAx6vE=;
        b=GutaP8LlqLj67BaWODW+rH0ViPRnuKMfWyv0ruM+4RwH9w6cFdJKilqPCMoJ1Dusuv
         DyjWXDQ6bTIzX9miKvSly+xqSQpRJDl+xzkWfF9VhfeI3xQb4JezHZTgMBLTuFvZaw2v
         wMHhi+aTfaFsr6K/5h1zF0Emlymc1YtiKyZccf5NS2WVE8QAnowEYbUmhe1jjmmPokZK
         EIExIdfrNFbxJJfHG/YgYApUfwTjIirMxK9anndkGAADPsui5PRgwUJJnDLWin/7sgGf
         DMGMQJ+kI1vPbtn/+j3VEoHR/wPax2Y/QuIDx+HbOjitA2gksRJfyrdnaqTvmOh9suo4
         c8jQ==
Received: by 10.152.111.131 with SMTP id ii3mr23102560lab.37.1354237900330;
 Thu, 29 Nov 2012 17:11:40 -0800 (PST)
Received: by 10.114.38.3 with HTTP; Thu, 29 Nov 2012 17:11:20 -0800 (PST)
In-Reply-To: <20121129191326.GC27409@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210885>

On Thu, Nov 29, 2012 at 2:13 PM, W. Trevor King <wking@tremily.us> wrot=
e:
>
> On Thu, Nov 29, 2012 at 01:29:12PM -0500, Phil Hord wrote:
>> On Fri, Nov 23, 2012 at 12:54 PM, W. Trevor King <wking@tremily.us> =
wrote:
>> > [snip initial thoughts leading to the update --remote v5]
>>
>> I was thinking the same thing, but reading this whole thread a coupl=
e of
>> weeks late.  Thanks for noticing.
>>
>> Moreover, I think that 'git submodule update --pull' is also the wro=
ng way
>> to spell this action.   Maybe you are misled from the outset by your
>> current workflow:
>
> Did you see my v5 (add --remote) series?

Eventually, I did.  Sorry for the out-of-order replies.


>> For that reason, I don't like the --pull switch since it implies a
>> fetch, but I will not always want to do a fetch.
>
>   $ git submodule update --remote --no-fetch
>
> will not fetch the submodule remotes.

This seems precisely backwards to me. Why not use

  $ git submodule update --remote --fetch

to do your "default" behavior instead?   I suppose I am arguing
against the tide of the dominant workflow, but the fetch-by-default
idea needlessly conflates two primitive operations:  "float" and
"fetch".

>> I don't know which remote I should be tracking, though.  I suppose
>> it is 'origin' for now, but maybe it is just whatever
>> $superproject's HEAD's remote-tracking branch indicates.
>
> With the --remote series, I always use "origin" because that's what
> `submodule add` should be setting up.  If people want to change that
> up by hand, we may need a submodule.<name>.remote configuration
> option.

I've always felt that the "origin" defaults are broken and are simply
being ignored because most users do not trip over them.  But ISTR that
submodule commands use the remote indicated by the superproject's
current remote-tracking configuration, with a fallback to 'origin' if
there is none.  Sort of a "best effort" algorithm, I think.  Am I
remembering that wrong?


>> I am not sure I want the gitlinks in superproject to update automati=
cally
>> in the index, but I definitely do not want to automatically create a=
 commit
>> for them.
>
> Commits are dissabled by default (see my recent --commit RFC for how
> they would be enabled).
>
>> But I really don't want to figure out how to handle submodule
>> collisions during a merge (or rebase!) of my superproject with chang=
es that
>> someone else auto-committed in his local $superproject as he and I
>> arbitrarily floated up the upstream independently.  There is nothing=
 but
>> loathing down that path.
>
> This is true.  I'm not sure how gitlink collisions are currently
> handled=85


They've always been trouble for me.  But it may be that I am ignorant.

Phil
