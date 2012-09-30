From: Hugh Esco <hesco@campaignfoundations.com>
Subject: bug report, v1.7.12.1 -- Documentation/git-rev-parse.xml:264:
 parser error
Date: Sun, 30 Sep 2012 04:05:21 -0400
Organization: CampaignFoundations.com
Message-ID: <20120930040521.82300f4b.hesco@campaignfoundations.com>
Reply-To: hesco@campaignfoundations.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 10:06:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIEXj-0005la-Bp
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 10:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617Ab2I3IGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 04:06:16 -0400
Received: from mail.greens.org ([207.111.216.211]:45267 "EHLO mail.greens.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491Ab2I3IGL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 04:06:11 -0400
Received: by mail.greens.org (Postfix, from userid 2012)
	id 8BC9B805BC; Sun, 30 Sep 2012 01:06:10 -0700 (PDT)
Received: from debianmarcus9.campaignfoundations.com (localhost [127.0.0.1])
	by martin.campaignfoundations.com (Postfix) with SMTP id 6DBAF8A8F
	for <git@vger.kernel.org>; Sun, 30 Sep 2012 04:05:21 -0400 (EDT)
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-Relay-for-martin: 2740405217270
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206680>

doing a source install of git v1.7.12.1, 
on the `make all doc` step, I get:

    XMLTO git-rev-parse.1
xmlto: input does not validate (status 1)
/usr/local/git-git-51993a4/Documentation/git-rev-parse.xml:264: parser error : Opening and ending tag mismatch: emphasis line 264 and literal
<literal><emphasis role="strong"></literal>, or <literal>[</literal>), it is tur
                                           ^
/usr/local/git-git-51993a4/Documentation/git-rev-parse.xml:264: parser error : Opening and ending tag mismatch: literal line 264 and emphasis
</literal>), it is turned into a prefix match by appending <literal>/</emphasis>
                                                                               ^
/usr/local/git-git-51993a4/Documentation/git-rev-parse.xml:277: parser error : Opening and ending tag mismatch: emphasis line 277 and literal
    character (<literal>?</literal>, <literal><emphasis role="strong"></literal>
                                                                               ^
/usr/local/git-git-51993a4/Documentation/git-rev-parse.xml:278: parser error : Opening and ending tag mismatch: literal line 278 and emphasis
        match by appending <literal>/</emphasis></literal>.
                                                ^
make[1]: *** [git-rev-parse.1] Error 1
make[1]: Leaving directory `/usr/local/git-git-51993a4/Documentation'
make: *** [doc] Error 2

-------------------------------------------
and the patch which permitted me to proceed
-------------------------------------------

264c264
> <literal></literal>, or <literal>[</literal>), it is turned into a prefix match by appending >literal>/</literal>.</simpara>
---
< <literal><emphasis role="strong"></literal>, or <literal>[</literal>), it is turned into a prefix match by appending <literal>/</emphasis></literal>.</simpara>
277,278c277,278
>         character (<literal>?</literal>, <literal></literal>, or <literal>[</literal>), it is turned into a prefix
>         match by appending <literal>/</literal>.
---
<         character (<literal>?</literal>, <literal><emphasis role="strong"></literal>, or <literal>[</literal>), it is turned into a prefix
<         match by appending <literal>/</emphasis></literal>.


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
