From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Rename handling
Date: Thu, 22 Mar 2007 14:39:38 +1200
Message-ID: <46a038f90703211939j15dbda4cpfa2f49229b8c16cb@mail.gmail.com>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org>
	 <4601B199.9060300@midwinter.com>
	 <46a038f90703211710q168a691cpa282f8e2afc5c8a6@mail.gmail.com>
	 <200703220301.41180.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Steven Grimm" <koreth@midwinter.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 03:39:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUDDK-0004Kr-RQ
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 03:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbXCVCjk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 22:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbXCVCjk
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 22:39:40 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:18084 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbXCVCjj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 22:39:39 -0400
Received: by wx-out-0506.google.com with SMTP id h31so619623wxd
        for <git@vger.kernel.org>; Wed, 21 Mar 2007 19:39:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UmtvABNgXATgaAXb1vP8QLG77Uvfs+/3+zFjb0tbPgSPhe2XMqLzjx2KUJesFce1YzynTRIJdTd1EFeLi6EAEHI9X12Po89Y2AY6ul56Y8kXMN9f4bIvrtlgLvVIsfOPeqI7XLBPiZcIFl55sgtj7aOWovvxDGnl9WJvHp8OOD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bIhiWD2gPvNzIIzLdyA2BGqC7u+Ql+FHhZ0GuIF85k25K37Pg1CCieFYbwyvISc1i9iesOoWLVXL7yqwnVfUEN1BFGTvn2W4Er+b+IynpxTjol8OaUIhGld0CLgcNG4HEV/ll/7AkuduTykFE97+HbuABULWDnjo8xm/fpYIE2Y=
Received: by 10.90.71.3 with SMTP id t3mr3022121aga.1174531178641;
        Wed, 21 Mar 2007 19:39:38 -0700 (PDT)
Received: by 10.90.52.17 with HTTP; Wed, 21 Mar 2007 19:39:38 -0700 (PDT)
In-Reply-To: <200703220301.41180.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42834>

On 3/22/07, Jakub Narebski <jnareb@gmail.com> wrote:
> Additional issue that we have to think about with respect to rename
> support for merges is that git uses 3-way merge, taking into account
> _only_ upstream commit (of the branch we want to merge to), side branch
> commit (of the branch we want to merge) and common ancestor[*1*]
> (merge base) for merging. What is important is that the intermediate
> states, how we got to the current state, does not matter.
>
> Well, one could argue that if we remember explicit (provided by user)
> info about renames for example in proposed 'note' field of a commit
> object, or in other helper structure (we cannot remember the information
> in blob or tree), we can gather and remember information about recorded
> explicit renames when finding common ancestor...

But we do have some of that already - if one trees being merged is
missing a path that changed on the other one, we walk back on the
ancestry looking for renames.

Or am I seeing things?

> Still, it would be nice to have --follow=<file> option to git-log family,
> besides path limiting.

+1 here - git log should have something equivalent to diff's -M. When
the file "disappears", run a diff-tree -M -C against the parents to
see whether there were any "related predecessors" to the file to add
to the pathspec. Of course, there could be more than one.

For example, right now, git log git-cvsimport.perl ends at the big tool rename.

cheers,


martin
