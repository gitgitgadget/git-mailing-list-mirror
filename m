From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] contrib/hooks/post-receive-email: reformat to wrap comments at 76 chars
Date: Tue, 6 Nov 2007 13:48:34 +0000
Message-ID: <20071106134834.24314.qmail@c81ecd7fc93275.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 14:48:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpOn8-0004Px-DI
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 14:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbXKFNsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 08:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752410AbXKFNsP
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 08:48:15 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:37009 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751444AbXKFNsO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 08:48:14 -0500
Received: (qmail 24315 invoked by uid 1000); 6 Nov 2007 13:48:34 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63678>

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 contrib/hooks/post-receive-email |  199 ++++++++++++++++++++------------------
 1 files changed, 107 insertions(+), 92 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 379cedc..9b9a977 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -2,24 +2,26 @@
 #
 # Copyright (c) 2007 Andy Parkins
 #
-# An example hook script to mail out commit update information.  This hook sends emails
-# listing new revisions to the repository introduced by the change being reported.  The
-# rule is that (for branch updates) each commit will appear on one email and one email
-# only.
+# An example hook script to mail out commit update information.  This hook
+# sends emails listing new revisions to the repository introduced by the
+# change being reported.  The rule is that (for branch updates) each commit
+# will appear on one email and one email only.
 #
-# This hook is stored in the contrib/hooks directory.  Your distribution will have put
-# this somewhere standard.  You should make this script executable then link to it in
-# the repository you would like to use it in.  For example, on debian the hook is stored
-# in /usr/share/doc/git-core/contrib/hooks/post-receive-email:
+# This hook is stored in the contrib/hooks directory.  Your distribution
+# will have put this somewhere standard.  You should make this script
+# executable then link to it in the repository you would like to use it in.
+# For example, on debian the hook is stored in
+# /usr/share/doc/git-core/contrib/hooks/post-receive-email:
 #
 #  chmod a+x post-receive-email
 #  cd /path/to/your/repository.git
 #  ln -sf /usr/share/doc/git-core/contrib/hooks/post-receive-email hooks/post-receive
 #
-# This hook script assumes it is enabled on the central repository of a project, with
-# all users pushing only to it and not between each other.  It will still work if you
-# don't operate in that style, but it would become possible for the email to be from
-# someone other than the person doing the push.
+# This hook script assumes it is enabled on the central repository of a
+# project, with all users pushing only to it and not between each other.  It
+# will still work if you don't operate in that style, but it would become
+# possible for the email to be from someone other than the person doing the
+# push.
 #
 # Config
 # ------
@@ -28,11 +30,11 @@
 #   emails for every ref update.
 # hooks.announcelist
 #   This is the list that all pushes of annotated tags will go to.  Leave it
-#   blank to default to the mailinglist field.  The announce emails lists the
-#   short log summary of the changes since the last annotated tag.
+#   blank to default to the mailinglist field.  The announce emails lists
+#   the short log summary of the changes since the last annotated tag.
 # hooks.envelopesender
-#   If set then the -f option is passed to sendmail to allow the envelope sender
-#   address to be set
+#   If set then the -f option is passed to sendmail to allow the envelope
+#   sender address to be set
 #
 # Notes
 # -----
@@ -49,8 +51,8 @@
 # this is and calls the appropriate body-generation routine after outputting
 # the common header
 #
-# Note this function doesn't actually generate any email output, that is taken
-# care of by the functions it calls:
+# Note this function doesn't actually generate any email output, that is
+# taken care of by the functions it calls:
 #  - generate_email_header
 #  - generate_create_XXXX_email
 #  - generate_update_XXXX_email
@@ -225,8 +227,9 @@ generate_create_branch_email()
 	echo $LOGBEGIN
 	# This shows all log entries that are not already covered by
 	# another ref - i.e. commits that are now accessible from this
-	# ref that were previously not accessible (see generate_update_branch_email
-	# for the explanation of this command)
+	# ref that were previously not accessible
+	# (see generate_update_branch_email for the explanation of this
+	# command)
 	git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
 	git rev-list --pretty --stdin $newrev
 	echo $LOGEND
