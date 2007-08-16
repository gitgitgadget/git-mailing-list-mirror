From: Richard MUSIL <richard.musil@st.com>
Subject: Re: git-svn: commit author x commit committer issue
Date: Thu, 16 Aug 2007 14:13:19 +0200
Message-ID: <46C43F5F.3040508@st.com>
References: <46B9C92B.3000000@st.com> <20070816092002.GD16849@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Aug 16 14:13:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILeEP-00079T-8f
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 14:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607AbXHPMNg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 08:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbXHPMNf
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 08:13:35 -0400
Received: from s200aog10.obsmtp.com ([207.126.144.124]:57287 "EHLO
	s200aog10.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbXHPMNf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 08:13:35 -0400
Received: from source ([164.129.1.35]) (using TLSv1) by eu1sys200aob010.postini.com ([207.126.147.11]) with SMTP;
	Thu, 16 Aug 2007 12:13:22 UTC
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP
	id 8676DDAF3; Thu, 16 Aug 2007 12:13:21 +0000 (GMT)
Received: from mail1.prg.st.com (mail1.prg.st.com [164.130.59.16])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3096E4C14E;
	Thu, 16 Aug 2007 12:13:21 +0000 (GMT)
Received: from [10.139.4.224] (pcdyn4224.prg.st.com [10.139.4.224])
	by mail1.prg.st.com (MOS 3.7.5a-GA)
	with ESMTP id CIL51101 (AUTH "richard musil");
	Thu, 16 Aug 2007 14:13:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
In-Reply-To: <20070816092002.GD16849@muzzle>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56010>

Eric Wong wrote:
> Richard MUSIL <richard.musil@st.com> wrote:
>> Normally, when patch is applied, git distinguishes commit author and
>> commit committer (relying on info from patch).
>> However, after the patches are committed to svn repository using:
>> git-svn dcommit
>> author and committer data are set to same values (or at least time and
>> date, I cannot verify it for names).
>> I wonder if there is any reason for this behavior, because I would
>> definitely like to keep original commit info (which came from patch) in
>> my git repository.
> 
> I try to keep commits made to SVN using git-svn as much like commits
> made using other SVN clients as much as possible.
> 
> Two people using git-svn (in its recommended fashion and maintaining
> linear history) can have identical SHA1s in their repository even if
> those two repositories had never seen each other before.  Consistency
> is good.

Ok, if I understand well, you are saying, that if someone commits with
distinguished author/committer and someone does not, they end up with
different SHA1s because those parts affect the calculation. I agree this
could be a breaking point.

> I also want to avoid creating extra junk on the SVN repository which I
> don't personally consider very important.  SVK does stuff like that with
> merges, and only SVK understands the metadata it uses.  I prefer
> transparency.

I made some suggestions in this thread about using revision
(unversioned) property of SVN fot git "metadata". AFAIK using rev. props
is completely transparent to other SVN clients (in this case those not
being git-svn), so they could easily ignore them.

It could be optional on git config property for commit and autodetected
for clone/pull.

The scenario I could easily imagine (though it is not something I am
currently using) is having dev teams using git internally (because its
much easier for tracking local development) and having SVN repo as a
"central hub". In such environment, there will be probably one person in
each team (dev. lead) collecting commits from others and once things are
set, he will commit all changes to svn. In that particular case, he does
not have to worry about different sha1s, because they use only one SVN
(as it was meant to be used). But he could be sad about losing all
authors info about the people commits. And my personal believe is, this
is how git-svn may enter svn world on big projects.

But you are right, it is up to you to decide. It was just an idea ;-).

Richard
