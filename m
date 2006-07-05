From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stgit: bunch of bugreports/wishes
Date: Wed, 5 Jul 2006 15:29:15 +0100
Message-ID: <b0943d9e0607050729v75a5e6deq6baff0350b422122@mail.gmail.com>
References: <20060622221425.GA7851@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 05 16:30:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fy8Nj-0001Kz-Aq
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 16:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWGEO3S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 10:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWGEO3R
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 10:29:17 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:10513 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964885AbWGEO3P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jul 2006 10:29:15 -0400
Received: by nz-out-0102.google.com with SMTP id k1so824864nzf
        for <git@vger.kernel.org>; Wed, 05 Jul 2006 07:29:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LggwcsqE1w/3cwvkXbbAZhN3KVC+MciwiLXO54rSq9ziC1ymPCZG5ohBQdNRA2jtFtm1ywaeybKtzAeHgjZYdpbB4S/VnrRseRuZHS+FbJB+Fg792cuCgUdhnOGDAFYrjWPlGWgda2ax+B6uJkwIFoDlvX88BTJ8VWwe8JE9sm0=
Received: by 10.36.58.12 with SMTP id g12mr6233916nza;
        Wed, 05 Jul 2006 07:29:15 -0700 (PDT)
Received: by 10.36.250.28 with HTTP; Wed, 5 Jul 2006 07:29:15 -0700 (PDT)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20060622221425.GA7851@nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23350>

On 22/06/06, Yann Dirson <ydirson@altern.org> wrote:
> - "push --undo" is not robust.  On the occasion reproduced below, I
> had to rollback the push myself by hand-modifying the stgit data,
> which took me some effort.  I'll have to gather precise info, but the
> issue occurs on patch reordering, on a genuine conflict, and seems to
> be involve a change to a non-existent file, when that file would have
> been added by a non-applied patch originally below the one I attempted
> to apply.

I fixed this bug and I'll push the changes tonight. It was caused by a
"git-diff-index" call with files but without the "--" argument. When
the file was actually missing from the repository, git was confused
and returned an error. The 'status --reset' command was failing in
this situation as well.

-- 
Catalin
