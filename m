From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: Re: [PATCH v5 00/23] Signed push
Date: Tue, 16 Sep 2014 20:16:04 +0200
Message-ID: <CAPuZ2NFw_NM2EYFkiMQDAwuPBSh1_3JUH13hMN4Rox5eJf-L1w@mail.gmail.com>
References: <1410819864-22967-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 20:16:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTxIS-00053C-GO
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 20:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754780AbaIPSQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 14:16:07 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:43098 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbaIPSQF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 14:16:05 -0400
Received: by mail-pd0-f170.google.com with SMTP id fp1so302653pdb.29
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 11:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/h0zkUb59ZGVFGlY/2oJ6UTo0/ABlhai1OYkUzoYdzA=;
        b=JXg2GUYR/OUkx8zo+SvJJR0zNjM0EvYjd/V0aZ0NVzFi6sGKWIjCNmvAbMvlddVr9/
         jQKHfdS3i71qgkyJwsJv9PtghmEv/V1QFUqLjQYsxXY900mB0Wi87dP3XZaSMP/uN0vm
         wvZbBBfHe4EYlOjiBiebhHBxZZ+NWPrUX4B5svGgi/BhehRMsSP24bGI+yLX7mDAyfxl
         6K36Hkna8QegfVPqV1GxaMoNVayBFc+FUsDSzxUi5vetIEKEqKeP9CpKE+DIR2fukQ5t
         y0QPB5j4bSkorYFOrUISTAaUYludJBU2kfGeQDqEM6Gevz9t3gD+/2jUoPoqVtp6JSNV
         siNQ==
X-Received: by 10.70.129.106 with SMTP id nv10mr64412316pdb.24.1410891364583;
 Tue, 16 Sep 2014 11:16:04 -0700 (PDT)
Received: by 10.70.49.230 with HTTP; Tue, 16 Sep 2014 11:16:04 -0700 (PDT)
In-Reply-To: <1410819864-22967-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257136>

On Tue, Sep 16, 2014 at 12:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> A failing test has been added at the end for smart HTTP.  It appears
> that somewhere in the callchain "--signed" is forgotten and the
> sending end not to send the certificate for some reason.  If
> somebody with a fresh set of eyes can look into it, that would be
> very much appreciated, as I do not expect I would have sufficient
> concentration to dig it quickly for several days at least.
>

It seems that smart HTTP is using "git send-pack" (called from
push_git()), that doesn't still know anything about signed pushes. I
think this is the point where the flag is forgotten.
