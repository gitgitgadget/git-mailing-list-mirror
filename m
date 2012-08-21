From: Junio C Hamano <gitster@pobox.com>
Subject: Re: receive.denyNonNonFastForwards not denying force update
Date: Tue, 21 Aug 2012 14:52:02 -0700
Message-ID: <7va9xndibh.fsf@alter.siamese.dyndns.org>
References: <CAHgXSop42qWcAEGn6=og8Pistv_Jrwhgcnv3B_ORVtSMi1fCHA@mail.gmail.com>
 <CAHgXSooFj2PJtcOWqsVNHUzMBQnH0cYzPjfs1CkzVuufwRVrog@mail.gmail.com>
 <7vzk5pjxy3.fsf@alter.siamese.dyndns.org>
 <CAMK1S_hMTGhiKDow3x-UZ7eNnTtpLd2=QUf6-YoQF1-O1ywi2w@mail.gmail.com>
 <7v628dght9.fsf@alter.siamese.dyndns.org>
 <20120821015738.GA20271@sigill.intra.peff.net>
 <7vpq6kgazt.fsf@alter.siamese.dyndns.org>
 <20120821061059.GA26516@sigill.intra.peff.net>
 <7v628cfb6h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	John Arthorne <arthorne.eclipse@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 21 23:52:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3wMx-0000xc-Gx
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 23:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758686Ab2HUVwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 17:52:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48450 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758608Ab2HUVwF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 17:52:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00B1C8A50;
	Tue, 21 Aug 2012 17:52:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TR8PyFK6IcbI6PvcCE4bxKGn02I=; b=Srouxm
	f6Y9G3TBl3HouASIMHv55VKV3sYIWU1r0gNHhCIxAAnGruaieqdNc8egfGU7t3z0
	b/BQFHqI89jfZT84ZtoKYr7TbQ6Vk9YlHxBmiT4HM136AW0qeg0el3QKlgMzz+EJ
	ho0PDh1s6B0Fv6Jdw3FXOlGQLGyCsyEEHrzY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kKLsneFPvaCfFj0qYg2oLWNXF8Iv3tDi
	qtieEMcUmQGa8jaoELP2ZNtnqcZpdA0RvJSNKpdCSFQQ7yLNRpfP/Yau31GvBb9c
	q5TY5+dSCVRF9XPRKsjTekGQq2hCaWN/GDsSu2hWiv8nA75IF8CD9b0l9exBuz81
	AEzr0IMEOo4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E14958A4F;
	Tue, 21 Aug 2012 17:52:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A1708A4B; Tue, 21 Aug 2012
 17:52:04 -0400 (EDT)
In-Reply-To: <7v628cfb6h.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 21 Aug 2012 09:43:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71C32BC8-EBDA-11E1-B4FB-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203994>

Junio C Hamano <gitster@pobox.com> writes:

> Modulo the above "you might want to turn the call to warn() to
> another helper that can be used from elsewhere", this patch looks
> perfect to me.

And that "modulo" is fairly simple if we wanted to go that route.

 attr.c            | 2 +-
 dir.c             | 2 +-
 git-compat-util.h | 3 +++
 wrapper.c         | 7 ++++++-
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git c/attr.c w/attr.c
index cab01b8..f12c83f 100644
--- c/attr.c
+++ w/attr.c
@@ -354,7 +354,7 @@ static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 
 	if (!fp) {
 		if (errno != ENOENT)
-			warning(_("unable to access '%s': %s"), path, strerror(errno));
+			warn_on_inaccessible(path);
 		return NULL;
 	}
 	res = xcalloc(1, sizeof(*res));
diff --git c/dir.c w/dir.c
index ea74048..4868339 100644
--- c/dir.c
+++ w/dir.c
@@ -398,7 +398,7 @@ int add_excludes_from_file_to_list(const char *fname,
 	fd = open(fname, O_RDONLY);
 	if (fd < 0 || fstat(fd, &st) < 0) {
 		if (errno != ENOENT)
-			warning(_("unable to access '%s': %s"), fname, strerror(errno));
+			warn_on_inaccessible(fname);
 		if (0 <= fd)
 			close(fd);
 		if (!check_index ||
diff --git c/git-compat-util.h w/git-compat-util.h
index 5a520e2..000042d 100644
--- c/git-compat-util.h
+++ w/git-compat-util.h
@@ -607,6 +607,9 @@ int remove_or_warn(unsigned int mode, const char *path);
 /* Call access(2), but warn for any error besides ENOENT. */
 int access_or_warn(const char *path, int mode);
 
+/* Warn on an inaccessible file that ought to be accessible */
+void warn_on_inaccessible(const char *path);
+
 /* Get the passwd entry for the UID of the current process. */
 struct passwd *xgetpwuid_self(void);
 
diff --git c/wrapper.c w/wrapper.c
index b40c7e7..68739aa 100644
--- c/wrapper.c
+++ w/wrapper.c
@@ -403,11 +403,16 @@ int remove_or_warn(unsigned int mode, const char *file)
 	return S_ISGITLINK(mode) ? rmdir_or_warn(file) : unlink_or_warn(file);
 }
 
+void warn_on_inaccessible(const char *path)
+{
+	warning(_("unable to access '%s': %s"), path, strerror(errno));
+}
+
 int access_or_warn(const char *path, int mode)
 {
 	int ret = access(path, mode);
 	if (ret && errno != ENOENT)
-		warning(_("unable to access '%s': %s"), path, strerror(errno));
+		warn_on_inaccessible(path);
 	return ret;
 }
 