@@ -254,9 +257,10 @@ generate_update_branch_email()
 	#
 	#  git-rev-list N ^O ^X ^N
 	#
-	# So, we need to build up the list more carefully.  git-rev-parse will
-	# generate a list of revs that may be fed into git-rev-list.  We can get
-	# it to make the "--not --all" part and then filter out the "^N" with:
+	# So, we need to build up the list more carefully.  git-rev-parse
+	# will generate a list of revs that may be fed into git-rev-list.
+	# We can get it to make the "--not --all" part and then filter out
+	# the "^N" with:
 	#
 	#  git-rev-parse --not --all | grep -v N
 	#
@@ -266,16 +270,17 @@ generate_update_branch_email()
 	#  git-rev-list N ^O ^X
 	#
 	# This leaves a problem when someone else updates the repository
-	# while this script is running.  Their new value of the ref we're working
-	# on would be included in the "--not --all" output; and as our $newrev
-	# would be an ancestor of that commit, it would exclude all of our
-	# commits.  What we really want is to exclude the current value of
-	# $refname from the --not list, rather than N itself.  So:
+	# while this script is running.  Their new value of the ref we're
+	# working on would be included in the "--not --all" output; and as
+	# our $newrev would be an ancestor of that commit, it would exclude
+	# all of our commits.  What we really want is to exclude the current
+	# value of $refname from the --not list, rather than N itself.  So:
 	#
 	#  git-rev-parse --not --all | grep -v $(git-rev-parse $refname)
 	#
-	# Get's us to something pretty safe (apart from the small time between
-	# refname being read, and git-rev-parse running - for that, I give up)
+	# Get's us to something pretty safe (apart from the small time
+	# between refname being read, and git-rev-parse running - for that,
+	# I give up)
 	#
 	#
 	# Next problem, consider this:
@@ -283,18 +288,18 @@ generate_update_branch_email()
 	#          \
 	#           * --- X --- * --- N ($newrev)
 	#
-	# That is to say, there is no guarantee that oldrev is a strict subset of
-	# newrev (it would have required a --force, but that's allowed).  So, we
-	# can't simply say rev-list $oldrev..$newrev.  Instead we find the common
-	# base of the two revs and list from there.
+	# That is to say, there is no guarantee that oldrev is a strict
+	# subset of newrev (it would have required a --force, but that's
+	# allowed).  So, we can't simply say rev-list $oldrev..$newrev.
+	# Instead we find the common base of the two revs and list from
+	# there.
 	#
-	# As above, we need to take into account the presence of X; if another
-	# branch is already in the repository and points at some of the revisions
-	# that we are about to output - we don't want them.  The solution is as
-	# before: git-rev-parse output filtered.
+	# As above, we need to take into account the presence of X; if
+	# another branch is already in the repository and points at some of
+	# the revisions that we are about to output - we don't want them.
+	# The solution is as before: git-rev-parse output filtered.
 	#
-	# Finally, tags:
-	#   1 --- 2 --- O --- T --- 3 --- 4 --- N
+	# Finally, tags: 1 --- 2 --- O --- T --- 3 --- 4 --- N
 	#
 	# Tags pushed into the repository generate nice shortlog emails that
 	# summarise the commits between them and the previous tag.  However,
@@ -302,13 +307,14 @@ generate_update_branch_email()
 	# for a branch update.  Therefore we still want to output revisions
 	# that have been output on a tag email.
 	#
-	# Luckily, git-rev-parse includes just the tool.  Instead of using "--all"
-	# we use "--branches"; this has the added benefit that "remotes/" will
-	# be ignored as well.
-
-	# List all of the revisions that were removed by this update, in a fast forward
-	# update, this list will be empty, because rev-list O ^N is empty.  For a non
-	# fast forward, O ^N is the list of removed revisions
+	# Luckily, git-rev-parse includes just the tool.  Instead of using
+	# "--all" we use "--branches"; this has the added benefit that
+	# "remotes/" will be ignored as well.
+
+	# List all of the revisions that were removed by this update, in a
+	# fast forward update, this list will be empty, because rev-list O
+	# ^N is empty.  For a non fast forward, O ^N is the list of removed
+	# revisions
 	fast_forward=""
 	rev=""
 	for rev in $(git rev-list $newrev..$oldrev)
