From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/3] fast-import: Allow cat requests at arbitrary
	points in stream
Date: Tue, 7 Sep 2010 22:57:32 -0500
Message-ID: <20100908035732.GA24444@capella.cs.uchicago.edu>
References: <20100701031819.GA12524@burratino> <20100701054849.GA14972@burratino> <20100817170216.GA14491@kytes> <20100905031528.GA2344@burratino> <20100908032736.GC23409@capella.cs.uchicago.edu> <AANLkTinU6TtFgLuQf54aZNE7-E3fDYLcmp25uiGRFgrV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 05:57:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtBnD-00076d-K2
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 05:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756361Ab0IHD5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 23:57:35 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:54529 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756085Ab0IHD5d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 23:57:33 -0400
Received: from capella.cs.uchicago.edu (capella.cs.uchicago.edu [128.135.24.228])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 37DB9B8FC;
	Tue,  7 Sep 2010 22:57:33 -0500 (CDT)
Received: by capella.cs.uchicago.edu (Postfix, from userid 10442)
	id 0628DA7CA; Tue,  7 Sep 2010 22:57:32 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinU6TtFgLuQf54aZNE7-E3fDYLcmp25uiGRFgrV@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155763>

Sverre Rabbelier wrote:
> On Tue, Sep 7, 2010 at 22:27, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Rather than planning in advance and saving up a bunch of objects
>> before a "commit" command, frontends might want to wait until the
>> middle of a commit and request objects then.
>
> I'm not sure I understand the justification of this patch. Is the
> purpose of this patch to save you from having to loop over everything
> you want to commit in the next commit and cat-ing that in advance?

Yes.  In particular, an importer that wants to apply deltas
to generate the content for

 M 100644 inline foo

commands might use this.

Probably not relevant for svn-fe in its current design, since it uses
blob commands and remembers the tree as it builds it up.
