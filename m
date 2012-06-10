From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2012, #01; Sun, 3)
Date: Sun, 10 Jun 2012 00:26:35 -0700
Message-ID: <7vmx4baaqc.fsf@alter.siamese.dyndns.org>
References: <7vr4twudqm.fsf@alter.siamese.dyndns.org>
 <CAMP44s0cQe3jdfzbJmFVoFS50Ho5hVPg9dpZx0KhG3sP_J8=_g@mail.gmail.com>
 <7vbokwmifp.fsf@alter.siamese.dyndns.org>
 <CAMP44s2VGLj8kRih-95A0VDq86WKWHF3EhLvz0etyHHtP27qLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 09:26:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdcXs-0003DA-8a
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 09:26:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499Ab2FJH0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 03:26:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47544 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176Ab2FJH0i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 03:26:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C45043E21;
	Sun, 10 Jun 2012 03:26:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ic0cGCQ0/F7Qby4B+aFgOqnVwXE=; b=XLaApp
	dX24VOWaYmYXIXwsa9YlSbjElUXDWhO9zxPysVgfZz2Vq1VWo/hedNb0LViWvWSN
	W5/rtidHroURd5sFba5wW2ML80kHL/kOCg8EEfflVQ0uNYlNlekPc+4zhDJgUo8u
	bdvj//XhQTlu+78V2Y92ObuYL4ObSOiOo3oAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eSawP2qddLrre/MMabMlNL2eyrPqzL20
	uDYajW3atsRDmHfz2wuzyekRbZ96Tm3B/NzofWxORulM6Mh49mDiaybhKS+Ruah4
	3ay2n/7P6/Dm5i797yoTfZiyTUu2zmguwlB60wD0u+Mq98waIpMvTJa9JuouH9MK
	QVUAJQQf6dE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAA353E20;
	Sun, 10 Jun 2012 03:26:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2CDEB3E1F; Sun, 10 Jun 2012
 03:26:37 -0400 (EDT)
In-Reply-To: <CAMP44s2VGLj8kRih-95A0VDq86WKWHF3EhLvz0etyHHtP27qLA@mail.gmail.com> (Felipe
 Contreras's message of "Wed, 6 Jun 2012 20:17:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9D1F3D20-B2CD-11E1-B36B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199573>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> I did not see anything like these.
>
> Nor is it needed *right now*. You could release v1.7.11 without any of
> these, and then v1.7.11.1 or even v1.7.12 with a solution; I bet
> __gitdir() would not have changed by that point.

And by that time on whom are you placing the burden of making sure
they do not diverge?  Don't you still realize that you are being
irresponsible?

In any case, I am tired of your arguing without being constructive,
so let's try again.  This is the third option I suggested to you.

Notice in the post context lines that they are already subtly
different; one pays attention to $GIT_DIR, and the other does not.
Shouldn't they be not just kept in sync, but start out in sync in
the first place?

Aren't there other functions or variables that need to be kept in
sync between these, by the way?

-- >8 --
Subject: completion: warn people about duplicated function

The __gitdir function is duplicated between completion and prompt
scripts, and these definitions should not diverge; otherwise one of
them can be subtly broken depending on the order the user's shell
dot-sources them.

Leave a note to people who may want to touch one copy to make sure
they update the other one in sync.  Hopefully this line would also
appear in the context of the patch to allow reviewers to notice a
patch that attempts to update only one of them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 contrib/completion/git-completion.bash | 2 ++
 contrib/completion/git-prompt.sh       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index abf8215..efcd875 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -33,12 +33,14 @@ case "$COMP_WORDBREAKS" in
 esac
 
 # __gitdir accepts 0 or 1 arguments (i.e., location)
 # returns location of .git repo
 __gitdir ()
 {
+	# Note: this function is duplicated in git-prompt.sh
+	# When updating it, make sure you update the other one to match.
 	if [ -z "${1-}" ]; then
 		if [ -n "${__git_dir-}" ]; then
 			echo "$__git_dir"
 		elif [ -d .git ]; then
 			echo .git
 		else
diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 8e2e9f3..29b1ec9 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -50,12 +50,14 @@
 # setting the bash.showUpstream config variable.
 
 # __gitdir accepts 0 or 1 arguments (i.e., location)
 # returns location of .git repo
 __gitdir ()
 {
+	# Note: this function is duplicated in git-completion.bash
+	# When updating it, make sure you update the other one to match.
 	if [ -z "${1-}" ]; then
 		if [ -n "${__git_dir-}" ]; then
 			echo "$__git_dir"
 		elif [ -n "${GIT_DIR-}" ]; then
 			test -d "${GIT_DIR-}" || return 1
 			echo "$GIT_DIR"
