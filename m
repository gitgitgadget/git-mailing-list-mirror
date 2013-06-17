From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] config doc: rewrite push.default section
Date: Mon, 17 Jun 2013 18:09:12 +0100
Organization: OPDS
Message-ID: <7B6316FB423B45559A4698FD35D519FC@PhilipOakley>
References: <1371377188-18938-1-git-send-email-artagnon@gmail.com><7vli69iff2.fsf@alter.siamese.dyndns.org> <vpqip1d803r.fsf@anie.imag.fr>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Git List" <git@vger.kernel.org>
To: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 19:09:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UocvY-0005ip-Cv
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 19:09:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938Ab3FQRJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 13:09:07 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:48012 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751222Ab3FQRJG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jun 2013 13:09:06 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhkOAFtBv1FOl3t//2dsb2JhbABaFoJzMYkHtjAEAQMBfBd0gh4FAQEFCAEBLhEFCAEBIQsCAwUCAQMRAwEBAQolFAEEGAIGBw8IBgEHCwgCAQIDAQwEh3EIuXWOXWoNgnlhA4hohgaJfIp5hSGDEDs
X-IronPort-AV: E=Sophos;i="4.87,882,1363132800"; 
   d="scan'208";a="431810973"
Received: from host-78-151-123-127.as13285.net (HELO PhilipOakley) ([78.151.123.127])
  by out1.ip02ir2.opaltelecom.net with SMTP; 17 Jun 2013 18:09:04 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228086>

From: "Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>
Sent: Monday, June 17, 2013 12:09 PM
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> +* `matching` - push the refspec ":".  In other words, push all
>>> +  branches having the same name in both ends, even if it means
>>> +  non-fast-forward updates.  This is for those who prepare all the
>>> +  branches into a publishable shape and then push them out with a
>>> +  single command.  Dangerous, and inappropriate unless you are the
>>> +  only person updating your push destination.
>>
>> It was already pointed out that unnecessary negativity needs to be
>> fixed, but more importantly the above "Dangerous" is not even
>> correct.
>
> What's really dangerous is the --force flag. A few weeks ago I had to
> help a colleague who did a "git push --force" to update his branch, 
> and
> he lost data on his co-worker's branches (thanks to "git reflog", it
> wasn't an actual data loss, but still pretty bad).
>
> But then the place to warn loudly is the doc for --force. What about
> this?
>
> ------- 8< ------- 8< ------- 8< ------- 8< ------- 8< ------- 8<
>
> From a529588dd8df84e54e5ec267068248cc555373f5 Mon Sep 17 00:00:00 2001
> From: Matthieu Moy <Matthieu.Moy@imag.fr>
> Date: Mon, 17 Jun 2013 13:02:39 +0200
> Subject: [PATCH] Documentation/git-push.txt: explain better cases 
> where
> --force is dangerous
>
> The behavior of "git push --force" is rather clear when it updates 
> only
> one remote ref, but running it when pushing several branches can 
> really
> be dangerous. Warn the users a bit more and give them the alternative 
> to
> push only one branch.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Documentation/git-push.txt | 7 +++++++
> 1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 938d1ee..0899a35 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -136,6 +136,13 @@ already exists on the remote side.
>        not an ancestor of the local ref used to overwrite it.
>        This flag disables the check.  This can cause the
>        remote repository to lose commits; use it with care.
> +       Note that `--force` applies to all the refs that are pushed,
> +       hence using `git push --all --force`, or `git push --force`
> +       with `push.default` set to `matching` may override refs other
> +       than the current branch (including local refs that are
> +       strictly behind their remote counterpart). To force a push to
> +       only one branch, use `git push <remote> +<branch>` instead of
> +       `--force`.

It would be useful to include a real example "e.g. `git push origin 
+master`", or a link to specifying a refspec "see <refspec>... above", 
such that the "+" doesn't get lost in the general text, as push is one 
of the first few commands a new user is likely to be looking up (and 
misunderstanding ;-), so let's make the + obvious

I did notice that the <refspec>... section doesn't actually associate 
the "+" with the force action - Am I misunderstanding this?

>
> --repo=<repository>::
>        This option is only relevant if no <repository> argument is
> -- 
> 1.8.3.1.495.g13f33cf.dirty
>
>
> -- 
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2013.0.3345 / Virus Database: 3199/6417 - Release Date: 
> 06/16/13
> 
