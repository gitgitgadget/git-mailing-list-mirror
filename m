Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BABC433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D92961355
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbhELXyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:54:07 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:60013 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349580AbhELXf1 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 12 May 2021 19:35:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0BF931ACF;
        Wed, 12 May 2021 19:34:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 12 May 2021 19:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-type
        :content-transfer-encoding; s=fm3; bh=sHmpoNCVJZU9xtFuxG0r0iQXJz
        BUBXLW184yYtjiGm8=; b=V5mCuznXPszXxWbapnrUQjaTO2XNtgGMIl3wBIsVl9
        J1aLt2KcuDF0q59QoPKcnNvGcMDEmlbnbaeOhjTjvFOHGWohrGEuFXB4SuMNoFLh
        Z3rX59FgMugIUrfyFJcP3/Wu4kEMI3RCzGSCcv5ikuToBob8NOzhCgXEfZwV0g3f
        pFwqSXAegd3RH/2ISmxo49FTxZH+iYW8dO+r9XJDGYwb8Io2Poub8qQhjNS6Btr2
        VC55Z7yzQg0SBrSj3r2pG66QlB/SULmyR0Rv5nlakC36mzA2uTHELqrBBergR0Kt
        NRv/dPY8XQb/2+u7pm2lpmtEPwnv+RSbbjRJkvDPAGJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=sHmpoNCVJZU9xtFuxG0r0iQXJzBUBXLW184yYtjiG
        m8=; b=tLc5jfuy6jbxbFpTep5J0i/DDGlUmqs+HU5FN6Rb5jSy+SFo87YHVWKx0
        mqEg2A12+F3RC9cRRiakO4VYb3FdBOzj6gkz95J53u6AsalmBblpyYOjuDGQVSdV
        ek+y21cMSwd6yUPqIZOCGc5VaJQmohXaKQEkBuPkhvLsUlvuTWxqu90FcvRGnGqk
        pGwmJVVBb47soKqqgmdeijV0BQD11DfekEF+7TslDT8QZExEGln/p4x3xIipQFAP
        JugW3pB32YXjP3OmiaJ1Ywuc/pi7D9bFFC9wXf8gPu2NX9ThLvriORJKkfKKGKJu
        TYPF9E4eno9dUxDQzmvnGRn6qc9vg==
X-ME-Sender: <xms:92WcYMVpIDkLug6B6j_TsZnhJ7QjdFSepZpbvuVQWg919FhBRU_XSw>
    <xme:92WcYAkjZhE7_Ab8quymtKmxKMlGU3SW_03U9xIzunxe8L9wGRnAPv2VW3Re3Eqoy
    b-NpyMtIit8-fy2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehfedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhggtgfgsehtke
    ertdertdejnecuhfhrohhmpeffrghvvgcujfhushgvsgihuceougifhheslhhinhhugihp
    rhhoghhrrghmmhgvrhdrohhrgheqnecuggftrfgrthhtvghrnhepkeffvefffedvtdejve
    eggeeiudfhudefudfffffgkeejueekvdelvedtiefhgfelnecuffhomhgrihhnpehfrhgv
    vghnohguvgdrnhgvthenucfkphepudejgedrhedvrdduhedrfeejnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugifhheslhhinhhugihprhho
    ghhrrghmmhgvrhdrohhrgh
X-ME-Proxy: <xmx:92WcYAZZoz1OaGplCXii0yTMZWi5RMtDGzHdC14qaqRoZrLTAMVUKQ>
    <xmx:92WcYLW384p_rNLVH0i_X7IdTjWqRoYKMWgfHCE3rMftum-DKt15_g>
    <xmx:92WcYGma8a2wxQwU3GR4S207b1K-zHmHfspkrT1XsDCJPp9pZadjvA>
    <xmx:-GWcYNuqGF8p7AQmdOe7Cbr5OfSoGklUiUjqYy38ywd3Xn0uJSJQog>
Received: from linuxprogrammer.org (c-174-52-15-37.hsd1.ut.comcast.net [174.52.15.37])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Wed, 12 May 2021 19:34:14 -0400 (EDT)
From:   Dave Huseby <dwh@linuxprogrammer.org>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, felipe.contreras@gmail.com,
        gitster@pobox.com, stefanmoch@mail.de, philipoak@iee.email,
        bagasdotme@gmail.com, sunshine@sunshineco.com, avarab@gmail.com
