From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 24/31] rebase: extract code for writing basic state
Date: Tue, 4 Jan 2011 21:40:22 -0500 (EST)
Message-ID: <alpine.DEB.1.10.1101042134180.11516@debian>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <1293528648-21873-25-git-send-email-martin.von.zweigbergk@gmail.com> <201101042019.24223.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 05 03:40:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaJIx-0004rs-Dg
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 03:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370Ab1AECkd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 21:40:33 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50849 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab1AECkb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 21:40:31 -0500
Received: by qwa26 with SMTP id 26so15215892qwa.19
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 18:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=/l4zVR8v6J87sOhIGZ7cVVAVMRoWmDZpPFLo6nStJuc=;
        b=HRgVK9Mc22niU6P02QnxAcNmgplc57ty3pw2W9LDQiVrUDTluwFtscMA7O78EB5Zxe
         ZJ3dTGT7Jo+7Y/hBY7/yfCdCbX+wXAqr3H3k41888HicinQhOYQu78DOoVMuBzWz0g5k
         rjr0C6+QSgQ1gHR2f8+6oZKyL8Jt7g5ufN2fs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=HSBbk6HUwGjG63lMTpAYnK9UQBOM1gyewlAMMXjPj7Z817qIuQ05AyjL4tRnNfWI5a
         83xDna5XyBGdR2vgWVGXIo+vltQl3j8Ku7a5FQcDdLy75ZPzbhZyiRGQMg4dTwfKv9Gm
         DB8j5+DZEkwrYfl6a89k0oOuEXz47p5GVNd/U=
Received: by 10.224.36.202 with SMTP id u10mr11599718qad.316.1294195230912;
        Tue, 04 Jan 2011 18:40:30 -0800 (PST)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id nb15sm12343714qcb.38.2011.01.04.18.40.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Jan 2011 18:40:29 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <201101042019.24223.trast@student.ethz.ch>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164542>

On Tue, 4 Jan 2011, Thomas Rast wrote:

> Martin von Zweigbergk wrote:
> > Note that non-interactive rebase stores the sha1 of the original head
> > in a file called orig-head, while interactive rebase stores it in a
> > file called head.
> [...]
> > +	if test "$type" = interactive
> > +	then
> > +		echo "$orig_head" > "$state_dir"/head
> > +	else
> > +		echo "$orig_head" > "$state_dir"/orig-head
> > +	fi &&
> 
> Do we have to cater to the use-case where the user starts a rebase,
> downgrades at a conflict, and then continues?

I'll let Junio answer that.
 
> If not, you could read 'orig-head' first and fall back to 'head', only
> writing 'orig-head' in the state saving independent of the mode.  That
> would give us the chance of removing the redundancy at some point.

Makes sense. Given that the answer to the previous question is a "no",
I'll change this as well in the next iteration.


/Martin
