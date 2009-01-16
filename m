From: "George Spelvin" <linux@horizon.com>
Subject: Re: fatal: git grep: cannot generate relative filenames containing
 '..'
Date: Thu, 15 Jan 2009 22:27:08 -0500
Message-ID: <20090116032708.21156.qmail@science.horizon.com>
References: <20090115222905.8157.qmail@science.horizon.com>
 <alpine.DEB.1.00.0901160307290.3586@pacific.mpi-cbg.de>
 <7vhc40ov78.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux@horizon.com, git@vger.kernel.org
To: Johannes.Schindelin@gmx.de, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 16 04:28:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNfNw-0001Dw-8Z
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 04:28:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760191AbZAPD1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 22:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755442AbZAPD1L
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 22:27:11 -0500
Received: from science.horizon.com ([192.35.100.1]:14651 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760082AbZAPD1K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 22:27:10 -0500
Received: (qmail 21157 invoked by uid 1000); 15 Jan 2009 22:27:08 -0500
In-Reply-To: <7vhc40ov78.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105917>

Junio C Hamano <gitster@pobox.com> wrote:
> Or perhaps someone did more than two years ago with --full-name?

Thank you for pointing that out!  It's a bit of a handful to type,
but at least it makes what I want to do possible without having to
write a wrapper script.  And I can reduce the typing with an alias.

I'm still trying to figure out why the basic form doesn't work,
though.  Is there something more subtle than that fact that the
filename simplification in grep_sha1 and grep_file might do the
wrong thing?  If I comment out the check in cmd_grep(), it seems
to work, although it prints out some funky filenames.

That seems like a straightforward thing to fix.  Basically, strip
off the common part of the prefix and name, and for every remaining
component in the prefix, prepend a ../ to the name.

I don't mind doing the coding, but can someone who groks the
code more fully tell me if I'm missing something major?
