From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] Provide API access to init_db()
Date: Sun, 27 Apr 2008 15:01:21 -0700
Message-ID: <7vr6crdkjy.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0804271305000.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 00:02:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqExM-00009J-H9
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 00:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbYD0WBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 18:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbYD0WBj
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 18:01:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbYD0WBi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 18:01:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3423B4A58;
	Sun, 27 Apr 2008 18:01:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 956E54A57; Sun, 27 Apr 2008 18:01:32 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0804271305000.19665@iabervon.org> (Daniel
 Barkalow's message of "Sun, 27 Apr 2008 13:39:27 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80489>

Daniel Barkalow <barkalow@iabervon.org> writes:

> ...
> +		 * PERM_EVERYBODY.
> +		 */
> +		sprintf(buf, "%d", shared_repository);

This line is superfluous (no need to send amended patch).

> +		if (shared_repository == PERM_GROUP)
> +			sprintf(buf, "%d", OLD_PERM_GROUP);
> ...


> +	if (is_bare_repository_cfg < 0)
> +		is_bare_repository_cfg = guess_repository_type(git_dir);
> +
> +	if (!is_bare_repository_cfg) {
> +		if (git_dir) {
> +			const char *git_dir_parent = strrchr(git_dir, '/');
> +			if (git_dir_parent) {
> +				char *rel = xstrndup(git_dir, git_dir_parent - git_dir);
> +				git_work_tree_cfg = xstrdup(make_absolute_path(rel));
> +				free(rel);

Good change to plug a leak and make the code easier to read..
