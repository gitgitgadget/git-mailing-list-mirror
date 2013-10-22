From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFE: support change-id generation natively
Date: Tue, 22 Oct 2013 13:43:17 -0700
Message-ID: <xmqqppqxrq8q.fsf@gitster.dls.corp.google.com>
References: <2127507934.9293293.1382367063640.JavaMail.root@openwide.fr>
	<201310212029.01589.thomas@koch.ro>
	<1382380858.25852.36711509.53CF173C@webmail.messagingengine.com>
	<201310211249.49568.mfick@codeaurora.org>
	<xmqqy55lrsoo.fsf@gitster.dls.corp.google.com>
	<871B6C10EBEFE342A772D1159D1320855772CBAD@umechphj.easf.csd.disa.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "james.moger\@gitblit.com" <james.moger@gitblit.com>,
	Thomas Koch <thomas@koch.ro>,
	Jeremy Rosen <jeremy.rosen@openwide.fr>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>,
	Martin Fick <mfick@codeaurora.org>
To: "Pyeron\, Jason J CTR \(US\)" <jason.j.pyeron.ctr@mail.mil>
X-From: git-owner@vger.kernel.org Tue Oct 22 22:43:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYinU-00052F-Ji
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 22:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015Ab3JVUnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 16:43:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40874 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754828Ab3JVUnU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 16:43:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78BB34C8F1;
	Tue, 22 Oct 2013 20:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y07rh1wVgqmlkCYQO5ajMUgErvs=; b=fTEh6c
	mHl3pXwy5ZtazM9VErwxpA/3VXQoueDUNuPw/IkQR8kSi0qZYJBbyqoVb6aIiSXy
	6U7Qhx7v+kMF+Jl/+vuJIfxL03+krJnT6kWIk8+hLNY1Z5LYfRcpis6CGRKESuLD
	tk7pS7siOiXIoa5YidSj1PmGyw/Aa0Fe45obo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZRnyljnY7cNfzpka9QiEJroVFhbQ7HUR
	73AxZi9m5gwbHJy20tGgpVkXiGlc+nQ4LzuqJHEIAD5Ynm0tNOFXfjkiQ8NI6slG
	le6R8s6HlD2il68EyKPK1DqbeQQ44pbImKO57y1EtE1XnmkTXVD/ZNUKUXms4h6W
	XEpzU/ToChA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 670B94C8F0;
	Tue, 22 Oct 2013 20:43:19 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B5AB4C8E9;
	Tue, 22 Oct 2013 20:43:18 +0000 (UTC)
In-Reply-To: <871B6C10EBEFE342A772D1159D1320855772CBAD@umechphj.easf.csd.disa.mil>
	(Jason J. Pyeron's message of "Tue, 22 Oct 2013 20:06:05 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 952EDBB8-3B5A-11E3-829B-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236489>

"Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil> writes:

>> -----Original Message-----
>> From: Junio C Hamano
>> Sent: Tuesday, October 22, 2013 3:51 PM
>> 
>
>
> <snip/>
>
>> I would think.  You might have a funny chicken-and-egg problem with
>> the signed commit, though.  I didn't think that part through.
>
> Respectfully, I do not think there is a chicken and egg situation
> here. Either the user has included a generated id field and value
> in the portion covered by the signature, or the mutation of the
> portion covered by the signature has been modified, hence has an
> invalid signature.
>
> Any user signing their commit, should ensure it is the last
> operation, or be prepared to resign it later.

Thanks, I think I got what you are saying.

I was coming from the existing code, assuming that you have a single
commit without Change Id but has already called do_sign_commit().
That is what the users today will get out of "commit -S".  But using
the object name of such a commit as the Change Id, and then creating
a new commit by appending a new Change Id trailer will not work, as
that will break the existing signature.

But you can begin from a single commit without Change Id and without
signature---its object name would be the Change Id.  You can add a
new Change Id trailer to record that and sign it while creating a
commit.  It conceptually may be a three-step process, but still can be
done inside a single invocation of "git commit --change-id -S".

So a rough outline of the patch to implement it may look like below.
The parsing and passing down of the "--change-id" option is left as
an exercise to interested readers.  A real patch may have to add an
extra blank line before the strbuf_addf() if buffer.buf does not end
with a trailer to separate the "Change Id" line from the end of the
existing message body.

 commit.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index de16a3c..664ef5d 100644
--- a/commit.c
+++ b/commit.c
@@ -1481,17 +1481,22 @@ static const char commit_utf8_warn[] =
 int commit_tree_extended(const struct strbuf *msg, unsigned char *tree,
 			 struct commit_list *parents, unsigned char *ret,
 			 const char *author, const char *sign_commit,
-			 struct commit_extra_header *extra)
+			 struct commit_extra_header *extra,
+			 unsigned int flags)
 {
 	int result;
 	int encoding_is_utf8;
 	struct strbuf buffer;
+	int add_change_id = !!(flags & COMMIT_ADD_CHANGE_ID);
 
 	assert_sha1_type(tree, OBJ_TREE);
 
 	if (memchr(msg->buf, '\0', msg->len))
 		return error("a NUL byte in commit log message not allowed.");
 
+	if (add_change_id && strstr(msg->buf, "\nChange-Id: "))
+		add_change_id = 0; /* already has one */
+
 	/* Not having i18n.commitencoding is the same as having utf-8 */
 	encoding_is_utf8 = is_encoding_utf8(git_commit_encoding);
 
@@ -1534,6 +1539,13 @@ int commit_tree_extended(const struct strbuf *msg, unsigned char *tree,
 	if (encoding_is_utf8 && !verify_utf8(&buffer))
 		fprintf(stderr, commit_utf8_warn);
 
+	if (add_change_id) {
+		unsigned char change_id[20];
+		if (hash_sha1_file(buffer.buf, buffer.len, commit_type, change_id))
+			return -1;
+		strbuf_addf(&buffer, "Change-Id: %s\n", sha1_to_hex(change_id));
+	}
+
 	if (sign_commit && do_sign_commit(&buffer, sign_commit))
 		return -1;
 
