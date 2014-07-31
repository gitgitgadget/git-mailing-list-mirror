From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 3/2] stash: show combined diff with "stash show"
Date: Wed, 30 Jul 2014 17:28:18 -0700
Message-ID: <CAPc5daWuyELptgGgBUxD_etTM3H40tneKXTrtFM3NLaneiibBA@mail.gmail.com>
References: <20140729115334.GA8976@peff.net> <20140729120732.GA9302@peff.net>
 <xmqq1tt43uem.fsf@gitster.dls.corp.google.com> <20140731001746.GC22297@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 31 02:28:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCeEg-000090-4B
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 02:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbaGaA2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 20:28:41 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:61745 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883AbaGaA2k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 20:28:40 -0400
Received: by mail-lb0-f172.google.com with SMTP id z11so1466734lbi.31
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 17:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=veuvpBPCMxdAOKLvCG7atiKgdoOH8zd/fpLZ+QmJ9zg=;
        b=sMicuBhuBf9CVEx4qM4vq9Gb3dGWtsPlCrrPpygJcOKhHs0FDqZko0rJgn9rIfjLYg
         XH8PrbWMenWLA+iifvpr0hHijmn2/3b5PuYRV6s2yiKCPjUdsGQb+r1qC/FKLecx99gf
         huXusp9qte8wtaywr9kWcUIMLjGmYy2fBgV1PPeKw1Mzv+A5Ai9g3+RGuITtQsE7pyiR
         imD6YRhNrG5zQBr4PBViK8D7MSmNtZUAedWXg5FCGuFEU0cY9Kokkp0s+q2v60cEl8q5
         KcmE14LNRWxbrtY9j/bbktljCWYHDVLAKMx4VPSD1CYTr6ZYiEe8gHuHZIK4mkp+IlLh
         uXSw==
X-Received: by 10.112.133.97 with SMTP id pb1mr7965405lbb.4.1406766518807;
 Wed, 30 Jul 2014 17:28:38 -0700 (PDT)
Received: by 10.112.199.102 with HTTP; Wed, 30 Jul 2014 17:28:18 -0700 (PDT)
In-Reply-To: <20140731001746.GC22297@peff.net>
X-Google-Sender-Auth: Pl7iSy-X3pVgcD91g6Fqrzyz-vE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254535>

On Wed, Jul 30, 2014 at 5:17 PM, Jeff King <peff@peff.net> wrote:
>
> Like I said, I'm iffy on this part of the series for that reason. But
> I'm curious: what do you think should happen in such a use case when
> there are staged contents in the index? Right now we completely ignore
> them.

I think ignoring is absolutely the right thing ;-)

Unlike "stash pop", which is "try to bring me back to exactly the same state",
it is a strong indication that the user wants to further tweak the previous work
to grab a patch and apply to the working tree---and while you are working
inside the working tree, you haven't started adding the index contents, so
"git diff" after such an operation should show what you grabbed out of the
stash, applied to the working tree, relative to what you had in the index.
