From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: Tabs in commit messages - de-tabify option in strbuf_stripspace()?
Date: Tue, 15 Mar 2016 20:34:41 -0400
Message-ID: <009801d17f1b$a4c3e080$ee4ba180$@nexbridge.com>
References: <CA+55aFzHMp4hiCp7+2Yxy=KNQ_rBru3RM-pghXUPtoxr_L+w2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: "'Git Mailing List'" <git@vger.kernel.org>
To: "'Linus Torvalds'" <torvalds@linux-foundation.org>,
	"'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 01:35:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afzQT-0000OF-G8
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 01:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbcCPAe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 20:34:58 -0400
Received: from elephants.elehost.com ([216.66.27.132]:62465 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933921AbcCPAe4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Mar 2016 20:34:56 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [174.112.90.66])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id u2G0YmVE018129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 15 Mar 2016 20:34:48 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <CA+55aFzHMp4hiCp7+2Yxy=KNQ_rBru3RM-pghXUPtoxr_L+w2w@mail.gmail.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEs+An5WFUYdH5ZCUuqYRGCghFGSaCkQ6Gg
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288931>

On March 15, 2016 8:17 PM Linus Torvalds wrote:
> So I end up doing this manually when I notice, but I was wondering ig maybe
> git could just have an option to "git am" and friends to de-tabify the commit
> message.
> 
> It's particularly noticeable when people line things up using tabs (for the
> kernel, it's often things like "cpu1 does X, cpu2 does Y"), and then when you
> do "git log" it looks like a unholy mess, because the 4-char indentation of the
> log message ends up causing those things to not line up at all after all.
> 
> The natural thing to do would be to pass in a "tab size" parameter to
> strbuf_stripspace(), and default it to 0 (for no change), but have some way to
> let people say "expand tabs to spaces at 8-character tab-stops" or similar
> (but let people use different tab-stops if they want).
> 
> Do people hate that idea? I may not get around to it for a while (it's the
> kernel merge window right now), but I can write the patch eventually - I just
> wanted to do an RFC first.

Speaking partly as a consumer of the comments and partly as someone who generates the commits through APIs, I would ask that the commit tab handling semantic be more formalized than just tab size to strbuf_stripspace(). While it might seem a bit unfair to have to worry about non-git git clients, the detabbing can impact the other commit implementers (e.g., SourceTree, EGit, JGit, and the raft of process automation bits out there using JGit for cool stuff). Personally, I would prefer to have a normalized behaviour so that any bit of automation building a commit message would have a specific definition to go to (and hopefully comply with) in order to properly format the message for posterity and across all consumers. It might also be useful to have some ability to be presentation-compatible 
 with legacy commits (done after this type of enhancement) so that a reasonable presentation can be done for those 8 year old commits that still have embedded tabs. Personally, I don't encourage tabs in commits myself and do see the value of this, but is this really restricted just to git am?

Just my $0.02,

Randall

-- Brief whoami: NonStop&UNIX developer since approximately UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.
