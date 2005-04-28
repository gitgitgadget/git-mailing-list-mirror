From: Junio C Hamano <junkio@cox.net>
Subject: Re: diff against a tag ?
Date: Thu, 28 Apr 2005 13:42:40 -0700
Message-ID: <7vpswe7hvj.fsf@assigned-by-dhcp.cox.net>
References: <20050428200953.GD8514@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 22:37:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRFlA-0006h8-3K
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 22:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVD1Umr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 16:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVD1Umr
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 16:42:47 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:40589 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262111AbVD1Umm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 16:42:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050428204239.BZEF8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Apr 2005 16:42:39 -0400
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20050428200953.GD8514@redhat.com> (Dave Jones's message of
 "Thu, 28 Apr 2005 16:09:53 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DJ" == Dave Jones <davej@redhat.com> writes:

DJ> Maybe I missed this in the discussion on tags recently
DJ> (I kinda tuned out after a while on that thread).

DJ> Is there an easy way to express 'show me the diff
DJ> between HEAD and 2.6.12rc3' today ?

Depends on your definition of today, but with the patch below I
sent today, you can say "diff-tree -p $tag $(cat .git/HEAD)".

    Subject: [PATCH] Rename and extend read_tree_with_tree_or_commit_sha1
    Date:	Thu, 28 Apr 2005 12:15:43 -0700
    Message-ID: <7vu0lq7lwg.fsf@assigned-by-dhcp.cox.net>

    This patch renames read_tree_with_tree_or_commit_sha1() to
    read_object_with_reference() and extends it to automatically
    dereference not just "commit" objects but "tag" objects.  With
    this patch, you can say e.g.:

        ls-tree $tag
        read-tree -m $(merge-base $tag $HEAD) $tag $HEAD
        diff-cache $tag
        diff-tree $tag $HEAD

