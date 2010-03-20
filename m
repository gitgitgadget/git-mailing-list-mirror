From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Allow passing of configuration parameters in the command 
	line
Date: Sat, 20 Mar 2010 16:09:47 +0700
Message-ID: <fcaeb9bf1003200209r6051f906kf2a0a1e96752845e@mail.gmail.com>
References: <81b0412b1003190742v6e5577c9wb121d5e3cbc9fccd@mail.gmail.com>
	 <7vmxy4kss9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 10:10:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsuh6-0005cO-CP
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 10:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888Ab0CTJJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 05:09:49 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:61683 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877Ab0CTJJs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 05:09:48 -0400
Received: by qw-out-2122.google.com with SMTP id 8so784742qwh.37
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 02:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=VRwlUz+k3sFVdY0mhjM0vDvtG7cUMb71y09QpKk7A48=;
        b=DhHRRTFYEbgi0uxmvKcCpVP43I2pigAtmgclynRG0ny503pXzsiFHrrQabBMLyKv6y
         35J83DOHjLNtVJcMwz89tK6ZbH91396/S1qD0EdH2nfpygmU0pjypdkCwdK7HOh3MtG2
         EMKw2d7Sf4ljBETmTBNt2d+rfYot/5OvVPgWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=TZK/4gWMQG+tPaTJenntNavcJu+bojSbj6C13aVc5KZ+31sJR6kn1mYRC6pVhuPRng
         tg72ry8jLazsI1McnocFbDgdas8yLx5IUTXsfo5wvnZnTMVHapH5Yw/VfJuPvNofMED2
         MnL7c1Xj3YPdvTZMF/5l04QazgogqCOAczWeE=
Received: by 10.229.38.69 with SMTP id a5mr273657qce.15.1269076187673; Sat, 20 
	Mar 2010 02:09:47 -0700 (PDT)
In-Reply-To: <7vmxy4kss9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142696>

On 3/20/10, Junio C Hamano <gitster@pobox.com> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>  > The values passed this way will override whatever is defined
>  > in the config files.
>  >
>  > Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
>  > ---
>  >
>  > Someone wanted to have this once. I accidentally remembered
>  > that when I wanted to temporarily set some config parameter
>  > (format.suffix?). From looking at code it seemed simple enough,
>  > so I did it.
>
>
> How does this interact with core.worktree and the setup sequence in
>  general?

To me it looks like another config file to the config stack. No thing
can go worse (except that if you have core.worktree in
$GIT_DIR/config, now also specify -c core.worktree=foo, then
core.worktree code would be called twice).

However, specifying "-c foo=relativepath" may surprise users. Current
working directory may have been moved when that config is used.
-- 
Duy
