From: Junio C Hamano <gitster@pobox.com>
Subject: Re: patch-2.7.3 no longer applies relative symbolic link patches
Date: Wed, 28 Jan 2015 22:05:56 -0800
Message-ID: <xmqqfvauf7ej.fsf@gitster.dls.corp.google.com>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
	<CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
	<CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
	<xmqqzj94lx7z.fsf@gitster.dls.corp.google.com>
	<xmqqa914klg0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Josh Boyer <jwboyer@fedoraproject.org>,
	"Linux-Kernel\@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>
X-From: linux-kernel-owner@vger.kernel.org Thu Jan 29 07:06:12 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YGiF0-0002Xs-9Q
	for glk-linux-kernel-3@plane.gmane.org; Thu, 29 Jan 2015 07:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756733AbbA2GGD (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 29 Jan 2015 01:06:03 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57410 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753212AbbA2GF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2015 01:05:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C8278291C1;
	Thu, 29 Jan 2015 01:05:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=htihrXplMHMJJY1wH/hWxe4ASDY=; b=bMlN2q
	59z4kWRA7Rsvw0VO3ynzauZrG3LTfR7BYhChtGToIfPzyyy4IZj2LLdxw0gSzn5o
	k+bNNhkZew1mHpquPhdjoGh/CBqTG3orDkzVhr21qQTlJNMQffj3K/8fK1JVB+0h
	RTUjTt5gZn1PGlzHKoVpAE1LkR3W9Q4iZqwik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cEsa2e27Lg6Hjl/eJgTDOyF5gYaUZXSX
	qMyaQ9EUPLXY5IICElrudO6QFFFBhh7aRTuCBnDo5SvzWqBhUhAWHRYRcmhQgp6z
	P2keJUKWHrGch+bcDYEJIg7O0eJs1T9gGfP5THJiImFzE+aZYIsFVc0ONwFW4dxj
	XYVj84LVcqw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BCBE9291C0;
	Thu, 29 Jan 2015 01:05:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17085291BF;
	Thu, 29 Jan 2015 01:05:58 -0500 (EST)
In-Reply-To: <xmqqa914klg0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 27 Jan 2015 12:39:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E49B8E14-A77C-11E4-A6D9-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263138>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> If the user wants to apply a patch that touches ../etc/shadow, is
>> the tool in the place to complain?"
>
> Let me take this part back.
>
> I think "git apply" should behave closely to "git apply --index"
> (which is used by "git am" unless there is a very good reason not to
> (and "'git apply --index' behaves differently from GNU patch, and we
> should match what the latter does" is not a very good reason).  When
> the index guards the working tree, we do not follow any symlink,
> whether the destination is inside the current directory or not.
>
> I however do not think the current "git apply" notices that it will
> overwrite a path beyond a symlink---we may need to fix that if that
> is the case.  I'll see what I can find (but I'll be doing 2.3-rc2
> today so it may be later this week).

Yikes.  It turns out that the index is what protects us from going
outside the working tree.  "apply --index" (hence "am") is immune
against the CVE-2015-1196, but that is not because we do not follow
symbolic links.

Also the solution is not just a simple has_symlink_leading_path().
Here is tonight's snapshot of what I've found out (not tested beyond
passing the test suite including the new test added by the patch).

-- >8 --
Subject: [PATCH] apply: refuse touching a file beyond symlink

Because Git tracks symbolic links as symbolic links, a path that has
a symbolic link in its leading part (e.g. path/to/dir being a
symbolic link to somewhere else, be it inside or outside the working
tree) can never appear in a patch that validly apply, unless the
same patch first removes the symbolic link.

Detect and reject such a patch.  Things to note:

 - Unfortunately, we cannot reuse the has_symlink_leading_path()
   from dir.c, as that is only about the working tree, but "git
   apply" can be told to apply the patch only to the index.

 - We cannot directly use has_symlink_leading_path() even when we
   are applying to the working tree, as an early patch of a valid
   input may remove a symbolic link path/to/dir and then a later
   patch of the input may create a path path/to/dir/file.  The
   leading symbolic link check must be done on the interim result we
   compute in core (i.e. after the first patch, there is no
   path/to/dir symbolic link and it is perfectly valid to create
   path/to/dir/file).  Similarly, when an input creates a symbolic
   link path/to/dir and then creates a file path/to/dir/file, we
   need to flag it as an error without actually creating path/to/dir
   symbolic link in the filesystem.

 - Instead, for any patch in the input that leaves a path (i.e. a
   non deletion) in the result, we check all leading paths against
   interim result and then either the index or the working tree.
   The interim result of applying patch is already kept track of
   by fn_table logic for us.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c                 | 44 +++++++++++++++++++++++++++++++++++++++++
 t/t4122-apply-symlink-inside.sh | 37 ++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)

diff --git a/builtin/apply.c b/builtin/apply.c
index ef32e4f..da088c5 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3483,6 +3483,46 @@ static int check_to_create(const char *new_name, int ok_if_exists)
 	return 0;
 }
 
