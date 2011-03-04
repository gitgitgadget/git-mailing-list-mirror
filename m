From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Fri, 04 Mar 2011 11:17:51 -0500
Message-ID: <1299255471.22002.15.camel@drew-northup.unet.maine.edu>
References: <4D70EBC3.3010400@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Colin Guthrie <gmane@colin.guthr.ie>
X-From: git-owner@vger.kernel.org Fri Mar 04 17:20:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvXjt-0002NY-AB
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 17:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759774Ab1CDQUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 11:20:19 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:40602 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759739Ab1CDQUS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 11:20:18 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p24GHtFP023129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 4 Mar 2011 11:18:00 -0500
In-Reply-To: <4D70EBC3.3010400@colin.guthr.ie>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=2
	Fuz1=2 Fuz2=2
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p24GHtFP023129
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1299860283.61635@bLN/PwmsRNqp77tW9tEp1A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168445>


On Fri, 2011-03-04 at 13:40 +0000, Colin Guthrie wrote:
> Hi,
> 
> We recently found a bug in git-am 1.7.4.1 while working on PulseAudio.
> 
> It seems that it mis-applied a patch and did so silently without
> generating any warnings. It is reproducible and has been confirmed on
> different distros.
> 
> I make reference to the bug here:
> http://thread.gmane.org/gmane.comp.audio.pulseaudio.general/8840/focus=8857
> 
> In order to reproduce:
> 
> git clone http://git.0pointer.de/repos/pulseaudio.git
> git co -b misapply 0ce3017b7407ab1c4094f7ce271bb68319a7eba7
> git am 0002-alsa-mixer-add-required-any-and-required-for-enum-op.patch
> 
> (I've attached the patch here for convenience).

> For reference, applying the patch manually with patch works fine and
> does not result in an error:
> 
> $ cat 0002-alsa-mixer-add-required-any-and-required-for-enum-op.patch |
> patch -p1
> patching file src/modules/alsa/alsa-mixer.c
> Hunk #1 succeeded at 1121 (offset 103 lines).
> Hunk #2 succeeded at 1325 (offset 103 lines).
> Hunk #3 succeeded at 1356 (offset 103 lines).
> Hunk #4 succeeded at 1613 (offset 103 lines).
> Hunk #5 succeeded at 1640 (offset 103 lines).
> Hunk #6 succeeded at 1913 (offset 103 lines).
> Hunk #7 succeeded at 1997 (offset 105 lines).
> Hunk #8 succeeded at 2242 (offset 106 lines).
> Hunk #9 succeeded at 2261 (offset 106 lines).
> Hunk #10 succeeded at 2312 (offset 106 lines).
> patching file src/modules/alsa/alsa-mixer.h
> Hunk #1 succeeded at 112 (offset 1 line).
> Hunk #2 succeeded at 133 (offset 1 line).
> Hunk #3 succeeded at 169 (offset 1 line).
> patching file src/modules/alsa/mixer/paths/analog-output.conf.common

Did you try removing the first line from the patch mbox file?
It seems to work just fine if you do that. 

That first line is "removed" from the output of "git format-patch" when
you correctly import the mbox file into your mail client's drafts folder
as described in the documentation. Then you send the mail created by
importing that draft.
If you just send the output of "git format-patch" untouched as an
attachment you can expect problems.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
