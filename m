Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B821F26659E
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867006; cv=none; b=Pe+dPKgltLyTW8B9y3Tl+Ynir2f8eHR/jTib79Frc0IPvilzMh4Ua65Tb4SgQfu+RtzmIUKkra7mDjTtqlBBlnIOA22Z8x+1pEyfjo6abHPtTiMcXFIdvghJFe/rHXSWWvIblQB2jvdi8bZ++TrGzUnzhOigmyGMrXV7LYCAJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867006; c=relaxed/simple;
	bh=OrjX+h+GfpIowt2h1JgfThgS5KlV9Q2nfZ/IaAFuPhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YCYUtgRasX0o6UxaSC2b9p4iSKJ0199AzUXULnDGPNW2mBptmpBOk4EQBmJgUinXnNeurDnuyiTTWL9o9QLdxFIVzIa/oZvu29yqBlZyGk4FeSJMSKCirxpnXX1jW2fU/JdNNvk06ZGUAU+ay8LAGD462vV1KMcyZfSoQ3yyswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S4lgMVpV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2mxY7W12; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S4lgMVpV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2mxY7W12"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9DF881382CFF;
	Thu, 13 Mar 2025 07:56:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 13 Mar 2025 07:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741867001; x=1741953401; bh=ONlIHYapH+
	g9kHG8jjFlGy1WyRQnCmBZEOPdqtVdcT8=; b=S4lgMVpVzSCuaiGukGFkNVYyJk
	oCSFV80z00XI74z5ahBdGeuEnn4+f5mjiwGudQWlLD7kfdY2WFrlq/2TFY2Ximhb
	XPog23urPANT8BBm2/SeTxi0ioVCdDiRPCNUan2tX1xR5xh7iwgenKmuUz42VgLB
	Ds4iqcHmrDu54Xq/GXGsTlRu4zJFTFXYaUF+/6NuN8cqDMkLZK9P8qhgSPobjjVs
	Fhc7jYGkmptHFS99tlEB6xCR5Om1E3Ea0v9pLpjsXA20/ptQUKaDZ0KqDkb3uV54
	1suiIlbb1gjeQfdki3vFgxB55DQaIeVbovZ+sXWrKZRyhNUEHnicbddjzNNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741867001; x=1741953401; bh=ONlIHYapH+g9kHG8jjFlGy1WyRQnCmBZEOP
	dqtVdcT8=; b=2mxY7W12OfiDTRGolmjAa6c97xuwrldIlH9aZBV52nHcGIlBaL5
	zNtdicfdMmK0ST2jpN5Ptk+l/V98m2WrdcxIxy9cZadZq9e+UQJ/sx6iR0pKLouo
	77Mwb+acUJ5A6/c6cAnPFZ4MRuunI0gbPlsj/NGRDrfdE83mW8SgY0ERIVZJ50+u
	av2ZuS5RqAWo78EzvaPwT17oDc3FJsBWiTOvGSZH5QGf4HV5O6EQJma8D1zNkl7f
	sVzLgz4j7y794sPUWPkcHsHi8DbX9HSAPGJnQuxAVWVPUgsRKZWANusxf8lIg8ik
	1nksGySIkb48VUM/vWweDDoMP+2vCSlvRBQ==
X-ME-Sender: <xms:-cfSZ5YgA4G8A2C0-CWFGpMjOD06gYC_lCFj5wxDz8UxhVW6RcO_WA>
    <xme:-cfSZwbA2SOQp0smBCAnLgrSYHHRFfdsgt_BUwuMwF2RoCO7Jzrp9nPdfWjfL9-Ql
    cRTvQp_Fd7AOzy-kg>
X-ME-Received: <xmr:-cfSZ79-JBcpab6mlnl-_gEZ9AFaC2p-SMZs7D3TbSLRwAldhBUk3yw8IEOQ78Ye1scgjkQZn_OnTOqJ9h70o5gK0OSDwikU32yH2d8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdejkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-cfSZ3r9YGNC-emMBuHcDKESddUJ1E3FyjwO51ohNvzwVzxFZxHXDA>
    <xmx:-cfSZ0pNwyhtt9Ze-1rbDATkIvi4Ts8DIXGktkU6R8O3aZZ_MnrRVw>
    <xmx:-cfSZ9QAt78Q6iqqeT9Ds1TeWMcy3EyQqTo5QaUYmey3BR7SBoQ16g>
    <xmx:-cfSZ8pjtxnApkLVFfxdT1b8hnuwqJAqYKy_7Epa97wsNBChrZMziQ>
    <xmx:-cfSZ_UsZxDr7VZNouwWSyIqDtM5puEABFAnA97GlDS1H1-lTgrDgz5J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 07:56:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/6] t: extend test_lazy_prereq
