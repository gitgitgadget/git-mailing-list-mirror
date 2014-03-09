From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Potential GSOC microproject idea
Date: Sat, 8 Mar 2014 17:54:40 -0800
Message-ID: <73E9BCA0-D55C-4751-A3C0-1CD21F296758@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 09 03:01:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMT30-00040Z-JC
	for gcvg-git-2@plane.gmane.org; Sun, 09 Mar 2014 03:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbaCICA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2014 21:00:58 -0500
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:33251 "EHLO
	nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbaCICA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2014 21:00:58 -0500
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Mar 2014 21:00:58 EST
Received: from rover.ms.mff.cuni.cz (rover.ms.mff.cuni.cz [195.113.20.142])
	by nikam.ms.mff.cuni.cz (Postfix) with ESMTP id 3A680541091;
	Sun,  9 Mar 2014 02:54:46 +0100 (CET)
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by rover.ms.mff.cuni.cz (Postfix) with ESMTP id 504C8113E13E;
	Sun,  9 Mar 2014 02:54:45 +0100 (CET)
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243686>

On Mar 3, 2014, at 23:58, Michael Haggerty wrote:
> list
> regulars should FEEL ENCOURAGED to submit microprojects to add to the
> list.  (Either submit them as a pull request to the GitHub repository
> that contains the text [1] or to the mailing list with CC to me.)

Potential idea for a microproject:

Add a new config setting:

   user.allowImplicitIdentity
     Defaults to true.
     If user.name and GIT_COMMITTER_NAME are unset or user.email and
     GIT_COMMITTER_EMAIL and EMAIL are unset, an implicit value is
     substituted for one or both of user.name and user.email.  If
     an automatically generated value is used for both name and email
     a warning "Your name and email address were configured  
automatically..."
     is displayed.  If set to false, no or never, instead of a warning,
     an error is generated and the operation fails:

         *** Please tell me who you are.

         Run

           git config --global user.email "you@example.com"
           git config --global user.name "Your Name"

         to set your account's default identity.
         Omit --global to set the identity only in this repository.

         fatal: implicit user identity not allowed

     the advice portion can be suppressed by setting  
advice.implicitIdentity to false,
     but not the "fatal: implicit user identity not allowed" part.

Note that if "git config --system --bool user.allowImplicitIdentity  
false" is in effect, it should still be possible to clone (ref logs  
may be updated, but they should be allowed to use an implicit  
identity).  In other words user.allowImplicitIdentity=false should  
only inhibit writing any new commit/tag objects that need the current  
user's name and email when it has not been explicitly provided.

I'm not sure how micro this is.  :)  I do think the amount of code  
involved is rather small though.  Support for something like this has  
popped up on the list before.  Perhaps "user.allowAutomaticIdentity"  
and "advice.automaticIdentity" would be better config names.

--Kyle
