From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Documentation: New GUI configuration and command-line
	options.
Date: Sun, 16 Nov 2008 14:05:10 -0800
Message-ID: <20081116220510.GH2932@spearce.org>
References: <200811132028.49450.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 23:06:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1plJ-0008Ft-DS
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 23:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbYKPWFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 17:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753232AbYKPWFM
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 17:05:12 -0500
Received: from george.spearce.org ([209.20.77.23]:54758 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753189AbYKPWFL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 17:05:11 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 60999381FF; Sun, 16 Nov 2008 22:05:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200811132028.49450.angavrilov@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101168>

Alexander Gavrilov <angavrilov@gmail.com> wrote:
> Add information on new git-gui and gitk command-line options,
> configuration variables, and the encoding attribute.
> 
> Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> ---
>  Documentation/config.txt        |   24 ++++++++++++++++++++++++
>  Documentation/git-gui.txt       |   19 +++++++++++++++++++
>  Documentation/gitattributes.txt |   17 +++++++++++++++++
>  Documentation/gitk.txt          |    5 +++++
>  4 files changed, 65 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 965ed74..2223dc4 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -796,6 +796,14 @@ gui.diffcontext::
>  	Specifies how many context lines should be used in calls to diff
>  	made by the linkgit:git-gui[1]. The default is "5".
>  
> +gui.encoding::
> +	Specifies the default encoding to use for displaying of
> +	file contents in linkgit:git-gui[1] and linkgit:gitk[1].
> +	It can be overridden by setting the 'encoding' attribute
> +	for relevant files (see linkgit:gitattributes[5]).
> +	If this option is not set, the tools default to the
> +	locale encoding.
> +
>  gui.matchtrackingbranch::
>  	Determines if new branches created with linkgit:git-gui[1] should
>  	default to tracking remote branches with matching names or
> @@ -818,6 +826,22 @@ gui.spellingdictionary::
>  	the linkgit:git-gui[1]. When set to "none" spell checking is turned
>  	off.
>  
> +gui.fastcopyblame::
> +	If true, 'git gui blame' uses '-C' instead of '-C -C' for original
> +	location detection. It makes blame significantly faster on huge
> +	repositories at the expense of less thorough copy detection.
> +
> +gui.copyblamethreshold::
> +	Specifies the theshold to use in 'git gui blame' original location
> +	detection, measured in alphanumeric characters. See the
> +	linkgit:git-blame[1] manual for more information on copy detection.
> +
> +gui.blamehistoryctx::
> +	Specifies the radius of history context in days to show in
> +	linkgit:gitk[1] for the selected commit, when the `Show History
> +	Context` menu item is invoked from 'git gui blame'. If this
> +	variable is set to zero, the whole history is shown.
> +
>  help.browser::
>  	Specify the browser that will be used to display help in the
>  	'web' format. See linkgit:git-help[1].
> diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
> index 0e650f4..d0bc98b 100644
> --- a/Documentation/git-gui.txt
> +++ b/Documentation/git-gui.txt
> @@ -65,9 +65,28 @@ git gui blame v0.99.8 Makefile::
>  	example the file is read from the object database and not
>  	the working directory.
>  
> +git gui blame --line=100 Makefile::
> +
> +	Loads annotations as described above and automatically
> +	scrolls the view to center on line '100'.
> +
>  git gui citool::
>  
>  	Make one commit and return to the shell when it is complete.
> +	This command returns a non-zero exit code if the window was
> +	closed in any way other than by making a commit.
> +
> +git gui citool --amend::
> +
> +	Automatically enter the 'Amend Last Commit' mode of
> +	the interface.
> +
> +git gui citool --nocommit::
> +
> +	Behave as normal citool, but instead of making a commit
> +	simply terminate with a zero exit code. It still checks
> +	that the index does not contain any unmerged entries, so
> +	you can use it as a GUI version of linkgit:git-mergetool[1]
>  
>  git citool::
>  
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index eb64841..e02899f 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -495,6 +495,23 @@ in the file.  E.g. the string `$Format:%H$` will be replaced by the
>  commit hash.
>  
>  
> +Viewing files in GUI tools
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +`encoding`
> +^^^^^^^^^^
> +
> +The value of this attribute specifies the character encoding that should
> +be used by GUI tools (e.g. linkgit:gitk[1] and linkgit:git-gui[1]) to
> +display the contents of the relevant file. Note that due to performance
> +considerations linkgit:gitk[1] does not use this attribute unless you
> +manually enable per-file encodings in its options.
> +
> +If this attribute is not set or has an invalid value, the value of the
> +`gui.encoding` configuration variable is used instead
> +(See linkgit:git-config[1]).
> +
> +
>  USING ATTRIBUTE MACROS
>  ----------------------
>  
> diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
> index ae29a00..317f631 100644
> --- a/Documentation/gitk.txt
> +++ b/Documentation/gitk.txt
> @@ -56,6 +56,11 @@ frequently used options.
>  	Use this instead of explicitly specifying <revs> if the set of
>  	commits to show may vary between refreshes.
>  
> +--select-commit=<ref>::
> +
> +	Automatically select the specified commit after loading the graph.
> +	Default behavior is equivalent to specifying '--select-commit=HEAD'.
> +
>  <revs>::
>  
>  	Limit the revisions to show. This can be either a single revision
> -- 
> 1.6.0.3.15.gb8d36

-- 
Shawn.
