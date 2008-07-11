From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: how to undo a git merge?
Date: Fri, 11 Jul 2008 20:55:43 +0200
Message-ID: <bd6139dc0807111155x46a9f6acnf2d585f62342f4a6@mail.gmail.com>
References: <fa7d16350807110916x689e316fr6bae01f28e2e1acb@mail.gmail.com>
	 <20080711161923.GE10347@genesis.frugalware.org>
	 <fa7d16350807111107o40c5cbb5xc06c3c56b16b7499@mail.gmail.com>
	 <20080711181413.GI10347@genesis.frugalware.org>
	 <fa7d16350807111146m18b0ca9q6902c2167bfd3512@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: ff <ff@member.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:57:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHNnj-00014z-UE
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 20:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757465AbYGKSzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 14:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbYGKSzp
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 14:55:45 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:3730 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757460AbYGKSzo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 14:55:44 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1352262yxm.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 11:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ef0WaTk/5hxXzUAHsGNoMsy95h9GiFEa0PP9JF7g7Qk=;
        b=u5bwYlzrQN6FyCFQv/Hu2pciUnT340/IomMYOST2qdDr8V5eQg8bknXCmBfYughXDt
         LbYt4Bv+hVh8iAl1O+60KgCHjtNmMCDWpBoTKgePRFYoEh4jx9n6rCt4i0MfyG4NDw4d
         9vBXDw7wSmVZ305I+V/WhFyEyXKF2B/hmsmTc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=eeFOKvKP03OQVJT7iqy3+kzXqod4ZxuVBIVtAX58IyonJS1DgzvjOQFfAGMy6vgy8Y
         tukPcq2SSVXG4uQfTO9RE2G8qKT2KhxwbbuSfZEjiOnEOwj5Pn1R383N9rGGiy6RSqMV
         AsFQ4onQWHGVjcendAp2h1v3XlLwOllXJETro=
Received: by 10.151.156.11 with SMTP id i11mr16379162ybo.106.1215802543156;
        Fri, 11 Jul 2008 11:55:43 -0700 (PDT)
Received: by 10.150.53.8 with HTTP; Fri, 11 Jul 2008 11:55:43 -0700 (PDT)
In-Reply-To: <fa7d16350807111146m18b0ca9q6902c2167bfd3512@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88159>

On Fri, Jul 11, 2008 at 8:46 PM, ff <ff@member.org> wrote:
>> For example, if you were on branch 'master' and you merged 'foo' to
>> master using 'git merge foo', and you want to revert that merge then you
>> need '-m 1'.
>
> In your example, how and why you can determine that the number 1
> represents the "foo" branch? Would "-m 2" represent the master branch?
> In your example is there any other choice for the "-m" number to use?

When you perform a merge on branch A, like so:
git checkout A  # first switch to the branch you want the merge to be on
git merge B  # now do the actual merge with the branch you want to merge with

The resulting merge commit will have the head of A as it's first
parent, and the head of B as it's second parent. With the -m switch
you can specify which parent you want to follow. If for example, you
have a three-way merge, like so ..:
git checkout A
git merge B C
.. the resulting merge commit would have A as it's first, B as it's
second and C as it's third parent. If you want to revert to the state
of C then you specify -m 3, so that the third parent is chosen. If you
performed the merge on the branch that you want to revert to, you
always specify -m 1. If you did this ..:
git checkout B
git merge A
.. and then you want to restore the state of branch A, you use '-m 2'.

-- 
Cheers,

Sverre Rabbelier
