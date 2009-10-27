From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git update --prune issue
Date: Tue, 27 Oct 2009 09:42:55 +0100
Message-ID: <4AE6B28F.9010407@drmicha.warpmail.net>
References: <4389ce950910261508p7eca354el77bad07305a80952@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeffrey Middleton <jefromi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 09:43:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2hee-0000sf-1H
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 09:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756619AbZJ0Ini (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 04:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756589AbZJ0Inh
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 04:43:37 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54786 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756587AbZJ0Ing (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 04:43:36 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AC791BD522;
	Tue, 27 Oct 2009 04:43:27 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 27 Oct 2009 04:43:32 -0400
X-Sasl-enc: PNBDFW0UL4P9oRsotGV6iNNp35DNdLPVXblD6+6+iRXm 1256632978
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7E74B31640;
	Tue, 27 Oct 2009 04:42:58 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091027 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <4389ce950910261508p7eca354el77bad07305a80952@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131316>

Jeffrey Middleton venit, vidit, dixit 26.10.2009 23:08:
> I have an unreliable problem when using "git remote update --prune".
> git claims that many refs from a particular remote do not point to a
> valid object, but only after finishing another update.  I've included
> a shortened version of the output from one particular instance of the
> issue.  Note that the errors are printed for every subsequent remote
> as well.  However, after the update is completed, everything is fine.
> 
> It seems to only happen when there are non-fast-forward changes (new
> branch, forced update, pruned branch).  The issue only happens with
> this particular remote, which I've tried removing and recreating, and
> is the same type of remote as all my others (another user's
> NFS-mounted home directory).  However, my remotes are all individual
> developers, and this developer is the only one who ever rebases her
> working branches.  (recloning the repo from origin and setting up my
> config and remotes all over again has also had no effect)
> 
> Unfortunately, I have been unable to reproduce the problem in any test
> repos - for example, though a forced update and a pruned branch in the
> problematic remote along with an update in another remote seems to
> fairly reliably produce the problem in this repo, recreating that
> situation in another repo doesn't cause any problems.  Sorry for the
> incomplete bug report, but perhaps this will be enough to go on!
> 
> Thanks,
> Jeffrey
> 
> 
> I've seen the issue in previous versions built from git.git master, as
> well as v1.6.3.3, but for this particular one:
> 
> $ git --version
> git version 1.6.5.1.61.ge79999
> 
> $ git remote update --prune
> Updating origin
> remote: Counting objects: 42, done.
> remote: Compressing objects: 100% (9/9), done.
> remote: Total 15 (delta 9), reused 12 (delta 6)
> Unpacking objects: 100% (15/15), done.
> From /users/cxtfcm/CxTF_DB
>    88b8613..d40f26d  2009.Q4    -> origin/2009.Q4
>    d40f26d..56305b8  dev        -> origin/dev
> Updating steph
> remote: Counting objects: 299, done.
> remote: Compressing objects: 100% (241/241), done.
> remote: Total 276 (delta 186), reused 19 (delta 6)
> Receiving objects: 100% (276/276), 41.09 KiB | 10 KiB/s, done.
> Resolving deltas: 100% (186/186), completed with 17 local objects.
> From /users/sdewet/CxTF_DEV/CxTF_DB
>  + c2439dd...69cb5c3 beta_gc_dev -> steph/beta_gc_dev  (forced update)
>  + fb25173...f0e4963 beta_veh_dev -> steph/beta_veh_dev  (forced update)
>  * [new branch]      beta_veh_dev_old -> steph/beta_veh_dev_old
> Pruning steph
> URL: /users/sdewet/CxTF_DEV/CxTF_DB/
>  * [pruned] steph/beta_gc_dev_old
> Updating kevin
> error: refs/remotes/steph/beta_gc_dev does not point to a valid object!
> error: refs/remotes/steph/beta_veh_dev does not point to a valid object!
> Updating jose
> error: refs/remotes/steph/beta_gc_dev does not point to a valid object!
> error: refs/remotes/steph/beta_veh_dev does not point to a valid object!
> ### many more remotes with the same errors ###

Do you get the same problem if you do the steps individually, i.e.:

git remote update steph
git remote prune steph
git remote update kevin

Does it depend on the order, i.e.:

git remote update steph
git remote update kevin
git remote prune steph

Does "git fsck --full" say anything special?

Michael
