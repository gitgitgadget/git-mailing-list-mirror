From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 3 Jun 2008 17:07:23 +0200
Message-ID: <b77c1dce0806030807t7654ac2cm96aa06690c7a5c02@mail.gmail.com>
References: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com>
	 <200806031614.29161.jnareb@gmail.com>
	 <b77c1dce0806030740td820c52ve45619812313776c@mail.gmail.com>
	 <200806031656.04780.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Luben Tuikov" <ltuikov@yahoo.com>,
	"Sam Vilain" <sam@vilain.net>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 17:09:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Y7V-0003i8-BW
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 17:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbYFCPHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 11:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbYFCPHY
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 11:07:24 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:41925 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbYFCPHX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 11:07:23 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1327398wfd.4
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 08:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Uxyu+llRKWH6kYWWmQMBs5yNexOaBcnvp3MrISAIM+w=;
        b=Ye+r6hjHroku92dB9gliQYjx8jHo3we5XAcJxywnkuFaZtNm3J3NqnaqgI6baJSH/hCMYy4nbRlgIb5BPvif7rbz/ivvbNupZnLp9J4SJdVzMmr47Hu48iWLmWbwKsahfyLORrlYJkXyh1ASTM5sUgJSC2ekVONXs6ax64i6H/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WbVJjP3OiHrD4QnyIhEbLXWeO1DWNO4OK3X2uAFSePBouj7usQPB4e0b7xIvfVqua4Oqxe/Rz7YvpTTzpuuBmr71tK3rX+6U9Y4g2GLwqpg2LKjkYNrUzPhMhcqHSUWJe3jWD++gSB0uiQ30s8KkG5GS3u205OWNJ5QWqhDRZio=
Received: by 10.142.103.2 with SMTP id a2mr2158799wfc.278.1212505643195;
        Tue, 03 Jun 2008 08:07:23 -0700 (PDT)
Received: by 10.142.212.20 with HTTP; Tue, 3 Jun 2008 08:07:23 -0700 (PDT)
In-Reply-To: <200806031656.04780.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83673>

2008/6/3 Jakub Narebski <jnareb@gmail.com>:
>>> By the way, what is the difference between '<<' links and 'br' link
>>> in the above mentioned annotate/blame interface?
>>
>> "br" navigates to another branch from which this file has been
>> integrated (in p4 speak.)
>
> Does it mark merge commits then? Or perhaps branch points?  What
> does "branch from which this file has been integrated" mean in git
> speak (in the terms of DAG of commits)?
>
>
> If the history of a file looks like this
>
>       ....*---*---A---M---C...
>                      /
>           ....*---B-/
>
> and the line comes from "evil merge" M git-blame would return M as
> blamed commit.  If the line comes from one or the other branch, from
> commit A or B, it makes I think no difference to git-blame; git tries
> to be "branch agnostic" (no special meaning to first parent; well,
> besides rev~n notation and --first-parent walk option).  I guess it
> is not the case in Perforce?

No, in perforce the branch you integrate changes from is always explicit.

> [...]
>>> [...].  Will you want to use git-diff-tree
>>> to mark differences from the version we came from (marked by 'hp',
>>> 'hpb' and 'fp' URI parameters), or would you rather extend git-blame?
>>
>> I don't know. I'll look at git-diff-tree.
>
> What I meant here, would you plan on extending git-blame, or would you
> use patchset (textual) diff between revision we are at, and revision we
> came from.  git-diff-tree just compares two trees (and have to have
> patch output explicitely enabled).  Sorry for the confusion.

I'm under the impression that extending git-blame is a more flexible solution.
