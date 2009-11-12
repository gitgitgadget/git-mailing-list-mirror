From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCHv2] Update gitworkflows man page to include release workflow
Date: Thu, 12 Nov 2009 09:27:13 +0100
Message-ID: <200911120927.16764.trast@student.ethz.ch>
References: <1257869339-15999-1-git-send-email-rocketraman@fastmail.fm> <1257869339-15999-2-git-send-email-rocketraman@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: <rocketraman@fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Nov 12 09:28:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8V2Z-0000QU-Ap
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 09:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbZKLI2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 03:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752468AbZKLI2P
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 03:28:15 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:32622 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752215AbZKLI2O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 03:28:14 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 12 Nov
 2009 09:28:19 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 12 Nov
 2009 09:28:00 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.27.29-0.1-default; KDE/4.3.3; x86_64; ; )
In-Reply-To: <1257869339-15999-2-git-send-email-rocketraman@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132747>

Here's my promised review of the whole patch.  Much of the text fits
my understanding of what's actually going on, but Junio will have the
final word on what he actually does (or what a sensible simplification
might be).

rocketraman@fastmail.fm wrote:
> +The current maintenance branch is optionally copied to another branch
> +named with the older release version number (e.g. maint-X.Y.(Z-1)
> +where X.Y.Z is the previous release). This allows for further
> +maintenance releases on the older codebase.

The use of Z-1 confused me; I guess by "previous release" you mean
"the release we just tagged in the last step".  Otherwise the maint
version number would come out wrong.

> +.Update maint to new release
> +[caption="Recipe: "]
> +=====================================
> +* `git checkout maint`
> +* `git merge master`
> +=====================================
> +
> +This updates 'maint' from 'master', while preserving the 'maint'
> +reflog.

I agree with what Junio said in the other mail: it's important at this
point that this was a fast-forward.  (If it's not, master could be
missing some fixes made on maint.)

> +An alternative approach to updating the 'maint' branch is to run
> +
> +  $ git branch -f maint master

In my book the alternative approach is

  git branch -m maint maint-X.Y.(Z-1)
  git branch maint master

I'd rather not teach users to play with loaded guns, much less in a
"good examples of workflows" manpage.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
