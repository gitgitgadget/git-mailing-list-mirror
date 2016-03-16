From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 05/17] rebase-options: implement
 rebase_options_load() and rebase_options_save()
Date: Wed, 16 Mar 2016 20:28:56 +0800
Message-ID: <CACRoPnS4JpNNACz4T0F0vFs3ogG+nzk-y1=zc1UrtAZKaEnggg@mail.gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
	<1457779597-6918-6-git-send-email-pyokagan@gmail.com>
	<CAGZ79kYeYzi=J=dY27FqXp72BRe-Vmm4MR5Q6dFTMUP9CxYZcg@mail.gmail.com>
	<alpine.DEB.2.20.1603160901520.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Sam Halliday <sam.halliday@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 13:29:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agAZT-0000fy-CY
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 13:29:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992AbcCPM27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 08:28:59 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:33427 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbcCPM26 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 08:28:58 -0400
Received: by mail-lb0-f182.google.com with SMTP id oe12so46952369lbc.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 05:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=cj+QlGFyVjioV1PAut7lAWDgH/o2f98OBcc6DXgQGn8=;
        b=nt+UIuNAvkoxhr3pjgaE3LW1eWv/iMoUwc1+iTPPc64LlgNOVqAxonFTGv+uMzOE9j
         dQWyLIaNpUscnvYEdG2qR+LWiSJX45/CNQpxgPMREKfIWZAufddTZLhgrcTFCSYrKZ6S
         WKj1tSOiJLUkQ5Kmm+z129dIMhjfGKY7CTZSRVZYZawDYVEO0mFleVVzeByT3s8G20jk
         +4z4aPo3dNO/UJ4952lzZ0S7+mID9ld0ekiHJfE0SrZJEMrowfYy8w1MquQ0rHM2vWpu
         Lcx9EvPAFf6fu+JfomSJEks71ONtetWc3tCbZsZJi1I1PVjReov6TJtN/z/Xxxn/mL8K
         GKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=cj+QlGFyVjioV1PAut7lAWDgH/o2f98OBcc6DXgQGn8=;
        b=nALmYE7n4OLTuZkStAs6jh6XVH2MCKDQjiwhSJF7ggEkaWesacd27+ADyVTQCfPDCP
         yFrKoqeZN5XhFAwbg5J3mlaq3snEyDVwORRn6rYLglKIFnwnrGbEBhtqysFkv18ImOkZ
         utWukE05CKeG8+BdmBpeFJrpZUUaVdI4+Ul1YQQsBrOvApyMB3GyLjiaUpiTGeK4ur90
         tVrqBa3iJnYXhGMd7/IrFEYhC8SDpiJ565KFANAcL1qzVTRj669WJIjHNGucAWnBKw7J
         Ph7T3x7/Kj+Cx5bY7Ho43RJbKvL3/ywLg+sqmvuXJ97275WGr3NwCPIdR5xwL6b/5ADF
         D6dg==
X-Gm-Message-State: AD7BkJIENw4h8VeYxAAMnWIckCBT3/Xdss5SVZCJHoipjeoVMeD5gNBAVfbowOQ9PXJcgK13HLBY9ihni4lqFg==
X-Received: by 10.112.128.225 with SMTP id nr1mr1287783lbb.101.1458131336273;
 Wed, 16 Mar 2016 05:28:56 -0700 (PDT)
Received: by 10.112.207.74 with HTTP; Wed, 16 Mar 2016 05:28:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603160901520.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288964>

Hi Dscho,

On Wed, Mar 16, 2016 at 4:04 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> In addition I want to point out that sequencer's replay_opts seem to be at
> least related, but the patch shares none of its code with the sequencer.
> Let's avoid that.
>
> In other words, let's try to add as little code as possible when we can
> enhance existing code.

Well, both git-rebase--am.sh and git-rebase--merge.sh do not use the
sequencer functionality at all, and we don't see git-am for example
needing to be aware of onto, orig-head, head-name etc.

Besides, I don't see why the sequencer needs to be aware of these
rebase-specific options. For simplicity[1], I would think the
sequencer would only need to be aware of what the todo list is, since
that is common to cherry-pick/revert and rebase-i, and all the other
non-sequencer related stuff like checking out the --onto <newbase>,
updating refs can be done at the rebase-interactive.c or
git-rebase--interactive.sh layer.

[1] Of course, it's kind of unfortunate that sequencer.c has to be
aware of whether it is being called as cherry-pick or revert, but I
don't see why implementing interactive rebase functionality needs to
make the same mistake.

Thanks,
Paul
