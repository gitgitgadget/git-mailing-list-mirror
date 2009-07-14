From: davidb@quicinc.com
Subject: Dividing up a large merge.
Date: Tue, 14 Jul 2009 16:32:46 -0700
Message-ID: <20090714233246.GA25390@huya.quicinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 15 01:44:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQrfS-0003Et-Mr
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 01:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596AbZGNXmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 19:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753978AbZGNXmL
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 19:42:11 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:8725 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718AbZGNXmL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 19:42:11 -0400
X-Greylist: delayed 564 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jul 2009 19:42:11 EDT
X-IronPort-AV: E=McAfee;i="5300,2777,5676"; a="20723811"
Received: from pdmz-ns-mip.qualcomm.com (HELO numenor.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Jul 2009 16:32:48 -0700
Received: from totoro.qualcomm.com (totoro.qualcomm.com [129.46.61.158])
	by numenor.qualcomm.com (8.14.2/8.14.2/1.0) with ESMTP id n6ENWlbx032689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Tue, 14 Jul 2009 16:32:47 -0700
Received: from huya.qualcomm.com (huya.qualcomm.com [10.46.166.122])
	by totoro.qualcomm.com (8.14.2/8.14.2/1.0) with SMTP id n6ENWkN3029052
	for <git@vger.kernel.org>; Tue, 14 Jul 2009 16:32:46 -0700 (PDT)
Received: by huya.qualcomm.com (sSMTP sendmail emulation); Tue, 14 Jul 2009 16:32:46 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123276>

I'm trying to figure out a better way of dividing up the effort
involved in a merge amongst a group of people.  Right now, I
basically describe the merge to each of them, and ask them to
merge their part, and then 'git checkout HEAD' the other parts.
They tell me about the commits, along with the files that they've
merged correctly.  When everybody is done, I make a real merge
commit, and pull in all of their files.  It's a lot for me to
track, and confusing for each person.

I'd like to create a branch we can all push to that we gradually
work to become the result of a resolved merge.  Not only does git
not want to help me do the merge, but seems to actively be
fighting against me doing this.

What I thought of was something like telling people to do:

  $ git merge v2.6.30
  resolve some files
  $ git checkout HEAD ...rest of files...
  $ git commit; git push

but that 'rest of files' is fairly large and complicated.  I can
think of two ideas:

  - Something that basically does a partial 'git reset --hard
    HEAD' to put many of the files back.

  - The ability to specify subpaths on the 'git merge' to do the
    merge work but limited to a directory or set of files.

Obviously, either case will require someone to still track the
overall effort and make sure the final state of the tree really
represents the total merge.

Is there anything that can parse the output of 'git merge-tree'?
Even just splitting this up and then applying parts of it would
be helpful.  Would it be useful to write something that can apply
the results output of 'git merge-tree'?

Thanks,
David
