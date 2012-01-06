From: demerphq <demerphq@gmail.com>
Subject: Aborting "git commit --interactive" discards updates to index (was:
 Re: [ANNOUNCE] Git 1.7.6)
Date: Fri, 6 Jan 2012 17:37:14 +0100
Message-ID: <CANgJU+X+qLe3Aqy_ZpoSDKMuf=8=OxVvpkt0tGmSi=KVgti3HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 06 17:37:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjCnD-000766-4Q
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 17:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758757Ab2AFQhQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jan 2012 11:37:16 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48021 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab2AFQhP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jan 2012 11:37:15 -0500
Received: by yenm11 with SMTP id m11so733674yen.19
        for <git@vger.kernel.org>; Fri, 06 Jan 2012 08:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ptyxneASGkkPlgbNtuN6Nn1tvnxzQS1pqw+afA21tyc=;
        b=QyW8R/JvOmX0G+mNe8FQ8QVFDe9zIT6j9u4ItK+pZTV3ZOkx7bt9zJdxE+g/FOgnza
         EgfDE/zUUpx3HcaUND1HQo6xbsfdZ3vk34GQeFWHgW0nVI0/LT0/TgAZaPi7/qQz3O0R
         wzIhI0S2O6viNZEZZNE3UGf6xw8jqAlMziN80=
Received: by 10.236.139.234 with SMTP id c70mr8338624yhj.33.1325867834406;
 Fri, 06 Jan 2012 08:37:14 -0800 (PST)
Received: by 10.236.63.2 with HTTP; Fri, 6 Jan 2012 08:37:14 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188035>

On 27 June 2011 17:59, Junio C Hamano <gitster@pobox.com> wrote:
> The latest feature release Git 1.7.6 is available at the usual
> places:
>
> =A0http://www.kernel.org/pub/software/scm/git/
[snip]
> =A0* Aborting "git commit --interactive" discards updates to the inde=
x
> =A0 made during the interactive session.

Hi, I am wondering why this change was made?

I can sort of understand if people do CTL-C during an interactive
commit that throwing the results away might be useful (although I
don't see why personally), but what I don't understand at all is why
it happens when the "add --interactive" is completed properly, but the
user decided not to actually commit. For me and a number of colleagues
the normal reason we exit the commit part (that is exit the editor
without modifying the commit message) is because we realize we forgot
something, such as adding a new file, and want to exit out and re-add
it. I am writing this after spending about 45 minutes showing a
colleague how to use git commit --interactive, when we realized that
we had forgotten to add a file. Needless to say he wasn't too happy
about losing 45 minutes work and having to redo it.

The new behavior potentially means that a lot of work (such as via the
'e' option) is instantly discarded. I don't understand why this is
perceived to be sensible behavior -- I thought the default policy for
git would be to not lose work!

I would really like an git config option to revert to the previous
behavior of not throwing away what I staged, or even better have git
commit --interactive ask me what I want to do, after all, it is an
interactive process so it seems reasonable it asks before it does
something like throw away work.

Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