+static int path_is_beyond_symlink(const char *name_)
+{
+	struct strbuf name = STRBUF_INIT;
+
+	strbuf_addstr(&name, name_);
+	do {
+		struct patch *previous;
+
+		while (--name.len && name.buf[name.len] != '/')
+			; /* scan backwards */
+		if (!name.len)
+			break;
+		name.buf[name.len] = '\0';
+		previous = in_fn_table(name.buf);
+		if (previous) {
+			if (!was_deleted(previous) &&
+			    !to_be_deleted(previous) &&
+			    previous->new_mode &&
+			    S_ISLNK(previous->new_mode))
+				goto symlink_found;
+		} else if (check_index) {
+			int pos = cache_name_pos(name.buf, name.len);
+			if (0 <= pos &&
+			    S_ISLNK(active_cache[pos]->ce_mode))
+				goto symlink_found;
+		} else {
+			struct stat st;
+			if (!lstat(name.buf, &st) && S_ISLNK(st.st_mode))
+				goto symlink_found;
+		}
+	} while (1);
+
+	strbuf_release(&name);
+	return 0;
+symlink_found:
+	strbuf_release(&name);
+	return -1;
+
+}
+
 /*
  * Check and apply the patch in-core; leave the result in patch->result
  * for the caller to write it out to the final destination.
@@ -3570,6 +3610,10 @@ static int check_patch(struct patch *patch)
 		}
 	}
 
+	if (!patch->is_delete && path_is_beyond_symlink(patch->new_name))
+		return error(_("affected file '%s' is beyond a symbolic link"),
+			     patch->new_name);
+
 	if (apply_data(patch, &st, ce) < 0)
 		return error(_("%s: patch does not apply"), name);
 	patch->rejected = 0;
diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-inside.sh
index 70b3a06..8b11bc6 100755
--- a/t/t4122-apply-symlink-inside.sh
+++ b/t/t4122-apply-symlink-inside.sh
@@ -52,4 +52,41 @@ test_expect_success 'check result' '
 
 '
 
+test_expect_success 'do not follow symbolic link' '
+
+	git reset --hard &&
+	test_ln_s_add ../i386/dir arch/x86_64/dir &&
+	git diff HEAD >add_symlink.patch &&
+	git reset --hard &&
+
+	mkdir arch/x86_64/dir &&
+	>arch/x86_64/dir/file &&
+	git add arch/x86_64/dir/file &&
+	git diff HEAD >add_file.patch &&
+	git reset --hard &&
+	rm -fr arch/x86_64/dir &&
+
+	cat add_symlink.patch add_file.patch >patch &&
+
+	mkdir arch/i386/dir &&
+
+	test_must_fail git apply patch 2>error-wt &&
+	test_i18ngrep "beyond a symbolic link" error-wt &&
+	test ! -e arch/x86_64/dir &&
+	test ! -e arch/i386/dir/file &&
+
+	test_must_fail git apply --index patch 2>error-ix &&
+	test_i18ngrep "beyond a symbolic link" error-ix &&
+	test ! -e arch/x86_64/dir &&
+	test ! -e arch/i386/dir/file &&
+	test_must_fail git ls-files --error-unmatch arch/x86_64/dir &&
+	test_must_fail git ls-files --error-unmatch arch/i386/dir &&
+
+	test_must_fail git apply --cached patch 2>error-ct &&
+	test_i18ngrep "beyond a symbolic link" error-ct &&
+	test_must_fail git ls-files --error-unmatch arch/x86_64/dir &&
+	test_must_fail git ls-files --error-unmatch arch/i386/dir
+
+'
+
 test_done
-- 
2.3.0-rc2-149-gdd42ee9
