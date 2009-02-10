From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: RFC re Thunderbird + imap-send
Date: Tue, 10 Feb 2009 12:06:30 +0100
Message-ID: <49915FB6.8010803@drmicha.warpmail.net>
References: <4990A4FF.6020404@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ben Bucksch <ben.bucksch.news@beonex.com>
To: Jeremy White <jwhite@codeweavers.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 12:08:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWqTF-0000xH-4v
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 12:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbZBJLGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 06:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752457AbZBJLGi
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 06:06:38 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53730 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751252AbZBJLGh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Feb 2009 06:06:37 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 12DD628DCE7;
	Tue, 10 Feb 2009 06:06:36 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 10 Feb 2009 06:06:36 -0500
X-Sasl-enc: vf8m9qeZ5nijRBzqCYQfb1nqOQHp3jYmSl1OTM7pKhd5 1234263995
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 299602A443;
	Tue, 10 Feb 2009 06:06:35 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090209 Shredder/3.0b2pre
In-Reply-To: <4990A4FF.6020404@codeweavers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109204>

Jeremy White venit, vidit, dixit 09.02.2009 22:49:
> So, MajorDomo knows that what I'm trying is sick and twisted; I seem to
> have run afoul of the taboos:
>   http://vger.kernel.org/majordomo-taboos.txt
> 
> (ixnay on the ention may of ontentcay ypetay tmlhay :-/).
> 
> So here is a pointer to a proposed patch to enable git-imap-send to work
> with Thunderbird, based on Ben's suggestion:
> 
> http://www.codeweavers.com/~jwhite/0001-Add-an-option-to-wrap-a-patch-in-pre-in-git-imap-s.patch
> 
> Essentially, with this patch, I add an html option to the imap-send
> server configuration block.  If turned on, we structure each patch as
> html, inside of pre blocks.  And, in fact, Thunderbird does
> automatically convert such an email into a plain/text, format=fixed
> email, that seems to diff cleanly with a regular git-format-patch result.
> 
> Thoughts?  Tar and feathers?

Looks okay here. I leave the tarring and feathering to Dscho ;)

Trying this out showed that indeed git-imap-send needs much more love.
The man page doesn't say much, doesn't describe all options. Most
options can be specified in config only. You can't pass file arguments,
only stdin. You can't even pass a recipient!

To be useful, imap-send should really obey the same config options and
parameters as much as possible. In fact they should share some.
imap-send and send-email should be usable interchangeably, without
fiddling with format-patch options (which has to: and cc: where it
doesn't really belong). Uhm, I'm getting off-topic.

Back on topic: TB does the automatic conversion to plain text only when
the send options are appropriate, or if you set the recipient to "text
only".

Also:
For a typical text mail in Drafts I see lines like

X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; uuencode=0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Any chance we could use that rather than invoke the HTML editor?
We would need to shut off q-p and f-f *and* avoid automatic word wrap
(or make sure patches don't have longer lines then TBs editor allows),
the latter I don't know how to do.

Michael
