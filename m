Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E6FC433E0
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 20:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D767A2067D
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 20:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MhUp/2Kj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgGAUWi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 16:22:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52483 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgGAUWh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 16:22:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B0B7FC0B72;
        Wed,  1 Jul 2020 16:22:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ph7r7UOfeyAj0lMa4aRFcKgRFXY=; b=MhUp/2
        KjAhtZ85TsSPwi7SMT3OzPkNZwYw/ZgWX8viXhmLMGcszkqqpkycBmA3T2MDgFes
        A0aAnZHG0JbDB07KSg0KD2FdwBqKjkhcKQZku5uPIVNo/KP8mO+T2ctSkabz06ha
        KwAM5iMvNQDtnmeSZ4gsLhSxX6u3pHyprOVWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o3kmKNvYsGb/eBlsc8D871tGP7jnG6fw
        HLXiiSkIB6nYnQJ6EF5FAho09pB19fbDL/MI4skB/TaqQDHM1z4wpmSIneZWWFDE
        DQR0PpjHo8EXs063RlANZjlYrwA70iCaoWuJ5t/INksIrebsklN5nGAuwlS9Vcng
        vimmw4BMrpQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A80CAC0B71;
        Wed,  1 Jul 2020 16:22:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E9739C0B70;
        Wed,  1 Jul 2020 16:22:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwenn@gmail.com>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re* [PATCH v19 03/20] checkout: add '\n' to reflog message
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
        <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <125695ce92218ca2ddb9868880db542acb0d2a79.1593457018.git.gitgitgadget@gmail.com>
        <xmqqmu4lfxet.fsf@gitster.c.googlers.com>
        <CAFQ2z_MuD0e+a_r0_-GMpjr1mV==hdh2=0gyVrT7f8tDbXC6xQ@mail.gmail.com>
        <xmqqftacds2a.fsf@gitster.c.googlers.com>
        <CAOw_e7bcfUyumKkQRubf=zg6zso4pOtiC8-6d8qQiVL7vyfCog@mail.gmail.com>
Date:   Wed, 01 Jul 2020 13:22:26 -0700
In-Reply-To: <CAOw_e7bcfUyumKkQRubf=zg6zso4pOtiC8-6d8qQiVL7vyfCog@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 1 Jul 2020 18:56:34 +0200")
Message-ID: <xmqqr1tvc7el.fsf_-_@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9542CD16-BBD8-11EA-9015-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwenn@gmail.com> writes:

> On Wed, Jul 1, 2020 at 1:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>> > I initially thought we could or should fix this across git-core, but I
>> > think it will be a lot of work to find all occurrences.
>>
>> I think we are on the same page, even if the definition of which is
>> correct might be different between us.  As long as all the refs
>
> Right. The practical upshot of this is that I should drop this patch, though.

I guess we are on the same page on that one, too, even if our
definition of which side is up and which side is down may be
different ;-)

I think this can be dropped, as it does not even try to enforce "all
reflog message arguments must end with LF".

At the same time, we would need to make sure that reftable backend
cleanses the reflog message the callers of refs API supplies the
same way as the files backend.  In short, if a series of Git
operations that accumulate records in a reflog are performed with
either the files or the reftable backend, "git log -g" and other
forms to retrieve these messages should produce identical results
from both backends.

What I observed during this review was:

 - We expect that a reflog message consists of a single line.  The
   file format used by the files backend may add a LF after the
   message as a delimiter, and output by commands like "git log -g"
   may complete such an incomplete line by adding a LF at the end,
   but philosophically, the terminating LF is not a part of the
   message.

 - We however allow callers of refs API to supply a random sequence
   of NUL terminated bytes.  We cleanse caller-supplied message by
   squasing a run of whitespaces into a SP, and by trimming trailing
   whitespace, before storing the message.  This is how we tolerate,
   instead of erring out, a message with LF in it (be it at the end,
   in the middle, or both).

Currently, the cleansing of the reflog message is done by the files
backend, before the log is written out.  This is sufficient with the
current code, as that is the only backend that writes reflogs.  But
new backends can be added that write reflogs, and we'd want the
resulting log message we would read out of "log -g" the same no
matter what backend is used.

For that, we could force each new ref backend implementation to call
the same cleansing helper, but instead why not do the cleansing at
the backend agnostic way in refs.c layer?  That would be less error
prone.

An added benefit is that the "cleansing" function could be updated
later, independent from individual backends, to e.g. allow
multi-line log messages if we wanted to, and when that happens, it
would help a lot to ensure we covered all bases if the cleansing
function (which would be updated) is called from the generic layer.

	Side note: I am not interested in supporting multi-line
	reflog messages right at the moment (nobody is asking for
	it), but I envision that instead of the "squash a run of
	whitespaces into a SP and rtrim" cleansing, we can
	%urlencode problematic bytes in the message *AND* append a
	SP at the end, when a new version of Git that supports
	multi-line and/or verbatim reflog messages writes a reflog
	record.  The reading side can detect the presense of SP at
	the end (which should have been rtrimmed out if it were
	written by existing versions of Git) as a signal that
	decoding %urlencode recovers the original reflog message.

