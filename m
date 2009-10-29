From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v4 26/26] test smart http fetch and push
Date: Thu, 29 Oct 2009 07:56:04 -0700
Message-ID: <20091029145604.GV10505@spearce.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org> <1256774448-7625-27-git-send-email-spearce@spearce.org> <7vpr86dgyj.fsf@alter.siamese.dyndns.org> <20091029143702.GU10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 15:56:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3WQ7-0007xW-HO
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 15:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbZJ2Oz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 10:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754287AbZJ2Oz7
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 10:55:59 -0400
Received: from george.spearce.org ([209.20.77.23]:44754 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065AbZJ2Oz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 10:55:59 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1A618381D3; Thu, 29 Oct 2009 14:56:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091029143702.GU10505@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131596>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > > +		s/^Content-Length: .*$/Content-Length: xxxx/
> > 
> > This chomped line is so unlike you---what happened?
> 
> I was getting different Content-Lengths on different runs of the
> test.  I don't know why.  Here the Content-Length is of the gzip'd
> request, it shouldn't be varying with each run, but it seemed to be.

FWIW, I found the variablity here.  It was triggered by running the
test with -v or without -v, which caused clone to change its first
"want" line to include or exclude progress messages, based on the
tty-ness of stderr.

Adding a --quiet to the clone command means I can avoid this munging
and hard code the length in the test vector.  But I'm still against
doing that here in case the protocol capabilities ever change in
the future.
  
-- 
Shawn.
