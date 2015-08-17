From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v8 8/8] notes: teach git-notes about notes.<ref>.mergeStrategy
 option
Date: Mon, 17 Aug 2015 15:21:09 +0200
Message-ID: <CALKQrgeBVfkWOPZYJLnLqJiBPG5XR++G2Mmma2tyc-kwZ5aW_A@mail.gmail.com>
References: <1439801191-3026-1-git-send-email-jacob.e.keller@intel.com>
	<1439801191-3026-9-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 15:21:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRKLq-0002D2-RT
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 15:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983AbbHQNVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 09:21:18 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:49644 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbbHQNVS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 09:21:18 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZRKLj-0001uL-TD
	for git@vger.kernel.org; Mon, 17 Aug 2015 15:21:16 +0200
Received: by ykfw73 with SMTP id w73so72167938ykf.3
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 06:21:09 -0700 (PDT)
X-Received: by 10.170.153.68 with SMTP id u65mr1342417ykc.94.1439817669987;
 Mon, 17 Aug 2015 06:21:09 -0700 (PDT)
Received: by 10.37.201.134 with HTTP; Mon, 17 Aug 2015 06:21:09 -0700 (PDT)
In-Reply-To: <1439801191-3026-9-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276051>

Allow me to suggest a different wording, somewhat inspired by the
branch.<name>.* documentation...

On Mon, Aug 17, 2015 at 10:46 AM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> Add new option "notes.<ref>.mergeStrategy" option which specifies the merge
> strategy for merging into a given notes ref.

Add new "notes.<name>.mergeStrategy" config, which specifies the merge
strategy for notes merges into refs/notes/<name>.

> This option enables
> selection of merge strategy for particular notes refs, rather than all
> notes ref merges, as user may not want cat_sort_uniq for all refs, but
> only some. Note that the <ref> is the local reference we are merging

s/<ref>/<name>/

> into, not the remote ref we merged from. The assumption is that users
> will mostly want to configure separate local ref merge strategies rather
> than strategies depending on which remote ref they merge from. Also,
> notes.<ref>.merge overrides the general behavior as it is more specific.

same here

>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  Documentation/config.txt            |  7 +++++++
>  Documentation/git-notes.txt         |  6 ++++++
>  builtin/notes.c                     | 14 ++++++++++++-
>  t/t3309-notes-merge-auto-resolve.sh | 39 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 65 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 56e20446f587..a48c111d3ce0 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1926,6 +1926,13 @@ notes.mergeStrategy::
>         STRATEGIES" section of linkgit:git-notes[1] for more information
>         on each strategy.
>
> +notes.<localref>.mergeStrategy::
> +       Which merge strategy to choose if the local ref for a notes merge
> +       matches <localref>, overriding "notes.mergeStrategy". <localref> must
> +       be the short name of a ref under refs/notes/.

notes.<name>.mergeStrategy::
        Which merge strategy to use when doing a notes merge into
        refs/notes/<name>. This overrides the more general
"notes.mergeStrategy".

Otherwise, the series (except possibly #4/#5, see separate discussion)
looks good to me.


...Johan



-- 
Johan Herland, <johan@herland.net>
www.herland.net
