From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH EGIT 1/2] Implement "jgit rev-parse"
Date: Fri, 1 May 2009 08:14:54 -0700
Message-ID: <20090501151454.GC23604@spearce.org>
References: <1241174172-19581-1-git-send-email-git@sdiz.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org,
	"Daniel Cheng (aka SDiZ)" <git@sdiz.net>
To: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 01 17:15:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzuS8-0000ig-Q8
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 17:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963AbZEAPOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 11:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755868AbZEAPOy
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 11:14:54 -0400
Received: from george.spearce.org ([209.20.77.23]:48620 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751AbZEAPOy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 11:14:54 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 30BB13807D; Fri,  1 May 2009 15:14:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1241174172-19581-1-git-send-email-git@sdiz.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118080>

"Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com> wrote:
>  .../src/org/spearce/jgit/pgm/RevParse.java         |   70 ++++++++++++++++++++

Thanks.  I have two remarks, I'm amending them in as they are
trivial for me to fix.

> +class RevParse extends TextBuiltin {
> +	RevWalk walk;

Unused field.  Deleted.

> +	@Option(name = "--all")
> +	boolean all = false;
> +
> +	@Argument(index = 0, metaVar = "commit-ish")
> +	private final List<ObjectId> commits = new ArrayList<ObjectId>();
> +
> +	@Override
> +	protected void run() throws Exception {
> +		if (all) {
> +			Map<String, Ref> allRefs = db.getAllRefs();
> +			for (final Ref r : allRefs.values())
> +				System.out.println(r.getObjectId().name());
> +		} else {
> +			for (final ObjectId o : commits)
> +				System.out.println(o.name());

These should use the PrintWriter called "out" inherited from
the TextBuiltin class, not System.out.  Fixed.

-- 
Shawn.
