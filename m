From: Yann Simon <yann.simon.fr@gmail.com>
Subject: Re: Error with git svn show-ignore: forbidden access
Date: Mon, 14 Sep 2009 09:30:44 +0200
Message-ID: <551f769b0909140030l6d4c46c1r30fb8b8a4313b741@mail.gmail.com>
References: <551f769b0909010246u524599bcoc5b227f4a6279259@mail.gmail.com>
	 <20090905055708.GA22272@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 09:30:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mn61T-0000zo-RK
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 09:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbZINHao convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Sep 2009 03:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbZINHan
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 03:30:43 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:47787 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbZINHam convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Sep 2009 03:30:42 -0400
Received: by fxm17 with SMTP id 17so638314fxm.37
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 00:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lqyDXC/E5T3Dw4Bh7t4Pxog04pO87XvD1hmlgBZOewE=;
        b=ugQpeGv2Qmp7+q8BcLkHbrx6VRXAFH2iZfXiD764hi08WXrWpP8GSFSYwWk5u3BXFR
         YbIyVkyF4Pdf25tVOOvADAI1bDSdx0Tw0sa0ErdUhwW2E7ZMeijWxL1hyWhOcowJYU9U
         bQXs73rdeWTGEjwafxh8UYkLHzEKIPryCtdu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EdZWVjNKK1V3u53pAziDpRmhTBMsDM4ias5a6WA85lKhu1zUi64mMDIrTuy5udT33v
         J02AcwwliZyz0gTzbYoRobKIQEB/WBn4Nm2Cm1EFtA7cGKmwYrSs2p0WLIQ/Op/Zrx36
         WR8pVsf/WeNt1rplcda7cy9bnxfudSizLkTb4=
Received: by 10.103.86.22 with SMTP id o22mr2542272mul.102.1252913445026; Mon, 
	14 Sep 2009 00:30:45 -0700 (PDT)
In-Reply-To: <20090905055708.GA22272@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128440>

Hi Eric,

2009/9/5 Eric Wong <normalperson@yhbt.net>:
> Yann Simon <yann.simon.fr@gmail.com> wrote:
>> with git version 1.6.4:
>>
>> $ git svn show-ignore > .gitignore
>> RA layer request failed: Server sent unexpected return value (403
>> Forbidden) in response to PROPFIND request for
>> '/repos/XXX/YYY/ZZZ/trunk/aaa' at /usr/lib/git-core/git-svn line 224=
3
>>
>> Is git svn show-ignore making request to the svn server?
>
> Yes, git svn has to read the svn:ignore property remotely since it
> doesn't do anything with it when it fetches. =C2=A0Do you have read
> permissions to /repos/XXX/YYY/ZZZ/trunk/aaa on that repo?

No I do not have permissions to /repos/XXX/YYY/ZZZ/trunk/aaa.
I did some more tests and found out that git svn fetch could care with
this and checkout every folders in trunk except aaa.
Git svn fetch and git svn ignore do not have similar behavior?

> For everything besides initialization/clone, git svn reads the url in
> your $GIT_CONFIG. =C2=A0--minimize-url is only used for the initial s=
etup.
>
> You can edit it to move the URL down/up a level if you edit your
> corresponding fetch/branches/tags lines:
> [...]

I tried that and it works. Tanks a lot!

It was easy in my case because there are only 2 folders in trunk, one
I can access, and one I cannot.
But let's suppose there are x folders in 'trunk', and only one of them
cannot be accessed.
In that case, the configuration could be very complex, is not it?
But that latter configuration is probably unlikely to be used. If
someone wants to restrict access, he/she would use one folder for
every one, and one folder for restricted access.

---
Yann
