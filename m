From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Making error messages stand out (Re: [RFC/PATCH 0/9] commit: more
 focused advice in the no-changes-staged case)
Date: Thu, 29 Jul 2010 18:51:51 -0500
Message-ID: <20100729235151.GB6623@burratino>
References: <20100725005443.GA18370@burratino>
 <AANLkTilnQhsopnuAf0nja8Qq63VrOlt0_uCJrqYv5X-v@mail.gmail.com>
 <201007251122.41166.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 30 01:53:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OecuU-00073s-1s
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 01:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070Ab0G2XxE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jul 2010 19:53:04 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61434 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760Ab0G2XxC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 19:53:02 -0400
Received: by iwn7 with SMTP id 7so738292iwn.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 16:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=eGKvx4BQ8uFciZswStsEY14rPJUtVI45ny9wIhIQqtE=;
        b=Xx25Z56G+jxhEVTF9v3nZy0+9Qy8EMtrscDLJePh/kgv8iNFpyOCDNKuvCoAQXnzqJ
         A0kNz7TamIiAeEQEUF+qRULadWKd//+PAxIO+np4IbL4de45XbLONXTla+itk7B/lvcf
         ROWPxeCkpyubLV8IGk99GZRqqbccSjjjipOJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=xkWgcU5H+2UQAo5DlgBHcQSs6anEvU1BKtOH+DV6dmG+fcFYbxGyQfpa4F5SJ8EvCa
         bjbkSSg3SiW7jSSAJCDzJZuFpJhLyCJqpQ+8gitPixTFICyOw0RIWmJn3wfnLqi8IL3b
         G2k/BbS8tN+yq2MkF28WDanKu08k4wd5MKhIQ=
Received: by 10.231.36.69 with SMTP id s5mr852376ibd.58.1280447581264;
        Thu, 29 Jul 2010 16:53:01 -0700 (PDT)
Received: from burratino ([205.197.14.202])
        by mx.google.com with ESMTPS id h8sm1276892ibk.15.2010.07.29.16.53.00
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 29 Jul 2010 16:53:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201007251122.41166.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152212>

Thomas Rast wrote:

>   git://repo.or.cz/git/trast.git t/color-porcelain-message-output

My first thought was "that=E2=80=99s a horrible idea; red text is so ha=
rd to
read".  My second thought: "oh, maybe it=E2=80=99s not so bad because i=
t=E2=80=99s
bold".  Now I am starting to worry about the sort of distraction that
can sometimes follow from too much formatting (e.g., with certain
syntax highlighting engines).

A little bold text here and there (maybe to highlight the heading
strings like "fatal" and "hint") would be very useful, certainly.  To
deal with messages like

  Recorded resolution for 'dir/a'.
  [detached HEAD aa9ae6b] related change                          (1)
   1 files changed, 1 insertions(+), 1 deletions(-)
  Automatic cherry-pick failed.  After resolving the conflicts,
  mark the corrected paths with 'git add <paths>', and
  run 'git rebase --continue'
  Recorded preimage for 'dir/a'
  Could not apply 649420f... second                               (2)
=20
though, I find the best solution is to use short, formulaic messages:

  ...
  Recorded resolution for 'dir/a'.
  [detached HEAD aa9ae6b] related change
   1 files changed, 1 insertions(+), 1 deletions(-)
  fatal: could not apply 649420f... second
  hint: after resolving the conflicts, mark the corrected paths
  hint: with 'git add <paths>' and run 'git rebase --continue'

I do realize this is not a very useful thing to say without attaching
a patch. ;-)