Subject: [PATCH v3] doc: writing down Git mailing list etiquette
Date:   Wed, 12 May 2021 16:34:12 -0700
Message-Id: <20210512233412.10737-1-dwh@linuxprogrammer.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210512031821.6498-2-dwh@linuxprogrammer.org>
References: <20210512031821.6498-2-dwh@linuxprogrammer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After violating a few unspoken etiquette rules while submitting patches
to the Git mailing list, it was suggeted that somebody write a guide.
Since I was the latest cause of this perenial discussion, I took it upon
myself to learn from my mistakes and document the Git mailing list
etiquette and the fixes I made to my email setup.

* Add documentation specifically on Git mailing list etiquette
* Add alternative actions for patches that receive no response.
* Add section on submitting a final, merge-ready patch.
* Add section on Mutt MUA settings.

Reported-by: Christian Couder <christian.couder@gmail.com>
Reported-by: Filipe Contreras <felipe.contreras@gmail.com>
Thanks-to: Junio C Hamano <gitster@pobox.com>
Thanks-to: Philip Oakley <philipoakley@iee.email>
Thanks-to: Bagas Sanjaya <bagasdotme@gmail.com>
Thanks-to: Eric Sunshine <sunshine@sunshineco.com>
Thanks-to: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Dave Huseby <dwh@linuxprogrammer.org>
---
 Documentation/MailingListEtiquette.txt | 93 ++++++++++++++++++++++++++
 Documentation/SubmittingPatches        | 74 +++++++++++++++++++-
 2 files changed, 166 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/MailingListEtiquette.txt

