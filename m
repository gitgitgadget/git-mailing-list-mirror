From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Tue, 16 Apr 2013 13:51:34 +0530
Message-ID: <CALkWK0=2+RY0cRSJD4pbHxPuqffDEqiwc7m0+Fzk7d8=wLvULQ@mail.gmail.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
 <7vy5ck4m6b.fsf@alter.siamese.dyndns.org> <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com>
 <516C21CF.5080705@xiplink.com> <7vvc7nu1hu.fsf@alter.siamese.dyndns.org>
 <516C4A52.1080908@xiplink.com> <7va9ozsk60.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 10:22:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US19j-0000na-Fj
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 10:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935533Ab3DPIWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 04:22:16 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:52167 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147Ab3DPIWO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 04:22:14 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so204162ieb.31
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 01:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=TeqIkg6dHre+JRJ17Vjg68qVFVi/i2nDXeu59wviUqw=;
        b=Nj8ek7yuXzoJl9FJdH/LpfDK1Hvq/hkUVQwGcumZs07JbeQtJUEW476UQI48Hfu7jh
         z+IAsJ/hc2qA3rpkZinvdNBT3uuWEL/4Eq3wdKKXYCda+1LHLbokpDPDYsDUvqRTHm+W
         SDFgvM5Mb6Mednl4pzjH8vl9mK+cADjGCar3IxHXrl0m+7YcMsRLTGwlG9GpsZnrt8h8
         HAARhWaA8YF48ir7XIy+bAwimgrijAo0wZcFOVreigDOETbj/p9YVRZv5ymPoFJZ/FiE
         DDZcgstKECNtPIJclzc2eIw58gevYPRpTKUUfSsIxJCDwXE9kybqqn/nn49X1+6bW0og
         n+eQ==
X-Received: by 10.42.50.202 with SMTP id b10mr616352icg.7.1366100534380; Tue,
 16 Apr 2013 01:22:14 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 16 Apr 2013 01:21:34 -0700 (PDT)
In-Reply-To: <7va9ozsk60.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221378>

Junio C Hamano wrote:
> It does not relieve "git add" (or "git submodulea add") from the
> responsibility of moving .git directory.  It only reduces the need
> to do so.
>
> When the user says "add" and the repository has .git directory in
> it, "add" (or "submodule add") is still responsible for relocating
> it.

Since you're so stubborn about it, I suppose 'git add' could call a
function in my "new first-class program to attach detach
worktrees/workdirs and relocate GITDIRs" as a last resort (if the user
somehow managed to put a GITDIR in the submodule worktree despite our
well-designed tools).  But last resort is not what we should be
discussing now: we're discussing what the design should ideally be.
And ideally, I think we both agree that it's best if init/clone did
the relocation.
