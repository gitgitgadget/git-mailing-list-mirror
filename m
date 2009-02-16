From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: CVS import [SOLVED]
Date: Mon, 16 Feb 2009 21:32:13 +0100 (CET)
Message-ID: <60044.192.168.0.51.1234816333.squirrel@hupie.xs4all.nl>
References: <19651.77.61.241.211.1234775877.squirrel@hupie.xs4all.nl>
    <7291.77.61.241.211.1234790434.squirrel@hupie.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Mon Feb 16 21:33:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZA9x-00075J-KQ
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 21:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbZBPUcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 15:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbZBPUcQ
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 15:32:16 -0500
Received: from hupie.xs4all.nl ([82.95.241.251]:49674 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750889AbZBPUcQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Feb 2009 15:32:16 -0500
Received: by Lighthouse.internal.Hupie.com (Postfix, from userid 48)
	id 4AE8558BDCE; Mon, 16 Feb 2009 21:32:14 +0100 (CET)
Received: from 192.168.0.51
        (SquirrelMail authenticated user ferry.huberts@pelagic.nl)
        by hupie.xs4all.nl with HTTP;
        Mon, 16 Feb 2009 21:32:13 +0100 (CET)
In-Reply-To: <7291.77.61.241.211.1234790434.squirrel@hupie.xs4all.nl>
User-Agent: SquirrelMail/1.4.8-5.el5.centos.3
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110235>

On Mon, February 16, 2009 14:20, Ferry Huberts (Pelagic) wrote:
> I solved it:
>
> it has to do with the
> core.autocrlf=input
> core.safecrlf=true
>
> settings I had in my global config.
> Maybe the manual page should warn against having these defined?
>

I'm working on it now, and did some more testing: it's actually the safecrlf setting, not the autocrlf option.
Which leaves me with some questions of what to do exactly:

 autocrlf safecrlf
1 false    false
2 false     warn
3 false     true
4 input    false
5 input     warn
6 input     true
7 true     false
8 true      warn
9 true      true


1- git ignores the safecrlf flag; obviously acceptable
2- git ignores the safecrlf flag; so acceptable
3- git ignores the safecrlf flag, so acceptable
4- seems acceptable to me
5- seems acceptable to me
6- unacceptable
7- seems acceptable to me
8- seems acceptable to me
9- unacceptable

So, 6 and 9 (safecrlf==true) are definitely unacceptable. 1-3 are definitely acceptable.
How about the others?
Should these produce warnings?
Should the user use a 'force' option to make the import work (and acknowledge that he's calling for trouble)
Should we enforce some setting? Which flags/setting?

Input appreciated :-)

Ferry
