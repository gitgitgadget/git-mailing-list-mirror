From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: why is tagger header optional?
Date: Mon, 18 Jan 2010 22:37:43 -0800
Message-ID: <20100119063743.GD23212@spearce.org>
References: <20100119060946.GA23212@spearce.org> <7vk4vebo6z.fsf@alter.siamese.dyndns.org> <20100119063255.GC23212@spearce.org> <7vfx62bo0i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 07:37:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX7io-0003dO-VJ
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 07:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321Ab0ASGhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 01:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021Ab0ASGhq
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 01:37:46 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:38648 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab0ASGhq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 01:37:46 -0500
Received: by iwn10 with SMTP id 10so2800776iwn.22
        for <git@vger.kernel.org>; Mon, 18 Jan 2010 22:37:45 -0800 (PST)
Received: by 10.231.59.5 with SMTP id j5mr1510033ibh.6.1263883065444;
        Mon, 18 Jan 2010 22:37:45 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm5093448iwn.6.2010.01.18.22.37.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Jan 2010 22:37:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vfx62bo0i.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137433>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > Junio C Hamano <gitster@pobox.com> wrote:
> >> "Shawn O. Pearce" <spearce@spearce.org> writes:
> >> 
> >> > So why is it legal to omit the tagger header from a tag?
> >> >
> >> > E.g. the Linux kernel tag v2.6.12 has no tagger header:
> >> 
> >> We didn't.add tagger line until c818566 ([PATCH] Update tags to record who
> >> made them, 2005-07-14), which is v0.99.1~9
> >> 
> >> Linux 2.6.12 is a lot older than that.  v2.6.13-rc4 in late July is the
> >> first one with tagger.
> >
> > Ugh.  So its like the 100640 or whatever mode tags in the kernel
> > trees that are also considered bogus by today's standards, but have
> > to be allowed because of the kernel history.
> 
> Yeah; don't we have "fsck --strict" or something to take the distinction
> into account, though?  I don't recall if lack of tagger triggers the check
> offhand and I am too lazy to check.

I don't think it does under --strict.  But yea, we do have --strict
for the non-kernel repositories.

This came up because Gerrit Code Review asks JGit to do fsck during
receive of objects from a client, JGit's tag fsck is too strict
and demands a "tagger " header, but someone was trying to push this
old tag from the Linux kernel into an empty repository.

I'll have to relax our tag fsck code in JGit and make the header
optional.

-- 
Shawn.
