From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] format-patch: fix dashdash usage
Date: Thu, 26 Nov 2009 15:11:27 -0800
Message-ID: <7v7htc3mqo.fsf@alter.siamese.dyndns.org>
References: <1259262720-24077-1-git-send-email-felipe.contreras@gmail.com>
 <1259262720-24077-2-git-send-email-felipe.contreras@gmail.com>
 <7vd4355aaw.fsf@alter.siamese.dyndns.org>
 <94a0d4530911261414o533aa108l202d4c6926da361e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 00:11:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDnV2-0005p0-Ny
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 00:11:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbZKZXLc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Nov 2009 18:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753271AbZKZXLc
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 18:11:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45870 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922AbZKZXLb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 18:11:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 16F8BA16A8;
	Thu, 26 Nov 2009 18:11:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fgcbVblgmSzD
	rM8WNtY09R2/UPg=; b=oQaU9wvdaStJAIvmyp7luAO+JdWFtrlmMV4QP+ZnEAhW
	lA6UwgxzONnr5vqSKkqmgNgyKX5m4kbjGKK7D7UjqAMzmI4APUkoEahQqdS82ym/
	Z95cWJVVDX2oy07qJDcHBQIgJ33jZxSQjU71JBcgXvl2wSbwgCK/WpMT8zaSDJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Rbln/K
	FMyoPGF+GJCndImQL8iBOsPnpYyE2cEu+KC3siNnVMFvvjx77vs0X/6b3HshdmP/
	IBTZsuP6NMpZJhpBx9XkODS4ZSM0LsANy0BvX1LlxZag+hMxkkWEilKWDcgzGRIM
	L1hT6W3Vjqty6WCQi4Klp09fXCA3ExYznd8Gc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E9DABA16A7;
	Thu, 26 Nov 2009 18:11:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5861BA16A6; Thu, 26 Nov 2009
 18:11:28 -0500 (EST)
In-Reply-To: <94a0d4530911261414o533aa108l202d4c6926da361e@mail.gmail.com>
 (Felipe Contreras's message of "Fri\, 27 Nov 2009 00\:14\:29 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0A110368-DAE1-11DE-85D9-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133845>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Nov 26, 2009 at 9:57 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Otherwise 'git format-patch <committish> -- <non-existent-path>' do=
esn't
>>> work.
>>
>> Instead of "doesn't work", I really wished you wrote something like:
>>
>> =C2=A0 =C2=A0$ git format-patch <commit> -- <path>
>>
>> =C2=A0 =C2=A0complains that <path> does not exist in the current wor=
k tree and the
>> =C2=A0 =C2=A0user needs to explicitly specify "--", even though the =
user _did_ give
>> =C2=A0 =C2=A0a "--". =C2=A0This is because it incorrectly removes "-=
-" from the command
>> =C2=A0 =C2=A0line arguments that is later passed to setup_revisions(=
).
>
> Complaining is one thing... failing to do anything is another.

Oh, I didn't mean to say "tone down from doesn't-work to complains".

    Instead of "doesn't work" and saying nothing else useful to describ=
e
    the nature of the problem you are addressing, I really wished you
    wrote something that has enough details like the sample explainatio=
n I
    gave you has.

Is it clearer what I meant?  More importantly, did I get the details
right?

>> I actually have a bigger question, though. =C2=A0Does it even make s=
ense to
>> allow pathspecs to format-patch? =C2=A0We sure are currently loose a=
nd take
>> them, but I doubt it is by design.
>
> Not everyone has clean branches only with pertinent patches.
>
> I stumbled upon this trying to re-create (cleanly) a "branch" that wa=
s
> constantly merged into another "master" branch that had a lot more
> stuff. Maybe there was a smarter way to do that with 'git rebase', bu=
t
> that doesn't mean format-patch -- <path> shouldn't work.
>
>> The patch itself looks good and is a candidate 'maint' material, if =
the
>> answer to the above question is a convincing "yes, because ...".
>
> Yeah, I also think this should go into 'maint'.

Hmm, I have not seen a clear "yes, because..." yet.

=46or one thing, Documentation/git-format-patch.txt does not even hint =
that
you can give pathspecs.  builtin_format_patch_usage[] doesn't, either. =
 As
I wrote the initial version of format-patch I can say with some authori=
ty
that use with pathspecs were never meant to be supported---if it works,=
 it
works by accident, giving long enough rope to users to potentially caus=
e
themselves harm.

I am inclined to think that we shouldn't encourage use of pathspecs (ju=
st
like we never encouraged use of options like --name-only that never mak=
es
sense in the context of the command) but I am undecided if we also shou=
ld
forbid the use of pathspecs (just like we did for --name-only recently)=
=2E

An appropriate patch that should go to 'maint' _might_ even be somethin=
g
like this in addition to your patch, if we decide to be consistent.

---
 builtin-log.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 33fa6ea..3a9bc69 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1036,6 +1036,8 @@ int cmd_format_patch(int argc, const char **argv,=
 const char *prefix)
 	argc =3D setup_revisions(argc, argv, &rev, "HEAD");
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
+	if (rev.prune_data)
+		die("unexpected pathspec");
=20
 	if (rev.diffopt.output_format & DIFF_FORMAT_NAME)
 		die("--name-only does not make sense");
