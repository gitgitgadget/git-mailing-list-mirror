From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: jgit problems for file paths with non-ASCII characters
Date: Wed, 25 Nov 2009 14:47:25 +0100
Message-ID: <4B0D356D.1080709@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 14:47:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDIDe-0006gR-Px
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 14:47:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758564AbZKYNr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 08:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbZKYNrZ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 08:47:25 -0500
Received: from syntevo.com ([85.214.39.145]:39371 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbZKYNrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 08:47:25 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTP id E958F37C7B0
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Enigmail-Version: 0.96.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133642>

I have noticed that jgit converts file paths to UTF-8 when querying the
repository. Especially,
org.eclipse.jgit.treewalk.filter.PathFilter#PathFilter performs this
conversion:

  private PathFilter(final String s) {
    pathStr = s;
    pathRaw = Constants.encode(pathStr);
  }

Because of this conversion, a TreeWalk fails to identify a file with
German umlauts. When using platform encoding to convert the file path to
bytes:

  private PathFilter(final String s) {
    pathStr = s;
    pathRaw = s.getBytes();
  }

the TreeWalk works as expected. Actually, the file path seems to be
stored with platform encoding in the repository.

Is this a bug or a misconfiguration of my repository? I'm using jgit
(commit e16af839e8a0cc01c52d3648d2d28e4cb915f80f) on Windows.

Thanks!

--
Best regards,
Marc Strapetz
=============
syntevo GmbH
http://www.syntevo.com
http://blog.syntevo.com
