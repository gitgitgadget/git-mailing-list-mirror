From: Mike Hommey <mh@glandium.org>
Subject: Re: Git's database structure
Date: Tue, 4 Sep 2007 20:04:29 +0200
Organization: glandium.org
Message-ID: <20070904180429.GA626@glandium.org>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com> <9e4733910709040928n6535e49esaf713b2c63ba0831@mail.gmail.com> <7vtzqany0z.fsf@gitster.siamese.dyndns.org> <9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 20:06:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IScmr-0001BL-4H
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 20:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225AbXIDSGA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 14:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755213AbXIDSGA
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 14:06:00 -0400
Received: from vawad.err.no ([85.19.200.177]:55561 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755206AbXIDSF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 14:05:59 -0400
Received: from aputeaux-153-1-67-149.w81-249.abo.wanadoo.fr ([81.249.53.149] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IScmW-0008RJ-C8; Tue, 04 Sep 2007 20:05:50 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1ISclJ-0000Al-AI; Tue, 04 Sep 2007 20:04:29 +0200
Content-Disposition: inline
In-Reply-To: <9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57630>

On Tue, Sep 04, 2007 at 01:44:47PM -0400, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 9/4/07, Junio C Hamano <gitster@pobox.com> wrote:
> > "Jon Smirl" <jonsmirl@gmail.com> writes:
> >
> > > Another way of looking at the problem,
> > >
> > > Let's build a full-text index for git. You put a string into the index
> > > and it returns the SHAs of all the file nodes that contain the string.
> > > How do I recover the path names of these SHAs?
> >
> > That question does not make much sense without specifying "which
> > commit's path you are talking about".
> >
> > If you want to encode such "contextual information" in addition
> > to "contents", you could do so, but you essentially need to
> > record commit + pathname + mode bits + contents as "blob" and
> > hash that to come up with a name.
> 
> I left the details out of the full-text example to make it more
> obvious that we can't recover the path names.
> 
> Doing this type of analysis may point out that even more fields are
> missing from the blob table such as commit id.
> 
> The current data store design is not very flexible. Databases solved
> the flexibility problem long ago. I'm just wondering if we should
> steal some good ideas out of the database world and apply them to git.
> Ten years from now we may have 100GB git databases and really wish we
> had more flexible ways of querying them.
> 
> The reason databases don't encode the fields into the index is that
> you can only have a single index on the table if you do that.
> Databases do sometimes duplicate the field in both the index and the
> table. Databases also have the property that indexes are just a cache
> and can be dropped at any time.

The big difference between a database and git is that a database is a
general purpose tool. git has a much more restricted scope. As such, it
doesn't need *that much* flexibility.

Mike
