From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ls-remote: a lone "-h" is asking for help
Date: Fri, 16 Sep 2011 13:31:40 -0700
Message-ID: <7v1uvgfcur.fsf@alter.siamese.dyndns.org>
References: <7vobykfj7g.fsf@alter.siamese.dyndns.org>
 <CAGdFq_h474OrLzP+CHj_eSdSp53n8x7jz1ORT16dOhvRdQMP+g@mail.gmail.com>
 <7vehzgfffw.fsf@alter.siamese.dyndns.org>
 <CAGdFq_hug3zNwvDZ3c8iG-F8jJSuxsuFghMWtWTmUTdfTrWiqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 22:31:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4f4g-0002PR-3r
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 22:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144Ab1IPUbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 16:31:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58186 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753463Ab1IPUbo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 16:31:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C38C5320;
	Fri, 16 Sep 2011 16:31:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aoqdUy3OG/mO/83R2xXyxjwtXBI=; b=wUbeIK
	s/gVbk34jSfT7Se+uUWwwlE5eMhYiTEJMfCOE3j+u6LBV62v16HSnC4PUzyS7k54
	URuFTo0A7wZtcXm4JiKJd3bMzl2gL07HEihMqrItD8DKVIHVyiny/3ZPtP54GMm7
	0+hwx6aktuD8/t19aCkM7GXqGKhPgakLRqs40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YvCxXhbFT1sVDuub7+BZYx2sJDPpqq7I
	N9x7J5OgQp7OAgtoSDxTZBPgDO8lAuKof525cQ39YNiGHlhrNbi3NfzJaAee0vSB
	7RepLHLaGv6G9A2mUikvLeBfyeUSV9i6JicVmCy4SvyCYxCST+lvZybWk5JuN5AD
	6vNM1OSr39g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 03547531F;
	Fri, 16 Sep 2011 16:31:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7912E531B; Fri, 16 Sep 2011
 16:31:41 -0400 (EDT)
In-Reply-To: <CAGdFq_hug3zNwvDZ3c8iG-F8jJSuxsuFghMWtWTmUTdfTrWiqg@mail.gmail.com> (Sverre
 Rabbelier's message of "Fri, 16 Sep 2011 21:44:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E2C5EFB6-E0A2-11E0-9298-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181551>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Fri, Sep 16, 2011 at 21:35, Junio C Hamano <gitster@pobox.com> wrote:
>> Sverre Rabbelier <srabbelier@gmail.com> writes:
>>> Should we really have "-h" as a short for anything other than "--help"
>>> in the first place?
> ...
> Does git 2.0 count?

I am not opposed to. We should do the usual "start from warning and then
deprecate" dance, but I do not think we would want to have a "I want the
old behaviour, please keep it" configuration, especially if we are talking
about a big version bump like 2.0.

The first step would look something like this, on top of the previous
patch.

 builtin/ls-remote.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 41c88a9..dabe21e 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -28,6 +28,12 @@ static int tail_match(const char **pattern, const char *path)
 	return 0;
 }
 
+static void warn_h_deprecation(void)
+{
+	warning("Using -h as synonym for --heads is deprecated");
+	warning("and will be removed in future versions of Git.");
+}
+
 int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -64,6 +70,8 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 			}
 			if (!strcmp("--heads", arg) || !strcmp("-h", arg)) {
 				flags |= REF_HEADS;
+				if (!arg[2])
+					warn_h_deprecation();
 				continue;
 			}
 			if (!strcmp("--refs", arg)) {
