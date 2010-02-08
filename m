From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: check whether systems nice command works or
	disable it
Date: Mon, 8 Feb 2010 07:56:31 -0800
Message-ID: <20100208155631.GB19288@spearce.org>
References: <20100207214755.GB3034@book.hvoigt.net> <7vhbps4lwr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 16:57:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeVzn-000141-Ne
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 16:57:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793Ab0BHP4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 10:56:37 -0500
Received: from mail-qy0-f201.google.com ([209.85.221.201]:60024 "EHLO
	mail-qy0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787Ab0BHP4g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 10:56:36 -0500
Received: by qyk39 with SMTP id 39so459829qyk.16
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 07:56:34 -0800 (PST)
Received: by 10.224.52.104 with SMTP id h40mr2518005qag.44.1265644594375;
        Mon, 08 Feb 2010 07:56:34 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm4543836iwn.8.2010.02.08.07.56.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Feb 2010 07:56:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vhbps4lwr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139294>

Junio C Hamano <gitster@pobox.com> wrote:
> > diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> > index 1fb3cbf..eec2dc9 100755
> > --- a/git-gui/git-gui.sh
> > +++ b/git-gui/git-gui.sh
> > @@ -388,6 +388,9 @@ proc _lappend_nice {cmd_var} {
> >  
> >  	if {![info exists _nice]} {
> >  		set _nice [_which nice]
> > +		if {[catch {exec $_nice git version}]} {
> > +			set _nice {}
> > +		}
> 
> Where does the output from this "git version" invocation go?

By default Tcl exec returns stdout's contents.  So in this case,
its passed to catch, which discards it, because catch returns true
if exec crashed, false if it ran without error.

Patch looks fine to me as-is.

-- 
Shawn.
