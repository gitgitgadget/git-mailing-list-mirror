From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Created branch in wrong place... how to fix?
Date: Thu, 2 Jun 2011 08:28:59 +0200
Message-ID: <201106020829.01063.jnareb@gmail.com>
References: <BANLkTingMK3Zv6NZdFAiLXZzJpSZYZmjQA@mail.gmail.com> <m362opy8xz.fsf@localhost.localdomain> <BANLkTiktYkvGqc9Wq51-QMKe2kHzcmGXRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Thu Jun 02 08:29:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS1PE-0001b5-Tk
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 08:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201Ab1FBG3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 02:29:15 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38837 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756617Ab1FBG3O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 02:29:14 -0400
Received: by bwz15 with SMTP id 15so673441bwz.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 23:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=l0ifq9z8Hc1lZfd7j2zH3TBRiDqs6fzUh7BlDivOekQ=;
        b=SVycoRrsUqO9DKztkwt6Gep7qM+Q688/3OamF/4Vq+f7DAB60zw/2kDyq6Xh/Rvs/t
         BayKMsJYJf7EzQMPe0Uyn233o12SnpkaF781TdL5mLqfjdldtrGaiOg7fB+SfZGq4T1z
         gR9cY6lif11WyCCXOR4vwUb+DY7BAtOd2sW1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=lQxo5EoKHVTOegJ3W/8lc5QUb1uX0WZhOXkG/k7JeZBjCBPrR/0A16FeFKZKeycjLE
         a04tzw/E5s0A0IMlBeSReh5gl8BgMWluOu32KdzfNZv8P8GazuXiWEUhW9QCBm0l8MIB
         v9J/bV/GHueVRNHd8WdNkSft5IBxFMyFEeNuY=
Received: by 10.204.141.17 with SMTP id k17mr376432bku.41.1306996153278;
        Wed, 01 Jun 2011 23:29:13 -0700 (PDT)
Received: from [192.168.1.13] (abvc230.neoplus.adsl.tpnet.pl [83.8.200.230])
        by mx.google.com with ESMTPS id af13sm203545bkc.19.2011.06.01.23.29.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Jun 2011 23:29:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <BANLkTiktYkvGqc9Wq51-QMKe2kHzcmGXRQ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174931>

Howard Miller wrote:

> > > I created a branch in a project and did a series of commits. I now
> > > discover that I really wanted to make all those changes against a
> > > completely different branch of the same project. There shouldn't be
> > > any issues as the branch introduces entirely new files (no changes to
> > > existing code).
> > >
> > > I'm struggling to see a way to do this without loosing the history.
> > > Some Google'ing suggests 'rebase --onto' but I'm struggling to see how
> > > this works or if it is appropriate. Any pointers much appreciated :)
> > > Thanks.
> >
> > This is decidely work for git rebase:
> >
> >  $ git rebase --onto <where it should be based> <where it is based> <branch>
>
> Thanks.... I've re-read the rebase help and spotted the appropriate
> example. This makes sense.
> 
> The only thing that I'm a little bit unsure of is what does 'upstream'
> actually mean (used in the help quite liberally)? Does it just mean an
> older ancestor of the current HEAD? I was struggling to find a definition.

gitglossary(7) has the following definition:

 upstream branch::
        The default branch that is merged into the branch in question
        (or the branch in question is rebased onto). It is configured
        via `branch.<name>.remote` and `branch.<name>.merge`. If the
        upstream branch of 'A' is 'origin/B' sometimes we say
        "'A' is tracking 'origin/B'"

But in the case of rebase "upstream" means branch you forked from (you
created branch from).


N.B. if the branch in question is not too old, you can examine its
reflog ('git log -g <branch>' or 'git reflog show <branch>') for a creation
event, e.g.:

  2de58b3 gitweb/doc@{24}: branch: Created from origin
-- 
Jakub Narebski
Poland
