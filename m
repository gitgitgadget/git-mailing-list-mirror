From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re:
Date: Thu, 7 May 2009 20:18:01 +0200
Message-ID: <81b0412b0905071118q46eb98b0k20f148e6a179a81f@mail.gmail.com>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504>
	 <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com>
	 <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bevan Watkiss <bevan.watkiss@cloakware.com>
X-From: git-owner@vger.kernel.org Thu May 07 20:18:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M28Ak-00028a-PV
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 20:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756514AbZEGSSG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 May 2009 14:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755022AbZEGSSF
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 14:18:05 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:30837 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbZEGSSD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 14:18:03 -0400
Received: by fk-out-0910.google.com with SMTP id 18so516423fkq.5
        for <git@vger.kernel.org>; Thu, 07 May 2009 11:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mEbHmiNUqvh6P0/1+Qs4QWV/uJo7oxl5lGJGSQ1IhVk=;
        b=YsFq4keMb3yO+X70pGkcPTB4CMONw15i4YguoQp5t3zayvKen4VUh2eQsFqbyLeU4K
         cbvVcmEaXebEfhdXmklKkNjwVxkNdfNrKaO665y8e6JB7rTCyDvBiPyMG1oXFEafnPRV
         Vjw3F6JB7WUnxsCNEAdDzrBt4dMC/YNsiVNxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UWF0yQb51Ih/8YQF1qvDxyITUs8Mp9fFnBpbvWEp425eZ3QT0MwKMVWIHt4tm0XWb+
         e3KcbJ5K7UFpFb8bhASR6rAGdeDng4L7AXtC+BRSzui1lkrAIiTEfL1RJSSsicgc0RMQ
         42oQJgexJ4ohiRKJ51xjwPINvVlsBL3yoI1UQ=
Received: by 10.204.59.145 with SMTP id l17mr2258981bkh.28.1241720281844; Thu, 
	07 May 2009 11:18:01 -0700 (PDT)
In-Reply-To: <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118501>

2009/5/7 Bevan Watkiss <bevan.watkiss@cloakware.com>:
> It's the looking for local changes I'm trying to avoid. =C2=A0Doing a=
 reset still
> goes over the tree, which isn't helpful.

The stat(2) is slow? Then try setting core.ignoreStat (see manpage
of git config) to true: git config core.ignorestat true
and read below.

> Basically I have a copy of my tree where only git can write to it, so=
 I know
> the files are right. =C2=A0The NAS box I have the tree on is slow, so=
 reading the
> tree adds about 10 minutes to the process when I only want to update =
a few
> files.

Try "git checkout origin/master". It uses index and shouldn't checkout =
files
which are uptodate with the index. And actually, git merge should fast-=
forward,
in your case and will update just the changed files...

Of course, you can always compare HEAD and origin/master, and resolve
the changes yourself (see git diff -z --name-status), but it is unlikel=
y to be
any faster.
