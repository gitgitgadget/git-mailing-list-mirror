From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] merge-recursive: Workaround unused variable warning
Date: Wed, 18 Aug 2010 11:55:07 -0700
Message-ID: <7veidvagz8.fsf@alter.siamese.dyndns.org>
References: <1281665352-10533-1-git-send-email-newren@gmail.com>
 <1281665352-10533-2-git-send-email-newren@gmail.com>
 <AANLkTikLXy4gPttmX=wzcDaFAfZO=OEk4PEDKh3sCSOF@mail.gmail.com>
 <20100818001032.GA7694@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 20:55:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olnna-00075M-1Z
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 20:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801Ab0HRSzY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 14:55:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60699 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753516Ab0HRSzX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 14:55:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D547BCEB65;
	Wed, 18 Aug 2010 14:55:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=M/IeA7AD8NTj
	DdlOMWk1H8nJGVg=; b=ayQ3a4Lq30KF4Wb8oBnYBjoJPHAg27GeMMvP+HhEbB+a
	bmNvcsyel94vhdGkeBc5rruuarBj4C5Db90XnTgt5nEv4asp8aj+pVvM+ShpUYjL
	UrZv0S4/Cha8jfV8/4gHFgsuS/2bvL2GvbsKJlLpwC2iphNKCZev4J5V3u+MhQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=t+Vy/T
	5Zr2NeC8isY82OSiVwG9JxHB/6lbccNH0Fwjn9GVXgYFd2b/YcUqrO4mhtEs+QKf
	XwmpD1GEZ5g2aVkyZCHjYRoyuOByhqw14Y6EN81BKi27p+1DwOrsQOI1Fp0zE8W1
	CqwfkE40PTkH1NvR6129DNR6uc8BVxC3t5Dlw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 89CE3CEB59;
	Wed, 18 Aug 2010 14:55:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74C57CEB54; Wed, 18 Aug
 2010 14:55:09 -0400 (EDT)
In-Reply-To: <20100818001032.GA7694@burratino> (Jonathan Nieder's message of
 "Tue\, 17 Aug 2010 19\:10\:32 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 234F962A-AAFA-11DF-A004-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153874>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Elijah Newren wrote:
>> On Thu, Aug 12, 2010 at 8:09 PM, Elijah Newren <newren@gmail.com> wr=
ote:
>
>>> +++ b/merge-recursive.c
>>> @@ -1214,6 +1214,7 @@ static int process_df_entry(struct merge_opti=
ons *o,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* We currently only handle D->F cases *=
/
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0assert((!o_sha && a_sha && !b_sha) ||
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (!o_sha && !a_sha =
&& b_sha));
>>> + =C2=A0 =C2=A0 =C2=A0 (void)o_sha;
> [...]
>>                        would a different method of fixing warnings
>> when NDEBUG is defined be preferred?  (Maybe changing the
>> "assert(foo)" into "if (!foo) die..." instead?)
>
> Yes, that sounds like a good idea.  The user would probably benefit
> from knowing what happened.

I'd agree.  This assert() is not about protecting new callers from maki=
ng
obvious programming error by passing wrong parameters, but about Elijah
not being confident enough that the changes made to process_entry() wit=
h
this series really covers all the cases so that only D/F cases are left
unprocessed.

Another possibility is to move this assert() out of process_df_entry() =
and
have it on the calling side.  Perhaps something like the attached.

BTW, it is not so obvious if (!o_sha && !!a_sha !=3D !!b_sha) is equiva=
lent
to "we are handling a D-F case".  Can you explain why?


diff --git a/merge-recursive.c b/merge-recursive.c
index b0f055e..7bab728 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1208,9 +1208,8 @@ static int process_df_entry(struct merge_options =
*o,
 	const char *conf;
 	struct stat st;
=20
-	/* We currently only handle D->F cases */
-	assert((!o_sha && a_sha && !b_sha) ||
-	       (!o_sha && !a_sha && b_sha));
+	if (! ((!o_sha && a_sha && !b_sha) || (!o_sha && !a_sha && b_sha)))
+		return 1; /* we don't handle non D-F cases */
=20
 	entry->processed =3D 1;
=20
@@ -1321,6 +1320,12 @@ int merge_trees(struct merge_options *o,
 				&& !process_df_entry(o, path, e))
 				clean =3D 0;
 		}
+		for (i =3D 0; i < entries->nr; i++) {
+			struct stage_data *e =3D entries->items[i].util;
+			if (!e->processed)
+				die("Unprocessed path??? %s",=20
+				    entries->items[i].string);
+		}
=20
 		string_list_clear(re_merge, 0);
 		string_list_clear(re_head, 0);
