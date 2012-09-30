From: Hugh Esco <hesco@campaignfoundations.com>
Subject: bug report, v1.7.12.1 --
 Documentation/git-check-ref-format.xml:162: parser error
Date: Sun, 30 Sep 2012 03:15:00 -0400
Organization: CampaignFoundations.com
Message-ID: <20120930031500.997b6bfb.hesco@campaignfoundations.com>
Reply-To: hesco@campaignfoundations.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 09:16:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIDlc-0003uW-Ux
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 09:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208Ab2I3HPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 03:15:51 -0400
Received: from mail.greens.org ([207.111.216.211]:35381 "EHLO mail.greens.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751955Ab2I3HPv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 03:15:51 -0400
Received: by mail.greens.org (Postfix, from userid 2012)
	id B4473804C4; Sun, 30 Sep 2012 00:15:50 -0700 (PDT)
Received: from debianmarcus9.campaignfoundations.com (localhost [127.0.0.1])
	by martin.campaignfoundations.com (Postfix) with SMTP id 23D5F88AE
	for <git@vger.kernel.org>; Sun, 30 Sep 2012 03:15:01 -0400 (EDT)
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-Relay-for-martin: 2740315017067
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206671>

doing a source install of git v1.7.12.1, 
on the `make all doc` step, I get:

xmlto: input does not validate (status 1)
/usr/local/git-git-51993a4/Documentation/git-check-ref-format.xml:162: parser error : Opening and ending tag mismatch: emphasis line 162 and literal
me&gt; is allowed to contain a single <literal><emphasis role="strong"></literal
                                                                               ^
/usr/local/git-git-51993a4/Documentation/git-check-ref-format.xml:164: parser error : Opening and ending tag mismatch: literal line 164 and emphasis
        <literal>foo/</emphasis>/bar</literal> but not <literal>foo/bar*</litera
                                ^
make[1]: *** [git-check-ref-format.1] Error 1
make[1]: Leaving directory `/usr/local/git-git-51993a4/Documentation'
make: *** [doc] Error 2

-------------------------------------------
and the patch which permitted me to proceed
-------------------------------------------

162c162
<         enabled, &lt;refname&gt; is allowed to contain a single <literal></literal>
---
>         enabled, &lt;refname&gt; is allowed to contain a single <literal><emphasis role="strong"></literal>

164c164
<         <literal>foo/bar</literal> but not <literal>foo/bar*</literal>).
---
>         <literal>foo/</emphasis>/bar</literal> but not <literal>foo/bar*</literal>).

-------------------------------------------
Next issue shows up in:
Documentation/git-config.xml
details coming under separate cover.

-- 
Hugh Esco 
skype: hresco3_ ; 678-921-8186 x21 
http://www.CampaignFoundations.com/
Providing Application Hosting, Telephony, 
Custom Development and Consulting Services 
to Green Candidates, Green Parties and
the non profits working for a just and sustainable future.

if( $insurance->rationing() ) { $people->die(); }
if( isa_ok($self,'Troy::Davis') =~ m/^ok/) { $people->are_whole(); }
