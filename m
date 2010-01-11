From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 6/6] Documentation: tweak How Merge Works
Date: Tue, 12 Jan 2010 00:11:28 +0100
Message-ID: <201001120011.42654.trast@student.ethz.ch>
References: <cover.1263081032.git.trast@student.ethz.ch> <20100111082123.GA23742@progeny.tock> <20100111084355.GF23806@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 12 00:12:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUTQj-0002vB-J5
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 00:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124Ab0AKXMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 18:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034Ab0AKXMG
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 18:12:06 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:13410 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355Ab0AKXMF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 18:12:05 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.213.0; Tue, 12 Jan
 2010 00:12:04 +0100
Received: from thomas.localnet (84.74.100.59) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Tue, 12 Jan
 2010 00:11:43 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.90; x86_64; ; )
In-Reply-To: <20100111084355.GF23806@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136679>

The below and earlier comments aside, I really like this series.  It
seems to make the manpage much more accessible.

Jonathan Nieder wrote:
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index ec9c6d3..7ae0f65 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -96,62 +96,56 @@ merge commit.
>  
>  This behavior can be suppressed with the `--no-ff` option.
>  
> -include::merge-strategies.txt[]
> -
> -

I'm not sure whether you deliberately did this, or deliberately
deferred it to this patch, but this "sneak moves" the merge-strategies
section beyond "TRUE MERGE" (was "HOW MERGE WORKS").

So the section layout changes as follows when comparing current master
with your series:

 NAME
 SYNOPSIS
 DESCRIPTION
 OPTIONS
+PRE-MERGE CHECKS
+FAST-FORWARD MERGE
+TRUE MERGE
 MERGE STRATEGIES
-CONFIGURATION
-HOW MERGE WORKS
 HOW CONFLICTS ARE PRESENTED
 HOW TO RESOLVE CONFLICTS
 EXAMPLES
+CONFIGURATION
 SEE ALSO
 AUTHOR
 DOCUMENTATION
 GIT
 NOTES

While I agree with the general intent of deferring the strategies
further back, wouldn't it be better go all the way and instead put
them before (or even after, but one of them uses -s ours) "EXAMPLES"?
The average user will care more about conflicts than about strategies
other than 'recursive'.

> +1. A version reconciling the changes from all branches to be
> +   merged is written to the index file and your working tree;
> +2. The index file is written out as a tree;
>  3. The tree gets committed; and
>  4. The `HEAD` pointer gets advanced.

Could we do away with the detail here?  The user most likely does not
care about the exact order because he cannot "see" it happening
anyway.  So how about

  A merged version reconciling the changes from all branches to be
  merged is committed, and your HEAD, index, and working tree are
  updated to it.  (It is possible to have modifications in the working
  tree as long as they do not overlap; the update will preserve them.)

and then snip everything up to

> +When it is not obvious how to reconcile the changes, the following
> +happens:

because that is far more important to the user: he is left in the
middle of the described state.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
