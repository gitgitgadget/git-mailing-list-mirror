From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert diffstat back to English
Date: Thu, 13 Sep 2012 11:40:12 -0700
Message-ID: <7va9wt9377.fsf@alter.siamese.dyndns.org>
References: <20120913132847.GD4287@sigill.intra.peff.net>
 <1347545786-936-1-git-send-email-pclouds@gmail.com>
 <7vzk4t960y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 13 20:40:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCEKw-0008Ou-Uf
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 20:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244Ab2IMSkR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Sep 2012 14:40:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54535 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753153Ab2IMSkP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Sep 2012 14:40:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46B4196E1;
	Thu, 13 Sep 2012 14:40:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fOi4PyH5fKNt
	UHWnfyqcTEVWYCk=; b=kd9KzSZi/psSDL3nCEQhmhjfvvZZE1JnAQMyIdGUmFQs
	Q6sMNJ1SLLzkmb6iK6PtqIr4hS+E8fcufxrRTj5Nr+1r5jZFoCmM+IKc8cg+v+/A
	XmpvjP6rG2BtJTlahhcIk1r3oesjUB45bRoa3NqmtbkJ2/KXGzQNB7HcIENPylM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RKq+Zp
	llR+DkjhCow1Et9Vn9/aPxPd3/cE3SPDx5uQjEr8oGsmYETXrv1X0KfEYFx9ris8
	fUdBMrwydk+g/ypczFHk06cjWhYOe2IpqQmEeV3oMjRGVFIzUWlTwwOmVfLYmuEz
	FBuCrIgTX/LrXCl5nnbW/d/yMSa8jlstYcbvE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3262E96E0;
	Thu, 13 Sep 2012 14:40:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CA7896DE; Thu, 13 Sep 2012
 14:40:13 -0400 (EDT)
In-Reply-To: <7vzk4t960y.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 13 Sep 2012 10:39:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74694C7C-FDD2-11E1-B4F4-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205409>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>>  Git is still partly i18n-ized, turning a few strings back does not
>>  seem a big regression.
>
> More than one people explicitly said that they do not want to see
> this in Klingon.  Even if the system is fully internationalized,
> these "... (+), ... (-)" should never be localized, just like we
> will never localize "diff --git", "index f00f..abcd", etc.

Nah, I was being silly.  People complaining on Klingon on _this_
list does not argue for this to be in "C"; it just means the
i18n.projectlang for this project is "C".

How about _not_ reverting it and doing something like this instead?
I suspect that we may need to delay the call to git_setup_gettext()
in a similar way that we delay the call to commit_pager_choice(),
but that is a minor detail people smarter than I can surely figure
out ;-)

 git.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git i/git.c w/git.c
index 8788b32..a2cb9c8 100644
--- i/git.c
+++ w/git.c
@@ -51,6 +51,15 @@ int check_pager_config(const char *cmd)
 	return c.want;
 }
=20
+static int project_lang_config(const char *var, const char *value, voi=
d *cb_data)
+{
+	if (!strcmp(var, "i18n.projectlang")) {
+		setenv("LANG", val, 1);
+		setenv("LC_ALL", val, 1);
+	}
+	return 0;
+}
+
 static void commit_pager_choice(void) {
 	switch (use_pager) {
 	case 0:
@@ -538,6 +547,7 @@ int main(int argc, const char **argv)
 	if (!cmd)
 		cmd =3D "git-help";
=20
+	git_config(project_lang_config, NULL);
 	git_setup_gettext();
=20
 	/*
