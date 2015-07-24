From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 1/9] refs:  Introduce pseudoref and per-worktree ref concepts
Date: Fri, 24 Jul 2015 20:52:49 +0100
Organization: OPDS
Message-ID: <344748CA1CA54D55A9F245FE2DBD23DC@PhilipOakley>
References: <1437713129-19373-1-git-send-email-dturner@twopensource.com> <1437713129-19373-2-git-send-email-dturner@twopensource.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "David Turner" <dturner@twopensource.com>
To: "David Turner" <dturner@twopensource.com>, <git@vger.kernel.org>,
	<mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jul 24 21:53:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIj1b-0000Fr-0O
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 21:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbbGXTwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 15:52:51 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:9941 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752134AbbGXTwu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jul 2015 15:52:50 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2B/FgBQlrJVPNwOFlxWBg4LgnyBPYZRbbt/BAQCgUtNAQEBAQEBBwEBAQFBJBuEHgYBAQQIAQEuHgEBIQsCAwUCAQMOBwwlFAEEGgYHAxQGARIIAgECAwGIIb98j1+LTYREQ4MfgRQFjHmHagGBDoxyhy+IFIgcgQqCWz89MYJLAQEB
X-IPAS-Result: A2B/FgBQlrJVPNwOFlxWBg4LgnyBPYZRbbt/BAQCgUtNAQEBAQEBBwEBAQFBJBuEHgYBAQQIAQEuHgEBIQsCAwUCAQMOBwwlFAEEGgYHAxQGARIIAgECAwGIIb98j1+LTYREQ4MfgRQFjHmHagGBDoxyhy+IFIgcgQqCWz89MYJLAQEB
X-IronPort-AV: E=Sophos;i="5.15,540,1432594800"; 
   d="scan'208";a="164596594"
Received: from host-92-22-14-220.as13285.net (HELO PhilipOakley) ([92.22.14.220])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 24 Jul 2015 20:52:48 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274594>

From: "David Turner" <dturner@twopensource.com>
> Add glossary entries for both concepts.
>
> Pseudorefs and per-worktree refs do not yet have special handling,
> because the files refs backend already handles them correctly.  Later,
> we will make the LMDB backend call out to the files backend to handle
> per-worktree refs.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
> Documentation/glossary-content.txt | 17 +++++++++++++++++
> refs.c                             | 23 +++++++++++++++++++++++
> refs.h                             |  2 ++
> 3 files changed, 42 insertions(+)
>
> diff --git a/Documentation/glossary-content.txt 
> b/Documentation/glossary-content.txt
> index ab18f4b..d04819e 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -411,6 +411,23 @@ exclude;;
>  core Git. Porcelains expose more of a <<def_SCM,SCM>>
>  interface than the <<def_plumbing,plumbing>>.
>
> +[[def_per_worktree_ref]]per-worktree ref::
> + Refs that are per-<<def_worktree,worktree>>, rather than
> + global.  This is presently only <<def_HEAD,HEAD>>, but might
> + later include other unsuual refs.
s/unsuual/unusual/

> +
> +[[def_pseudoref]]pseudoref::
> + Files under `$GIT_DIR` whose names are all-caps, and that

s/and that/excluding 'HEAD', which is special./ ?

> + contain a line consisting of a <<def_sha1,SHA-1>> followed by

s/contain/Pseudorefs typically contain/ perhaps?

> + a newline, and optionally some additional data.  `MERGE_HEAD`
> + and `CHERRY_PICK_HEAD` are examples.  Unlike
> + <<def_per_worktree_ref,per-worktree refs>>, these files cannot
> + be symbolic refs, and never not have reflogs.  They also
> + cannot be updated through the normal ref update machinery.
> + Instead, they are updated by directly writing to the files.
> + However, they can be read as if they were refs, so `git
> + rev-parse MERGE_HEAD` will work.
> +
> [[def_pull]]pull::
>  Pulling a <<def_branch,branch>> means to <<def_fetch,fetch>> it and
>  <<def_merge,merge>> it.  See also linkgit:git-pull[1].
[...]

The key points I'd picked out were:

*    ALL_CAPS names

*    acts like a ref <<>>, but separate from refs

*    HEAD is special and not a pseudoref (i.e. see <<HEAD>>).

*    CHERRY_PICK_HEAD and REVERT_HEAD are examples.

*    three way split: refs/; pseudorefs; HEAD.

*    one-level ALL_CAPS names are per worktree

*    is a file in $GIT_DIR/ that always contains at least a SHA1.

--
Philip 
