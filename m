From: Ondra Medek <xmedeko@gmail.com>
Subject: gitweb showing slash r at the end of line
Date: Fri, 27 Jan 2012 06:19:14 -0800 (PST)
Message-ID: <1327673954458-7229895.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 27 15:19:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqmeG-00065O-TY
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 15:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287Ab2A0OTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 09:19:16 -0500
Received: from sam.nabble.com ([216.139.236.26]:56509 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752017Ab2A0OTO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 09:19:14 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <xmedeko@gmail.com>)
	id 1Rqme2-0006Ri-Fx
	for git@vger.kernel.org; Fri, 27 Jan 2012 06:19:14 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189223>

Hi,
we have gitweb running on Linux box. Some files have Windows line ending
(CRLF) end we do not use core.autcrlf translation. gitweb show the last \r
in the end of each line, which is annoying. I have creates a simple patch to
avoid this. It adds just one line. I am not sure if the regexp should
contain 'g' switch in the end. Also, not sure if there shoul be some config
option to switch on/off this?

Cheers
Ondra
---
 gitweb/gitweb.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index abb5a79..92175bc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1500,6 +1500,7 @@ sub esc_html {
        if ($opts{'-nbsp'}) {
                $str =~ s/ /&nbsp;/g;
        }
+       $str =~ s/\r$//;
        $str =~ s|([[:cntrl:]])|(($1 ne "\t") ? quot_cec($1) : $1)|eg;
        return $str;
 }
--
1.7.8.4


--
View this message in context: http://git.661346.n2.nabble.com/gitweb-showing-slash-r-at-the-end-of-line-tp7229895p7229895.html
Sent from the git mailing list archive at Nabble.com.
