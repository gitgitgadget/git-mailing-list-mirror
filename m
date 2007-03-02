From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-config --remove-section, document --rename-section
Date: Fri, 2 Mar 2007 16:44:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703021640440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <es66vt$jej$1@sea.gmane.org>
 <Pine.LNX.4.63.0703012344270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45E7DDB5.9060009@lu.unisi.ch> <Pine.LNX.4.63.0703021220420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45E814D9.7020104@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Mar 02 16:44:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN9vx-00024S-QA
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 16:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992530AbXCBPoe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 10:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992529AbXCBPoe
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 10:44:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:58102 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992530AbXCBPod (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 10:44:33 -0500
Received: (qmail invoked by alias); 02 Mar 2007 15:44:32 -0000
X-Provags-ID: V01U2FsdGVkX1/M2Hx5v2nMBPQt3Zn0OGSRSyzdD7fkFlho1ot1rW
	WR22ZDw+HkcXN6
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45E814D9.7020104@lu.unisi.ch>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41219>

Hi,

On Fri, 2 Mar 2007, Paolo Bonzini wrote:

> > Of course you would have to move "int removing" and the related two 
> > lines to rename_section(), too.
> > 
> > The diff would be shorter, and if you then rename the function to 
> > rename_or_remove_section() it becomes all clearer.
> 
> It's more different than it looks like.  For example, remove_section needs this,
> 
>         if (buf[i] == '[') {
>                 if (section_name_match (&buf[i + 1], name)) {
> 		} else
> 			...
> 	}
> 
> while rename_section can use
> 
>         if (buf[i] == '[' && section_name_match (&buf[i+1], old_name)) {

But it does not have to.

	if (buf[i] == '[') {
		if (section_name_match(&buf[i + 1], old_name) {
			if (new_name == NULL)
				remove = 1;
			else
				/* write new section */
			continue;
		}
		remove = 0;
	}
	if (!remove)
		/* write buf */

Ciao,
Dscho
