From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCH 0/2] Speed up fetch with large number of tags
Date: Wed, 16 Sep 2009 15:42:53 -0700
Message-ID: <20090916224253.GB14660@spearce.org>
References: <20090916074737.58044.42776.julian@quantumfyre.co.uk> <7vbplb2pi7.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0909162141140.13697@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Sep 17 00:43:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo3DJ-0005mM-1C
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 00:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760358AbZIPWmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 18:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760523AbZIPWmx
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 18:42:53 -0400
Received: from george.spearce.org ([209.20.77.23]:57611 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760468AbZIPWmu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 18:42:50 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CD735381FE; Wed, 16 Sep 2009 22:42:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0909162141140.13697@reaper.quantumfyre.co.uk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128687>

Julian Phillips <julian@quantumfyre.co.uk> wrote:
> On Wed, 16 Sep 2009, Junio C Hamano wrote:
>> * It is tempting to use a hash table when you have to deal with an
>>   unordered collection, but in this case, wouldn't the refs obtained from
>>   the transport (it's essentially a ls-remote output, isn't it?) be
>>   sorted?  Can't you take advantage of that fact to optimize the loop,
>>   without adding a specialized hash table implementation?
>
> I wasn't sure if we could rely on the refs list being sorted.  But I've  
> got a new version that uses an extra string_list instead that is actually 
> slightly faster.  I'll post that shortly.

JGit depends on the fact that the refs list is sorted by the remote
peer, and that foo^{} immediately follows foo.  I don't think this
has ever been documented, but all sane implementations[1] follow
this convention and it may be something we could simply codify as
part of the protocol standard.

[1] Sane implementations are defined to be what I consider to be
    the two stable implementations in deployed use, git.git and JGit.

-- 
Shawn.
