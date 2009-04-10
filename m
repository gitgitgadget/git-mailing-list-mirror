From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [PATCH] git-add: introduce --edit (to edit the diff vs. the 
	index)
Date: Fri, 10 Apr 2009 10:03:19 +0800
Message-ID: <46dff0320904091903p57df51c8ice90648ab7a4baa6@mail.gmail.com>
References: <cover.1239225986u.git.johannes.schindelin@gmx.de>
	 <61c07126e28aba0a36730da06112bd2d16eabc1b.1239225986u.git.johannes.schindelin@gmx.de>
	 <46dff0320904081900n7bff2280rc49315e3db427919@mail.gmail.com>
	 <46dff0320904091843p3e034647j3c78506b4d0c2b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 10 04:06:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls68S-0000lw-W1
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 04:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbZDJCDV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2009 22:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbZDJCDV
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 22:03:21 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:61338 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbZDJCDU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2009 22:03:20 -0400
Received: by rv-out-0506.google.com with SMTP id f9so868887rvb.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 19:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eAHurVfqFpor1EnENucpkE3lGVK20rpE0qyG/T74Qd8=;
        b=bM01FxB+kfpr1RnwER9SZr6iBW+6s0UAn+XJJTaJ1+8njvJDjA/INhXfjMiL6cyFSK
         4N4Z8zjZE60opogZ12hEVJ0fNQ4dMWXJzHEHcuxV7ryV3J/c9oxi2LLSt9cmv43btqzu
         OBK9ZLJIzgGxbfNTPCECrCMThpvsJjsbMEa+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kgVPfIML+RLbXO8eWPqCiFPxUC5tXsyURFer4ruFc8xCFKladDfzQsblm5pN1a4LYb
         WCJlB8dFgd7UnabuuSrAphpmktBovhcIGM5nFRMXCiSjWBMgxwcH7wbU5Y+fbMt1CjGv
         EBpexcLw/Q2AsFRPULS2L+63j0KmFPh/k8i3A=
Received: by 10.114.131.1 with SMTP id e1mr1677853wad.222.1239328999798; Thu, 
	09 Apr 2009 19:03:19 -0700 (PDT)
In-Reply-To: <46dff0320904091843p3e034647j3c78506b4d0c2b4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116233>

On Fri, Apr 10, 2009 at 9:43 AM, Ping Yin <pkufranky@gmail.com> wrote:

> How about this?
> =C2=A0'add --edit=3Dpatch' to edit the patch and "add --edit=3Dindex"=
 to edit the index
>

One usecase for edit index

After a big change in foo.c in the worktree, you find a typo in foo.c.
You want to fix the typo first before commit the big change. But the
change is so big that you can't just fix the typo in worktree foo.c
and then use "add -p" to pick the typo fix first.

So you can

git stash
fix typo and commit
git stash apply and resolve the conflict

With 'add --edit=3Dpatch', you can
git add --edit=3Dpatch foo.c

an editor is fired up with the foo.c in index and worktree open side
by side. And you can fix the typo in both index and worktree file.
When exiting the editor, the index file is modified, and no conflict
to resolve.
