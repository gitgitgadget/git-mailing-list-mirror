From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] git-fast-import(1): reorganise options
Date: Sun, 6 Jan 2013 13:29:15 +0000
Message-ID: <20130106132915.GG6440@serenity.lan>
References: <20130105164415.39B144044B@snark.thyrsus.com>
 <20130105231151.GD3247@elie.Belkin>
 <7vy5g6okdi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Eric S. Raymond" <esr@thyrsus.com>, git@vger.kernel.org,
	David Michael Barr <b@rr-dav.id.au>,
	Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 14:29:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrqIQ-00008y-QR
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 14:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932Ab3AFN3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 08:29:31 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:36779 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818Ab3AFN33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 08:29:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 0E5F86064CC;
	Sun,  6 Jan 2013 13:29:29 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 26Ueb1KlgDbj; Sun,  6 Jan 2013 13:29:28 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id A20046064C7;
	Sun,  6 Jan 2013 13:29:27 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 95431161E54C;
	Sun,  6 Jan 2013 13:29:27 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZOuAAGmnKNdJ; Sun,  6 Jan 2013 13:29:27 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 61AC7161E552;
	Sun,  6 Jan 2013 13:29:17 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vy5g6okdi.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212800>

On Sat, Jan 05, 2013 at 11:12:25PM -0800, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> But in fact the current options list doesn't seem to be well organized at all.
>> What do you think would be a logical way to group these?
>>
>>  Features of input syntax
>>
>> 	--date-format
>> 	--done
>>
>>  Verbosity
>>
>> 	--quiet
>> 	--stats
>>
>>  Marks handling (checkpoint/restore)
>>
>> 	--import-marks
>> 	--import-marks-if-exists
>> 	--export-marks
>> 	--relative-marks
>>
>>  Semantics of execution
>>
>> 	--dry-run
>> 	--force
>> 	--cat-blob-fd
>> 	--export-pack-edges
>>
>>  Tuning
>>
>> 	--active-branches
>> 	--max-pack-size
>> 	--big-file-threshold
>> 	--depth
> 
> Sounds sensible.

How about this?

I left the "Semantics of execution" options with the general options
since I couldn't think of a sensible heading that didn't also apply to
'--quiet' or '--stats', but I think the result is reasonable.

-- <8 --

The options in git-fast-import(1) are not currently arranged in a
logical order, which has caused the '--done' options to be documented
twice (commit 3266de10).

Rearrange them into logical groups under subheadings.

While doing this, fix the duplicate '--done' documentation by taking the
best bits of each.  Also combine the descriptions of '--relative-marks'
and '--no-relative-marks' since they make more sense together.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/git-fast-import.txt | 115 +++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 56 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 68bca1a..0e25c8d 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -33,38 +33,55 @@ the frontend program in use.
 
 OPTIONS
 -------
---date-format=<fmt>::
-	Specify the type of dates the frontend will supply to
-	fast-import within `author`, `committer` and `tagger` commands.
-	See ``Date Formats'' below for details about which formats
-	are supported, and their syntax.
 
--- done::
-	Terminate with error if there is no 'done' command at the
-	end of the stream.
+--quiet::
+	Disable all non-fatal output, making fast-import silent when it
+	is successful.  This option disables the output shown by
+	\--stats.
+
+--stats::
+	Display some basic statistics about the objects fast-import has
+	created, the packfiles they were stored into, and the
+	memory used by fast-import during this run.  Showing this output
+	is currently the default, but can be disabled with \--quiet.
 
 --force::
 	Force updating modified existing branches, even if doing
 	so would cause commits to be lost (as the new commit does
 	not contain the old commit).
 
---max-pack-size=<n>::
-	Maximum size of each output packfile.
-	The default is unlimited.
+--cat-blob-fd=<fd>::
+	Write responses to `cat-blob` and `ls` queries to the
+	file descriptor <fd> instead of `stdout`.  Allows `progress`
+	output intended for the end-user to be separated from other
+	output.
 
