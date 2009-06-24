From: =?ISO-8859-1?Q?Johan_S=F8rensen?= <johan@johansorensen.com>
Subject: Reason for objects still being written with a failing pre-receive 
	hook?
Date: Wed, 24 Jun 2009 15:21:09 +0200
Message-ID: <9e0f31700906240621k314b4bbehc283c8a1c673a2f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 24 15:21:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJSPh-00017j-6Y
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 15:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbZFXNVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 09:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752154AbZFXNVI
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 09:21:08 -0400
Received: from mail-ew0-f210.google.com ([209.85.219.210]:43125 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbZFXNVH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 09:21:07 -0400
Received: by ewy6 with SMTP id 6so1160526ewy.37
        for <git@vger.kernel.org>; Wed, 24 Jun 2009 06:21:09 -0700 (PDT)
Received: by 10.210.35.17 with SMTP id i17mr766596ebi.66.1245849669629; Wed, 
	24 Jun 2009 06:21:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122137>

Hi,

I'm wondering what the reason is that objects are still being stored,
despite a non-zero exit code from the pre-receive hook?

Obviously refs aren't being updated, but I can see this a gateway for
abuse if I want to control push permissions per ref via the
pre-receive hook (which is the earliest place I know about the ref
being pushed to, unless I've missed something). Basically an abuser
could continuously attempt to push a set of commits with large blobs
to a repo the pre-receive hook doesn't give him access to, and
eventually fill up the repo with useless objects. I could nuke these
with git-prune (after the fact though), but still it seems illogical
that one is allowed to even write the objects in the first place if
the hook fails.

If it's expected and accepted behaviour, what other options do I have
to prevent a scenario like the above?

Cheers,
Johan
