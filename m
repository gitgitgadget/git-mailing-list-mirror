From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Splitting a rev list into 2 sets
Date: Thu, 20 Jun 2013 19:17:31 +0530
Message-ID: <CALkWK0k_2jzQNBjLKZ4SDc9vqoZuQ7937dnO6Z_Ye4Ha+FNcag@mail.gmail.com>
References: <CAC9WiBi-E+LN4hKGeu0mG7ihJWCaTg-W1Dx_PWmX_vsx-uLOaw@mail.gmail.com>
 <CALkWK0=6ZofURGvC-FtS81765yDsA9+0wW94riPZUPudc_nDyw@mail.gmail.com> <CAC9WiBgmswSqDHS3XOubvkY6GhBqrQ3YdwgKR4npqHM-kLJuMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 15:48:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpfDk-0003Ev-Eu
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 15:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965570Ab3FTNsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 09:48:12 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:52831 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965461Ab3FTNsL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 09:48:11 -0400
Received: by mail-ie0-f170.google.com with SMTP id e11so16579471iej.15
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 06:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yfv8DRRR6Axzh6OHiZr2bGBGWDrORkD1WaCYS8bwgDk=;
        b=c2t2Cezq/CKKII1VuaS6IE++LZ2zm02S7qzW28KiC2GiF/2xIWqR/UGsbXmoz6LJx8
         70xNZxPpYEMp6j5uRdEhlbBBLoJ4hoXB+cj0IQ20gyXz+E/MwGBeBKKRTXrHwkkpFxtf
         d70uXg/jHc0njZXuwMkwpAf9FkUtsjYe+nDI6zhFopaqdv3KFS23KQNgojmKwpB/1eu5
         7qxbPCfHeFYVCBpkd6KMq2JXC2BtCrerjjbHeaJV/OiYMd8MVLyvvuU54THwXsRM6lOp
         t5jgvh/Ma5d8MeYtRlrEJn2pqDVjzH9MdZEo/c+IpCaLnzhmNGVwJ63oKBuLiRfE8vfi
         E3RA==
X-Received: by 10.50.60.98 with SMTP id g2mr286217igr.111.1371736091324; Thu,
 20 Jun 2013 06:48:11 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 20 Jun 2013 06:47:31 -0700 (PDT)
In-Reply-To: <CAC9WiBgmswSqDHS3XOubvkY6GhBqrQ3YdwgKR4npqHM-kLJuMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228505>

Francis Moreau wrote:
> Basically I have an initial set (or can be several different sets)
> expressed as a revision specification described by git-rev-list man
> page. I just want to find the common set of commit which are part of
> the initial sets *and* is reachable by master.

That's just a generic list intersection between

  [a, b, c] and [d, e, f]

no?  [a, b, c] is a list you built up somehow, and [d, e, f] comes
from $(git rev-list master), right?

You could go about determining the revision walk boundaries and
combine them to set up a revision walk to splice the master line, but
what is the point of that?  You'll only be painting yourself into a
design-corner (you won't be able to do other kinds of filtering), and
going around your head to touch your nose.  You precisely want list
intersection: so write an efficient list intersection in the language
of your choice.  Why is it a poor man's solution?  If anything, your
convoluted rev-list solution will probably be more complicated,
slower, and bug-ridden.
