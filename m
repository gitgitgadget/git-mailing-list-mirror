From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: Re: [RFC PATCH v2 0/2] git-gui: (un)stage a range of changes
	at once
Date: Mon, 7 Dec 2009 18:38:36 -0600
Message-ID: <20091208003836.GB22330@unpythonic.net>
References: <1256160023-29629-1-git-send-email-jepler@unpythonic.net> <20091026193903.GA27319@unpythonic.net> <20091205213613.GG5610@spearce.org> <20091207125435.GA43609@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Dec 08 01:39:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHo6S-0005te-5L
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 01:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbZLHAin convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Dec 2009 19:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965236AbZLHAin
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 19:38:43 -0500
Received: from dsl.unpythonic.net ([206.222.212.217]:49622 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965184AbZLHAin (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 19:38:43 -0500
Received: by unpythonic.net (Postfix, from userid 1000)
	id 9DDAA1148EA; Mon,  7 Dec 2009 18:38:36 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20091207125435.GA43609@book.hvoigt.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134792>

On Mon, Dec 07, 2009 at 01:54:35PM +0100, Heiko Voigt wrote:
> Jeff could you clarify or provide an example?

If I recall correctly, the problem with the v2 patch was when the chang=
e
was like
    @@ -13,8 +13,8 @@ set appvers {@@GITGUI_VERSION@@}
     set copyright [encoding convertfrom utf-8 {
     Copyright =A9 2006, 2007 Shawn Pearce, et. al.

    -This program is free software; you can redistribute it and/or modi=
fy
    -it under the terms of the GNU General Public License as published =
by
    +blah blah
    +blah blah
     the Free Software Foundation; either version 2 of the License, or
     (at your option) any later version.
and the 'blah blah' lines were both staged in the same operation.

When doing this, the staged change is actually
    +blah blah
     This program is free software; you can redistribute it and/or modi=
fy
     it under the terms of the GNU General Public License as published =
by
    +blah blah

but the change that should have been staged is:
    +blah blah
    +blah blah
     This program is free software; you can redistribute it and/or modi=
fy
     it under the terms of the GNU General Public License as published =
by

Since it requires staging multiple "+" lines in one go, this problem
doesn't exist in git-gui before my changes.

The v3 patch I posted just a few minutes ago fixes this problem.

Jeff
