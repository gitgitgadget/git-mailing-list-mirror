From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2010, #04; Wed, 18)
Date: Wed, 18 Aug 2010 22:02:37 -0500
Message-ID: <20100819030237.GE18922@burratino>
References: <7vfwyb8skr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 05:04:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlvQX-0002os-55
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 05:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149Ab0HSDEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 23:04:20 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51543 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab0HSDES (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 23:04:18 -0400
Received: by gyd8 with SMTP id 8so490004gyd.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 20:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=4gqtGRJM7V3Fxgq6bU6S5HfphCJ1WFc2W5UzLVllO60=;
        b=xHzQP2jDw2patGaOVouC2MHayyoVNLyM0Vh6xF9DteAE/I3lgfEoCYqADKDZIXtYbF
         WMhpCqVE72d5otwe5kciMx+IV9MbZ9CJLBimfSMhfQBPoMbJPUliOqMWZXcw9OwOPXV5
         HkZo6R4dNE5dnSf+0Vqz+sCVuOUftQUM0W2+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=puRJFRPD8G7xjqsDgHiBAv2uuJVMkCWsI+bJCCkluIl0Lrp0REKqo9zycOzaib77CB
         jCRQip/Nr5gJ+PMrBJumRrHmTxt+sM+Rv+jfQ72px1VSLzimZaN5DusZdPPePaIRW0sJ
         thnumC8rqyoL9xQ1/DdXlmkfCiJcUP3poV1yA=
Received: by 10.150.53.13 with SMTP id b13mr1078149yba.419.1282187057893;
        Wed, 18 Aug 2010 20:04:17 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id m12sm2058451ybn.7.2010.08.18.20.04.16
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 20:04:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vfwyb8skr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153905>

Junio C Hamano wrote:

> * ab/compat-regex (2010-08-17) 5 commits
>  - autoconf: don't use platform regex if it lacks REG_STARTEND
>  - t/t7008-grep-binary.sh: un-TODO a test that needs REG_STARTEND
>  - Change regerror() declaration from K&R style to ANSI C (C89)
>  - compat/regex: get the gawk regex engine to compile within git
>  - compat/regex: use the regex engine from gawk for compat

As Hannes noticed, the tip commit is bogus and the configure
test gives the wrong result on platforms with missing or inferior
regex.  Sorry about that.  Replacement is at $gmane/153782.

> * jn/update-contrib-example-merge (2010-08-17) 25 commits
[...]
> A series like this may update scripted Porcelains with
> recent new features, but the result will never be as solidly battle tested
> implementations (admittedly with only subset of features and without later
> fixes) like we had there so far.

I was similarly nervous about that.  But as you say, it is always possible
to search through history for the older version.

Administrivia:

 - patch 1 (do not mistake ancestor of tag for branch) is a separate fix.
   It probably should have been sent separately.

 - patch 9-11 (merge-base --octopus, merge-base --independent, and especially
   fmt-merge-msg -m) which expose library functions to scripts might be
   independently useful.

 - patch 24 (merge script: learn --[no-]rerere-autoupdate) requires a
   working rerere --rerere-autoupdate, which means the patch for commit
   672d1b78 (rerere: migrate to parse-options API, 2010-08-05).  I can
   make a more targetted fix if that would be helpful for testing.

> * jn/commit-no-change-wo-status (2010-08-11) 10 commits
[...]
> There seemed to be some doubts on removal of the "no changes" line?

I'm happy to drop this series for now; the resulting output is just
not very good.

> * jn/paginate-fix (2010-08-16) 14 commits
>   (merged to 'next' on 2010-08-18 at bb04a13)

I am happy to see this get more exposure.  Thanks.

> There were heavy merge conflicts in t4200; I tried to be careful when
> merging this, but extra sets of eyeballs from parties involved (Jonathan
> and Szeder) would always be a good idea.

Looks good (and agrees with what I got from manually applying Szeder's
patch on top of the topic).
