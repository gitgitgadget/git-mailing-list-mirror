Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8A11202F2
	for <e@80x24.org>; Fri, 24 Nov 2017 02:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbdKXCLD (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 21:11:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63807 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751502AbdKXCLC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 21:11:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F1290B4798;
        Thu, 23 Nov 2017 21:11:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=puifRGeCKwOJkcA8mJ0qK6SoViM=; b=cGmJDN
        Vd6tHDA+7O7uaFuRr3kveiz1YCfwWB2go5L6VWdp71mPkQhBJaC4JBoV8U8P+uRs
        lrqB3w9/C98PHWFI08KjYPN4rKfuvGJanquBEFOZS2g2jqx/Vx4+axKuqJPzgBJn
        UXOH9MzNKuNzF5CmP1DHrCyu/mybX47EyTxF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KCL0DOAtNEgOTkhQgJzxEbnfKjzhXzTs
        szfRc0wGYuR9AIUA7WGX2/5Ol3tQn7/vjJcajvRCfFRsgMbnMFD6wqrCLaPhvJqj
        bOFe7FwLJZYHV11NQIELz2qjoFA+Of/8iWXYAtaiCip6i0A9ClAQU2ezD4lsOZ51
        ZPXRIJnX/VU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8093AB4797;
        Thu, 23 Nov 2017 21:11:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C8496B4796;
        Thu, 23 Nov 2017 21:10:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Christoph Michelbach <michelbach94@gmail.com>
Subject: Re*: Documentation of post-receive hook
References: <1510872031.23230.7.camel@gmail.com>
        <xmqqpo8hu1fi.fsf@gitster.mtv.corp.google.com>
        <xmqq375dtwnr.fsf@gitster.mtv.corp.google.com>
        <1511112703.8109.5.camel@gmail.com>
        <xmqq1sktoiih.fsf@gitster.mtv.corp.google.com>
        <A82275FD-C9AC-4632-A5E8-ED86CE2AC67D@gmail.com>
        <xmqqlgizyv0o.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 24 Nov 2017 11:10:58 +0900
In-Reply-To: <xmqqlgizyv0o.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 22 Nov 2017 10:14:31 +0900")
Message-ID: <xmqqlgiwpgst.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6DBD6F2-D0BC-11E7-A759-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Your suggesting to mention that particular message hints at me that
> you feel that the users may not necessarily understand that push did
> not result in any update of references on the other side when they
> see it.  If the message was clear enough to them, "when it reacts to
> push and updates" ought to be clear enough description, too.
>
> And if that indeed is the case (and I would not be surprised if it
> is, but I suspect that most users are clueful enough), it is not the
> documentation, but the "Already up-to-date" message, that needs to
> be clarified, no?

I do not know if it helps to _also_ clarify the message, but at
least, let's tie the loose end by updating the documentation.

-- >8 --
Subject: hooks doc: clarify when receive-pack invokes its hooks

The text meant to say that receive-pack runs these hooks, and only
because receive-pack is not a command the end users use every day
(ever), as an explanation also meantioned that it is run in response
to 'git push', which is an end-user facing command readers hopefully
know about.

This unfortunately gave an incorrect impression that 'git push'
always result in the hook to run.  If the refs push wanted to update
all already had the desired value, these hooks are not run.  

Explicitly mention "... and updates reference(s)" as a precondition
to avoid this ambiguity.

Helped-by: Christoph Michelbach <michelbach94@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Documentation/githooks.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 9565dc3fda..8f6a3cd63e 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -222,8 +222,8 @@ to the user by writing to standard error.
 pre-receive
 ~~~~~~~~~~~
 
-This hook is invoked by 'git-receive-pack' on the remote repository,
-which happens when a 'git push' is done on a local repository.
+This hook is invoked by 'git-receive-pack' when it reacts to
+'git push' and updates reference(s) in its repository.
 Just before starting to update refs on the remote repository, the
 pre-receive hook is invoked.  Its exit status determines the success
 or failure of the update.
@@ -260,8 +260,8 @@ will be set to zero, `GIT_PUSH_OPTION_COUNT=0`.
 update
 ~~~~~~
 
-This hook is invoked by 'git-receive-pack' on the remote repository,
-which happens when a 'git push' is done on a local repository.
+This hook is invoked by 'git-receive-pack' when it reacts to
+'git push' and updates reference(s) in its repository.
 Just before updating the ref on the remote repository, the update hook
 is invoked.  Its exit status determines the success or failure of
 the ref update.
@@ -305,8 +305,8 @@ unannotated tags to be pushed.
 post-receive
 ~~~~~~~~~~~~
 
-This hook is invoked by 'git-receive-pack' on the remote repository,
-which happens when a 'git push' is done on a local repository.
+This hook is invoked by 'git-receive-pack' when it reacts to
+'git push' and updates reference(s) in its repository.
 It executes on the remote repository once after all the refs have
 been updated.
 
@@ -344,8 +344,8 @@ will be set to zero, `GIT_PUSH_OPTION_COUNT=0`.
 post-update
 ~~~~~~~~~~~
 
-This hook is invoked by 'git-receive-pack' on the remote repository,
-which happens when a 'git push' is done on a local repository.
+This hook is invoked by 'git-receive-pack' when it reacts to
+'git push' and updates reference(s) in its repository.
 It executes on the remote repository once after all the refs have
 been updated.
 
@@ -375,8 +375,8 @@ for the user.
 push-to-checkout
 ~~~~~~~~~~~~~~~~
 
-This hook is invoked by 'git-receive-pack' on the remote repository,
-which happens when a 'git push' is done on a local repository, when
+This hook is invoked by 'git-receive-pack' when it reacts to
+'git push' and updates reference(s) in its repository, and when
 the push tries to update the branch that is currently checked out
 and the `receive.denyCurrentBranch` configuration variable is set to
 `updateInstead`.  Such a push by default is refused if the working
