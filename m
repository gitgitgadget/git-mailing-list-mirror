From: "J.H." <warthog9@kernel.org>
Subject: Re: [PATCHv3 0/4 (resent)] Miscelanous gitweb improvements from J.H.
Date: Wed, 06 Jan 2010 14:28:50 -0800
Message-ID: <4B450EA2.5020104@kernel.org>
References: <1262534850-24572-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 23:29:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSeN9-00009Q-Ia
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 23:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756336Ab0AFW2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 17:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756326Ab0AFW2w
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 17:28:52 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:40312 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756294Ab0AFW2v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 17:28:51 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id o06MSopr026539
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Jan 2010 14:28:50 -0800
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <1262534850-24572-1-git-send-email-jnareb@gmail.com>
X-Enigmail-Version: 1.0
X-Virus-Scanned: ClamAV 0.88.7/10264/Wed Jan  6 09:54:01 2010 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Wed, 06 Jan 2010 14:28:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136306>

Just a heads up I've been on vacation for two weeks and hadn't gotten
around to dealing with these e-mails.  I'm going to get them imported
into my tree here and take a look over them.

- John 'Warthog9' Hawley

On 01/03/2010 08:07 AM, Jakub Narebski wrote:
> This is resend of early part of "[PATCH 0/6] Gitweb caching changes v2"
> thread by John 'Warthog9' Hawley (J.H.),
>   Message-ID: <1260488743-25855-1-git-send-email-warthog9@kernel.org>
>   http://thread.gmane.org/gmane.comp.version-control.git/135052
> 
> or alternatively
>   git://git.kernel.org/pub/scm/git/warthog9/gitweb.git gitweb-ml-v2
> 
> with a few modifications of my own.  Those patches were send originally as
> responses in the mentioned thread, for further comments from original
> author.  As the discussion didn't pick up (because of kernel.org upgrade, and
> perhaps due to end-of-year stuff), I am resending those patches in a
> separate thread for a better visibility; only comments are changed.
> 
> This series of patches is rebased on top of commit 37bae10
> (Merge branch 'maint', 2009-12-31) in 'master' branch.
> 
> 
> Change that apply to all patches in series: 
> * moving from "GITWEB - " to "gitweb: " as subsystem prefix
> * changing author to John 'Warthog9' Hawley <warthog9@kernel.org>
>   (it was John 'Warthog9' Hawley <warthog9@eaglescrag.net>)
> * add signoff or change it to John 'Warthog9' Hawley <warthog9@kernel.org>,
>   and of course add my own signoff.
> 
> 
> I have included reply to neither "GITWEB - File based caching layer"
> nor "GITWEB - Separate defaults from main file" in this thread/series.
> 
> I haven't included the main point of the whole series, namely adding
> response caching layer in the form that is used in git.kernel.org, because
> I think this patch should be split into smaller parts, and unit-tested.
> As it is now it is a bit of mess.  I have done patch which makes gitweb
> always use explicit filehandle when printing (simplifying a bit it
> replaces 'print <something>' by 'print {$out} <something>', with $out set
> to \*STDOUT), as a patch that prepares for (optional) gitweb caching, while
> not affecting throughput, latency and memory consumption when caching is
> disabled, as opposed to original solution by J.H. of always storing whole
> response in scalar and writing it at the end. 
> 
> I haven't included splitting of gitweb_defaults.perl off gitweb.perl, as it
> was after large and invasive gitweb caching patch, it would require
> substantial changes to gitweb tests upfront (by testing built gitweb.cgi and
> not source gitweb.perl), and needs fixing of Makefile to actually work
> reliably (we could have to process both gitweb.perl and
> gitweb_defaults.perl, while provided Makefile process only the file which
> triggered the rule... I think).
> 
> 
> I am not sure if 'gitweb: Add option to force version match' is a good
> solution to the problem it tires to address, i.e. if it is worth having, 
> and I am not sure if I did 'gitweb: Makefile improvements' correctly.
> 
> John 'Warthog9' Hawley (4):
>   gitweb: Load checking
>   gitweb: Add option to force version match
>   gitweb: Optionally add "git" links in project list page
>   gitweb: Makefile improvements
> 
>  Makefile           |   65 +++++---------------------
>  gitweb/Makefile    |  129 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  gitweb/README      |   14 +++++-
>  gitweb/gitweb.perl |   80 ++++++++++++++++++++++++++++++--
>  4 files changed, 230 insertions(+), 58 deletions(-)
>  create mode 100644 gitweb/Makefile
> 
> John, any comments?
> 
