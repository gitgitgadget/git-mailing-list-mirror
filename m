From: Phil Miller <mille121@illinois.edu>
Subject: Re: [PATCH] (to improve gitosis support) CVS Server: Support reading 
	base and roots from environment
Date: Tue, 17 Nov 2009 22:11:58 -0600
Message-ID: <81f018ac0911172011la6948cfk8b5e95e6d8f796e@mail.gmail.com>
References: <81f018ac0911120925w848594dt276735955681e8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 18 05:12:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAbu6-0005dS-Eg
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 05:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756630AbZKREMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 23:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756608AbZKREMN
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 23:12:13 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:58732 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756391AbZKREMN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 23:12:13 -0500
Received: by fxm21 with SMTP id 21so758809fxm.21
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 20:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to
         :content-type;
        bh=W+ID098aU848LjdQ3ErMEjkcxvaHWiFrpLTEVIS1bx0=;
        b=OQ3HmdVrtcFqmflr+dalJKg/b8482ZuhQS1IeZxMnHRXzMmIim+4QgJrDLKnyyl+pK
         IgHzcQFqJpqdk0PIPEZ+JAePpoAiMqFJz0lpsOm7KnveQ7qjscI7g8rfuMZ9ciMyNgU/
         8as83+v0f94wxvc5FYFpMjRd+dTN7CAgCr92k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        b=XDVNEsPLepGhSis7ffQglP0hgEQnHCViiZeDr59Xb+WQAx4VSSq+ZG6BR8H384zNF0
         fdpuyAdWkHNz/iOyPN+HJg/DJmFOGfEcTiToe+/lrLXM2kLG+NB5PlaLtubnbf8c6185
         k7WyVFQJiYpNP2LoOPfK29BCin8i4f2Mdz/74=
Received: by 10.216.86.3 with SMTP id v3mr776284wee.165.1258517538256; Tue, 17 
	Nov 2009 20:12:18 -0800 (PST)
In-Reply-To: <81f018ac0911120925w848594dt276735955681e8f@mail.gmail.com>
X-Google-Sender-Auth: 2ee318c4376de407
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133136>

I've seen no response or comment on this since sending it in. Does it
need revision of some sort? Did it just get lost in the shuffle? I'll
be happy to do the legwork to get this integrated, so that I don't
have to carry it in a private git tree.

Phil

On Thu, Nov 12, 2009 at 11:25, Phil Miller <mille121@illinois.edu> wrote:
> The Gitosis single-account Git/ssh hosting system runs git commands
> through git-shell after confirming that the connecting user is
> authorized to access the requested repository. This works well for
> upload-pack and receive-pack, which take a repository argument through
> git-shell. This doesn't work so well for `cvs server', which is passed
> through literally, with no arguments. Allowing arguments risks
> sneaking in `--export-all', so that restriction should be maintained.
>
> Despite that, passing a list of repository roots is necessary for
> per-user access control by the hosting software, and passing a base
> path improves usability without weakening security. Thus,
> git-cvsserver needs to come up with these values at runtime by some
> other means. Since git-shell preserves the environment for other
> purposes, the environment can carry these arguments as well.
>
> Thus, modify git-cvsserver to read $GIT_CVSSERVER_{BASE_PATH,ROOTS} in
> the absence of equivalent command line arguments.
>
> Signed-off-by: Phil Miller <mille121@illinois.edu>
>
