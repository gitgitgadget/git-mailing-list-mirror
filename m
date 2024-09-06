Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B183158A30
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 23:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725667061; cv=none; b=tWRq5e1gw+kcTVyn9uyf+1WFZzXlAk7KTR0TgmS0f5N6Gk9+6GcZaMwLzz7uP4ayCZZhumVMi07v61Qu67GoC8LybD+Woe7E6uh7Thm3MvTpPBEy3dSyOyQqBOM6dzD3DY5wnFygvIk4xksMMTQX0Wg6Y7i7VOzu/Cc/eDHmbhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725667061; c=relaxed/simple;
	bh=wYZrza4c46koN8cdyKWd4LeDdXXnZgEIo9jHBVPy4Jc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=id/ocDI+mSFy9hgU0BarH30UXrltb8eAFWGRGuMfFUfkkFM3arRuREON+G/rFLNbTfK/pBI4ukFyQWCFzlHagj5HKRIhHugGbL3ECC/XDjUzKv2MeWR400tbOufuVWNMConzxcThkadkpy1BRlsjQ6wnPBmqQseaO8KMdVVCy/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XgRGgwuv; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XgRGgwuv"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 153BF3BDC4;
	Fri,  6 Sep 2024 19:57:39 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wYZrza4c46koN8cdyKWd4LeDdXXnZgEIo9jHBV
	Py4Jc=; b=XgRGgwuvShjX410ktN5WN3HlD4rZo3G2cdfmyYS67IJI+uMqGUQLGk
	V4UQn8100QCtOv30livs6kFcs/mT41xQDubYrMcaBcWAt+NeaqNK6bI1eVuN6WQT
	NsU+UaOpT1XwgGYTYlw9qseji8Ft6zRvMh5FrjMJEu80itEDg2h6U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EFACD3BDC3;
	Fri,  6 Sep 2024 19:57:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 628693BDC2;
	Fri,  6 Sep 2024 19:57:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v5 0/7] t: port reftable/stack_test.c to the unit
 testing framework
In-Reply-To: <xmqqo750wxee.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	06 Sep 2024 09:38:01 -0700")
References: <20240904150132.11567-1-chandrapratap3519@gmail.com>
	<20240906113746.8903-1-chandrapratap3519@gmail.com>
	<xmqqo750wxee.fsf@gitster.g>
Date: Fri, 06 Sep 2024 16:57:37 -0700
Message-ID: <xmqq4j6suyha.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CBAF3AD2-6CAB-11EF-B66B-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>
>> Changes in v5:
>> - Edit the commit messages in patches 3 and 4 to reflect the changes
>>   and the motivation behind those changes better.
>> - Add newlines after variable declarations in patch 6.
>> - Introduce patch 7 which removes leftover cruft from the previous
>>   reftable testing scheme.
>
> Hmph, the end-result looks good to me, but the structure of the
> series is a bit curious.  I didn't expect there will be a separate
> step for removal.  Shouldn't these "leftover cruft" be removed *in*
> the same step that they become cruft (which I am assuming is when
> reftable/stack_test.c and all references to it gets removed in an
> early part of the series)?
>
> Other than that, looking good.
>
> Thanks.

There is another issue.

It is unique to this among the reftable/*_test topics, simply
because this one happens to be the last and needs to clean up a bit
more.

Apparently, GNU "ar" can be invoked without any .o object files and
happily creates an empty archive, but on BSD may not be that may be
the case.  macOS CI jobs seem to be hard failing due to this.

You'd need to squeeze in the following, in addition to [7/7], to
earlier patch(es).

Thanks.

 Makefile | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git c/Makefile w/Makefile
index 64ccb1433f..bdea061971 100644
--- c/Makefile
+++ w/Makefile
@@ -912,7 +912,6 @@ TEST_SHELL_PATH = $(SHELL_PATH)
 LIB_FILE = libgit.a
 XDIFF_LIB = xdiff/lib.a
 REFTABLE_LIB = reftable/libreftable.a
-REFTABLE_TEST_LIB = reftable/libreftable_test.a
 
 GENERATED_H += command-list.h
 GENERATED_H += config-list.h
@@ -2866,9 +2865,6 @@ $(XDIFF_LIB): $(XDIFF_OBJS)
 $(REFTABLE_LIB): $(REFTABLE_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
 
-$(REFTABLE_TEST_LIB): $(REFTABLE_TEST_OBJS)
-	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
-
 export DEFAULT_EDITOR DEFAULT_PAGER
 
 Documentation/GIT-EXCLUDED-PROGRAMS: FORCE
@@ -3248,7 +3244,7 @@ perf: all
 
 t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS)) $(UNIT_TEST_DIR)/test-lib.o
 
-t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS) $(REFTABLE_TEST_LIB)
+t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
 check-sha1:: t/helper/test-tool$X
@@ -3709,7 +3705,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) git.res
 	$(RM) $(OBJECTS)
 	$(RM) headless-git.o
-	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
+	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) $(FUZZ_PROGRAMS)
