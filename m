From: "Alex Bennee" <kernel-hacker@bennee.com>
Subject: Verifying the whole repository
Date: Thu, 23 Oct 2008 14:59:59 +0100
Message-ID: <b2cdc9f30810230659n15f44f64l571a0df3dbe104d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 23 16:03:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt0kp-00028O-KC
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 16:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbYJWOAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 10:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbYJWOAF
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 10:00:05 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:56503 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbYJWOAD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 10:00:03 -0400
Received: by gxk9 with SMTP id 9so1425425gxk.13
        for <git@vger.kernel.org>; Thu, 23 Oct 2008 07:00:00 -0700 (PDT)
Received: by 10.90.113.17 with SMTP id l17mr588429agc.40.1224770399930;
        Thu, 23 Oct 2008 06:59:59 -0700 (PDT)
Received: by 10.90.105.11 with HTTP; Thu, 23 Oct 2008 06:59:59 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: f42dac9db39c650e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98966>

Hi,

While I was debugging a crash in parsecvs while converting our CVS
repository I discovered it was because one of the CVS files had become
corrupted (truncated). This is a problem I've had before with RCS
based files which are prone to silent corruption that you won't notice
until you try and checkout an old revision of the file.

As git is fundamentally hash based it's a lot easier to determine the
health of the repository but I wonder if it's possible for silent
corruption to creep in which won't be noticed until you try and
checkout a historical commit of the tree. I notice there is a
git-verify-pack command that checks the pack files are OK. Do any of
the other commands implicitly ensure all objects in the repo are
correct and valid? git-gc?

Are there any other parts of the .git metadata that are crucial or is
it enough to say if all objects and packs match their hashes you have
all the information you may need to recover an arbitrary revision of
the repo?

-- 
Alex, homepage: http://www.bennee.com/~alex/
