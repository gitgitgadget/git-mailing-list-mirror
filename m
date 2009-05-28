From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] bisect: display first bad commit without forking a new process
Date: Thu, 28 May 2009 23:20:04 +0200
Message-ID: <200905282320.05039.chriscool@tuxfamily.org>
References: <20090527052354.3824.22018.chriscool@tuxfamily.org> <7veiuai33m.fsf@alter.siamese.dyndns.org> <4A1E458E.6050505@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu May 28 23:21:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9n2c-0001kD-MN
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 23:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764254AbZE1VUe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2009 17:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764091AbZE1VUd
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 17:20:33 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:43662 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764114AbZE1VUc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2009 17:20:32 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 2C4B99400D4;
	Thu, 28 May 2009 23:20:06 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 30B78940165;
	Thu, 28 May 2009 23:20:04 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <4A1E458E.6050505@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120233>

Le Thursday 28 May 2009, Andreas Ericsson a =E9crit :
> Junio C Hamano wrote:
> > Christian Couder <chriscool@tuxfamily.org> writes:
> >> Le Wednesday 27 May 2009, Christian Couder a =E9crit :
> >>> Previously "git diff-tree --pretty COMMIT" was run using
> >>> "run_command_v_opt" to display information about the first bad
> >>> commit.
> >>>
> >>> The goal of this patch is to avoid a "fork" and an "exec" call
> >>> when displaying that information.
> >>>
> >>> To do that, we manually setup revision information as
> >>> "git diff-tree --pretty" would do it, and then use the
> >>> "log_tree_commit" function.
> >>>
> >>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> >>> ---
> >>>  bisect.c |   30 +++++++++++++++++++++++++++---
> >>>  1 files changed, 27 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/bisect.c b/bisect.c
> >>> index c43c120..e94a77b 100644
> >>> --- a/bisect.c
> >>> +++ b/bisect.c
> >>> @@ -816,6 +816,31 @@ static void
> >>> check_good_are_ancestors_of_bad(const char *prefix) }
> >>>
> >>>  /*
> >>> + * This does "git diff-tree --pretty COMMIT" without one fork+ex=
ec.
> >>> + */
> >>> +static void show_diff_tree(const char *prefix, struct commit
> >>> *commit) +{
> >>> +	static struct rev_info opt;
> >>
> >> Oops, "static" can be removed, it's a copy-paste error, sorry.
> >
> > Is that "can" or "must"?  If the answer is the latter, shouldn't th=
e
> > function be renamed to make it clear it is a bisect specific thing?
>
> I think he was referring to the 'static' in the variable declarations=
=2E

You are right. I will send a v2 of this patch anyway.

Thanks for this clarification,
Christian.
