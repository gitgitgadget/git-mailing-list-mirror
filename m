From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv5 00/14] git notes
Date: Tue, 08 Sep 2009 10:54:02 +0200
Message-ID: <200909081054.02523.johan@herland.net>
References: <1252376822-6138-1-git-send-email-johan@herland.net>
 <200909080512.34634.johan@herland.net>
 <7vd462qdeg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 10:54:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkwTL-000467-4A
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 10:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbZIHIyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 04:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753850AbZIHIyE
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 04:54:04 -0400
Received: from smtp.getmail.no ([84.208.15.66]:39682 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753625AbZIHIyD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Sep 2009 04:54:03 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPN00AUDA23KY20@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Sep 2009 10:54:03 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPN00GGTA220K10@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Sep 2009 10:54:03 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.9.8.84223
User-Agent: KMail/1.12.1 (Linux/2.6.30-ARCH; KDE/4.3.1; x86_64; ; )
In-reply-to: <7vd462qdeg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127993>

On Tuesday 08 September 2009, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > Furthermore, the following notes tree structures were tested:
> >
> > - "no-notes": Testing without any notes at all. This is only present as
> > a baseline, and to verify that the notes code does not negatively
> > affect performance when not in use.
> 
> Minor nit.
> 
> For this to be a baseline, you would need to have another algorithm
>  before "before", i.e., without any of these notes implementation.
> 
> Comparison with "before" alone is not meaningful.  That is like starting
> with a state with unknown performance regression compared to the stock
> version, and then boast improvements made by various variations.
> 
> You would need to compare overhead of various "algorithms" with the stock
> git in "no-notes" case as well.  It would give us the true performance
> cost of supporting notes.

True. Here is the same table with the baseline ('next') entry on top:


Algorithm / Notes tree   git log -n10 (x100)   git log --all
------------------------------------------------------------
next / no-notes                4.77s              63.84s

before / no-notes              4.78s              63.90s
before / no-fanout            56.85s              65.69s

16tree / no-notes              4.77s              64.18s
16tree / no-fanout            30.35s              65.39s
16tree / 2_38                  5.57s              65.42s
16tree / 2_2_36                5.19s              65.76s

flexible / no-notes            4.78s              63.91s
flexible / no-fanout          30.34s              65.57s
flexible / 2_38                5.57s              65.46s
flexible / 2_2_36              5.18s              65.72s
flexible / ym                  5.13s              65.66s
flexible / ym_2_38             5.08s              65.63s
flexible / ymd                 5.30s              65.45s
flexible / ymd_2_38            5.29s              65.90s
flexible / y_m                 5.11s              65.72s
flexible / y_m_2_38            5.08s              65.67s
flexible / y_m_d               5.06s              65.50s
flexible / y_m_d_2_38          5.07s              65.79s


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
