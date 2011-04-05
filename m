From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Git exhausts memory.
Date: Tue, 5 Apr 2011 18:13:44 +0700
Message-ID: <BANLkTi=nzY7wFTr3647SYkSMHx=AityRgw@mail.gmail.com>
References: <BANLkTin=yUtzbZjs_92FHDfs62VFFuLHwg@mail.gmail.com>
 <alpine.LFD.2.00.1104021103130.28032@xanadu.home> <BANLkTikRGQ45xvWvisMhXi4Hu2r_0GS=Gg@mail.gmail.com>
 <alpine.LFD.2.00.1104031110150.28032@xanadu.home> <BANLkTinCwZG3+0Ss8o9ODptg=L8LKKN7aQ@mail.gmail.com>
 <BANLkTinU7x16yp+y-HW9UhkVn9SftOJCcA@mail.gmail.com> <20110405022235.GA4414@spacedout.fries.net>
 <BANLkTik6XoWaehp7=5fxwcyhkTHWCO8-Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Fries <david@fries.net>, Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Alif Wahid <alif.wahid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 13:14:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q74DF-0008SF-Ks
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 13:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087Ab1DELOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 07:14:15 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:50035 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474Ab1DELOO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 07:14:14 -0400
Received: by pxi2 with SMTP id 2so173974pxi.10
        for <git@vger.kernel.org>; Tue, 05 Apr 2011 04:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=sdK4HIcefBmYlrwjzGKUVv2DPSsxa9EngTvFTjlEIpc=;
        b=SnD9exSerlqieHZ3X2YSQujC3MkXJ/sY1/9D5jyccWpf5w7xCw/P+TzZd9C6M5NGOP
         jXrK/UVMYRRcnuLTxHCDD0lD/RMWmKhWZl8EmiBgWShLE3HvujplleIxwRvy9Fg5yuK6
         6HSrXv+J1D58Ayl09Mdp9c+D0G+687pG9T75k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=e6Itoap5ViP/N+FvhPrc5VhGT51fPOScc0+QBXoH0+rqeYW0gGp03L7e1PDTnB3sa4
         b23z7G/eXMtDLK9Svm2XZI0OJ4tZe/amLrBATkhwBrDgvHG2/ZEip+b4Y11AUarwsFxP
         F07evm5jYq/shGDNi+B0ICAAy0OW2momDgkiw=
Received: by 10.142.62.6 with SMTP id k6mr7478717wfa.100.1302002054174; Tue,
 05 Apr 2011 04:14:14 -0700 (PDT)
Received: by 10.68.54.201 with HTTP; Tue, 5 Apr 2011 04:13:44 -0700 (PDT)
In-Reply-To: <BANLkTik6XoWaehp7=5fxwcyhkTHWCO8-Eg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170878>

On Tue, Apr 5, 2011 at 11:35 AM, Alif Wahid <alif.wahid@gmail.com> wrote:
> It seems to me that if "git init" creates a $GIT_DIR/info/attributes
> file by default with a line like "*.gz -delta", then that will disable
> the memory intensive deltra compression plumbing for those special
> cases where people need to track gzip archives (similarly another line
> "*.bz2 -delta" for bzip2 archives and so on). Since these files can't
> supposedly be compressed much more, I think Git ought to have a
> default heuristic to not attempt any compression on them.

I was thinking of very similar thing on my ride home. But I selected
files on size, not extension. With the (hopefully coming soon)
introduction of pathspec magic specifier [1], we can teach git-attr to
express "files that have size in a range [a,b]" (either a or b can be
infinite). The rest is like yours: applying -delta on selected files
then put such a rule with a default range in default template.

[1] http://thread.gmane.org/gmane.comp.version-control.git/169813/focus=169844
-- 
Duy
