From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Test that we can add a new file to a non-topmost patch with refresh -p
Date: Mon, 21 Jul 2008 23:01:17 +0100
Message-ID: <b0943d9e0807211501g68d1cffeh12bcb34df0f28dae@mail.gmail.com>
References: <20080718084127.GA7042@diana.vm.bytemark.co.uk>
	 <20080718170225.10086.17504.stgit@yoghurt>
	 <20080718180109.GA14825@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Jon Smirl" <jonsmirl@gmail.com>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 00:02:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL3Sg-0006ZR-SW
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 00:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624AbYGUWBU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jul 2008 18:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755554AbYGUWBU
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 18:01:20 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:17930 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754538AbYGUWBS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jul 2008 18:01:18 -0400
Received: by wa-out-1112.google.com with SMTP id j37so912252waf.23
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 15:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fMvWmLcC8aUSaGG5UJKecBzOP0lw58nuLEcEZO7DDmg=;
        b=hAC0/zSStm0abr3FOnsGyFTkLHRoIiyGmDIHX4ivB5hV0K80aS6IYe3rsB/yqFZRsb
         FRpYwVdMhRM4dFm4hXZoC0lz7SJ1tWPcEYZYpCSjFQPLKMzFD2NSFlMcd12ilRA3Ypmy
         xRjnYf3BlrghqYWAKf22eK26ogqCTTikWcQzI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=s6VtbLUwXCol5JD0U9yiraguK/4+nopi/AuiBADzlvygpntGokWdU41bi23KWmMK3Z
         yBeH3AQ5zm844yCk7+wE00EuWu8Q7Ikjb/zHHr+MzhBFEu5V0TmltjbnetWR9YSy68/4
         PdWl4XckP4597HqN+WSoTm29VBy46yyQfOaKc=
Received: by 10.114.56.1 with SMTP id e1mr3113467waa.69.1216677677352;
        Mon, 21 Jul 2008 15:01:17 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Mon, 21 Jul 2008 15:01:17 -0700 (PDT)
In-Reply-To: <20080718180109.GA14825@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89412>

2008/7/18 Karl Hasselstr=F6m <kha@treskal.com>:
> On 2008-07-18 19:03:06 +0200, Karl Hasselstr=F6m wrote:
>
>> We currently can't -- this is bug 12038, found by Jon Smirl. See
>>
>>   https://gna.org/bugs/index.php?12038
>
> OK, the problem is that to pop the patches on top of the one we are t=
o
> refresh, we call pop_patch(keep =3D True). This in turn calls
> git.switch(keep =3D True), which resets the index (but is careful to =
not
> touch the worktree).

Yes.

> I'm not quite sure how to fix this in a simple way -- the code simply
> assumes that the index contains nothing of interest. And since I
> already have a rewrite of refresh that handles this and a handful of
> other cases that the old code does not, I'm kind of disinclined to
> undertake a larger restructuring of the code.
>
> Catalin, what do you think?

I don't think we should spend time on fixing the current code as you
already have a new implementation. Maybe we could add a simple test
and refuse refreshing other than the topmost patch in case of files
added to the index.

--=20
Catalin
