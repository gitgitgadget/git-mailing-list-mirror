Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE74C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 916B42177B
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XVA2Y5ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbgJGSrU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 14:47:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51310 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgJGSrU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 14:47:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 02F34EDE56;
        Wed,  7 Oct 2020 14:47:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eoT2DCeXl2L/x8LkriVdspWe0ac=; b=XVA2Y5
        ldHROAX+0zhzIhUYBXM5NhjhG7A5BpruZxh5oUlr4EkXUTjc8TmBBlpNtRhCw4+B
        dDi1LjST1EXLG5SbUkMk86ipSYPIlId2OVCcV3DmFuL2FicujZwdBDhZMRwWae9c
        pZ1Iki32ggEahzOe35VYcU5cTYRxDa/pODXwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m9r218ujZohpenqyp7ncTmnpxskxRWfz
        IoXj7PQ4b1GngIZtjVcbfPbDRmQB6vJSm6kSV/h5wvvuHkKZipKfb6j9n/eapWGs
        PXz54E+RTFPQr5mAXg88ZFetNSEPgU3lWpZDjz0AbdyhLuS3WhWlrlmkTE1DQqeK
        M9x/ZrtZhuQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E48B8EDE54;
        Wed,  7 Oct 2020 14:47:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 22C9AEDE52;
        Wed,  7 Oct 2020 14:47:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Javier Spagnoletti via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Javier Spagnoletti <phansys@gmail.com>
Subject: Re: [PATCH v2] Improve diff pattern for PHP files
References: <pull.864.git.git.1601980656554.gitgitgadget@gmail.com>
        <pull.864.v2.git.git.1602041898670.gitgitgadget@gmail.com>
        <xmqqeema4la5.fsf@gitster.c.googlers.com>
Date:   Wed, 07 Oct 2020 11:47:12 -0700
In-Reply-To: <xmqqeema4la5.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 06 Oct 2020 23:12:18 -0700")
Message-ID: <xmqqpn5t27rj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 840BA616-08CD-11EB-AF5F-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Javier Spagnoletti via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> Subject: Re: [PATCH v2] Improve diff pattern for PHP files
>
> You seem to have read J6t's excellent suggestion well but forgot to
> retitle.

Will queue with minimum copy-editing (reproduced below).

Thanks.

commit aff92827b54f4b7f9e339982a49bab4bdbd1fc55
Author: Javier Spagnoletti <phansys@gmail.com>
Date:   Wed Oct 7 03:38:18 2020 +0000

    userdiff: PHP: catch "abstract" and "final" functions
    
    PHP permits functions to be defined like
    
           final public function foo() { }
           abstract protected function bar() { }
    
    but our hunk header pattern does not recognize these decorations.
    Add "final" and "abstract" to the list of function modifiers.
    
    Helped-by: Johannes Sixt <j6t@kdbg.org>
    Signed-off-by: Javier Spagnoletti <phansys@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/t/t4018/php-abstract-method b/t/t4018/php-abstract-method
new file mode 100644
index 0000000000..ce215df75a
--- /dev/null
+++ b/t/t4018/php-abstract-method
@@ -0,0 +1,7 @@
+abstract class Klass
+{
+    abstract public function RIGHT(): ?string
+    {
+        return 'ChangeMe';
+    }
+}
diff --git a/t/t4018/php-final-method b/t/t4018/php-final-method
new file mode 100644
index 0000000000..537fb8ad9a
--- /dev/null
+++ b/t/t4018/php-final-method
@@ -0,0 +1,7 @@
+class Klass
+{
+    final public function RIGHT(): string
+    {
+        return 'ChangeMe';
+    }
+}
diff --git a/userdiff.c b/userdiff.c
index fde02f225b..4e2b55a5e0 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -147,7 +147,7 @@ PATTERNS("perl",
 	 "|=~|!~"
 	 "|<<|<>|<=>|>>"),
 PATTERNS("php",
-	 "^[\t ]*(((public|protected|private|static)[\t ]+)*function.*)$\n"
+	 "^[\t ]*(((public|protected|private|static|abstract|final)[\t ]+)*function.*)$\n"
 	 "^[\t ]*((((final|abstract)[\t ]+)?class|interface|trait).*)$",
 	 /* -- */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
