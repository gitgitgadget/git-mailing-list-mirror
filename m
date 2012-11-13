From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Tue, 13 Nov 2012 07:42:58 +0100
Message-ID: <CAMP44s1w3oZhEUM-cnO=kECH2bhdOTGVuKy8JS4uhWFbA_oi3w@mail.gmail.com>
References: <1352653610-2090-1-git-send-email-felipe.contreras@gmail.com>
	<20121112233546.GG10531@sigill.intra.peff.net>
	<CAMP44s0emar-C27SX-FDsUVB6Sevuy4fBFHuO2OD6xELCEjmGg@mail.gmail.com>
	<20121113000217.GH10531@sigill.intra.peff.net>
	<CAMP44s16y9WSmnTdb04EMSzXVgzfYP7pSMo6qZi0HY0bjouA0w@mail.gmail.com>
	<20121113032727.GA8387@sigill.intra.peff.net>
	<CAMP44s0SDHVzSd-8Rq7Z1sbiQ6m0pxX+2pgx16_DoWnHeyNsNQ@mail.gmail.com>
	<20121113040104.GA9361@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 07:43:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYADK-00089K-Os
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 07:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485Ab2KMGnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 01:43:00 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40929 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab2KMGm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 01:42:59 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so7083491obb.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 22:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UQD/3JtPYhrgpei3qBT9OX207S0OnDQgjqDHFgMIARA=;
        b=UB6pb+mdzGLt9qGQRk1O76/BrjbO54AQAhvyNiMsg8sWT8qkUEuGvdtWa3jNxCRfbn
         vXI/R7PRNtno++ZUtRWGZt6NkvBDYU6bJl8w9UMfT2HYj7u5zwvWXhfoiBTla9yLtKqL
         eVlTy3zXAmtes9sTrBxiHXwKF0QYAeEjGlia2UymCpHwPGR9qxq9BUX2g+bQfBr9WZPd
         l85nvmWyM+sfk8Cy8bgeOoUo02KG3IO0SWROBDTvZLG5gFIVIg6l6HemraKbKo3AjAsq
         lNcDKXOLXipfga/EGfvfEpqv2SOSkGkvJyDGLmZI7KYkhFrc9f8zvqVfV1R2oXWvbOyE
         1d5g==
Received: by 10.60.20.1 with SMTP id j1mr7478115oee.46.1352788978897; Mon, 12
 Nov 2012 22:42:58 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 12 Nov 2012 22:42:58 -0800 (PST)
In-Reply-To: <20121113040104.GA9361@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209580>

On Tue, Nov 13, 2012 at 5:01 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 13, 2012 at 04:55:25AM +0100, Felipe Contreras wrote:
>
>> > No, it's not. Those broken names do not come from the environment, but
>> > from our last-resort guess of the hostname.
>>
>> That depends how you define environment, but fine, the point is that
>> it happens.
>
> If you have a strawman definition that does not have anything to do with
> what I said in my original email, then yes, it could happen.

It happens, I've seen commits with (none) not that long ago.

> But as I
> said already, "git var" uses IDENT_STRICT and will not allow such broken
> names.

Since 1.7.11, sure. But not everyone is using such a recent version of
git, and people with fully qualified domains would still get unwanted
behavior.

>> > We long ago switched to
>> > printing the name as a warning when we have made such a guess (bb1ae3f),
>> > then more recently started rejecting them outright (8c5b1ae).
>>
>> Right, but these would still happen:
>>
>> michael <michael@michael-laptop.michael.org>
>
> Did you read my email? I explicitly proposed that we would _not_ allow
> send-email to use implicit email addresses constructed in that way.

I'm not talking about git send-email, I'm talking about your comment
'it has always been the case that you can use git without setting
user.*', which has caused issues with wrong author/commmitter names in
commits, and will probably continue to do so.

>> > But in the meantime you are causing a regression for anybody who expects
>> > GIT_AUTHOR_NAME to override user.email when running git-send-email (and
>> > you have taken away the prompt that they could have used to notice and
>> > correct it).
>>
>> I think they can survive. If anybody like this exists.
>
> Sorry, but that is not how things work on this project. You do not get
> to cause regressions because you are too lazy to implement the feature
> _you_ want in a way that does not break other people.

That doesn't change the fact that they would survive, and the fact
that those users don't actually exist.

But let's look at the current situation closely:

PERL5LIB=~/dev/git/perl ./git-send-email.perl --confirm=always -1

1) No information at all

fatal: empty ident name (for <felipec@nysa.(none)>) not allowed

2) Full Name + full hostname

Who should the emails appear to be from? [Felipe Contreras
<felipec@nysa.felipec.org>]

That's right, ident doesn't fail, and that's not the mail address I
specified, it's *implicit*.

3) Full Name + EMAIL

Who should the emails appear to be from? [Felipe Contreras
<felipe.contreras@gmail.com>]

4) config user

Who should the emails appear to be from? [Felipe Contreras 2nd
<felipe.contreras+2@gmail.com>]

