From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: pull-fetch-param.txt (was Re: [PATCH] escape tilde in Documentation/git-rev-parse.txt)
Date: Tue, 03 Oct 2006 11:19:20 +0200
Message-ID: <45222B18.1090305@s5r6.in-berlin.de>
References: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de>	<7vhcymt07a.fsf@assigned-by-dhcp.cox.net>	<452211C2.8020402@s5r6.in-berlin.de> <7vven1rfpj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 11:22:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUgTZ-0000nY-Vp
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 11:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbWJCJWG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 05:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbWJCJWG
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 05:22:06 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:52107 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030284AbWJCJWD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 05:22:03 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from [192.168.0.41] ([83.221.230.151])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id k939LoXu030094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 3 Oct 2006 11:21:54 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vven1rfpj.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.1.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28261>

Junio C Hamano wrote:
> It's a bit sad that asciidoc's nicer quoting features
> are not backward compatible.

Yes, this is awkward. Here comes the next candidate for quoting.
In pull-fetch-param.txt:

----8<----
<refspec>::
	The canonical format of a <refspec> parameter is
	`+?<src>:<dst>`; that is, an optional plus `+`, followed
	by the source ref, followed by a colon `:`, followed by
	the destination ref.
+
The remote ref that matches <src>
is fetched, and if <dst> is not empty string, the local
ref that matches it is fast forwarded using <src>.
Again, if the optional plus `+` is used, the local ref
---->8----

"man git-fetch" and "man git-pull" show:
----8<----
       <refspec>
              The  canonical  format of a <refspec> parameter is ?<src>:<dst>;
              that is, an optional plus, followed by the source ref,  followed
              by a colon :, followed by the destination ref.

              The  remote  ref  that matches <src> is fetched, and if <dst> is
              not empty string, the local ref that matches  it  is  fast  for-
              warded  using  <src>. Again, if the optional plus + is used, the
---->8----

I.e. the first and second + were swallowed, but not the third one.
This is the fix for asciidoc 8.0.0:
	`$$+$$?<src>:<dst>`; that is, an optional plus `+`, followed

Here is another fix that works with asciidoc 8.0.0:
	`\+?<src>:<dst>`; that is, an optional plus `+`, followed

Results in
----8<----
       <refspec>
              The  canonical format of a <refspec> parameter is +?<src>:<dst>;
              that is, an optional plus +, followed by the  source  ref,  fol-
              lowed by a colon :, followed by the destination ref.

              The  remote  ref  that matches <src> is fetched, and if <dst> is
              not empty string, the local ref that matches  it  is  fast  for-
              warded  using  <src>. Again, if the optional plus + is used, the
---->8----

Does the backslash notation work with asciidoc 7?
-- 
Stefan Richter
-=====-=-==- =-=- ---==
http://arcgraph.de/sr/
