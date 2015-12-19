From: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v3] gitk: add -C <path> commandline parameter to change
 path
Date: Sat, 19 Dec 2015 14:13:32 +1100
Message-ID: <20151219031332.GE422@fergus.ozlabs.ibm.com>
References: <563C85C5.80703@gmail.com>
 <1447069522-19895-1-git-send-email-juhapekka.heikkila@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 04:18:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aA81z-0002DO-1x
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 04:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbbLSDRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2015 22:17:21 -0500
Received: from ozlabs.org ([103.22.144.67]:59723 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752780AbbLSDRT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 22:17:19 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 72C6514032E; Sat, 19 Dec 2015 14:17:17 +1100 (AEDT)
Content-Disposition: inline
In-Reply-To: <1447069522-19895-1-git-send-email-juhapekka.heikkila@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282731>

On Mon, Nov 09, 2015 at 01:45:22PM +0200, Juha-Pekka Heikkila wrote:
> This patch adds -C (change working directory) parameter to
> gitk. With this parameter, instead of need to cd to directory
> with .git folder, one can point the correct folder from
> commandline.
> 
> Signed-off-by: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>

Thanks.

While I like the idea, there are a couple of minor problems with the
patch.  First, the Documentation directory is in Junio's tree, not
mine, so the change to gitk and the change to Documentation need to be
separated.  Secondly, please use 4-space indentation rather than
8-space for consistency with the rest of the file.  See also the
comments below.

> +	"-C*" {
> +		if {[string length $arg] < 3} {
> +			incr i
> +			set cwd_path [lindex $argv [expr {$i}]]

No need to say [expr {$i}] here; [lindex $argv $i] works just fine.

Also, if i is now >= [llength $argv], we'll get an empty string in
cwd_path.  Is that what you meant?  Shouldn't we display an
appropriate error message instead of trying to cd to ""?

Paul.
