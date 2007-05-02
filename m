From: "Dana How" <danahow@gmail.com>
Subject: Re: [RFD/PATCH] Implement pack.compression and pack-objects --compression=N
Date: Wed, 2 May 2007 11:55:15 -0700
Message-ID: <56b7f5510705021155k40b576d6ke286e65494fc8b05@mail.gmail.com>
References: <463802ED.1080200@gmail.com>
	 <7vk5vr3w8n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 02 20:55:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjJz2-0006Tm-Lg
	for gcvg-git@gmane.org; Wed, 02 May 2007 20:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767236AbXEBSzT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 14:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767233AbXEBSzT
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 14:55:19 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:4076 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767236AbXEBSzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 14:55:16 -0400
Received: by nz-out-0506.google.com with SMTP id o1so242696nzf
        for <git@vger.kernel.org>; Wed, 02 May 2007 11:55:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R7NgfcqRgWcup0yqbRwV6erL/ZAG8qYgIMZxViJ1q3I7CJdewU+E86hycubRzNM9/zKBD9vUcnSVEbFOWSMfKVgGwwRV1DLgFmsoC8J+tvzSt0cmS7fvK0LRiOB9zI5EX1VaMH/q1lhgnVbuw/OadZoeGw4zXqDLuuHN4Pl8f58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pCaOd1qQgzG+M3PaDnAoNzOqWKRVJqCq4R+nknxAL5DFebG9n4HIzpoOdPMThxyJW5SE4gvzicXtm9X6c1jC9x0VC+t1tgA9/k9o1kDqcCOWVISU7r0pn65MkNZpVDtk7uVcmS5F5xRcba7777n+r/5pBJo1khkc60NcCe70Tf4=
Received: by 10.114.170.1 with SMTP id s1mr335115wae.1178132115404;
        Wed, 02 May 2007 11:55:15 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Wed, 2 May 2007 11:55:15 -0700 (PDT)
In-Reply-To: <7vk5vr3w8n.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46044>

On 5/2/07, Junio C Hamano <junkio@cox.net> wrote:
> Dana How <danahow@gmail.com> writes:
> > Consequently,  for such a usage pattern it is useful
> > to specify different compression levels for loose
> > objects and packs.  This patch implements a config
> > variable pack.compression in addition to the existing
> > core.compression,  meant to be used for repacking.
> > It also adds --compression=N to pack-objects,
> > meant for push/pull/fetch,  if different,  or if different
> > on a per-repository basis.
> >
> > ** THIS PATCH IS UNTESTED AND MEANT FOR DISCUSSION. **
>
> I think we tweaked this area in the past, but I do not think
> the current setting was determined to be the best tradeoff for
> all workloads.  To be able to discuss the patch, I think it
> needs to come with benchmark numbers using publicly available
> repositories as guinea pigs and set of typical git operations,
> so people can reproduce and compare notes.

OK, but this patch doesn't mandate any particular setting.

Its motivation in my work environment is for pack.compression
to be what core.compression currently is,  and to set
core.compression to 0 to speed up large commits
(the resulting space-inefficient loose objects will be scrubbed away
 by a later off-line repack).
Thus,  my config settings (almost) change the gzip's behind a git-add to cp's.
Do you want me to submit timings for a git-add/git-commit -a
on a typical 50-file commit I would be interested in,
with the (new) settings that I would use?

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
