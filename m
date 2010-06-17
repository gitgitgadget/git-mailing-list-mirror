From: Steven Michalske <smichalske@gmail.com>
Subject: Re: SVN migration
Date: Wed, 16 Jun 2010 17:41:49 -0700
Message-ID: <7B0F34CE-9C9F-4FC3-AD96-8B1B8DD4359B@gmail.com>
References: <4C1957EF.6070504@gnatter.net>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: William Hall <will@gnatter.net>
X-From: git-owner@vger.kernel.org Thu Jun 17 02:41:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OP3B7-0002Lm-0p
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 02:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758855Ab0FQAlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 20:41:53 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:58523 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009Ab0FQAlw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jun 2010 20:41:52 -0400
Received: from relay11.apple.com (relay11.apple.com [17.128.113.48])
	by mail-out3.apple.com (Postfix) with ESMTP id 9ADB7984983D;
	Wed, 16 Jun 2010 17:41:50 -0700 (PDT)
X-AuditID: 11807130-b7cd0ae00000795d-1b-4c196f4effac
Received: from monopole.apple.com (monopole.apple.com [17.205.37.84])
	(using TLS with cipher AES128-SHA (AES128-SHA/128 bits))
	(Client did not present a certificate)
	by relay11.apple.com (Apple SCV relay) with SMTP id 57.D1.31069.E4F691C4; Wed, 16 Jun 2010 17:41:50 -0700 (PDT)
In-Reply-To: <4C1957EF.6070504@gnatter.net>
X-Mailer: Apple Mail (2.1078)
X-Brightmail-Tracker: AAAAAQAAAZE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149281>


On Jun 16, 2010, at 4:02 PM, William Hall wrote:

> 
> The issue is the dcommit operation from the bridge. The rebase part of this re-writes the commit messages to include the SVN commit-ids which is nice, but screws up the push/pulls between the bridge and the bare repo.

Look into svn.noMetadata configuration option.  It will prevent you from rebuilding the svn to git bridge if something seriously goes wrong, but it prevents the messages from changing.

svn-remote.<name>.noMetadata
This gets rid of the git-svn-id: lines at the end of every commit.
If you lose your .git/svn/git-svn/.rev_db file, git svn will not be able to rebuild it and you won't be able to fetch again, either. This is fine for one-shot imports.
The git svn log command will not work on repositories using this, either. Using this conflicts with the useSvmProps option for (hopefully) obvious reasons