@@ -321,10 +327,10 @@ generate_update_branch_email()
 	fi
 
 	# List all the revisions from baserev to newrev in a kind of
-	# "table-of-contents"; note this list can include revisions that have
-	# already had notification emails and is present to show the full detail
-	# of the change from rolling back the old revision to the base revision and
-	# then forward to the new revision
+	# "table-of-contents"; note this list can include revisions that
+	# have already had notification emails and is present to show the
+	# full detail of the change from rolling back the old revision to
+	# the base revision and then forward to the new revision
 	for rev in $(git rev-list $oldrev..$newrev)
 	do
 		revtype=$(git cat-file -t "$rev")
@@ -334,19 +340,20 @@ generate_update_branch_email()
 	if [ "$fast_forward" ]; then
 		echo "      from  $oldrev ($oldrev_type)"
 	else
-		#  1. Existing revisions were removed.  In this case newrev is a
-		#     subset of oldrev - this is the reverse of a fast-forward,
-		#     a rewind
-		#  2. New revisions were added on top of an old revision, this is
-		#     a rewind and addition.
+		#  1. Existing revisions were removed.  In this case newrev
+		#     is a subset of oldrev - this is the reverse of a
+		#     fast-forward, a rewind
+		#  2. New revisions were added on top of an old revision,
+		#     this is a rewind and addition.
 
-		# (1) certainly happened, (2) possibly.  When (2) hasn't happened,
-		# we set a flag to indicate that no log printout is required.
+		# (1) certainly happened, (2) possibly.  When (2) hasn't
+		# happened, we set a flag to indicate that no log printout
+		# is required.
 
 		echo ""
 
-		# Find the common ancestor of the old and new revisions and compare
-		# it with newrev
+		# Find the common ancestor of the old and new revisions and
+		# compare it with newrev
 		baserev=$(git merge-base $oldrev $newrev)
 		rewind_only=""
 		if [ "$baserev" = "$newrev" ]; then
@@ -387,21 +394,22 @@ generate_update_branch_email()
 		git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
 		git rev-list --pretty --stdin $oldrev..$newrev
 
-		# XXX: Need a way of detecting whether git rev-list actually outputted
-		# anything, so that we can issue a "no new revisions added by this
-		# update" message
+		# XXX: Need a way of detecting whether git rev-list actually
+		# outputted anything, so that we can issue a "no new
+		# revisions added by this update" message
 
 		echo $LOGEND
 	else
 		echo "No new revisions were added by this update."
 	fi
 
-	# The diffstat is shown from the old revision to the new revision.  This
-	# is to show the truth of what happened in this change.  There's no point
-	# showing the stat from the base to the new revision because the base
-	# is effectively a random revision at this point - the user will be
-	# interested in what this revision changed - including the undoing of
-	# previous revisions in the case of non-fast forward updates.
+	# The diffstat is shown from the old revision to the new revision.
+	# This is to show the truth of what happened in this change.
+	# There's no point showing the stat from the base to the new
+	# revision because the base is effectively a random revision at this
+	# point - the user will be interested in what this revision changed
+	# - including the undoing of previous revisions in the case of
+	# non-fast forward updates.
 	echo ""
 	echo "Summary of changes:"
 	git diff-tree --stat --summary --find-copies-harder $oldrev..$newrev
