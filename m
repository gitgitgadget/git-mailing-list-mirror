From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Newbie questions regarding jgit
Date: Wed, 12 Nov 2008 11:29:05 -0800
Message-ID: <20081112192905.GW2932@spearce.org>
References: <4919EECB.7070408@wellfleetsoftware.com> <2c6b72b30811111337v2fe23c75v25251838f721a007@mail.gmail.com> <491AE2BD.7080103@wellfleetsoftware.com> <491AE91C.4020402@wellfleetsoftware.com> <491B18C4.2070000@wellfleetsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Farrukh Najmi <farrukh@wellfleetsoftware.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 20:30:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0LQ5-0005oa-HA
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 20:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbYKLT3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 14:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbYKLT3J
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 14:29:09 -0500
Received: from george.spearce.org ([209.20.77.23]:54049 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbYKLT3H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 14:29:07 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 30C4B381FF; Wed, 12 Nov 2008 19:29:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <491B18C4.2070000@wellfleetsoftware.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100806>

Farrukh Najmi <farrukh@wellfleetsoftware.com> wrote:
>
> So far I have figured out how to get the treeWalk for the path filter as  
> shown below.
> Now I am lost as to how to get the blob associated with the treeWalk.  
> TIA for your help.
>
>   /**
>    * Gets the content of specified file in git Repo.
>    *
>    * @parameter relativePath the relative path in jitRepo for  desired  
> file to get
>    * @parameter versionName the versionName for the desired file. It  
> will be unmarshalled from String to ObjectId.
>    * @return the content of the desired file version packaged as a  
> DataHandler.
>    */
>   public DataHandler get(String relativePath, String versionName) throws 
> RepositoryException {
>            ObjectId retrieveStart = repository.resolve(versionName);
>            RevWalk revWalk = new RevWalk(repository);
>            RevCommit entry = revWalk.parseCommit(retrieveStart);
>            RevTree revTree = entry.getTree();
>
>            TreeWalk treeWalk = TreeWalk.forPath(repository,  
> relativePath, revTree);
>
>            //Not sure how to get the blob next

	if (treeWalk.next()) {
		// Path exists
		if (treeWalk.getFileMode(0).getObjectType() == Constants.OBJ_BLOB) {
			ObjectId blob = treeWalk.getObjectId(0);
		} else {
			// Not a blob, its something else (tree, gitlink)
		}
	} else {
		// Path not found
	}

-- 
Shawn.