diff --git a/Documentation/MailingListEtiquette.txt b/Documentation/MailingListEtiquette.txt
new file mode 100644
index 0000000000..8a383f81a8
--- /dev/null
+++ b/Documentation/MailingListEtiquette.txt
@@ -0,0 +1,93 @@
+Mailing List Etiquette
+======================
+
+[[introduction]]
+== Introduction
+
+The Git project uses a mailing list and email to coordinate development and
+submit patches. Many other open source projects use web-based forums and pull
+requests (PRs) to achieve the same thing. This article focuses entirely on the
+Git project and the etiquette and unspoken rules that have developed over the
+years. What follows are best practices and suggestions for the "proper" way to
+interact via email on the Git mailing list.
+
+If you are looking for details on how to submit a patch, that is documented
+elsewhere in:
+
+- `Documentation/SubmittingPatches`
+- `Documentation/MyFirstContribution.txt`
+
+[[proper-use-of-to-and-cc]]
+== Proper Use of To and Cc
+
+The "To:" field is the place to list the people you want to directly interact
+with and request responses from and the "Cc:" field is for other people that
+you wish to inform of this conversation. Everybody is welcome to chime in on
+the thread. When there is no particular person you wish to talk to, the mailing
+list address is a good catch-all addres to reach everybody and should be put in
+the "To:" field.
+
+When replying to an email on the mailing list, put the person you are replying
+to in the "To:" field and all other people in the thread in the "Cc:" field,
+including the mailing list address.
+
+The motivation for the above suggestions is to allow recipients to prioritize
+their incoming messages; they can direct their immediate attention to those
+messages with their names on the "To:" field and the ones with their names on
+the "Cc:" field can wait.
+
+Make sure to keep everyone involved in the "Cc:" field so that they do not have
+to be subscribed to the mailing list to receive replies.
+
+[[proper-use-of-subject]]
+== Proper Use of the Subject
+
+When replying to an email on the list, make sure that the subject of the
+original email is the subject of your email with "Re:" added to it. So if
+you reply to an email with subject "first post", the subject of your email
+should be "Re: first post".
+
+Sometimes email threads diverge into other threads about related, but distinct
+topics. In those cases, the subject like should change to the new topic and
+include in parenthesis "(Was: <original thread subject>)". So for instance,
+if a side thread is created from the "first post" thread example, the subject
+line should be something like "second post (was: first post)" with replies
+having the subject "Re: second post (was: first post)".
+
+[[use-interleaved-style]]
+== Use Interleaved Style in Replies
+
+> A: Because it messes up the order in which people normally read text.
+> Q: Why is top-posting such a bad thing?
+> A: Top-posting.
+> Q: What is the most annoying thing in email?
+
+When replying to emails, use interleaved style which is also sometimes called
+an "inline reply". This creates a natural flow for the reader of the reply. They
+can easily see what the context for the reply is. Also leave only the context
+that is important for your reply and delete the rest.
+
+[[do-not-use-mail-followup-to]]
+== Do Not Use Mail-Followup-To
+
+When posting to the mailing list, your email client might add a
+"Mail-Followup-To:" field containing all of the recipients, including the
+mailing list address, but not the sender's email address. This is intended to
+prevent the sender from receiving replies twice, once from the replying person
+and again from the mailing list.
+
+This goes directly against the desired "To:" and "Cc:" etiquette (see "Proper
+Use of To and Cc" above) because "Reply to all"/"group reply" will redirect the
+response to all of the people in the original "Cc:" field instead of going to
+the person who sent the message being responded to.
+
+Some email clients, such as Mutt (see Disable Mail-Followup-To in the Mutt
+section below) are configured by default to add "Mail-Followup-To:" fields and
+to honor existing "Mail-Followup-To:" fields. It is best to disable both.
+
+[[enable-plain-text-mode]]
+== Enable Plain Text Mode
+
+The Git mailing list software rejects email sent in text/html format. It is
+important that your email client is set to create text/plain emails to ensure
+delivery.
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 55287d72e0..4f8b9f24ee 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -433,7 +433,7 @@ help you find out who they are.
 
 In any time between the (2)-(3) cycle, the maintainer may pick it up
 from the list and queue it to `seen`, in order to make it easier for
-people play with it without having to pick up and apply the patch to
+people to play with it without having to pick up and apply the patch to
 their trees themselves.
 
 [[patch-status]]
@@ -450,6 +450,46 @@ their trees themselves.
   entitled "What's cooking in git.git" and "What's in git.git" giving
   the status of various proposed changes.
 
+[[patches-that-receive-no-response]]
+== Patches that Receive No Response
+
+If you sent a patch and you did not hear any response from anybody for
+several days, it could be that your patch was totally uninteresting,
+but it also is possible that it was simply lost in the noise.  Please
+do not hesitate to send a reminder message in such a case.  Messages
+getting lost in the noise may be a sign that those who can evaluate
+your patch don't have enough mental/time bandwidth to process them
+right at the moment, and it often helps to wait until the list traffic
+becomes calmer before sending such a reminder.
+
+Alternatives to sending direct reminders are:
+
+* Wait for the next "What's cooking in git.git" email to see if your patch
+  series was mentioned and replying to that email with a note pointing out that
+  your patch series has been overlooked.
+
+* Attend the weekly "stand-up" meeting held in the "#git-devel" channel on
+  irc.freenode.net and bring it up then.
+
+[[send-merge-ready-patches-to-the-maintainer]]
+== Send Merge-Ready Patches to the Maintainer
+
+Once a patch has achieved consensus and all stakeholders are satisfied and
+everything is ready for merging, you have two main options for getting your
+patch noticed by the maintainer.
+
+1. Submit a new, final, version of the patch with an accurate list of commit
+   trailers. Make this submission "To:" the maintainer, "In-Reply-To:" the
+   previous version of the patch, and add everybody concerned, including the
+   mailing list address to the "Cc:" field. This is a nice way to reduce the
+   amount of work the maintainer must do to merge the patch while also getting
+   their attention.
+
+2. Creating a "group reply"/"Reply to all" email to the latest patch series
+   with the maintainer in the "To:" field. This is sometimes referred to as a
+   "review ping" email and is appropriate if the patch requires no more work
+   and is in its final state with an accurate list of commit trailers.
+
 [[travis]]
 == GitHub-Travis CI hints
 
@@ -510,6 +550,38 @@ first patch.\n", if you really want to put in the patch e-mail,
 should come after the three-dash line that signals the end of the
 commit message.
 
+=== Mutt
+
+[[known-mailing-lists]]
+==== Known Mailing Lists
+
+Mutt has the ability to change its behavior when replying to a mailing list. You
+must specify mailing list addresses using the `subscribe` keyword in your Mutt
+configuration:
+
+**~/.muttrc:**
+```
+# tell Mutt about the Git mailing list
+subscribe git@vger.kernel.org
+```
+
+[[disable-mail-followup-to]]
+==== Disable Mail-Followup-To
+
+By default, when replying to mailing lists, Mutt automatically generates
+"Mail-Followup-To:" fields. To fix this, disable the generation of the field
+in your Mutt configuration. It is also a good idea to disable honoring any
+"Mail-Followup-To:" field so that your "group reply" operations are correctly
+addressed.
+
+**~/.muttrc:**
+```
+# disable Mail-Followup-To header
+unset followup_to
+
+# disable honoring Mail-Followup-To header
+unset honor_followup_to
+```
 
 === Pine
 
-- 
2.20.1

