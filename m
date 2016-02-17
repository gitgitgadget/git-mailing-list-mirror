From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 15/15] config: rename git_config_set_or_die to git_config_set
Date: Wed, 17 Feb 2016 13:09:25 -0800
Message-ID: <xmqqh9h7hwmy.fsf@gitster.mtv.corp.google.com>
References: <1455627402-752-1-git-send-email-ps@pks.im>
	<1455627402-752-16-git-send-email-ps@pks.im>
	<CAO2U3Qia8r=jp9CmF0rN3ZxeJk+811q5VZ65pygr9aqrgLUn3A@mail.gmail.com>
	<CAO2U3QjYKV_fPWb7CBYqvHXhQjcgZC+ht6VMQso4PBaHXas99Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Patrick Steinhardt <ps@pks.im>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 22:09:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW9Ln-00070F-QH
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 22:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965485AbcBQVJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 16:09:28 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53847 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965348AbcBQVJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 16:09:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CDDCA44424;
	Wed, 17 Feb 2016 16:09:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z05D8GO+6P8twsRzaGd+/yJwQwg=; b=eCW0MP
	UcXLXGta60BYDLauYYlR9+ScGBjHM4XoE44HDHaRcxE09iW7qthDCb5qR7tUJO8H
	l9TBhkvINJ1lt9MtpXWmVpfV+32IIZGlsZARhV31Tg9alDV6J1oTIfJ7zvUvLXwj
	9swApzyc0WBYQjo8nH2MIh9DUbizSlDcrSBrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ma7aRjxIS/+uqYUjVDD4Wy4uIbpjk2ZS
	kTWr7+QQxAgsZM8h0Uos+3UKroS6Od6HDh/2X6+jsyyDKjFNttzVdHRIatkFVSog
	CccWWi4++9jVUUkNZEnh2F7yJ/QrWG73jseAf2wEFmOV8TqLQBDwyNlh/1Qh/fo3
	ZsiLPzIqYAE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BBE9644423;
	Wed, 17 Feb 2016 16:09:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 40EFC44422;
	Wed, 17 Feb 2016 16:09:26 -0500 (EST)
In-Reply-To: <CAO2U3QjYKV_fPWb7CBYqvHXhQjcgZC+ht6VMQso4PBaHXas99Q@mail.gmail.com>
	(Michael Blume's message of "Wed, 17 Feb 2016 13:02:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B9D1B1FA-D5BA-11E5-A26F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286554>

Michael Blume <blume.mike@gmail.com> writes:

[administrivia: please cull unnecessary parts from your quote]

>> 1 warning generated.
>>     AR libgit.a
>>     LINK git-credential-store
>> Undefined symbols for architecture x86_64:
>>   "_git_config_set_or_die", referenced from:
>>       _probe_utf8_pathname_composition in libgit.a(precompose_utf8.o)
>> ld: symbol(s) not found for architecture x86_64
>> clang: error: linker command failed with exit code 1 (use -v to see invocation)
>> make: *** [git-credential-store] Error 1
>
> Looks like there's one more use of git_config_set_or_die that needs to
> be removed.

Thanks; let's squash this in.

 compat/precompose_utf8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 9ff1ebe..dfbe6d8 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -50,8 +50,8 @@ void probe_utf8_pathname_composition(void)
 		close(output_fd);
 		git_path_buf(&path, "%s", auml_nfd);
 		precomposed_unicode = access(path.buf, R_OK) ? 0 : 1;
-		git_config_set_or_die("core.precomposeunicode",
-				      precomposed_unicode ? "true" : "false");
+		git_config_set("core.precomposeunicode",
+			       precomposed_unicode ? "true" : "false");
 		git_path_buf(&path, "%s", auml_nfc);
 		if (unlink(path.buf))
 			die_errno(_("failed to unlink '%s'"), path.buf);
