From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] sha1_name: fix error message for @{<N>}, @{<date>}
Date: Tue, 21 May 2013 23:39:54 +0530
Message-ID: <CALkWK0=kSxRC_d9feL-_foM3uU11E_Hx_xUL++V6q9k-7kjzbQ@mail.gmail.com>
References: <1369132915-25657-1-git-send-email-artagnon@gmail.com>
 <1369132915-25657-3-git-send-email-artagnon@gmail.com> <7vppwkp961.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 20:10:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uer1D-0000Os-9X
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 20:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255Ab3EUSKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 14:10:35 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:51396 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642Ab3EUSKe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 14:10:34 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so2611161iej.30
        for <git@vger.kernel.org>; Tue, 21 May 2013 11:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Pvgq7W+YlwrhSfywNplkZyNliHi9JVAGBykDLW3Mg/s=;
        b=TPF73K9PakYPXbtYxbvxhdEj2eD4fSmS1oXNoNdik9LoTN4doiwX6lOJZ1fXkEY4hA
         MkK98mEZrUAdCnCXwW4k95Ody/NTy7stZZG5L5uvGU0Dq5b//uETdWexr/fzXTyMAHQm
         kIjEfsGw7FVB+Tn3JPM6WVQSB3fxYx4tV/L8u1/IwzcEuX4o0XT6tt/Fkqc8VdiOYAIW
         xek97Bxu8G8xePMCe/mnBcZitb43tvuTFONrj9p6hCVe1M9posrAHnOme02BcTBLZGJ5
         jPWZnhHIhnSuAcTDhxYY/PuGjCYAZxobu6F2OISvdTDdkQFnGDwIOV0i9x3dCwoR9wxe
         k5Lg==
X-Received: by 10.50.120.68 with SMTP id la4mr8722808igb.49.1369159834336;
 Tue, 21 May 2013 11:10:34 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 21 May 2013 11:09:54 -0700 (PDT)
In-Reply-To: <7vppwkp961.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225058>

Junio C Hamano wrote:
> More importantly, doesn't "real_ref" have the name of the branch?
>
> Suppose the user said "git show @{10000}" instead of "git show
> master@{10000}" while on 'master'.

My stupidity, sorry.

> It could be argued that it may look nicer to say "your current
> branch does not have enough update history" instead of saying
> "master does not..." (i.e. different input to ask for the same
> thing, different output depending on the way the user asked).  It
> also could be argued that they should produce the same diagnosis
> that is more informative.

Yeah, I wanted to discuss this: the problem is that even something as
low-level as rev-list will print this "pretty" error.  It's certainly
useful for porcelain.  How do we achieve this?  An extra
"is-porcelain" argument?
