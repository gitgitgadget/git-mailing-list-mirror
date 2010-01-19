From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: why is tagger header optional?
Date: Mon, 18 Jan 2010 22:09:46 -0800
Message-ID: <20100119060946.GA23212@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 19 07:17:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX7PO-0006no-Dp
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 07:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846Ab0ASGQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 01:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322Ab0ASGQ5
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 01:16:57 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:48304 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab0ASGQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 01:16:56 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jan 2010 01:16:56 EST
Received: by iwn10 with SMTP id 10so2790640iwn.22
        for <git@vger.kernel.org>; Mon, 18 Jan 2010 22:16:53 -0800 (PST)
Received: by 10.231.153.1 with SMTP id i1mr1826553ibw.35.1263881389940;
        Mon, 18 Jan 2010 22:09:49 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm5087955iwn.8.2010.01.18.22.09.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Jan 2010 22:09:48 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137428>

So why is it legal to omit the tagger header from a tag?

E.g. the Linux kernel tag v2.6.12 has no tagger header:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=tag;h=26791a8bcf0e6d33f43aef7682bdb555236d56de

JGit is currently failing on this tag, because its fsck
implementation demands that a tag have a tagger header
that can be parsed as a person identity.

Looking at tag.c's parse_tag_buffer(), the variable sig_line seems
to be expected to point at the "tagger " header (given its name),
but its not actually validated as such.

Is there a version of Git floating around that doesn't create a
tagger header when creating a signed tag?  WTF?

-- 
Shawn.
