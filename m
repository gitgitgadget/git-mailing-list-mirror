From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] Replace git-cvsimport with a rewrite that fixes major bugs.
Date: Thu, 3 Jan 2013 08:47:56 +0100
Message-ID: <CALWbr2xx0beca_LUHO45pGMZ4Y0jZ9-iMWq8WBO6PmW==Ysw=A@mail.gmail.com>
References: <20130101172645.GA5506@thyrsus.com>
	<CAEUsAPYwinmbDkSVu71WJRgUjLfBeNdKDFt6O1f8-Ti9evn6Hw@mail.gmail.com>
	<7vmwwqyc8w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Chris Rorvick <chris@rorvick.com>, Eric Raymond <esr@thyrsus.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 08:48:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqfXI-0003Zn-1m
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 08:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003Ab3ACHsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 02:48:00 -0500
Received: from mail-ea0-f179.google.com ([209.85.215.179]:64663 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852Ab3ACHr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 02:47:59 -0500
Received: by mail-ea0-f179.google.com with SMTP id i12so6008574eaa.24
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 23:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4ucvUYF3Vm3Re5puS/Jb3ygiC3xr96eSQtvAbgRZMME=;
        b=pjZCYNGZ+IpD899ARMxj8FRb9H993YTIccCMaNoDYfms35ECI+azbX/wOLBWuKrH47
         bMUUXTxjGnqY76lpTu3+g+bIGC9hWDN1ovQuuhMcahSwUNu2ZG18QdZMP8AMGERIhnCz
         pGJ5rB0yaVeK8ijuCaw822KNdtCtx2fvnx40ehYbUp344t9wSasfkAgwSallIlJzfyKo
         EHrEG5w7XBgg6CYBK+LPUerAk81JQAw6UIsipw5wMt7b7oU2R6ByN51OiA+VgZfA3ksk
         RKiXMnC6lqh1eRDRgNOiy/DILv3kDtPHmY47a7LuqbDr6UwYUke3ZwUMQ0VOzXA5fvtx
         aU5A==
Received: by 10.14.178.196 with SMTP id f44mr132358816eem.14.1357199277067;
 Wed, 02 Jan 2013 23:47:57 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Wed, 2 Jan 2013 23:47:56 -0800 (PST)
In-Reply-To: <7vmwwqyc8w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212573>

> Doesn't Python come with a standard subprocess module that lets you
> spawn external programs safely, similar to the way Perl's list form
> open(), e.g. "open($fh, "-|", 'git', @args)", works?

You mean something like this:

  p1 = subprocess.Popen([backend.command()], stdout=subprocess.PIPE)
  subprocess.Popen(["git", "fast-import", "--quiet"] + gitopts,
cwd=outdir, stdin=p1.stdout)

Assuming gitopts is a list rather than a string. (care must be taken
with backend.command() also)
