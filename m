Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9481C152E13
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714079141; cv=none; b=UiByNAP/BNvfYBsFvG5/iWYCSIwW+eQ/rjBlgwgayuBQvZrtdhwtRDQLINFufA7GnNurwJyIoZqciB/eEghmXjfcGgukPRp/1kn5qvvlKlSY1+SPmeQ/FLfNAt64cPUcGPuftuc2oGdcOoRO2mPBa5Cd9rI0LtszyfRvtd5VwF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714079141; c=relaxed/simple;
	bh=q44IAtI3uNwZHl5QvczibTJKEgz2oJVh0BQ3Y2cMFb8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VWCqdOpxG5a0RHJNiIb/+XJKtW5xvwl8k+7qPgwBJAxMh+ZMbwt/VI8/R8E2jyK8jOCjGieygltbF71GCSyzyJRW3Pf2dgyja7N5b4yNFoAEAIVnLs7Yf4YJQPRwmleEw+kvXuGc+k+xt4FdmMDDeBaP5VUwua2dNoxE7RoXEAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=j4a8j6Z4; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j4a8j6Z4"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0EEA83EDF4;
	Thu, 25 Apr 2024 17:05:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=q44IAtI3uNwZHl5QvczibTJKEgz2oJVh0BQ3Y2
	cMFb8=; b=j4a8j6Z4TLqRWOz/FGa7Sy+HbZrRk0F++93tgswRvoi7g30BeXdKJR
	AKjb08I3S/qjK2mdRAoCtXProsQOr3D67w4opweTNhw8Kj097c9U2AF8ZXxuDLzc
	Y6KyJVLwousCLAshV+B541ObuY9TO2b0rlTmXRZUyEDMaiwL37lZg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 06D883EDF3;
	Thu, 25 Apr 2024 17:05:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4F6F83EDF2;
	Thu, 25 Apr 2024 17:05:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Jeff King <peff@peff.net>,  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4] add-patch: response to unknown command
In-Reply-To: <xmqqedatfay3.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	25 Apr 2024 13:23:48 -0700")
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
	<6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
	<db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
	<b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
	<20240425014432.GA1768914@coredump.intra.peff.net>
	<CAPig+cST4_hUwWg+P_drqT-mv8+eLAzBmuMFXm=Dui14kfYZzA@mail.gmail.com>
	<xmqqedatfay3.fsf@gitster.g>
Date: Thu, 25 Apr 2024 14:05:33 -0700
Message-ID: <xmqqv845dug2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8F4B9202-0347-11EF-B150-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> That's very reminiscent of [1]. Although, unlike [1], the output
>> presented to the user in this case is (I suppose) less likely to be
>> messed up; only the combined captured output is probably affected. So,
>> capturing stdout and stderr separately would indeed be a good idea.
>
> Hmph, something along this line?
>
> It loses to capture how the output should be intermixed, which is
> essential to validate what the end-user should see.  As we can see
> in the attached patch, we cannot express that "Unknown ..." should
> come in between two "Stage addition?" questions, which is a downside.
>
> Between adding fflush() before err() writes, and updating err() to
> write to the standard output stream, I am in favor of the latter for
> its simplicity (of the mental model of the resulting code, not of
> the patch that is required to do so).

The latter, which I claimed to prefer, would look like this.

The idea is to perform the interactive session over the standard
output (and the standard input).  For that, we teach err() to use
the standard output and have a few fprintf() to also call err().

A few tests expect certain messages to appear on the standard error
stream, which needed adjusting.

I know the previous one "fixes" the CI job at Windows, but I haven't
tried this yet.

diff --git c/add-patch.c w/add-patch.c
index 7be142d448..c28ad380ed 100644
--- c/add-patch.c
+++ w/add-patch.c
@@ -293,10 +293,10 @@ static void err(struct add_p_state *s, const char *fmt, ...)
 	va_list args;
 
 	va_start(args, fmt);
-	fputs(s->s.error_color, stderr);
-	vfprintf(stderr, fmt, args);
-	fputs(s->s.reset_color, stderr);
-	fputc('\n', stderr);
+	fputs(s->s.error_color, stdout);
+	vfprintf(stdout, fmt, args);
+	fputs(s->s.reset_color, stdout);
+	fputc('\n', stdout);
 	va_end(args);
 }
 
@@ -1326,7 +1326,7 @@ static int apply_for_checkout(struct add_p_state *s, struct strbuf *diff,
 		err(s, _("Nothing was applied.\n"));
 	} else
 		/* As a last resort, show the diff to the user */
-		fwrite(diff->buf, diff->len, 1, stderr);
+		fwrite(diff->buf, diff->len, 1, stdout);
 
 	return 0;
 }
@@ -1780,9 +1780,9 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 			break;
 
 	if (s.file_diff_nr == 0)
-		fprintf(stderr, _("No changes.\n"));
+		err(&s, _("No changes."));
 	else if (binary_count == s.file_diff_nr)
-		fprintf(stderr, _("Only binary files changed.\n"));
+		err(&s, _("Only binary files changed."));
 
 	add_p_state_clear(&s);
 	return 0;
diff --git c/t/t3701-add-interactive.sh w/t/t3701-add-interactive.sh
index 482d5c117e..a315ec99a3 100755
--- c/t/t3701-add-interactive.sh
+++ w/t/t3701-add-interactive.sh
@@ -43,17 +43,17 @@ force_color () {
 }
 
 test_expect_success 'warn about add.interactive.useBuiltin' '
-	cat >expect <<-\EOF &&
+	cat >expect.error <<-\EOF &&
 	warning: the add.interactive.useBuiltin setting has been removed!
 	See its entry in '\''git help config'\'' for details.
-	No changes.
 	EOF
 
 	for v in = =true =false
 	do
-		git -c "add.interactive.useBuiltin$v" add -p >out 2>actual &&
-		test_must_be_empty out &&
-		test_cmp expect actual || return 1
+		git -c "add.interactive.useBuiltin$v" add -p >actual 2>error &&
+		echo "No changes." >expect &&
+		test_cmp expect actual &&
+		test_cmp expect.error error || return 1
 	done
 '
 
@@ -348,13 +348,13 @@ test_expect_success 'different prompts for mode change/deleted' '
 
 test_expect_success 'correct message when there is nothing to do' '
 	git reset --hard &&
-	git add -p 2>err &&
-	test_grep "No changes" err &&
+	git add -p >out &&
+	test_grep "No changes" out &&
 	printf "\\0123" >binary &&
 	git add binary &&
 	printf "\\0abc" >binary &&
-	git add -p 2>err &&
-	test_grep "Only binary files changed" err
+	git add -p >out &&
+	test_grep "Only binary files changed" out
 '
 
 test_expect_success 'setup again' '
