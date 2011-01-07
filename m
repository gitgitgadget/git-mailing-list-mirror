From: Yaroslav Halchenko <debian@onerussian.com>
Subject: Re: problem with cherry-picking a commit which comes before
 introducing a new submodule
Date: Fri, 7 Jan 2011 13:32:26 -0500
Message-ID: <20110107183226.GG6040@onerussian.com>
References: <20110107172432.GA6040@onerussian.com>
 <20110107181501.GA28980@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 19:32:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbH77-0001R7-Kk
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 19:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276Ab1AGSca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 13:32:30 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:56722 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169Ab1AGSc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 13:32:29 -0500
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1PbH6x-0003lZ-6e; Fri, 07 Jan 2011 13:32:27 -0500
Received: from yoh by washoe.onerussian.com with local (Exim 4.69)
	(envelope-from <yoh@onerussian.com>)
	id 1PbH6w-0003lW-Tm; Fri, 07 Jan 2011 13:32:27 -0500
Content-Disposition: inline
In-Reply-To: <20110107181501.GA28980@burratino>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org, jrnieder@gmail.com, newren@gmail.com
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164732>

oy -- I thought that cherry-pick is primarily just application of the
patch (without use of the merge clevernesses).

Here is the protocol:
% export GIT_MERGE_VERBOSITY=4
%         base=todonotloose^
%         next=todonotloose
%         head=HEAD
% 
%         git merge-recursive $base -- $head $next
Merging HEAD with todonotloose
Merging:
855981d just placeholders in the abstract
a00c497 Initial draft for HBM abstract.
CONFLICT (file/directory): There is a directory with name frontiers/code in todonotloose. Adding frontiers/code as frontiers/code~HEAD
%         git ls-files -u;        # after the merge
160000 a2b57871d2d79bef06ba6214739d82b9a63772a8 2   frontiers/code
zsh: command not found: #
%         git diff-tree todonotloose
a00c497fa399c00486c97121ed0b8fda72c7ce47
:040000 040000 40427e34a1ff89c458f2a5f262a108d46b4fa004 c7ba91028b1cef63f4f7eef70f0c4054b31e92b6 M  poster-hbm2011_neurodebian
%         git diff-tree todonotloose^ HEAD
:100644 100644 378e1379ec5ebb7abac59fec162b7238b5846525 c39ced763aeb5fd352cecd6fef1bfc40471f2246 M  .gitmodules
:000000 040000 0000000000000000000000000000000000000000 141dbc1bfe1be2eab77f04ca03f6f28feb372cca A  challenge-execpapers
:040000 040000 401fd66867de412b8653dc3a698bbaa45441bec1 ee190f09786f324abdda6e7a36e8278c201a20a0 M  frontiers
:040000 040000 26c884a67efb55bdf96d7453d9acd50cee36ae90 ad3e829d15b302c4342a6b2a9fb5dfede0ed77c9 M  sty


On Fri, 07 Jan 2011, Jonathan Nieder wrote:
> As contrib/examples/git-revert.sh explains, the heart of "git
> cherry-pick" is

> 	base=todonotloose^
> 	next=todonotloose
> 	head=HEAD

> 	git merge-recursive $base -- $head $next

> Could you try that, perhaps with GIT_MERGE_VERBOSITY=4 (or some other
> number from 1 to 5, larger is louder) in the environment?  For context,

> 	git ls-files -u;	# after the merge
> 	git diff-tree todonotloose
> 	git diff-tree todonotloose^ HEAD

> would also be interesting.


-- 
Yaroslav O. Halchenko
Postdoctoral Fellow,   Department of Psychological and Brain Sciences
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
