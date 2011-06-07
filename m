From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Tue, 7 Jun 2011 22:33:27 +0200
Message-ID: <201106072233.28244.jnareb@gmail.com>
References: <201106051311.00951.jnareb@gmail.com> <4DEE755C.8030108@ira.uka.de> <20110607191152.GB24929@elie>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Holger Hellmuth <hellmuth@ira.uka.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 22:35:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU2zn-0005le-C3
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 22:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756582Ab1FGUfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 16:35:22 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53952 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756564Ab1FGUfV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 16:35:21 -0400
Received: by bwz15 with SMTP id 15so87697bwz.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 13:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=e+4Jf18aiM/CuB1DGFBc8TFPXiRdbNnjlUcEgqQu0cw=;
        b=GYKD2D4PkrD1Ujgo30DURHSYOMzHThumwtZ5EIueOJJFL1WgKO06SkYgOLDS3kON/+
         ziWBPodsHzrhiYGRXpB6pwuYSWZC9jhq4Ghs0P1ajO26aJdXy67G3qdcZ57itR3vy3xQ
         0NNMWeXmL2N4HBYAK2ZsG12mGv7NY8rZr9U7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=IttStutHBOEkWDxFIzz9UodzbUlYsQXvAcpAloW3r3PhLnuWrXyxeq3naxie/1riVb
         Tp4V9sRliZzC1LeC3gy5XgStbRuKhyUllLAjmFbkzvY72pY3HMQH9nX9txbuJd01aRkI
         yaLJimVQ71nh3RIi2ryxs3iMwTa6pt+AfEBos=
Received: by 10.205.35.1 with SMTP id su1mr71309bkb.129.1307478817203;
        Tue, 07 Jun 2011 13:33:37 -0700 (PDT)
Received: from [192.168.1.15] (abvu41.neoplus.adsl.tpnet.pl [83.8.218.41])
        by mx.google.com with ESMTPS id g2sm4514260bkz.11.2011.06.07.13.33.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Jun 2011 13:33:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110607191152.GB24929@elie>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175265>

On Tue, 7 June 2011, Jonathan Nieder wrote:
> Holger Hellmuth wrote:
> 
> > If someone finds the three-way diff completely mystifiying, how do
> > you expect him to resolve a merge conflict at all? Or recognize that
> > there is one? Or find the command to use after editing out the
> > conflict markers?
> >
> > A novice user will have no real mental model anyway.
> 
> Yes, I think you're getting closer to the point I was trying to make.
> A novice will have a naive mental model, and a good user interface
> needs to be close to it but not too close.  Close because the UI must
> be intuitive on its own.  Not too close because a good UI will help in
> leading such a person to productive ways of thinking and working, by
> making common tasks convenient.
> 
> So much for generalities.

To reiterate; perhaps it is not stated clearly in documentation:

1. "git diff" is about examining _your_ changes.  This short form is the
   same in every SCM.

   Because of explicit index (cache, staging area) one needs to know if
   it is working area against index, or working area against HEAD. 
   Thinking about merge conflict case helps to remember; in such case
   you want your changes against partially resolved merge.

   Also advanced users can use index to hide fully cooked changes from
   having to browse during review.

   Novice users which do not use index (and use "git commit -a") would
   never notice the difference, if not for the complication of newly
   added files: in other SCM you would see on "<scm> diff" creation
   diff (well, there is "git add -N").  Same with removal if one uses
   "git rm" and not simply "rm".

2. "git diff --cached" is about cached (staged) changes, therefore
   it is index against HEAD.

3. "git diff <commit>" in general, and "git diff HEAD" in particular,
   is about your changes (worktree), compared to given commit.

At in no place I _have_ to explain what is compared with what to explain 
when and what for to use "git diff", "git diff --cached" and "git diff 
HEAD".

-- 
Jakub Narebski
Poland
