From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: git-svn clone problem
Date: Wed, 27 May 2009 19:41:53 -0700
Message-ID: <20090528024153.GH12914@mail.oracle.com>
References: <20090527221601.GA12914@mail.oracle.com> <86d4c5e00905271911g58cccc1bwd4b881541db6f7a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Deskin Miller <deskinm@umich.edu>
X-From: git-owner@vger.kernel.org Thu May 28 04:42:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9VZq-0006Tu-3O
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 04:42:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531AbZE1Cmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 22:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755469AbZE1Cmc
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 22:42:32 -0400
Received: from acsinet11.oracle.com ([141.146.126.233]:33469 "EHLO
	acsinet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbZE1Cmb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 22:42:31 -0400
Received: from acsinet15.oracle.com (acsinet15.oracle.com [141.146.126.227])
	by acsinet11.oracle.com (Switch-3.3.1/Switch-3.3.1) with ESMTP id n4S2h7JD031241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 28 May 2009 02:43:08 GMT
Received: from acsmt355.oracle.com (acsmt355.oracle.com [141.146.40.155])
	by acsinet15.oracle.com (Switch-3.3.1/Switch-3.3.1) with ESMTP id n4S2hGF1013507;
	Thu, 28 May 2009 02:43:16 GMT
Received: from ca-server1.us.oracle.com by acsmt357.oracle.com
	with ESMTP id 17351749181243478500; Wed, 27 May 2009 21:41:40 -0500
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.69)
	(envelope-from <joel.becker@oracle.com>)
	id 1M9VYq-000159-HJ; Wed, 27 May 2009 19:41:40 -0700
Content-Disposition: inline
In-Reply-To: <86d4c5e00905271911g58cccc1bwd4b881541db6f7a5@mail.gmail.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
	come to perfection.
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Source-IP: acsmt355.oracle.com [141.146.40.155]
X-Auth-Type: Internal IP
X-CT-RefId: str=0001.0A010204.4A1DFA13.023A:SCFMA4539814,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120138>

On Wed, May 27, 2009 at 07:11:01PM -0700, Deskin Miller wrote:
> The problem here isn't with git-svn; rather, it is with the svn
> repository at oss.oracle.com claiming a nonsensical UUID.  svn uses
> UUIDs behind the scenes to identify each repository, and git-svn does
> the same thing.  When doing git svn init (or clone, which is just init
> && fetch) the svn server sends back a UUID which identifies it.  When
> I use wireshark and expand the first HTTP packet back from a good svn
> server, I see something like the following embedded in the xml tree:
> 
> <lp3:repository-uuid>
> 612f8ebc-c883-4be0-9ee0-a4e9ef946e3a
> </lp3:repository-uuid>
> 
> However when I do the same with oss.oracle.com I see
> 
> <lp2:repository-uuid>
> ????????-????-????-????-????????????
> </lp2:repository-uuid>
> 
> git-svn tries to play along for a while, but the bottom line is that a
> string of question marks isn't a UUID.
> 
> There's more about svn's use of UUIDs in the svn book.  Perhaps the
> admin of oss.oracle.com can correct this UUID problem so one can use
> git-svn with this repository.

	Is this some new feature of svn that git-svn has decided to
require?  We're running subversion 1.4.4 there, and git-svn used to work
against those repos.
	Hmm, it's only a couple of very old repos with this problem -
they were probably created with subversion 1.1 or 1.0.  I found how to
fix it.  Thanks.

Joel

-- 

"People with narrow minds usually have broad tongues."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
