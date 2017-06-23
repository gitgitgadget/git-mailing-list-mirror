Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 055CE2082E
	for <e@80x24.org>; Fri, 23 Jun 2017 04:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbdFWEqY (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 00:46:24 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33567 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbdFWEqY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 00:46:24 -0400
Received: by mail-pf0-f171.google.com with SMTP id e7so18624020pfk.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 21:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TgPvf/YAcoQQWjnoAc7oSZciz8xLaeDRFdGB05HuJ5Q=;
        b=iOxmsKMFg1+a+feaiXcKg+TWxV7WUmgMUBrsspyncPTCYuWIcAnrrJHjNACtVYY73q
         2r8Wj1E+cJsnM+oo0+m/ZEf6OYKic9bVDYgs6jull6Q4Ayka3rl0Do9qoi4DZXnKqgiq
         dA1SevyL9wkyAfHRJC3y6j7jdt8e8v3WvA0AndBMwvtDziLvuuW98guN3rCH9YSbehl6
         Fa851i4DoaDYN5yfvvGr3ewTUiSgVEnI+/rPmlbwoUy/SocAeagGrk297hd6LOSLG+NM
         fKlOWbZVdyDw7MV+bVeQ+IbTn7p7HFkjb02WNz/GNvUDudccGElUnYl4BYOlRZXQKAQq
         VBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TgPvf/YAcoQQWjnoAc7oSZciz8xLaeDRFdGB05HuJ5Q=;
        b=LxYoRqNG9mcWPAmoGdgU0AiM7uCPdz13mas3lquIowhtVn2go1kfosl2Qmb8A83utv
         AVqZtgjlAvnXqCm3hzTKLjZ8aq1h7TImWK1DPN5qgcC0dIVpmfFg4nvKNysjKq4ZLxV4
         aVQDe3zsvpx/VB/tNozqDM6qeq+akIdmcYX0Pbncz7KDVj5cb+AIfJS6+kl6U4mUE+pE
         zFKEMO8u6WYYqolrvvEtWH2VjKGYAEPbq7MAKBVtQjy0ByVaQ03+mYzNIePQ0p3LtWb/
         akYTCHCcTh5mfcN8DyEJ3PuzfVkEpfPDT2m8QtDKuSmWb97YTYZbDOCI/DOeA9FE+j4N
         5UdQ==
X-Gm-Message-State: AKS2vOwehB15k4bHMquXnOqy0YSz7niN3k7sj51KngsQ+apEWvQ3Bq4x
        l1Jh4ZJwbnV/qw==
X-Received: by 10.84.131.71 with SMTP id 65mr6839633pld.35.1498193183139;
        Thu, 22 Jun 2017 21:46:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id 189sm6580216pgj.67.2017.06.22.21.46.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 21:46:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Xie <emilyxxie@gmail.com>
Cc:     git@vger.kernel.org, David Turner <novalis@novalis.org>
Subject: Re: [PATCH] pathspec: die on empty strings as pathspec
References: <20170607033308.33550-1-emilyxxie@gmail.com>
        <xmqqfuf82xr5.fsf@gitster.mtv.corp.google.com>
        <CAAin2ARfUCYM95L_k3fSQ--reQD3uMG72ah=Xg1xvvgKcU+QkQ@mail.gmail.com>
        <xmqqefubgxa3.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 22 Jun 2017 21:46:21 -0700
In-Reply-To: <xmqqefubgxa3.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 22 Jun 2017 21:09:40 -0700")
Message-ID: <xmqq60fngvky.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Emily Xie <emilyxxie@gmail.com> writes:
>
>> I ran the tests and none of them failed. 
>
> This is not about a test you touched, but applied to or merged to
> any of the recent integration branches (like 'master' or 'maint')
>
>     $ make
>     $ cd t
>     $ GIT_TEST_LONG=YesPlease sh ./t0027-*.sh
>
> fails at the very beginning.  I do not know if 0027 is the only one
> that triggers this failure, though.

t0027 should pass with this, I think.

I am not sure if we even want the dot there, but at least that is
what the original author of the test intended to do when s/he
decided to pass an empty string as the pathspec.

 t/t0027-auto-crlf.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 93725895a4..e41c9b3bb2 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -322,7 +322,7 @@ test_expect_success 'setup master' '
 	echo >.gitattributes &&
 	git checkout -b master &&
 	git add .gitattributes &&
-	git commit -m "add .gitattributes" "" &&
+	git commit -m "add .gitattributes" . &&
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONE\nLINETWO\nLINETHREE"     >LF &&
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\r\nLINEONE\r\nLINETWO\r\nLINETHREE" >CRLF &&
 	printf "\$Id: 0000000000000000000000000000000000000000 \$\nLINEONE\r\nLINETWO\nLINETHREE"   >CRLF_mix_LF &&
