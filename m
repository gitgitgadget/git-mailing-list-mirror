From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 3/5] setup_revisions: remember whether a ref was positive
 or not
Date: Tue, 9 Aug 2011 01:25:24 +0200
Message-ID: <CAGdFq_hO-MYC_kXZZhoqXhTRvVhCDfTT4EHPoYDyHjGtRiSB9g@mail.gmail.com>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
 <1311517282-24831-4-git-send-email-srabbelier@gmail.com> <7vy5znscst.fsf@alter.siamese.dyndns.org>
 <7vr55fs1z0.fsf@alter.siamese.dyndns.org> <CAGdFq_ghxFdpjxCgTNbqXWGpt0rpJaGZ1_h+ZC71PzaPzbQ-0A@mail.gmail.com>
 <7vy5zabbz7.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1108081748060.7748@s15462909.onlinehome-server.info>
 <7vfwlbztfg.fsf@alter.siamese.dyndns.org> <CAGdFq_hLy6_AW-Yh_9fi318Z6jdkFWw5+cYrwMtOitDkGQorFA@mail.gmail.com>
 <7vty9rv9p2.fsf@alter.siamese.dyndns.org> <CAGdFq_joHskwhp=934OjirmXiRMR3NbGd4s-hSjJc-gCFT_Jew@mail.gmail.com>
 <7vliv3v8cx.fsf@alter.siamese.dyndns.org> <CAGdFq_iHBE7eESpsX_doyfJu6EAkPOJpBgqkw1psMhqATf2oCw@mail.gmail.com>
 <7vhb5rv7x0.fsf@alter.siamese.dyndns.org> <CAGdFq_ioxeZUCnn-fFKuiT-6eVzVoph8eQE2j0hEbAxtDZzGnQ@mail.gmail.com>
 <7vy5z3trwu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 09 01:26:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqZCz-0002Po-Rg
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 01:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab1HHX0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 19:26:06 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35925 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376Ab1HHX0E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 19:26:04 -0400
Received: by pzk37 with SMTP id 37so9065567pzk.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 16:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HtK0o5neIfQYYhiln2aKMptDe2oP+1F/4blsiKmf5Go=;
        b=RYGf9z+CyPnJZ9BjrnA9o10t55FtObeUoNlmCZ2oVewTU0XbXyyiBVZGbzVwknq7XO
         1zgugaz6we3VbfhFU5APD6rawkJVG9/wd0DYDrUADzWxDxzP0WWgDP6Hp+nzQVpNxGSz
         mKRjazdbE4F4cYdRs12Ej86xRimEJ11brMmJY=
Received: by 10.142.165.18 with SMTP id n18mr3813615wfe.235.1312845964110;
 Mon, 08 Aug 2011 16:26:04 -0700 (PDT)
Received: by 10.68.63.102 with HTTP; Mon, 8 Aug 2011 16:25:24 -0700 (PDT)
In-Reply-To: <7vy5z3trwu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179008>

Heya,

On Tue, Aug 9, 2011 at 01:17, Junio C Hamano <gitster@pobox.com> wrote:
> Yes, I am that user who have been disturbed by the command line revision
> parser limitation for a loooooooong time and have been wanting to see it
> properly fixed for quite a while (by myself or by somebody else).

Aaaah, well that does explain a thing or two :).

> Seeing a single-bit "hack" not
> from a complete newbie but from two known-to-be-competent long timers of
> Git is another.

Perhaps known-to-be-competent, but time-constrained nonetheless.
Sometimes one is forced to chose between fixing something you care
about and doing something in a non-hacky way... There's only so much
time in a day to work on side-projects such as this after all :).

> There are numerous hacks that try to work around the same revision parser
> limitation (lossage of information), and I have been hoping that a series
> that touch the parser to leave more information during parsing to be
> cleanly enhancible to get rid of them (e.g. "git checkout $commit" vs "git
> checkout $branch" looks at the command line itself, but it should be able
> to call into the revision parser and inspect what the parser gives it
> back).

Ok, knowing that, I am somewhat more inclined to have a look at this.
I'm still not sure that I know how to implement the design you
described though. I mean, I understand the general concept, but I have
no idea in what places it would need to hook in to make it work (ditto
on how to fix the diff bug).

-- 
Cheers,

Sverre Rabbelier
