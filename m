From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2 5/5] describe: Break annotated tag ties by tagger
	date
Date: Tue, 13 Apr 2010 12:46:23 -0700
Message-ID: <20100413194623.GA17484@spearce.org>
References: <20100411024008.GC23075@spearce.org> <1271114729-18166-5-git-send-email-spearce@spearce.org> <201004131132.30186.trast@student.ethz.ch> <20100413140830.GA12635@spearce.org> <7vbpdnupbm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 13 21:46:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1m4B-0002My-NO
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 21:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300Ab0DMTqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 15:46:30 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53975 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab0DMTq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 15:46:29 -0400
Received: by wyf19 with SMTP id 19so382396wyf.19
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 12:46:28 -0700 (PDT)
Received: by 10.216.90.206 with SMTP id e56mr72916wef.167.1271187988437;
        Tue, 13 Apr 2010 12:46:28 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id h31sm2642463wbh.1.2010.04.13.12.46.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Apr 2010 12:46:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vbpdnupbm.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144827>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Thomas Rast <trast@student.ethz.ch> wrote:
> >> Shawn O. Pearce wrote:
> >> > If the tag is an older-style annotated tag with no tagger date,
> >> > we assume a date stamp of 1 second after the UNIX epoch.
> >> 
> >> This patch doesn't seem to actually set this, but as a minor nit: the
> >> '1 second' contradicts the 0 mentioned in the last patch.
> 
> Surely I can, but I am curious as to the motivation behind '1 second' in
> the original patch.  If you wanted to give these '1 second' ones slight
> preference over the ones with 'date stamp at the UNIX epoch', that logic
> is not there anymore in the re-rolled series, no?

The 1-second in the original patch had nothing to do about giving
one tag an edge over another tag.

The meaning of date in the original patch was:

  date = 0: we haven't yet looked up the date
  date = 1: we looked it up, but there is no tagger present
  date > 0: "valid" date, we can sort with it

So date = 1 was just about getting ourselves out of the !date case so
that we didn't keep parsing a tag which has no tagger field present.

In the new version this is handled by the standard parsed field
of struct object.  So I didn't need to overload the meaning of the
date field anymore.

Make sense?

-- 
Shawn.