5) GIT_COMMITTER

Who should the emails appear to be from? [Felipe Contreras 2nd
<felipe.contreras+2@gmail.com>]

Whoa, what happened there?

Well:

  $sender = $repoauthor || $repocommitter || '';
  ($repoauthor) = Git::ident_person(@repo, 'author');
  % ./git var GIT_AUTHOR_IDENT
  Felipe Contreras 2nd <felipe.contreras+2@gmail.com> 1352783223 +0100

That's right, AUTHOR_IDENT would fall back to the default email and full name.

Hmm, I wonder...

5.1) GIT_COMMITER without anything else

fatal: empty ident name (for <felipec@nysa.(none)>) not allowed
var GIT_AUTHOR_IDENT: command returned error: 128

Why? Because:

% PERL5LIB=~/dev/git/perl perl -e 'use Git; printf("%s\n",
Git::ident_person(@repo, 'author'));'
fatal: empty ident name (for <felipec@nysa.(none)>) not allowed

($repoauthor) = Git::ident_person(@repo, 'author');
($repocommitter) = Git::ident_person(@repo, 'committer');

So $repoauthor || $repocommiter is pointless.

6) GIT_AUTHOR

Who should the emails appear to be from? [Felipe Contreras 4th
<felipe.contreras+4@gmail.com>]

What about after my change?

6.1) GIT_AUTHOR without anything else

fatal: empty ident name (for <felipec@nysa.(none)>) not allowed
var GIT_COMMITTER_IDENT: command returned error: 128

4) config user

From: Felipe Contreras 2nd <felipe.contreras+2@gmail.com>

5) GIT_COMMITTER

From: Felipe Contreras 2nd <felipe.contreras+2@gmail.com>

6) GIT_AUTHOR

From: Felipe Contreras 2nd <felipe.contreras+2@gmail.com>

And what about your proposed change?

2) Full Name + full hostname

./git var GIT_EXPLICIT_IDENT
0

6.1) GIT_AUTHOR without anything else

Even if the previous problem was solved:

export GIT_AUTHOR_NAME='Felipe Contreras 4th'; export
GIT_AUTHOR_EMAIL='felipe.contreras+4@gmail.com'
./git var GIT_EXPLICIT_IDENT
0

No explicit ident? This is most certainly not what the user would expect.

And then:

5.2) GIT_COMMITTER with Full Name and full hostname

export GIT_COMMITTER_NAME='Felipe Contreras 3nd'; export
GIT_COMMITTER_EMAIL='felipe.contreras+3@gmail.com'
./git var GIT_EXPLICIT_IDENT
1

From: Felipe Contreras <felipec@nysa.felipec.org>

It is explicit, yeah, but 'git send-email' would not be picking the
committer, it would pick the author.

> I tried to help you by pointing you in the right direction and even
> providing a sample "git var" patch.

Are you 100% sure that was the right direction?

I think the right approach is more along these lines:

--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -748,16 +748,11 @@ if (!$force) {
        }
 }

-my $prompting = 0;
 if (!defined $sender) {
        $sender = $repoauthor || $repocommitter || '';
-       $sender = ask("Who should the emails appear to be from? [$sender] ",
-                     default => $sender,
-                     valid_re => qr/\@.*\./, confirm_only => 1);
-       print "Emails will be sent from: ", $sender, "\n";
-       $prompting++;
 }

+my $prompting = 0;
 if (!@initial_to && !defined $to_cmd) {
        my $to = ask("Who should the emails be sent to (if any)? ",
                     default => "",
diff --git a/ident.c b/ident.c
index a4bf206..c73ba82 100644
--- a/ident.c
+++ b/ident.c
@@ -291,9 +291,9 @@ const char *fmt_ident(const char *name, const char *email,
        }

        if (strict && email == git_default_email.buf &&
-           strstr(email, "(none)")) {
+               !(user_ident_explicitly_given & IDENT_MAIL_GIVEN)) {
                fputs(env_hint, stderr);
-               die("unable to auto-detect email address (got '%s')", email);
+               die("no explicit email address");
        }

        if (want_date) {

With that we get:

2) Full Name + full hostname

fatal: no explicit email address

3) Full Name + EMAIL

From: Felipe Contreras <felipe.contreras@gmail.com>

4) config user

From: Felipe Contreras 2nd <felipe.contreras+2@gmail.com>

5) GIT_COMMITTER

From: Felipe Contreras 2nd <felipe.contreras+2@gmail.com>

(as buggy as before)

6) GIT_AUTHOR

From: Felipe Contreras 4th <felipe.contreras+4@gmail.com>

Not only will this fix 'git send-email', but it will also fix 'git
commit' so that we don't end up with authors such as 'Felipe Contreras
<felipec@nysa.felipec.org>' ever again.

> But it is not my itch to scratch.

Suit yourself, it's only git users that would get hurt. I can always
use my own 'git send-email' (as I am doing right now).

Cheers.

-- 
Felipe Contreras
