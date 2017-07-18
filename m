Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DA3420356
	for <e@80x24.org>; Tue, 18 Jul 2017 18:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbdGRSqQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 14:46:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56385 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751388AbdGRSqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 14:46:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F4557B941;
        Tue, 18 Jul 2017 14:46:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IwTueAvg19WUH4ZYwoMfp3xUSBw=; b=lB+5GP
        3b25EwdZZWIKbf/IXfMlYNtdb2fyQ5j6VI6dhyxgJCQciQKiEYogaoK1Q3SGLGQ5
        4fSh5ai6smHCclwqa4TzYPHtguMmv1f+j4lCmQ/QJCXztAlrRYBehvYxyIR7QbjC
        ofEjgtrle8bneUa8mf2YG/6uqpsH1Fhp/l6OA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SWEfZooJra3UYGAzsQswOFpJcOKLrwDE
        Dlp5uEnjPU5VHRGFCtPME8xi4PnZ9SoIpkUMmwfl2kD2JzWciT5OACBfs+uIVKcJ
        EnEu10mCAnSxQ35KZ0afdwqmOVI76cQZ6mwjm5pjorlHLpi7h1DC32l0PlEY7yqS
        HrOetxGP4LE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37AFD7B940;
        Tue, 18 Jul 2017 14:46:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A15E77B93E;
        Tue, 18 Jul 2017 14:46:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #04; Thu, 13)
References: <xmqqo9snsy0k.fsf@gitster.mtv.corp.google.com>
        <20170714002754.jyck5qmykbmuado7@LykOS.localdomain>
        <xmqqfudzsq7u.fsf@gitster.mtv.corp.google.com>
        <20170714140241.mqg5256ml3grmrn6@LykOS.localdomain>
        <xmqqwp7bqbvg.fsf@gitster.mtv.corp.google.com>
        <20170717214241.yui75hywg2ddkfsb@LykOS.localdomain>
        <xmqqmv82g1g7.fsf@gitster.mtv.corp.google.com>
        <20170718175458.hadk64c3yccyv57t@LykOS.localdomain>
Date:   Tue, 18 Jul 2017 11:46:06 -0700
In-Reply-To: <20170718175458.hadk64c3yccyv57t@LykOS.localdomain> (Santiago
        Torres's message of "Tue, 18 Jul 2017 13:54:59 -0400")
Message-ID: <xmqqeftdpor5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C3692BA-6BE9-11E7-942F-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Santiago Torres <santiago@nyu.edu> writes:

> On Mon, Jul 17, 2017 at 03:09:44PM -0700, Junio C Hamano wrote:
>> I am not sure if it is merely "if it's even necessary"; if there are
>> two tests running in parallel, with their own separate
>> $TRASH_DIRECTORY, and one of them say "kill the agent" at the
>> beginning, would it affect the other test, depending on the timing?
>
> This shouldn't happen, provided their respective GNUPGHOME env vars
> aren't the same. A gpg-agent process is spawned per GNUPGHOME on the
> versions that I've tested.
>
>> 
>> I would imagine that the sockets are kept per GNUPGHOME and they are
>> not going to interfere, so if that is the case, I do not think we
>> mind helping folks with a buggy versions of GnuPG by having a "let's
>> be cautious and kill a leftover agent before starting to test"
>> patch, as long as the reason why we do so is clearly understood and
>> documented.
>
> I double checked the patch/solutions/causes just to be sure I'm not
> doing anything crazy. Here's a v2 of the patch that kills the agent upon
> cleanup rather than startup.

Thanks.  

The workaround of killing the lingering agent makes sense to me, but
is test_done the right place to do so?  When "sh t7004-tag.sh -i"
dies in the middle, I do not think the control even reaches the
invocation of that shell function at the end.

The httpd tests seem to do this in start_httpd shell function:

	start_httpd () {
		prepare_httpd 
		trap 'code=$?; stop_httpd: (exit $code); die' EXIT
		...

and I can see how this would avoid the "'-i' option can stop the
test script in the middle" issue.  Because the GPG tests do not have
a clear "start agent" step, we'd need to arrange the "trap" in the
case arm in t/lib-gpg.sh where we set GPG prerequisite if we were to
use the same approach.  Or killing a possibly lingering one like your
first patch did may be simpler (we need to make sure &&-chain works
well with "gpgconf --kill all").

Oh, wait, I can run "gpg" just fine, but I do not seem to have
gpgconf.

	$ type gpgconf
	bash: type: gpgconf: not found

The patch may need a bit more cross-version work, it seems.


-- >8 --
From: Santiago Torres <santiago@nyu.edu>
Date: Tue, 18 Jul 2017 13:16:11 -0400
Subject: [RFC/PATCH] t: test-lib: flush gpg agent on cleanup

When running gpg-relevant tests, a gpg-daemon is spawned for each
GNUPGHOME used. This daemon may stay running after the testand cache ile
descriptors for the trash directories, even after the trash directory is
removed. This leads to ENOENT errors when attempting to create files if
tests are run multiple times.

Add a cleanup script to force flushing the gpg-agent when before
removing the trash directory if the test is GPG-relevant.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 t/test-lib.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1b6e53f78..ed8796d7a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -732,6 +732,11 @@ test_done () {
 		EOF
 	fi
 
+	if test_have_prereq GPG
+	then
+		GNUPGHOME="$TRASH_DIRECTORY/gpghome" gpgconf --kill all
+	fi
+
 	if test "$test_fixed" != 0
 	then
 		say_color error "# $test_fixed known breakage(s) vanished; please update test(s)"
-- 
2.13.3