@@ -448,7 +456,8 @@ generate_update_atag_email()
 #
 generate_atag_email()
 {
-	# Use git-for-each-ref to pull out the individual fields from the tag
+	# Use git-for-each-ref to pull out the individual fields from the
+	# tag
 	eval $(git for-each-ref --shell --format='
 	tagobject=%(*objectname)
 	tagtype=%(*objecttype)
@@ -459,8 +468,10 @@ generate_atag_email()
 	echo "   tagging  $tagobject ($tagtype)"
 	case "$tagtype" in
 	commit)
+
 		# If the tagged object is a commit, then we assume this is a
-		# release, and so we calculate which tag this tag is replacing
+		# release, and so we calculate which tag this tag is
+		# replacing
 		prevtag=$(git describe --abbrev=0 $newrev^ 2>/dev/null)
 
 		if [ -n "$prevtag" ]; then
@@ -477,25 +488,27 @@ generate_atag_email()
 	echo ""
 	echo $LOGBEGIN
 
-	# Show the content of the tag message; this might contain a change log
-	# or release notes so is worth displaying.
+	# Show the content of the tag message; this might contain a change
+	# log or release notes so is worth displaying.
 	git cat-file tag $newrev | sed -e '1,/^$/d'
 
 	echo ""
 	case "$tagtype" in
 	commit)
-		# Only commit tags make sense to have rev-list operations performed
-		# on them
+		# Only commit tags make sense to have rev-list operations
+		# performed on them
 		if [ -n "$prevtag" ]; then
 			# Show changes since the previous release
 			git rev-list --pretty=short "$prevtag..$newrev" | git shortlog
 		else
-			# No previous tag, show all the changes since time began
+			# No previous tag, show all the changes since time
+			# began
 			git rev-list --pretty=short $newrev | git shortlog
 		fi
 		;;
 	*)
-		# XXX: Is there anything useful we can do for non-commit objects?
+		# XXX: Is there anything useful we can do for non-commit
+		# objects?
 		;;
 	esac
 
@@ -544,13 +557,14 @@ generate_update_general_email()
 #
 generate_general_email()
 {
-	# Unannotated tags are more about marking a point than releasing a version;
-	# therefore we don't do the shortlog summary that we do for annotated tags
-	# above - we simply show that the point has been marked, and print the log
-	# message for the marked point for reference purposes
+	# Unannotated tags are more about marking a point than releasing a
+	# version; therefore we don't do the shortlog summary that we do for
+	# annotated tags above - we simply show that the point has been
+	# marked, and print the log message for the marked point for
+	# reference purposes
 	#
-	# Note this section also catches any other reference type (although there
-	# aren't any) and deals with them in the same way.
+	# Note this section also catches any other reference type (although
+	# there aren't any) and deals with them in the same way.
 
 	echo ""
 	if [ "$newrev_type" = "commit" ]; then
@@ -558,10 +572,10 @@ generate_general_email()
 		git show --no-color --root -s $newrev
 		echo $LOGEND
 	else
-		# What can we do here?  The tag marks an object that is not a commit,
-		# so there is no log for us to display.  It's probably not wise to
-		# output git-cat-file as it could be a binary blob.  We'll just say how
-		# big it is
+		# What can we do here?  The tag marks an object that is not
+		# a commit, so there is no log for us to display.  It's
+		# probably not wise to output git-cat-file as it could be a
+		# binary blob.  We'll just say how big it is
 		echo "$newrev is a $newrev_type, and is $(git cat-file -s $newrev) bytes long."
 	fi
 }
@@ -604,8 +618,8 @@ if [ -z "$GIT_DIR" ]; then
 fi
 
 projectdesc=$(sed -ne '1p' "$GIT_DIR/description")
-# Check if the description is unchanged from it's default, and shorten it to a
-# more manageable length if it is
+# Check if the description is unchanged from it's default, and shorten it to
+# a more manageable length if it is
 if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
 then
 	projectdesc="UNNAMED PROJECT"
@@ -616,11 +630,12 @@ announcerecipients=$(git repo-config hooks.announcelist)
 envelopesender=$(git-repo-config hooks.envelopesender)
 
 # --- Main loop
-# Allow dual mode: run from the command line just like the update hook, or if
-# no arguments are given then run as a hook script
+# Allow dual mode: run from the command line just like the update hook, or
+# if no arguments are given then run as a hook script
 if [ -n "$1" -a -n "$2" -a -n "$3" ]; then
 	# Output to the terminal in command line mode - if someone wanted to
-	# resend an email; they could redirect the output to sendmail themselves
+	# resend an email; they could redirect the output to sendmail
+	# themselves
 	PAGER= generate_email $2 $3 $1
 else
 	while read oldrev newrev refname
-- 
1.5.3.5
