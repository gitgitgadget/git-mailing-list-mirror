From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Implement packed refs
Date: Tue, 15 May 2007 00:49:23 +0200
Message-ID: <200705150049.24467.robin.rosenberg@dewire.com>
References: <11790995572233-git-send-email-robin.rosenberg@dewire.com> <11790995571637-git-send-email-robin.rosenberg@dewire.com> <20070514224533.GA28832@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 15 00:49:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnjME-00074G-UE
	for gcvg-git@gmane.org; Tue, 15 May 2007 00:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757019AbXENWtR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 18:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756937AbXENWtR
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 18:49:17 -0400
Received: from [83.140.172.130] ([83.140.172.130]:5543 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754113AbXENWtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 18:49:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B53288028BE;
	Tue, 15 May 2007 00:43:03 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18467-02; Tue, 15 May 2007 00:43:03 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 5B5798027ED;
	Tue, 15 May 2007 00:43:03 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070514224533.GA28832@spearce.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47298>

tisdag 15 maj 2007 skrev Shawn O. Pearce:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> > index 76191be..3b2a82c 100644
> > @@ -411,6 +412,10 @@ public class Repository {
> >  	private Ref readRefBasic(String name) throws IOException {
> >  		int depth = 0;
> >  		REF_READING: do {
> > +			ObjectId id = packedRefs.get(name);
> > +			if (id != null)
> > +				return new Ref(null, id);
> > +
> >  			final File f = new File(getDirectory(), name);
> >  			if (!f.isFile()) {
> >  				return new Ref(f, null);
> 
> This is actually backwards.  Git checks the loose ref first, and
> then the packed ref.  The reason is so that users can pack all
> of their refs (git pack-refs --all) and then just create new ref
> files for those that they change, rather than rewriting the entire
> packed-refs file over again.
> 
> I'm adding a commit after your series to correct this.
Thanks.

> > +		} catch (IOException e) {
> > +			e.printStackTrace();
> > +		}
> 
> We really should be throwing exceptions back to the caller,
> especially on things that could indicate corruption or other
> problems with reading the repository contents.

Well, [looking for something to blame]... 

-- robin
