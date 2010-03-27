From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Enumerating all objects in the Git object store
Date: Sat, 27 Mar 2010 14:33:57 +0100
Message-ID: <4BAE0945.8040406@drmicha.warpmail.net>
References: <a1138db31003260831q34967f69u9fc8de861f7931b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Richards <paul.richards@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 14:33:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvW92-0008GY-0t
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 14:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293Ab0C0Ndj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 09:33:39 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:59601 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753274Ab0C0Ndi (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Mar 2010 09:33:38 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1DFECE9F95;
	Sat, 27 Mar 2010 09:33:38 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Sat, 27 Mar 2010 09:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=NMoOXZ8NL4t3FFJD5AFUVmDWeeA=; b=MZVb9yTSCYqdL9h6bxN4DWw3b+sd65uPkl8liNZftRC5esz0mh7oIGbq7XjtTd2HugT7ei7kePJ+4C9EY9yNJG2hVkB+Er5g/+GHfQ6Z1yyt/ZQps+dEIcoKB+dyFAkSo6YbqZFYUe0te8/IK1Te4n81tgWXiLCYQMVeO9FoI08=
X-Sasl-enc: uojOwOFPyeCpdCcvSMxAh/N6IjiBxRo5SVfrid2+4VxQ 1269696817
Received: from localhost.localdomain (p3EE29A92.dip0.t-ipconnect.de [62.226.154.146])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5D8BB2E9A5;
	Sat, 27 Mar 2010 09:33:37 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <a1138db31003260831q34967f69u9fc8de861f7931b1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143331>

Paul Richards venit, vidit, dixit 26.03.2010 16:31:
> Hi,
> I'd like to visualize the objects in a Git repository using Graphviz
> and "dot".  I'd like to see commits as circles, trees as triangles,
> blobs as rectangles, and have arrows linking these objects showing how
> they reference each other in the Git DAG.  For small repositories this
> may be a useful way to visualize how Git objects work.
> 
> I could not find a pre-existing script to do this so I am considering
> writing one.  Is there a way to enumerate all the objects in the Git
> object store, and for each one figure out its type (commit, tree, or
> blob) and obtain a list of the objects it references?  If not, is
> there a way to do this for a single object at a time?  (I can then
> simply recurse through the whole structure.)
> 

If you don't care about loose (unreferenced) objects then it's enough to
walk through all refs (branches, tags) and, for each ref, look at parent
and tree references (using git cat-file) and recurse.

If you don't care about the sha1 of commits you might even want to
(ab)use git-fast-export for that!

Michael
