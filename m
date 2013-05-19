From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH/WIP 0/9] for-each-ref format improvements
Date: Sun, 19 May 2013 17:38:06 +0530
Message-ID: <CALkWK0kYDB+cCsD7Fsymf9ETR2Ymyaf072gCUu6Uh8yFVFJV2Q@mail.gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
 <CALkWK0=7z91A54jSzc2yZU3g50u8H_f8su1Y+i=D+KxYtqor5g@mail.gmail.com> <CACsJy8DMF3NzvMRUO56H+EwpXSjmY9qzdNdv9cGJ9XxUO=ekJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 14:08:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue2Q0-0001HE-Bl
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 14:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540Ab3ESMIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 08:08:48 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:50548 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483Ab3ESMIr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 08:08:47 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so11503998iec.8
        for <git@vger.kernel.org>; Sun, 19 May 2013 05:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fNnNHq3SHFkoiQgll6yBj9hRD+sThitc6JyaD5chK0s=;
        b=RPtIIPYV2Q2nYFdUIQirEheBWpCoyXQ8/huBamPIe4pOKKuMhNLRb2/gDE3CMWfgDk
         65v2PC4oMNYohIPDeuz6Y9I5qxF9AhLj8ZFbIuR062tny2DQdAqf1i/yoZD5NdMSR8GT
         k8dwYCML3W6MTZCpmhCfFsF1D9iFDcQme9+a6OGU6TK4LV2fLWaNLwm8rOhe4iZBKvJf
         2tZxRwyvMdgtlWyRekWoLjHVMeZPsUreG6NmgXI6Fz0tcEobdZ8ppJq4i5VXwOcg0bHE
         JBuPVX2QzUVlBt4uTcI3dsxrdeTTHCW8OfMmO4Djhvm8uT89Yym/qeQEpwQECZO+J86t
         79Tw==
X-Received: by 10.42.27.146 with SMTP id j18mr30207719icc.54.1368965327477;
 Sun, 19 May 2013 05:08:47 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Sun, 19 May 2013 05:08:06 -0700 (PDT)
In-Reply-To: <CACsJy8DMF3NzvMRUO56H+EwpXSjmY9qzdNdv9cGJ9XxUO=ekJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224879>

Duy Nguyen wrote:
> Hmm.. I missed that mail (or I wouldn't have worked on this already).
> Do you want to take over?

Oh, we can collaborate on one beautiful series :)

> "branch -vv" shows [upstream: ahead x, behind y]. We need a syntax to
> cover that too.

Can't we construct that using [%(upstream:short): %(upstream:diff)]?
It's nothing fundamental.

> pretty and for-each-ref format seem to be on the opposite: one is
> terse, one verbose. Unless you are going to introduce a lot of new
> specifiers (and in the worst case, bring all pretty specifiers over,
> unify underlying code), I think we should stick with %(xx) convention.

We can stick to using the existing %(...) atoms: there's no need to go
as far as %an versus %aN.  The atoms cannot be consistent with
pretty-formats anyway, because pretty-formats has completely different
atoms.  For the _new_ stuff like color and alignment, we can be
consistent with pretty-formats, no?

>> Why should we deviate from the pretty case?  What is different here?
>
> Laziness plays a big factor :) So again, you want to take over? ;)

It's just a matter of modifying the parsing/printing layer, instead of
introducing new atoms in the current parser.  Doesn't $gmane/224692
demonstrate that the former can, in fact, be easier?

> it uses builtin/branch.c:branch_use_color. Eventually
> fill_tracking_info() should be moved to for-each-ref.c and pass
> branch_use_color in as an argument. But for now, I just leave it
> broken.

Auto-color can come later: it's not that urgent.  What's more
important is that we give users the flexibility to set their own
colors now.

Can you give me a pull URL to your series, so we can start
collaborating?  Mine's at gh:artagnon/git (branch: hot-branch).
