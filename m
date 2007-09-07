From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 07 Sep 2007 21:40:20 +0200
Message-ID: <85sl5q2riz.fsf@lola.goethe.zz>
References: <46DDC500.5000606@etek.chalmers.se>
	<1189004090.20311.12.camel@hinata.boston.redhat.com>
	<vpq642pkoln.fsf@bauges.imag.fr>
	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	<alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
	<a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
	<D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com>
	<fbr2iv$ugg$1@sea.gmane.org> <46E11CE1.4030209@op5.se>
	<fbs8es$1cd$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Walter Bright <boost@digitalmars.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 21:40:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITjgz-0004WN-RE
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 21:40:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758179AbXIGTkc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 15:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758164AbXIGTkc
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 15:40:32 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:37852 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751071AbXIGTka (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 15:40:30 -0400
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id A7968302C67;
	Fri,  7 Sep 2007 21:40:29 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 955AD23D327;
	Fri,  7 Sep 2007 21:40:29 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-039-212.pools.arcor-ip.net [84.61.39.212])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 53AFC1BF3D7;
	Fri,  7 Sep 2007 21:40:21 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id C82911CAD71D; Fri,  7 Sep 2007 21:40:20 +0200 (CEST)
In-Reply-To: <fbs8es$1cd$1@sea.gmane.org> (Walter Bright's message of "Fri\, 07 Sep 2007 12\:23\:16 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4183/Fri Sep  7 21:19:48 2007 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58061>

Walter Bright <boost@digitalmars.com> writes:

> On my project, one. But I've seen this problem repeatedly in other
> projects that had multiple developers. For example, I used to use
> version 1 of an assembler. It was itself written entirely in
> assembler. It ran *incredibly* slowly on large asm files. But it was
> written in assembler, which is very fast, so how could that be?
>
> Turns out, the symbol table used internally was a linear one. A
> linear symbol table is easy to implement, but doesn't scale well at
> all.

Well, my first system was a Z80 computer with an editor/assembler in
ROM (4kb).  At one time I tried figuring out the size requirements of
symbols.  It was two bytes for each symbol.  Namely the value.  The
"symbol table" was located behind the source code.  Whenever this
marvel of technology encountered a label, it searched the source code
from the beginning for the definition of the label, keeping count of
all label definitions in between.  When it found the definition, the
count corresponded to the position in the symbol table.

So compilation times were O(ns), with n the number of symbol uses and
s the size of the source code.

Implementing in a higher language would not have helped: memory
efficiency was what dictated this layout.  Given that the whole
available memory was perhaps 50kB, assembly language modules could not
get so large that scale issues were deadly.  But the assembly times
did get annoying sometimes.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
