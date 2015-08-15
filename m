From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v7 4/4] notes: teach git-notes about notes.<ref>.mergestrategy
 option
Date: Sat, 15 Aug 2015 11:25:44 +0200
Message-ID: <CALKQrgfA4qfBV7yb1QNNtBvA9BK1gcDMFwdGRLxiVwk4SLWfHA@mail.gmail.com>
References: <1439586835-15712-1-git-send-email-jacob.e.keller@intel.com>
	<1439586835-15712-5-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 11:26:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQXj1-0000Sm-Mr
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 11:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbbHOJZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 05:25:52 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:62140 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbbHOJZw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2015 05:25:52 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZQXio-000MvZ-HG
	for git@vger.kernel.org; Sat, 15 Aug 2015 11:25:50 +0200
Received: by ykfw73 with SMTP id w73so34605515ykf.3
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 02:25:44 -0700 (PDT)
X-Received: by 10.13.204.208 with SMTP id o199mr6450291ywd.170.1439630744623;
 Sat, 15 Aug 2015 02:25:44 -0700 (PDT)
Received: by 10.37.201.134 with HTTP; Sat, 15 Aug 2015 02:25:44 -0700 (PDT)
In-Reply-To: <1439586835-15712-5-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275989>

On Fri, Aug 14, 2015 at 11:13 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> Add new option "notes.<ref>.mergestrategy" option which specifies the merge
> strategy for merging into a given notes ref. This option enables
> selection of merge strategy for particular notes refs, rather than all
> notes ref merges, as user may not want cat_sort_uniq for all refs, but
> only some. Note that the <ref> is the local reference we are merging
> into, not the remote ref we merged from. The assumption is that users
> will mostly want to configure separate local ref merge strategies rather
> than strategies depending on which remote ref they merge from. Also,
> notes.<ref>.merge overrides the general behavior as it is more specific.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  Documentation/config.txt            |  7 +++++++
>  Documentation/git-notes.txt         |  6 ++++++
>  builtin/notes.c                     | 13 ++++++++++---
>  t/t3309-notes-merge-auto-resolve.sh | 39 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 62 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 5e3e03459de7..47478311367e 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1926,6 +1926,13 @@ notes.mergestrategy::
>         STRATEGIES" section of linkgit:git-notes[1] for more information
>         on each strategy.
>
> +notes.<localref>.mergestrategy::

Nit: mergeStrategy

> +       Which merge strategy to choose if the local ref for a notes merge
> +       matches <localref>, overriding "notes.mergestrategy". <localref> must
> +       be the short name of a ref under refs/notes/. See "NOTES MERGE

An example would be useful here, methinks:

<localref> must be the short name of a ref under refs/notes/, e.g. for
configuring
the merge strategy for refs/notes/commits, notes.commits.mergeStrategy must
be set.


Otherwise, the patch looks good to me.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
