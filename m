From: Phillip Susi <psusi@cfl.rr.com>
Subject: Splitting a repository but sharing the common parts of the object
 database
Date: Mon, 13 Dec 2010 13:39:47 -0500
Message-ID: <4D066873.4020208@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 19:39:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSDId-0007Mh-EB
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 19:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757625Ab0LMSi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 13:38:57 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.122]:55934 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754260Ab0LMSi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 13:38:57 -0500
Authentication-Results: cdptpa-omtalb.mail.rr.com smtp.user=psusi@cfl.rr.com; auth=pass (PLAIN)
X-Authority-Analysis: v=1.1 cv=Inhw+Jdt7z1D3BivGPfn2aw54OvUEJw5lAn/booRZkE= c=1 sm=0 a=OkGVMUMuZ1MA:10 a=8nJEP1OIZ-IA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:17 a=3mBZ2fG7rkcXB5OK52IA:9 a=RPR68vU2SQq79Rtk-wQA:7 a=2wI1q2MO5Ezb3m65NVRTafPFatUA:4 a=wPNLvfGTeEIA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:117
X-Cloudmark-Score: 0
X-Originating-IP: 72.242.190.170
Received: from [72.242.190.170] ([72.242.190.170:2215] helo=[10.1.1.235])
	by cdptpa-oedge04.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTPA
	id EB/BB-13137-F38660D4; Mon, 13 Dec 2010 18:38:56 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163579>

I have recently started a new project that has begun its life as a fork
of an old project, then heavily modified.  At the same time I am looking
into migrating from svn to git.  Since this is a separate project, I
thought I should split it into a separate git repository and keep them
separate going forward, however, since they have common ancestry up to
this point, I would like to make sure that all of that data is not
duplicated.

I thought what I could do is set up an initial repository that is fully
packed and use it as a read only archive to contain all of the shared
history, then clone that into two new repositories for the two separate
projects.  It seems like I can do this by running a clone -s so that the
archive is set up to be an alternate object store, then its big pack
file will be found and used for all of the old history, but new commits
will be specific to each of the two new respective projects.  The
problem I run into though, is when it comes time to repack the new projects.

If I run a repack -a, then the new project has everything copied out of
the archive and into its new main pack, rather than continuing to use
the archive repository for old history, and just pack everything since
then.  I guess I am looking for is somewhere between a full repack and
an incremental; a way to make repack -a discard existing local packs,
but to respect the alternate packs and omit objects they contain from
the new local pack.  Is this possible?
