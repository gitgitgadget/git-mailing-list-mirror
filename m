From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC 1/x] gitweb: Use git-diff-tree patch output for commitdiff
Date: Thu, 24 Aug 2006 20:56:47 +0200
Organization: At home
Message-ID: <eckspe$vuc$1@sea.gmane.org>
References: <200608240015.15071.jnareb@gmail.com> <7v3bbmhoa2.fsf@assigned-by-dhcp.cox.net> <eck1em$p8b$1@sea.gmane.org> <7vzmdu7z1m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 24 20:57:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGKNq-00022X-CO
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 20:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030457AbWHXS4v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 14:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030458AbWHXS4v
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 14:56:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:48511 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030457AbWHXS4u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 14:56:50 -0400
Received: by nf-out-0910.google.com with SMTP id o25so654034nfa
        for <git@vger.kernel.org>; Thu, 24 Aug 2006 11:56:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:from:subject:to:newsgroups:mail-copies-to:date:references:lines:organization:user-agent:mime-version:content-type:content-transfer-encoding;
        b=UBO8T8BKkya5/HtOQl2X1nW6ELBrmNKAIywCeGtRXL6Aateo177GKoPDr/shdxvdKRQm9pKk3cV2MmAV5xuaclhT51+QwoXSey87Z1fQ3YIiStKCyehQAWmG1aMdTuac1lbx6IhKnccNsUiC1JgkB2GTewAQ461XetxwkEF0Tvc=
Received: by 10.49.92.18 with SMTP id u18mr4160426nfl;
        Thu, 24 Aug 2006 11:56:49 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id l32sm4322950nfa.2006.08.24.11.56.48;
        Thu, 24 Aug 2006 11:56:49 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25973>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Junio C Hamano wrote:
>>
>>> Jakub Narebski <jnareb@gmail.com> writes:
>>> 
>>>> Converting "blobdiff" and "blobdiff_plain" format would be much easier
>>>> if git-diff-tree and friends had -L <label>/--label=<label> option,
>>>> like GNU diff has.
>>> 
>>> I am not sure how that would be useful, given that you would
>>> disect the header line-by-line to colorize anyway.
>>
>> gitweb could output patch directly (slurp-print) in blobdiff_plain,
>> if there were -L <label>/--label=<label> option to git-diff. As it is now
>> git_blobdiff_plain (or git_blobdiff('plain')) would have to process diff
>> header, replacing hashes by file names.
> 
> I do not think gitweb does diff between two arbitrary blobs; in
> other words, you only need "diff-tree treeA treeB -- path".

gitweb didn't pass parent commit (i.e. treeB) information for blobdiff,
and IIRC passed only blob hashes for blobdiff_plain (and not passed
filename aka path).

> I think feeding object names _is_ what's causing you trouble.

As I said:
>> Anyway to get full information you need commits to diff, not only blobs to
>> diff, otherwise the mode change information is lost, I think. And then we
>> would be able to reuse git_patchset_body for git_blobdiff... 
 
Instead of using hash and hash_parent parameters for tree-ish and 
tree_parent-ish hashes (instead of blob hashes as it is now), I have 
used in patch (in this thread):

  [PATCH 10] gitweb: Add support for hash_parent_base parameter for blobdiffs

hash_base and (newly introduced) hash_parent_base arguments/parameters.

Not used yet, but planned.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
