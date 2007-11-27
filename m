From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git bug/feature request
Date: Tue, 27 Nov 2007 12:21:35 +0100
Message-ID: <81b0412b0711270321q6f70554at177ade878448b9fc@mail.gmail.com>
References: <200711271127.41161.gapon007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gapon <gapon007@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 12:22:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwyVp-0005ck-PK
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 12:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754263AbXK0LVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 06:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754002AbXK0LVj
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 06:21:39 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:33135 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588AbXK0LVi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 06:21:38 -0500
Received: by nf-out-0910.google.com with SMTP id g13so907279nfb
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 03:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=eF1/I1CxNPJkdfuupG0eiquFftKttaac75Xww9wbXBk=;
        b=MpZIWFzVcD1eZRnz8VIfCUDzShtQ5bKMulsOZB2uQQdLgtTp9UCKwp9bGJZCTBNS1TTkCKoHMkM53WXn2ISPLEcwRmwmc75Cc9eO9eMxd97Kho6jmg7V6HeJUjUC6dle9M3g38PAn71GyewfQVMtjYbpPjaMRcZeT2vQX2SAYwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bQdEuZBCohgzjFPO3h3884PnA0g0Tc5CZ9NWlv3d1L54GC35+0RdzxCGTwNOApaxs2MjqkC6GpfNjeZ6Sm8i1eGdgdvGz0BO/1qmgRerPgYqJd6sk61R3f7xejy/MWjoGssMoMwe2QSbbD19Aavb/aXdO8G/3EwMlmU7lmJH2lY=
Received: by 10.78.118.5 with SMTP id q5mr4028152huc.1196162496030;
        Tue, 27 Nov 2007 03:21:36 -0800 (PST)
Received: by 10.78.120.4 with HTTP; Tue, 27 Nov 2007 03:21:35 -0800 (PST)
In-Reply-To: <200711271127.41161.gapon007@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66188>

On 27/11/2007, gapon <gapon007@gmail.com> wrote:
> hi all,
> first of all i don't know if there's a bugzilla or something similar for git -
> i have found just this email (on http://git.or.cz/ webpage).
>
> i have discovered "weird" behaviour of git in this scenario*:
> - user A is working in repo A
> - user B clones repo A
> - user B makes some changes, commits, pushes
> - user A makes some changes, git status (no info about new commit in his repo
> from user B but it's probably ok i'd say - but some of my files are marked as
> changed and already added to index  but i haven't changed them - that's
> confusing, isn't it?)
> - user A can commit his changes => shouldn't be there any info/message/warning
> displayed? it would be helpful to have here some info about "foreign commit"
> in the repo or something like this

If you share a repository with someone else, you better use different
branches. What's happened is that user B changed the branch the
user A was working on (strictly speaking, the B-user changed the
reference A-user used as HEAD at the moment).

Just have the B-user push his/hers changes on something else,
not the master of the parent repository. For instance, B-user can
add a "push"-line to his origin remote which redirects its pushes
somewhere else:

  git config remote.origin.push 'refs/heads/*:refs/heads/B-user/*'

Or just use a dedicated shared repo where no one works in.
See also Documentation/config.txt, and the man page of git-push.
