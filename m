From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Tue, 23 Feb 2010 14:45:53 +0200
Message-ID: <20100223124553.GA19153@Knoppix>
References: <4B7D8358.1080108@gmail.com>
 <fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com>
 <4B7E3856.3080609@gmail.com>
 <20100219135549.GA31796@Knoppix>
 <4B820B4E.7050405@gmail.com>
 <20100222105133.GA10577@Knoppix>
 <4B834989.50502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 13:46:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nju9L-0000NV-Hq
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 13:46:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199Ab0BWMp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 07:45:58 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:54778 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab0BWMp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 07:45:57 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id CC7B618D5A0;
	Tue, 23 Feb 2010 14:45:56 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A02624A8FE1; Tue, 23 Feb 2010 14:45:56 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id A4AC84065;
	Tue, 23 Feb 2010 14:45:54 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <4B834989.50502@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140792>

On Mon, Feb 22, 2010 at 10:20:41PM -0500, Gabriel Filion wrote:
> On 2010-02-22 05:51, Ilari Liusvaara wrote:
> > bzr::ssh://something/somewhere ?
> > 
> > That goes to git-remote-bzr (as 'ssh://something/somewhere').
> > 
> That would be feasible. But for users, when they copy URLs from sites,
> they'd probably like to use it as is. (I'd like it to be like that :P )
> 
> But, as long as it's not possible right now to use "+" in the URL, I can
> implement it exactly like you said and maybe change it later if helper
> names obtain the right to have non-alnum characters.

Patch to allow '+', '-' and '.' sent (those characters were taken from
IETF STD66).

Its entierely possible to have remote helpers set up so that in git
version that doesn't allow '+', the following work (passed as means
beginning of second (URL) argument):

1) 'bzr://' [passed as 'bzr://']
2) 'bzr::ssh://' [passed as 'ssh://']

And in versions that allow '+', the following additionally work:

3) 'bzr+ssh://' [passed as 'bzr+ssh://']
4) 'ssh+bzr://' [passed as 'ssh+bzr://']

That can be done by making three copies of executable ('git-remote-bzr',
'git-remote-bzr+ssh' and 'git-remote-ssh+bzr') and the infering correct
protocol from prefix of 2nd arguement (see those "passed as" strings).

-Ilari
