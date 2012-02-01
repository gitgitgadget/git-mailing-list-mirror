From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2012, #08; Tue, 31)
Date: Wed, 01 Feb 2012 12:46:20 -0800
Message-ID: <7vty3a2sf7.fsf@alter.siamese.dyndns.org>
References: <7vlion3tr5.fsf@alter.siamese.dyndns.org>
 <m3fweudaf6.fsf@localhost.localdomain>
 <7v39au47dt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Bernhard R. Link" <brl+git@mail.brlink.eu>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 21:46:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsh4W-00048N-UU
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 21:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550Ab2BAUqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 15:46:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61739 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752899Ab2BAUqX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 15:46:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EC5452F7;
	Wed,  1 Feb 2012 15:46:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DaiXwd+IexPDlAhvvG3kaxfj/NE=; b=baeUAN
	a/1G8aeUvqVkDljdRiq8lKLFddQ/IQXmPdDqSSEC8wwxwNuMr9nCirwuv1N4gDM5
	mkEUMIVuhJ0IBVgg5v+fe7np7mMt17CnyO8WYekkoDqJTBuuKp4XFXrGWPlpilsm
	ZG4VBBpLgY4bhNsCwzisREoQfSA8460RpyZ00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mq+t9algzBBzmmOU+v0blLBgjU8gGhqS
	7rGOb72/twGuWiI/zgkG0n0ZSjYwytB8B3/9j2SDporDF+d6SnX2EmI5DyaX2W0X
	sRtHD5TW+f9nbBdHdcq3F5GgyqDEh0EQKUPlvjeKhpUpajMwTFE4GiGgr8booL/0
	FVSqXUfb9DU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1565D52F6;
	Wed,  1 Feb 2012 15:46:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 578D352F5; Wed,  1 Feb 2012
 15:46:22 -0500 (EST)
In-Reply-To: <7v39au47dt.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 01 Feb 2012 12:37:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CCD08574-4D15-11E1-858E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189535>

Junio C Hamano <gitster@pobox.com> writes:

> I am getting 
>
>     7ad1b64084ff003f71fe749a3e5a74d071a193d8 is the first bad commit
>     commit 7ad1b64084ff003f71fe749a3e5a74d071a193d8
>     Author: Bernhard R. Link <brl+git@mail.brlink.eu>
>     Date:   Mon Jan 30 21:05:47 2012 +0100
>
>         gitweb: move hard coded .git suffix out of git_get_projects_list
>
> *** t9502-gitweb-standalone-parse-output.sh ***
> ...
> not ok - 14 forks: "forks" action for forked repository
> #
> #               gitweb_run "p=foo.git;a=forks" &&
> #               grep -q ">foo/foo-forked\\.git<" gitweb.body &&
> #               grep -q ">fork of foo<"          gitweb.body
> #
> ok 15 - forks: can access forked repository
> ok 16 - forks: project_index lists all projects (incl. forks)
> # failed 1 among 16 test(s)
>
> The output file gitweb.body has this in it:
>
> <div class="page_body">
> <br /><br />
> 404 - No forks found
> <br />
> </div>
> <div class="page_footer">

And of course the culprit turns out to be that "cute" expression.

-- >8 --
Subject: gitweb: do not use assignment with regexp replace in parameter

A recent patch made the code to generate a parameter to git_get_projects_list
a bit too cute, by introducing a new variable, assigning a value to it, and
then munging that value with s/// replacement, all in the parameter list.

The whole expression returns the number of replacements, not the resulting
value in the variable after s/// operation.

Split them into separate expressions, which also would make the resulting
lines shorter and less taxing on the brain. 

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 gitweb/gitweb.perl |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b764d51..e074cd7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6003,7 +6003,9 @@ sub git_forks {
 		die_error(400, "Unknown order parameter");
 	}
 
-	my @list = git_get_projects_list((my $filter = $project) =~ s/\.git$//);
+	my $filter = $project;
+	$filter =~ s/\.git$//;
+	my @list = git_get_projects_list($filter);
 	if (!@list) {
 		die_error(404, "No forks found");
 	}
@@ -6062,7 +6064,9 @@ sub git_summary {
 
 	if ($check_forks) {
 		# find forks of a project
-		@forklist = git_get_projects_list((my $filter = $project) =~ s/\.git$//);
+		my $filter = $project;
+		$filter =~ s/\.git$//;
+		@forklist = git_get_projects_list($filter);
 		# filter out forks of forks
 		@forklist = filter_forks_from_projects_list(\@forklist)
 			if (@forklist);