---big-file-threshold=<n>::
-	Maximum size of a blob that fast-import will attempt to
-	create a delta for, expressed in bytes.  The default is 512m
-	(512 MiB).  Some importers may wish to lower this on systems
-	with constrained memory.
+--export-pack-edges=<file>::
+	After creating a packfile, print a line of data to
+	<file> listing the filename of the packfile and the last
+	commit on each branch that was written to that packfile.
+	This information may be useful after importing projects
+	whose total object set exceeds the 4 GiB packfile limit,
+	as these commits can be used as edge points during calls
+	to 'git pack-objects'.
 
---depth=<n>::
-	Maximum delta depth, for blob and tree deltification.
-	Default is 10.
+Options related to the input stream
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
---active-branches=<n>::
-	Maximum number of branches to maintain active at once.
-	See ``Memory Utilization'' below for details.  Default is 5.
+--date-format=<fmt>::
+	Specify the type of dates the frontend will supply to
+	fast-import within `author`, `committer` and `tagger` commands.
+	See ``Date Formats'' below for details about which formats
+	are supported, and their syntax.
+
+--done::
+	Terminate with error if there is no `done` command at the end of
+	the stream.  This option might be useful for detecting errors
+	that cause the frontend to terminate before it has started to
+	write a stream.
+
+Options related to marks
+~~~~~~~~~~~~~~~~~~~~~~~~
 
 --export-marks=<file>::
 	Dumps the internal marks table to <file> when complete.
@@ -87,51 +104,37 @@ OPTIONS
 	Like --import-marks but instead of erroring out, silently
 	skips the file if it does not exist.
 
---relative-marks::
+--[no-]relative-marks::
 	After specifying --relative-marks the paths specified
 	with --import-marks= and --export-marks= are relative
 	to an internal directory in the current repository.
 	In git-fast-import this means that the paths are relative
 	to the .git/info/fast-import directory. However, other
 	importers may use a different location.
++
+Relative and non-relative marks may be combined by interweaving
+--(no-)-relative-marks with the --(import|export)-marks= options.
 
---no-relative-marks::
-	Negates a previous --relative-marks. Allows for combining
-	relative and non-relative marks by interweaving
-	--(no-)-relative-marks with the --(import|export)-marks=
-	options.
+Options for tuning
+~~~~~~~~~~~~~~~~~~
 
---cat-blob-fd=<fd>::
-	Write responses to `cat-blob` and `ls` queries to the
-	file descriptor <fd> instead of `stdout`.  Allows `progress`
-	output intended for the end-user to be separated from other
-	output.
-
---done::
-	Require a `done` command at the end of the stream.
-	This option might be useful for detecting errors that
-	cause the frontend to terminate before it has started to
-	write a stream.
+--active-branches=<n>::
+	Maximum number of branches to maintain active at once.
+	See ``Memory Utilization'' below for details.  Default is 5.
 
---export-pack-edges=<file>::
-	After creating a packfile, print a line of data to
-	<file> listing the filename of the packfile and the last
-	commit on each branch that was written to that packfile.
-	This information may be useful after importing projects
-	whose total object set exceeds the 4 GiB packfile limit,
-	as these commits can be used as edge points during calls
-	to 'git pack-objects'.
+--big-file-threshold=<n>::
+	Maximum size of a blob that fast-import will attempt to
+	create a delta for, expressed in bytes.  The default is 512m
+	(512 MiB).  Some importers may wish to lower this on systems
+	with constrained memory.
 
---quiet::
-	Disable all non-fatal output, making fast-import silent when it
-	is successful.  This option disables the output shown by
-	\--stats.
+--depth=<n>::
+	Maximum delta depth, for blob and tree deltification.
+	Default is 10.
 
---stats::
-	Display some basic statistics about the objects fast-import has
-	created, the packfiles they were stored into, and the
-	memory used by fast-import during this run.  Showing this output
-	is currently the default, but can be disabled with \--quiet.
+--max-pack-size=<n>::
+	Maximum size of each output packfile.
+	The default is unlimited.
 
 
 Performance
-- 
1.8.0.2
