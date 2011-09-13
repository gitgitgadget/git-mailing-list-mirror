From: Junio C Hamano <gitster@pobox.com>
Subject: [Survey] Signed push
Date: Tue, 13 Sep 2011 09:45:37 -0700
Message-ID: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Tue Sep 13 18:45:48 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1R3W7I-0003E1-0u
	for glk-linux-kernel-3@lo.gmane.org; Tue, 13 Sep 2011 18:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755663Ab1IMQpo (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 13 Sep 2011 12:45:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35906 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755635Ab1IMQpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2011 12:45:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C4F658D9;
	Tue, 13 Sep 2011 12:45:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=C
	M7NCRZQFMmedJQWCR7iVbfQ9ZU=; b=cqGVrzzsqt0zPo6ShPfk5F00P2BHYEwJl
	WC0UIojDH/N8Zr/ZpCSyEQB5w8Uxr2xtBeEQEKUqiSE+loxSauMtuImh3ncWgo1r
	M03nDaECgfdxAUoLcItxudz0AkmJgDlMlYkjAwZX8j4ZRSZUeuzLxBxNdt2hAdLl
	F51eADEkcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=LdJpX9hAGmF3NHKF3G2xzxdfYfsKvy78Z2Mka8nWxyrgyd4QOWD3hFBW
	XqdzRnM6YMmT/JSrpuXArTTC0VgoXv7+GkrqYMvAoE0qUzkaZMIBTKFtyHfwYpl8
	CQJTFDCQf4in5kb85NBS4rXMKUXZwfePzWfa5EUiKVspZnNCNYs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 835E158D8;
	Tue, 13 Sep 2011 12:45:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C379A58D7; Tue, 13 Sep 2011
 12:45:39 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D08DC6E8-DE27-11E0-8EFE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181291>

[administrivia] This message is also Cc'ed to the kernel mailing list in
order to ask for opinions from members of one of the most important user
communities of Git, but people may want to drop the kernel list when
responding to this message to reduce the noise level over there. Thanks.

In the light of what happened to k.org recently, we've been discussing
things Git can do to help raising confidence levels perceived by the
general public on integrity of the source trees, especially for the kernel
community. As the article by Jonathan Corbet on lwn.net nicely described,
projects managed with Git are already pretty resistant from tampering, and
it is not my (nor anybody in the Git community's) intention to propose any
more unnecessary bureaucracy to the development process without merit.

There are two updates that may change the end user experience I would like
to ask your opinions on, both as the Git designer (emeritus?) and as the
top kernel developer.


1. Improved pull requests.

Currently a typical pull-request begins like this:

    The following changes since commit f696543dad6c7ba27b0c4fab167a5687263a9ba0:

      Flobar 2.4.3 (2011-09-13 12:34:56 +0900)

    are available in the git repository at:
      git://git.kernel.org/pub/flobar.git/ master

which is followed by the shortlog and expected diffstat.  This tells you
where the requester based his work on in excruciating detail, but does not
tell you what you should expect to fetch, any more than "whatever happened
to be at the named branch when you happened to notice the request."

We have a tentative patch to add an extra line after the "URL branch" line
that is for your cut & paste that looks like:

    are available in the git repository at:
      git://git.kernel.org/pub/flobar.git/ master
    for you to fetch changes up to 5738c9c21e53356ab5020912116e7f82fd2d428f

I often see you respond to a pull request on the kernel mailing list with
"I see nothing new; forgot to push?", and having this extra line may also
help communication.

Would it be just an added and useless noise that you nor your requesters
would not care much about?

An alternative that I am considering is to let the requester say this
instead:

    are available in the git repository at:
      git://git.kernel.org/pub/flobar.git/ 5738c9c21e53356ab5020912116e7f82fd2d428f

without adding the extra line.

That is, to allow fetching the history up to an explicitly named commit
object. This would only involve a change to fetch-pack at the receiving
end; just match the commit object name given from the command line against
the ls-remote response and ask upload-pack to give the history leading to
it. The released versions of Git already will happily oblige, as long as
the commit object named in the request message still sits at the tip of
the intended branch.

Do you think it is worthwhile to pursue this alternative?


2. Signed pushes.

You tag official releases and release candidates with your GPG key, and
everybody who works within the kernel ecosystem trusts the history behind
the commits pointed by them, but there is no easy way to verify that
commits and merges between the last tagged commit and the tip of your
branch(es) are indeed from you, or if an intruder piled fake ones on top
of your commits (until you try to push again and discover that the history
does not fast-forward, that is).

We have been discussing an addition of "git push -s" to let people sign
their pushes (instead of having to sign every commit or add signed
tag). The implementation alternatives were being bikeshed but not of much
interest in this message, but the user experience would go like this:

 * You push out your work with "git push -s";

 * "git push" prepares a "push certificate" (it is meant to certify "these
   are the commits I place at the tips of these refs"), which is a human
   and machine readable text file in core, that may look like this:

        Push-Certificate-Version: 0
        Pusher: Junio C Hamano <gitster@pobox.com>
        Update: 3793ac56b4c4f9bf0bddc306a0cec21118683728 refs/heads/master
        Update: 12850bec0c24b529c9a9df6a95ad4bdeea39373e refs/heads/next

   and asks you to GPG sign it. You only unlock your GPG key and the
   command internally runs GPG, just like "tag -s".

 * When "git push" finishes, the receiving end has this record in its
   refs/notes/signed-push notes tree, together with your previous pushes
   (as this is not a shared repository, it will record only your pushes).
   The notes annnotate the commits named on the "Update:" lines above.

 * People who want to verify commits that are not yet tagged near the tip
   in their clone of your tree can fetch refs/notes/signed-push and run

     $ git log --show-notes=signed-push --branches --not --tags

   to see your push certificates as annotations on commits that are not
   yet tagged. They can verify them using a tool (yet to be written) that
   acts like "git tag --verify".

It is hoped that it would help downstream with warm and fuzzy assurances
that all commits including the ones that are not yet tagged are genuine
(disclaimer: my employer is among the "downstream" that wants to have that
warm and fuzzy assurance) if we can see these push certificates published
at your public repository.

A few questions.

 * As a user, do you think "signed push" is a good idea, or is it merely
   an unnecessary bureaucracy, having to sign all pushes?

 * As a user, do you think it is a good thing that you could also verify
   the commits you receive from the Git-managed repositories of your
   lieutenants using this mechanism, or you wouldn't bother, perhaps
   because you are applying many patches sent via unsigned e-mail from
   Andrew anyway?

 * If the answers to the above points are both "yes", do you think it
   would make sense to also propagate the push certificates you obtain
   from your lieutenants to your public repository when you make your
   "push -s"? It will allow your downstream to follow the chain of trust
   in one-go (if you are pulling from public places, they can fetch the
   push certificates from your lieutenants themselves and merge them, so
   this is merely a convenience feature) by simply fetching from the
   refs/notes/signed-push notes tree from your public repository.  Do you
   think it is a useful and worthwhile thing to do?
