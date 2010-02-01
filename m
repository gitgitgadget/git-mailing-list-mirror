From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: Speed of conversion from Subversion repository to Git
Date: Mon, 1 Feb 2010 10:17:07 -0800
Message-ID: <8c9a061002011017l6127dd22na1930481c7b59d4@mail.gmail.com>
References: <4B6717DF.8020004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 01 19:17:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc0q6-0007YP-0U
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 19:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172Ab0BASR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 13:17:28 -0500
Received: from mail-pz0-f189.google.com ([209.85.222.189]:60733 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824Ab0BASR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 13:17:27 -0500
Received: by pzk27 with SMTP id 27so5085928pzk.33
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 10:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Cd/fK+eynLj1eDCtqnjHswQ/2lEfEml21qMOuSlR6E4=;
        b=hl2DBOwUSGa6AMnnNJ8rN94ultGmH5xIvtbsKqwLwlHd+L7nQWWU16fbrgOlhB/hSt
         bmHkPFCb3GyX6NLXbmJbAoJZgYvqLAPW29e07m1RSNaXS+0v9m3KVg959rZFPrZCERDW
         l/z1J8HQbBEoLlQiI3JTGFPC8KgKTdDJyFM4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=bDuJ/d+0MMtjR5tu1T8tgBg79xcAOgmQP+tor0tmn3TkQjVia142oOaeO2+K/WtRhe
         G79Zj1C4edIOZh/F8EIcSgicwLsJvJLLuDAIpU9sZUVM0hu9zzC+CP92K7oqswhwgTRE
         N+C7gPjGgVaZREqXxqkHRmyDCz2F125TCamKI=
Received: by 10.140.58.9 with SMTP id g9mr3363750rva.39.1265048247105; Mon, 01 
	Feb 2010 10:17:27 -0800 (PST)
In-Reply-To: <4B6717DF.8020004@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138638>

On Mon, Feb 1, 2010 at 10:05, Markus Elfring <Markus.Elfring@web.de> wrote:
> Hello,
>
> I am trying to convert the YaST Subversion repository into a Git variant on my
> system. Unfortunately, a command like "svn2git
> http://svn.opensuse.org/svn/yast/" does not finish this attempt after 1,5 days
> (> 715:13.24 CPU time) here. I would appreciate suggestions for improvements of
> the execution speed.
> (Renicing of the process "git-svn" does not help to increase its processor
> utilisation in noticeable ways.)
>
> Regards,
> Markus
>

We're in the process of converting to Git at work, and I've found that
svn-all-fast-export was the best option for us.  git-svn's behavior of
a branch's entire history every time it found a new branch (even
though it has already seen 3/4 of the revisions involved) caused it to
be far too slow for our needs.  Admittedly, this was ~1 year ago that
I tried git-svn to do a test conversion, and things might have
improved since then.

svn-all-fast-export does require access to the raw repository, instead
of just (http|svn|svn+ssh):// access, but it does allow you to split
out one SVN "repository" into multiple Git repositories in one go.

-Jacob
