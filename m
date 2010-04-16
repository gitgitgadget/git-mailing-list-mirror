From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
Subject: Re: [PATCH v4 4/8] diff: Filter files that have changed only due to
 conversion changes.
Date: Fri, 16 Apr 2010 17:30:16 +0200 (CEST)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1004161723430.4423@shipon.roxen.com>
References: <cover.1270554878.git.grubba@grubba.org>
 <3daab2593b3f83971c6da6cfcd3d56046c84477a.1270554878.git.grubba@grubba.org>
 <7vvdbzszmi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-959030623-1271431816=:4423"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 17:30:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2nVC-0007NF-DH
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 17:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758065Ab0DPPac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 11:30:32 -0400
Received: from mail.roxen.com ([212.247.29.220]:39006 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710Ab0DPPab (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 11:30:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id C780962827B;
	Fri, 16 Apr 2010 17:30:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gxYDFm28b0V3; Fri, 16 Apr 2010 17:30:16 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id E02D262825E;
	Fri, 16 Apr 2010 17:30:16 +0200 (CEST)
In-Reply-To: <7vvdbzszmi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145066>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-959030623-1271431816=:4423
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 10 Apr 2010, Junio C Hamano wrote:

> "Henrik Grubbström (Grubba)"  <grubba@grubba.org> writes:
>
>> When the conversion filter for a file is changed, files may get listed
>> as modified even though the user has not made any changes to them.
>> This patch adds a configuration option 'core.refilterOnDiff', which
>> performs an extra renormalization pass to filter out such files.
>>
>> Signed-off-by: Henrik Grubbström <grubba@grubba.org>
>
> Does this really have to be done for every invocation of diff?
>
> But the problem feels very similar to the issue that touching the inode
> information would make the cached stat information in the index invalid
> and plumbing commands such as "diff-files" would report phantom changes.

True, storing this information in the index is a much better approach.

> Of course you do not want to re-commit.  If however these files that are
> unchanged from the end-user's point of view can be re-checked out safely,
> then that would be similar to what "update-index --refresh" does for paths
> that are stat-dirty.

I now have a tentative set of patches implementing this.

--
Henrik Grubbström					grubba@grubba.org
Roxen Internet Software AB				grubba@roxen.com
---559023410-959030623-1271431816=:4423--
