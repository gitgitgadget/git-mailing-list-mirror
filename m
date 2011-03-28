From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: allow -E and -n to be turned on by default via
 configuration
Date: Mon, 28 Mar 2011 16:16:08 -0700
Message-ID: <7vr59qvnt3.fsf@alter.siamese.dyndns.org>
References: <1301088071-918-1-git-send-email-jratt0@gmail.com>
 <7vlj024wal.fsf@alter.siamese.dyndns.org>
 <7vbp0ux5c9.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTimpp+dyt8cONp_nK72eTXXgsOfkHuWpPTr90h=u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Joe Ratterman <jratt0@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 01:16:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Lfc-0000E7-4Z
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 01:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755280Ab1C1XQT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2011 19:16:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48773 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab1C1XQS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2011 19:16:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0EF7659FB;
	Mon, 28 Mar 2011 19:18:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/mVfVs7moYd+
	dUEBfererqqXvpw=; b=X73wfIC86ITsdazyhDWhGEDUEn0wPfOCsve//RDsJcbU
	4IipiabFgx4fmWzokic6mlQUXNc0kyXeWrdnnTEum1mJHyc9mJHZHS4DzuNV/1P8
	OxhYTffj++H+YvZ5gaMjveZ23+PFYTvWPqgTnjOf5tCiwSxSYQYdjHRDFBqoouo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=K3o72g
	sotuEA5oEVJMO6sqHS+ofQ2JnX2xKGcaQtrm8k0CBz1aota0fLG4v6cwGxdG81oY
	KIv5uFXLoiO88l8fAtUIg4mc0BkOJJ4J4ZsXwSM9UFPIwLBNViFt85ha78DdPywR
	OHzx4Qt0xPI2afIoT3Thl8wCwzKoZcdTbefIg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DA3E359FA;
	Mon, 28 Mar 2011 19:17:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D7CEA59F9; Mon, 28 Mar 2011
 19:17:56 -0400 (EDT)
In-Reply-To: <AANLkTimpp+dyt8cONp_nK72eTXXgsOfkHuWpPTr90h=u@mail.gmail.com>
 (Joe Ratterman's message of "Mon, 28 Mar 2011 17:41:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F40AB98-5991-11E0-B67A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170197>

Joe Ratterman <jratt0@gmail.com> writes:

> On Mon, Mar 28, 2011 at 5:12 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> +grep.lineNumbers::
>> + =C2=A0 =C2=A0 =C2=A0 If set to true, enable '-n' option by default=
=2E
>> +
>> +grep.extendedRegexp::
>> + =C2=A0 =C2=A0 =C2=A0 If set to true, enable '--extended-regexp' op=
tion by default.
>> +
>
> I know my original patch was plural, but I since noticed that the GNU
> grep --line-number option is singular.  I used the same thing in my
> patch to add that option to git grep.  Should this one be singular?

Good eyes.

We should match what we are trying to mimic, and we need to be internal=
ly
consistent. So --[no-]line-number should be singular to mimic GNU (whic=
h
is how your othr patch is done---I don't have to amend what I already
queued).  And we should match the variable by naming it "grep.lineNumbe=
r"
to the command line option.

>> + =C2=A0 =C2=A0 =C2=A0 if (!strcmp(var, "grep.linenumbers")) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 opt->linenum =3D =
git_config_bool(var, value);
>
> We need to match the case between the docs and the code or use
> strcasecmp().

In git_config() callback functions, the variable name is supposed to be
already downcased by the caller, except for the second-level name in
three-level names, like "branch.Foo.merge" where the second-level name =
is
case sensitive.  Feeding var we got from the caller and lowercased
variable name we expect to strcmp() is the right way to write them when
you are dealing with configuration variable names.

Some places might unnecessarily and incorrectly use strcasecmp() but if
so, we should be fixing them instead.  We shouldn't mimic bad code.

In documentation we customary write them in camelCase only for
readability.
