From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Fix git-svn for SVN 1.7
Date: Thu, 2 Aug 2012 10:31:22 +0000
Message-ID: <20120802103122.GA24385@dcvr.yhbt.net>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, jrnieder@gmail.com,
	"Michael G. Schwern" <schwern@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 12:31:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Swsgj-00068A-Aq
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 12:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460Ab2HBKbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 06:31:24 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57385 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972Ab2HBKbX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 06:31:23 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A721F42D;
	Thu,  2 Aug 2012 10:31:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1343468872-72133-1-git-send-email-schwern@pobox.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202748>

"Michael G. Schwern" <schwern@pobox.com> wrote:
> This patch series fixes git-svn for SVN 1.7 tested against SVN 1.7.5 and
> 1.6.18.  Patch 7/8 is where SVN 1.7 starts passing.

Thanks Michael.  I've made minor editorial changes (mostly rewording
commit titles to fit the larger project).

Junio:

The following changes since commit 05a20c87abd08441c98dfcca0606bc0f8432ab26:

  Merge git://github.com/git-l10n/git-po (2012-08-01 15:59:08 -0700)

are available in the git repository at:


  git://bogomips.org/git-svn master

for you to fetch changes up to db7c5388b6d843f7cd248dc465af4507d1de7918:

  git-svn: remove ad-hoc canonicalizations (2012-08-02 09:42:25 +0000)

----------------------------------------------------------------
Michael G. Schwern (20):
      Git::SVN: use accessors internally for path
      Git::SVN: use accessor for URLs internally
      Git::SVN::Ra: use accessor for URLs
      use Git::SVN->path accessor globally
      use Git::SVN{,::RA}->url accessor globally
      git-svn: move canonicalization to Git::SVN::Utils
      git-svn: use SVN 1.7 to canonicalize when possible
      git-svn: factor out _collapse_dotdot function
      git-svn: add join_paths() to safely concatenate paths
      Git::SVN::Utils: remove irrelevant comment
      git-svn: path canonicalization uses SVN API
      Git::SVN{,::Ra}: canonicalize earlier
      t9118: workaround inconsistency between SVN versions
      t9107: fix typo
      git-svn: attempt to mimic SVN 1.7 URL canonicalization
      git-svn: replace URL escapes with canonicalization
      git-svn: canonicalize earlier
      git-svn: introduce add_path_to_url function
      git-svn: canonicalize newly-minted URLs
      git-svn: remove ad-hoc canonicalizations

 git-svn.perl                          |  92 ++++++------------
 perl/Git/SVN.pm                       | 174 ++++++++++++++++++++++------------
 perl/Git/SVN/Fetcher.pm               |   2 +-
 perl/Git/SVN/Migration.pm             |   6 +-
 perl/Git/SVN/Ra.pm                    |  92 ++++++++++--------
 perl/Git/SVN/Utils.pm                 | 173 ++++++++++++++++++++++++++++++++-
 t/Git-SVN/Utils/add_path_to_url.t     |  27 ++++++
 t/Git-SVN/Utils/canonicalize_url.t    |  26 +++++
 t/Git-SVN/Utils/collapse_dotdot.t     |  23 +++++
 t/Git-SVN/Utils/join_paths.t          |  32 +++++++
 t/t9107-git-svn-migrate.sh            |   6 +-
 t/t9118-git-svn-funky-branch-names.sh |   7 +-
 12 files changed, 486 insertions(+), 174 deletions(-)
 create mode 100644 t/Git-SVN/Utils/add_path_to_url.t
 create mode 100644 t/Git-SVN/Utils/canonicalize_url.t
 create mode 100644 t/Git-SVN/Utils/collapse_dotdot.t
 create mode 100644 t/Git-SVN/Utils/join_paths.t
