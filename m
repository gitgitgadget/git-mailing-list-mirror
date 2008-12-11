From: "Lars Hjemli" <hjemli@gmail.com>
Subject: [RFC] cgit in git?
Date: Thu, 11 Dec 2008 22:48:45 +0100
Message-ID: <8c5c35580812111348iceaf30dyb55183017cff5b1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>,
	"Seth Vidal" <skvidal@fedoraproject.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 22:50:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAtQ5-0005m6-U4
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 22:50:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430AbYLKVsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 16:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757380AbYLKVsq
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 16:48:46 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:13906 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757421AbYLKVsq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 16:48:46 -0500
Received: by wa-out-1112.google.com with SMTP id v27so536518wah.21
        for <git@vger.kernel.org>; Thu, 11 Dec 2008 13:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=v7DqFX9XvFLVAqLHEgkz9Qu6eF1lSDGXOwXwcae1j0o=;
        b=WFnMu6ALbp+a3c/EvEXQ55ef9yE0Lf7rx9/aIbcIArY0aXjBk4zrpjktbH1kS3W19Z
         7feoVlgQm2ZAporUENJtWlKsi3uiTFVvdg9vTW//bF+T7uP2TcJLXrbNmY2vCjS2g80T
         Km2oEeHCq4VyHWlhB/sj2bptr4pJdEk8yWdDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=J9rfsGoGzFYd9/T+axYNot+fQ/tkeNYS4IXucDSFKBqcCflCfm2THv37n10VIpfX38
         H8aYjprSgom8Nfsx4hzq9hoFT8a6NcdOf03E/2Jy8X6DxEUKK4NMqJBXn+qLzI4hsoU2
         GWUnV1Lk2RafZOGuypNYfFwvsC4gADLVSQYZw=
Received: by 10.114.134.20 with SMTP id h20mr2190994wad.116.1229032125093;
        Thu, 11 Dec 2008 13:48:45 -0800 (PST)
Received: by 10.114.170.20 with HTTP; Thu, 11 Dec 2008 13:48:45 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102827>

Background: I've been asked by the fedora project how to package cgit.
The problem is basically that cgit is designed to be statically linked
with a specific git release (i.e. libgit.a and xdiff/lib.a).

When manually building cgit from a tarball this isn't a problem:
'make get-git' will download the required git sources from kernel.org.
But the buildsystem/policy used by the fedora project does not allow
network access during package builds, and since it is quite unlikely
that the git package always will match the exact release needed by the
cgit package, I only see four options:
1) the fedora project makes a 'git-for-cgit' package containing the
needed release of the git sources
2) the cgit release tarballs includes the needed git sources
3) the cgit sources are subtree-merged into git
4) cgit is modified to link against libgit2

Option 1 seems unlikely to happen since such a 'git-for-cgit' package
would basically require the fedora project to support two git
packages.

Option 2 is doable but still requires the fedora project to support
two git packages (but now the 'git-for-cgit' package is hidden inside
the cgit source tree). The good thing about this option is that it
only requires some minor modifications to the cgit releases.

Option 3 would solve the problem for the fedora project but is not for
me to decide - it might become an extra maintenance burden on the git
maintainer and community.

Option 4 is the correct solution but not a very practical one; it's
currently hard to predict when libgit2 will be ready for general
(c)git use.

Personally I'd love for option 3 to happen, hence this rfc.

-- 
larsh
