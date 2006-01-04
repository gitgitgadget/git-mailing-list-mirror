From: Kyle McMartin <kyle@mcmartin.ca>
Subject: git format-patch shell quoting bug
Date: Tue, 3 Jan 2006 23:55:19 -0500
Message-ID: <20060104045519.GB29515@quicksilver.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jan 04 05:55:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eu0gi-00082C-1f
	for gcvg-git@gmane.org; Wed, 04 Jan 2006 05:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWADEzm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jan 2006 23:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWADEzm
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jan 2006 23:55:42 -0500
Received: from cabal.ca ([134.117.69.58]:37516 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S932506AbWADEzm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jan 2006 23:55:42 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by fattire.cabal.ca (Postfix) with ESMTP id D591B23E83
	for <git@vger.kernel.org>; Tue,  3 Jan 2006 23:55:38 -0500 (EST)
Received: from fattire.cabal.ca ([127.0.0.1])
	by localhost (fattire [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07438-05 for <git@vger.kernel.org>;
	Tue, 3 Jan 2006 23:55:38 -0500 (EST)
Received: from quicksilver.road.mcmartin.ca (CPE0030ab0b413b-CM0012c9a9a56e.cpe.net.cable.rogers.com [70.28.1.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "quicksilver.road.mcmartin.ca", Issuer "There Is No Cabal Certificate Authority" (verified OK))
	by fattire.cabal.ca (Postfix) with ESMTP id 8EAFD23E82
	for <git@vger.kernel.org>; Tue,  3 Jan 2006 23:55:38 -0500 (EST)
Received: by quicksilver.road.mcmartin.ca (Postfix, from userid 1000)
	id 107603B059; Tue,  3 Jan 2006 23:55:19 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at cabal.ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14173>

Hi,

There's apparently a quoting bug in git-format-patch. When I import
a patch with apply-mbox, for example

From: Carlos O'Donell <carlos@parisc-linux.org>

The author field is correctly set, including the "'" in Carlos' name.

So when I go to rebase my tree, or send out patches, I 
"git-format-patch origin" and get...

/usr/bin/git-format-patch: eval: line 200: unexpected EOF while looking for 
matching `''
/usr/bin/git-format-patch: eval: line 201: syntax error: unexpected end of file

Which produces a bogus output patch with a blank From and Date,

Subject: [PATCH] ...
From:
Date:

[...]

I believe this recently crept in, as I don't recall seeing it before.

Cheers,
	Kyle