In-Reply-To: <Z9ExMHf9CkcDwEt1@pks.im> (Patrick Steinhardt's message of "Wed,
	12 Mar 2025 08:01:04 +0100")
References: <20250310231652.3742490-1-gitster@pobox.com>
	<20250311212505.2920181-1-gitster@pobox.com>
	<20250311212505.2920181-3-gitster@pobox.com> <Z9ExMHf9CkcDwEt1@pks.im>
Date: Thu, 13 Mar 2025 04:56:39 -0700
Message-ID: <xmqqsenhrvns.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +	elif test "$eval_ret" = 125; then
>> +		:;
>>  	else
>>  		say >&3 "prerequisite $1 not satisfied"
>>  	fi
>
> The semicolon in ":;" threw me off a bit. Am I missing why we need it or
> is it superfluous?

The latter, of course -).

>> @@ -811,6 +813,9 @@ test_have_prereq () {
>>  				if test_run_lazy_prereq_ "$prerequisite" "$script"
>>  				then
>>  					test_set_prereq $prerequisite
>> +				elif test $? = 125
>> +				then
>> +					BUG "Do not use $prerequisite"
>>  				fi
>>  				lazily_tested_prereq="$lazily_tested_prereq$prerequisite "
>>  			esac
>
> Hm, okay. It feels quite close to overthinking the whole deprecation
> cycle around prerequisites as it's nothing that we tend to do very
> often. But on the other hand the implementation is trivial enough, so I
> don't mind it much.

I agree that this has nothing to do with breaking changes at the Git
3.0 boundary.  We just did not have good documentation for lazy
prerequisites, and we just did not have any good support for marking
a prerequisite should no longer be used.  [1/6] is for the former,
and [2/6] is for the latter.

We can avoid the magic 125 by adding a new helper like test_removed_prereq
and do this instead, which may be cleaner and simpler to reason about.

Another alternative that may make writing tests even be less error
prone but a bit more verbose is to introduce test_unset_prereq and
be explicit about unsatisfied prerequisites.  The effect of the
resulting system becomes larger to include detecting misspelled
prerequisites, and removed prerequisites would be detected as a
natural fallout from the same mechanism.

As we have >50 prerequisites defined with test_set_prereq and we'd
need to add 50 calls to test_unset_prereq to mark them as "known but
not satisified on this platform" to differentiate them from the ones
that are misspelt or removed, if we go that route.  I am not sure if
that is worth it.  Certainly not in the short term, but for a longer
term, if people ever misspelt a prerequisite SYMLINKS as SYMLINK and
wasted time wondering why their tests didn't trigger, it might be
worth it.  I dunno.

 t/test-lib-functions.sh | 14 ++++++++++++++
 t/test-lib.sh           |  5 +++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git c/t/test-lib-functions.sh w/t/test-lib-functions.sh
index 79377bc0fc..3903344fc1 100644
--- c/t/test-lib-functions.sh
+++ w/t/test-lib-functions.sh
@@ -751,7 +751,15 @@ test_set_prereq () {
 		;;
 	esac
 }
+
 satisfied_prereq=" "
+
+removed_prereq=
+# Mark a prerequisite deprecated-and-then-removed
+test_removed_prereq () {
+	removed_prereq="$removed_prereq$1 "
+}
+
 lazily_testable_prereq= lazily_tested_prereq=
 
 # Usage: test_lazy_prereq PREREQ 'script'
@@ -801,6 +809,12 @@ test_have_prereq () {
 			negative_prereq=
 		esac
 
+		case " $removed_prereq " in
+		*" $prerequisite "*)
+			BUG "Do not use $prerequisite"
+			;;
+		esac
+
 		case " $lazily_tested_prereq " in
 		*" $prerequisite "*)
 			;;
diff --git c/t/test-lib.sh w/t/test-lib.sh
index 9001ed3a64..c2c96f5e7a 100644
--- c/t/test-lib.sh
+++ w/t/test-lib.sh
@@ -1862,8 +1862,9 @@ test_lazy_prereq CURL '
 	curl --version
 '
 
-test_lazy_prereq WITHOUT_BREAKING_CHANGES '
-	test -z "$WITH_BREAKING_CHANGES"
+test_removed_prereq WITHOUT_BREAKING_CHANGES
+test_lazy_prereq WITH_BREAKING_CHANGES '
+	test -n "$WITH_BREAKING_CHANGES"
 '
 
 # SHA1 is a test if the hash algorithm in use is SHA-1.  This is both for tests
