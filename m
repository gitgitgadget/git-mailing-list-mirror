From: David Kastrup <dak@gnu.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Sun, 02 Sep 2007 10:06:00 +0200
Message-ID: <85odgltrtj.fsf@lola.goethe.zz>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org>
	<46DA5F33.2020005@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933904AbXIBIGa@vger.kernel.org Sun Sep 02 10:06:56 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933904AbXIBIGa@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRkTw-0002Qb-FJ
	for glk-linux-kernel-3@gmane.org; Sun, 02 Sep 2007 10:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933904AbXIBIGa (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 2 Sep 2007 04:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754229AbXIBIGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Sep 2007 04:06:14 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:37149 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750886AbXIBIGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Sep 2007 04:06:11 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 86CFD2E2952;
	Sun,  2 Sep 2007 10:06:10 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 7B65FABE0E;
	Sun,  2 Sep 2007 10:06:10 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-038-061.pools.arcor-ip.net [84.61.38.61])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 479C236E866;
	Sun,  2 Sep 2007 10:06:02 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 532B61C15372; Sun,  2 Sep 2007 10:06:00 +0200 (CEST)
In-Reply-To: <46DA5F33.2020005@zytor.com> (H. Peter Anvin's message of "Sun\, 02 Sep 2007 07\:58\:59 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57305>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Junio C Hamano wrote:
>>
>> * For people who need to import from Perforce, a front-end for
>>   fast-import is in contrib/fast-import/.
>>
>
> There seems to be an issue with this and RPMS.
>
> In particular, there is no longer a git-p4 RPMS, which prevents git
> from getting upgraded at all by yum.
>
> Anyone who knows yum well enough to explain what needs to be done so
> that yum knows this is obsolete?

Probably a matter of the correct spec file.  In auctex.spec, we have

Summary: 	Enhanced TeX modes for Emacsen
Name: 		auctex
Version: 	11.84
Release: 	1%{distri}
License: 	GPL
Group: 		%{commongroup}
URL: 		http://www.gnu.org/software/auctex/
Source0:        ftp://ftp.gnu.org/pub/gnu/auctex/%{name}-%{version}.tar.gz
BuildArchitectures: noarch
BuildRoot: 	%{_tmppath}/%{name}-root

%description
AUCTeX is [...]

%package emacs
Summary: 	Enhanced TeX modes for GNU Emacs
Group:          %{commongroup}
Requires: 	emacs >= 21
Obsoletes:      ge_auc emacs-auctex auctex preview-latex-emacs
Conflicts:      emacspeak < 18
Provides:       auctex


So auctex-emacs obsoletes the previous "auctex" package and some other
packages.  It also provides "auctex" since some other packages might
require it.

Basically, you need to provide everything that a third-party package
might have asked for, and you need to obsolete everything that you
intend to replace.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
