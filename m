From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 1/3] Support viewing all changes in a single
	compare editor
Date: Mon, 12 Jan 2009 08:54:35 -0800
Message-ID: <20090112165435.GH10179@spearce.org>
References: <1231550077-1057-1-git-send-email-robin.rosenberg@dewire.com> <1231550077-1057-2-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 17:56:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMQ52-0004kI-5p
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 17:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbZALQyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 11:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbZALQyh
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 11:54:37 -0500
Received: from george.spearce.org ([209.20.77.23]:59050 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbZALQyh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 11:54:37 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id A811738210; Mon, 12 Jan 2009 16:54:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1231550077-1057-2-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105356>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Instead of having to click on every file listed as a diff
> an extra diff entry is inserted at the top. Double clicking
> on it will launch a compare editor for all changed files.

Nice.
 
> diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitFileDiffViewer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitFileDiffViewer.java
> index ebec261..7549aa4 100644
> --- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitFileDiffViewer.java
> +++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/CommitFileDiffViewer.java
> @@ -124,13 +149,16 @@ void doCopy() {
...
> +			else
> +				r.append(((RevDiff)o).left.getChildren().length + " files");

This should use the NLS framework for translation.

> diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FileDiffLabelProvider.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FileDiffLabelProvider.java
> index 60b3a5a..c78ba6e 100644
> --- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FileDiffLabelProvider.java
> +++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/FileDiffLabelProvider.java
> @@ -14,12 +14,49 @@
>  class FileDiffLabelProvider extends BaseLabelProvider implements
...
> +					StringBuilder b = new StringBuilder();
> +					if (add > 0) {
> +						b.append(add + " added");
> +					}
> +					if (mod > 0) {
> +						if (b.length() > 0)
> +							b.append(", ");
> +						b.append(mod + " changed");
> +					}
> +					if (del > 0) {
> +						if (b.length() > 0)
> +							b.append(", ");
> +						b.append(del + " deleted");

Again, NLS.

> diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/RevDiff.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/RevDiff.java
> new file mode 100644
> index 0000000..020ec73
> --- /dev/null
> +++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/RevDiff.java
> +class DiffSide implements ITypedElement, IStructureComparator {
...
> +	public String getName() {
> +		return "EGit diff";
> +	}

Should this have NLS applied to it?

-- 
Shawn.