In any case, a patch that moves the existing "squash SPs and rtrim"
cleansing from the files backend to the generic layer may look like
the attached patch.  We can add reftable backend on top of a change
like this one and then we do not have to worry about each backend
cleansing the incoming reflog messages the same way.  Nice?

Thanks.

 refs.c               | 50 +++++++++++++++++++++++++++++++++++++++++---------
 refs/files-backend.c |  2 +-
 refs/refs-internal.h |  6 ------
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/refs.c b/refs.c
index 224ff66c7b..75a0cda68a 100644
--- a/refs.c
+++ b/refs.c
@@ -870,7 +870,7 @@ int delete_ref(const char *msg, const char *refname,
 			       old_oid, flags);
 }
 
-void copy_reflog_msg(struct strbuf *sb, const char *msg)
+static void copy_reflog_msg(struct strbuf *sb, const char *msg)
 {
 	char c;
 	int wasspace = 1;
@@ -887,6 +887,15 @@ void copy_reflog_msg(struct strbuf *sb, const char *msg)
 	strbuf_rtrim(sb);
 }
 
+static char *normalize_reflog_message(const char *msg)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (msg && *msg)
+		copy_reflog_msg(&sb, msg);
+	return strbuf_detach(&sb, NULL);
+}
+
 int should_autocreate_reflog(const char *refname)
 {
 	switch (log_all_ref_updates) {
@@ -1092,7 +1101,7 @@ struct ref_update *ref_transaction_add_update(
 		oidcpy(&update->new_oid, new_oid);
 	if (flags & REF_HAVE_OLD)
 		oidcpy(&update->old_oid, old_oid);
-	update->msg = xstrdup_or_null(msg);
+	update->msg = normalize_reflog_message(msg);
 	return update;
 }
 
@@ -1951,9 +1960,14 @@ int refs_create_symref(struct ref_store *refs,
 		       const char *refs_heads_master,
 		       const char *logmsg)
 {
-	return refs->be->create_symref(refs, ref_target,
-				       refs_heads_master,
-				       logmsg);
+	char *msg;
+	int retval;
+
+	msg = normalize_reflog_message(logmsg);
+	retval = refs->be->create_symref(refs, ref_target,
+					 refs_heads_master, msg);
+	free(msg);
+	return retval;
 }
 
 int create_symref(const char *ref_target, const char *refs_heads_master,
@@ -2268,10 +2282,16 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 	return refs->be->initial_transaction_commit(refs, transaction, err);
 }
 
-int refs_delete_refs(struct ref_store *refs, const char *msg,
+int refs_delete_refs(struct ref_store *refs, const char *logmsg,
 		     struct string_list *refnames, unsigned int flags)
 {
-	return refs->be->delete_refs(refs, msg, refnames, flags);
+	char *msg;
+	int retval;
+
+	msg = normalize_reflog_message(logmsg);
+	retval = refs->be->delete_refs(refs, msg, refnames, flags);
+	free(msg);
+	return retval;
 }
 
 int delete_refs(const char *msg, struct string_list *refnames,
@@ -2283,7 +2303,13 @@ int delete_refs(const char *msg, struct string_list *refnames,
 int refs_rename_ref(struct ref_store *refs, const char *oldref,
 		    const char *newref, const char *logmsg)
 {
-	return refs->be->rename_ref(refs, oldref, newref, logmsg);
+	char *msg;
+	int retval;
+
+	msg = normalize_reflog_message(logmsg);
+	retval = refs->be->rename_ref(refs, oldref, newref, msg);
+	free(msg);
+	return retval;
 }
 
 int rename_ref(const char *oldref, const char *newref, const char *logmsg)
@@ -2294,7 +2320,13 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
 		    const char *newref, const char *logmsg)
 {
-	return refs->be->copy_ref(refs, oldref, newref, logmsg);
+	char *msg;
+	int retval;
+
+	msg = normalize_reflog_message(logmsg);
+	retval = refs->be->copy_ref(refs, oldref, newref, msg);
+	free(msg);
+	return retval;
 }
 
 int copy_existing_ref(const char *oldref, const char *newref, const char *logmsg)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6516c7bc8c..e0aba23eb2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1629,7 +1629,7 @@ static int log_ref_write_fd(int fd, const struct object_id *old_oid,
 
 	strbuf_addf(&sb, "%s %s %s", oid_to_hex(old_oid), oid_to_hex(new_oid), committer);
 	if (msg && *msg)
-		copy_reflog_msg(&sb, msg);
+		strbuf_addstr(&sb, msg);
 	strbuf_addch(&sb, '\n');
 	if (write_in_full(fd, sb.buf, sb.len) < 0)
 		ret = -1;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 4271362d26..357359a0be 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -96,12 +96,6 @@ enum peel_status {
  */
 enum peel_status peel_object(const struct object_id *name, struct object_id *oid);
 
-/*
- * Copy the reflog message msg to sb while cleaning up the whitespaces.
- * Especially, convert LF to space, because reflog file is one line per entry.
- */
-void copy_reflog_msg(struct strbuf *sb, const char *msg);
-
 /**
  * Information needed for a single ref update. Set new_oid to the new
  * value or to null_oid to delete the ref. To check the old value


