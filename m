From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 10/10] mergetool: use run_mergetool from git-mergetool-lib
Date: Thu, 2 Apr 2009 22:13:14 +0200
Message-ID: <200904022213.15173.markus.heidelberg@web.de>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com> <200904020054.23147.markus.heidelberg@web.de> <20090402200235.GB13817@hashpling.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu Apr 02 22:15:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpTJd-0001OM-Mg
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 22:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932749AbZDBUN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 16:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933495AbZDBUNZ
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 16:13:25 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:42511 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764211AbZDBUNS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 16:13:18 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 00227F9E712E;
	Thu,  2 Apr 2009 22:13:15 +0200 (CEST)
Received: from [89.59.93.159] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LpTHn-0003y1-00; Thu, 02 Apr 2009 22:13:15 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20090402200235.GB13817@hashpling.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/aWZNVSEdO+x4qo3YmZ9L9CYTdXAp5kb/0keu/
	Y8h7HtyN04sCW4RCfyvQT3JVebmipuXeDFN1nx4idPIT5SKWNB
	X2hLCj7j7M/McqJQWVmg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115493>

Charles Bailey, 02.04.2009:
> On Thu, Apr 02, 2009 at 12:54:22AM +0200, Markus Heidelberg wrote:
> > David Aguilar, 01.04.2009:
> > > +    present=false
> > > +    base_present &&
> > > +    present=true
> > > +
> > > +    run_mergetool "$merge_tool" "$present"
> > > +    status=$?
> > 
> > This last line has to be deleted, because the variable 'status' set in
> > run_mergetool would be overwritten then. In this case the merge will
> > succeed even if it didn't and the file will be staged.
> 
> I think that it would be better if $status stayed as local as
> possible. If run_mergetool returned the value of $status as its exit
> code then the function will properly return whether the merge
> succeeded or not.
> 
> This way run_mergetool's clients can just use its exit code, without
> having to know about a magic $status global variable.

Sure. Next time I have to think about the right solution before
spreading workarounds.

And shouldn't also check_unchanged() move from git-mergetool.sh to
git-mergetool--lib.sh, since it is only used there?
Huh, it seems as if some editors for difftool cannot work correctly
currently, because this function is used, but defined in
git-mergetool.sh.

Markus
