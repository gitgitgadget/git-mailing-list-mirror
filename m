From: "Ron Parker" <ron.parker@mobot.org>
Subject: Preserving ownership and set*id bits
Date: Thu, 18 Jan 2007 11:09:33 -0600
Message-ID: <769697AE3E25EF4FBC0763CD91AB1B0201D49679@MBGMail01.mobot.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Thu Jan 18 18:09:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7alc-0005A1-So
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 18:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbXARRJf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 12:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752073AbXARRJf
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 12:09:35 -0500
Received: from mbgmail01.mobot.org ([4.36.133.74]:11961 "EHLO
	mbgmail01.mobot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbXARRJe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jan 2007 12:09:34 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Preserving ownership and set*id bits
Thread-Index: Acc7I2zW0xO26nH/QKS1cZF6biFxNg==
To: <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37124>

I am tracking a development web server in git.  The problem is that some
of the scripts I am tracing are setgid.  And certain files must have
different ownership.

I assumed that git would preserve the setgid bit as well as the user and
group of the files.  Since it is described as the "stupid directory
content manager" that just tracks the content of directories, I expected
it would maintain at least as much information as tar.  Oops.  Color me
stupid.

Anyway, I'm not here to complain, but I am looking for suggestions of
how I might store and preserve this information as well.  

I got bit when I did something equivalent to "git reset --hard HEAD^",
to back out a change.  I need someway of preserving this information
across commits, clones, pushes, pulls, etc.

Our development has been centered around the idea of using git to track
the changes to our development server and later "git pull" those changes
to the production server with GIT_DIR pointing to an out-of-directory
clone.
