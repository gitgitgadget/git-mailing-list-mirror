From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: =?windows-1252?Q?Re=3A_Can_I_specify_a_=93chunk_size=94_for_git_svn_fet?=
	=?windows-1252?Q?ch=3F?=
Date: Mon, 9 May 2011 19:29:43 +0200
Message-ID: <BANLkTinpK1DtgSBq=znBb=ung5FcttLn_g@mail.gmail.com>
References: <BANLkTinXvjQth3wBmZUu8A0QszCXm8dc6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Zak Whaley <zak.whaley@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 19:29:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJUHG-0002Ku-Ha
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 19:29:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455Ab1EIR3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 13:29:45 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63414 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084Ab1EIR3o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 13:29:44 -0400
Received: by iyb14 with SMTP id 14so4485623iyb.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 10:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=hrbBJ6HuQ9SuINvISUK4PmYeqix8BS4r1Q942SgmWQk=;
        b=shzsumsXb4n/Jml9rceQLZ7UPg+l8y5azoAdrF7VZXmKDK/K/yjLRW7IEX8NBnu9ft
         Gfe80EW4LVogLh2yFnxBipSh4UFWPyBS8zsMSwF7LHt0sJ5LB2HlBpcWTUPry98mSbjm
         PgOB4Y+zyt118ap5i6y00y3mechIMX26GHgD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=wNHVCw/iHbhKI16X85KZpFrWOuTOZ6s0G45rnaYHt5w3ClbAytVMUUuFTU7xLnu+ay
         C5TvoxhN/dCYrD4+h3FLVyrv0r+irA33qCFo7OD9nQACWvKt/G1kQpFGbqaoNek+6WCg
         d1ZjkMX9WpmsmfWWntQAk7QFd5WVtOdd8pdVU=
Received: by 10.231.197.27 with SMTP id ei27mr4529061ibb.198.1304962183695;
 Mon, 09 May 2011 10:29:43 -0700 (PDT)
Received: by 10.231.159.143 with HTTP; Mon, 9 May 2011 10:29:43 -0700 (PDT)
In-Reply-To: <BANLkTinXvjQth3wBmZUu8A0QszCXm8dc6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173247>

> Is there a way to tell git-svn fetch to get an index in multiple
> chunks of a particular chunk-size or to retain the partial index if
> the server hangs up?
>
> Spec info:
> Win7 with Cygwin 1.7.9-1
> git & git-svn 1.7.4-1
>

If you are willing to leave out the big zip file from your repository,
you could try the following:

Make two clones, one before the over-sized commit, and one for
afterwards.  Say the big commit was committed in revision 36, it would
be something like:

git svn clone -r1:35 url first-clone
git svn clone -r36:HEAD url second-clone

Now fetch the second repo into the first repo, and tie the history
together using _grafts_. I've made a screencast with an example of
grafting like this here:

http://blog.tfnico.com/2010/10/gitsvn-6-grafting-together-svn-history.html

(I'll cross-post this answer to StackOverflow as well).
