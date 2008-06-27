From: "Adr3nal D0S" <adr3nald0s@gmail.com>
Subject: Determining if two commits are on a separate branch
Date: Fri, 27 Jun 2008 09:55:51 -0500
Message-ID: <308083c30806270755t4316be67u1f468b51bf475d28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 16:56:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCFNb-0007Wf-9q
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 16:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756100AbYF0Ozy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 10:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753465AbYF0Ozy
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 10:55:54 -0400
Received: from rn-out-0910.google.com ([64.233.170.189]:2657 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756100AbYF0Ozx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 10:55:53 -0400
Received: by rn-out-0910.google.com with SMTP id k40so165121rnd.17
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 07:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=CIVW4pOCejSC7/BZEW+HP0UQ56Z6JMCXDAL8Ir5yiH0=;
        b=Utdu4FZsK772gDXb6gnpml0lKxD7xkj547dBzY5oGtk/8ZvctK8ABociAnVNIhRjYl
         DcQ8USRBo21OG+hSHohOelhMVgELRcYPP31mp1b2EGghcgoYLe0PU9AF5V6vl5d54eqD
         imu+bOOs2YkkptzLGJ/zEPDKsUzUm9mNrnnfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=xWOrudiLzskXMPrpC+ng42o0xOEafEqHbk0NHMXqxTM+mfUBfSYIAN78Zjm7KOwsLd
         EHSr+qJqW0qO9l0rr29uVdP/odS3DBYoLZ0UqLYowke5qKuA4SlnZppSsh03Xhg2gUZS
         WQCbc/XSzENCjIUZOZf7APJRQaCdHpQH5q5Cs=
Received: by 10.150.52.2 with SMTP id z2mr2388888ybz.43.1214578551774;
        Fri, 27 Jun 2008 07:55:51 -0700 (PDT)
Received: by 10.151.15.1 with HTTP; Fri, 27 Jun 2008 07:55:51 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86570>

We are making extensive use of submodules at work and we have created
a number of extra scripts to simplify our usage.  For example, there
is git-rstatus, which recursively reports status of all submodules.

I am working on another script to check whether or not a change to any
submodules jump branches.  If we have commits like this:

A--B--C
   \--D

I don't care if a submodule moves from A to C or B to C, but I do care
if a commit of the super-project would cause a jump from D to C or
revert from C to B, effectively dropping previously committed code on
the floor.

So, is there a "correct" or "best" way to determine if one commit's
SHA follows directly from another's SHA in the commit history?
