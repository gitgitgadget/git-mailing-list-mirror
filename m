From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: [PATCH] git-gui: Help identify aspell version on Windows too
Date: Fri, 26 Sep 2008 11:05:55 +0200
Message-ID: <48DCA5F3.4090009@isy.liu.se>
References: <1222378282-21757-1-git-send-email-hendeby@isy.liu.se> <48DC815C.6030401@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Sep 26 11:07:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj9I8-0008Vy-KY
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 11:07:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbYIZJGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 05:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbYIZJGA
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 05:06:00 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:36544 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbYIZJF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 05:05:59 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 4467E25A44;
	Fri, 26 Sep 2008 11:05:57 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 19164-10; Fri,  4 Jul 2008 02:08:55 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 8335C25953;
	Fri, 26 Sep 2008 11:05:56 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <48DC815C.6030401@viscovery.net>
X-Enigmail-Version: 0.95.7
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96840>

On 09/26/2008 08:29 AM, Johannes Sixt wrote:
> Gustaf Hendeby schrieb:
>> On windows, git gui fails to correctly extract the aspell version
>> (experienced with aspell version 0.50.3) due to scilent white space at
>> the end of the version string.  Trim the obtained version string to
>> work around this.
> 
> With this I've partial success here: Aspell 0.50.3 alpha (downloaded from
> http://aspell.net/win32/) is recognized, but
> 
> - it only ever checks the first line of the commit message;

Hmm, strange, I just had it mark my whole first like red, I think it
took an enter at the end of the line to get everything started though.
Does it check the rest of the lines for you?  I know spell checking is
disabled for too early versions of Aspell, due to some change in the
interface I think.

> 
> - after I change the catalog in the Options, I can't "Save" (it does
> nothing), until I change to some other catalog. I haven't discovered the
> pattern, yet, when the "Save" succeeds.
> 
> - At startup the correct catalog is used. But if I change the catalog
> during a session (if I succeed, see above), then the second-last picked
> catalog is used.
> 
> Any idea how to debug this?

I have experienced some saving related issues I think, but I'm not sure.
 Unfortunately I have very little understanding on what is going on in
the code, basically I don't know tcl/tk at all.  I was just lucky to
find a solution to my problem that seemed to work for me.

> 
>> @@ -80,7 +80,7 @@ method _connect {pipe_fd} {
>>  		error_popup [strcat [mc "Unrecognized spell checker"] ":\n\n$s_version"]
>>  		return
>>  	}
>> -	set s_version [string range $s_version 5 end]
>> +			set s_version [string range [string trim $s_version] 5 end]
> 
> A strange indentation you have here.

Yep, sorry about that, seems I had a nonstandard tab-width setting.  Too
bad not all projects can decide on the same tab width. :(  Will resend
if there are no other comments to this, and at the same time fix the
spelling in the commit message...

/Gustaf
