Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7785C20188
	for <e@80x24.org>; Mon,  8 May 2017 04:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbdEHELW (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 00:11:22 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33962 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdEHELW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 00:11:22 -0400
Received: by mail-pg0-f65.google.com with SMTP id u187so8773054pgb.1
        for <git@vger.kernel.org>; Sun, 07 May 2017 21:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HY5Agwqgd0vv/dr4QGCfqpg3SMrrojxntwHYDEgW8Gc=;
        b=R2qPwBSYmsvjGNT1/SZzy09sTD8sVScUiCg8LBT5jZvy9teEqEnbFxgWesEm+VuFq4
         p4GEl5mlaytjc3dia35T3u90HQ+N2jGEGK0YohTM4jrUOzaMuBKZOhCaJuRTvraKXexy
         Z7LWVjqPU4hurWb42/UECE2BnHD6mO3pCv29YPS0GaFClbXM2ordZHto2CiVQZhHbOoD
         LnOR7Zgw0EemTwEISQSHpBzMmt6T4Y7I/l1j6s55Py3g/OeuQ9H2Qzt0IurhK7D9Uzl7
         IPMeLmFAD3TzrXf+3EYFkWNb92qR9VLKQVnNInlzpDXMbdQXDgnKx7/zdj3GdsmuMFtk
         AWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HY5Agwqgd0vv/dr4QGCfqpg3SMrrojxntwHYDEgW8Gc=;
        b=WwRrdfLGKTLE535B/6o7SRRFejcd4q+jcNSN25+XgfEwu14r/qPtFj2DWjs0bx9xCw
         8xS4iZ7fC+ty7jVk4PgYslJ6suxuQUzyXOnOD0OWzKhSMoLKWfPWdV/KFBm7sN+8I1o2
         YLt+GYjyiaOkKKFbye7ZivK2a4iRNKzPf+ptZUATqW3N1VS7eZJVB7hIoNBLdvr+sVN7
         QfEsSvCYbPhwQujdloccdXvQAOZ86oZ7gjHyyKW1q9U9b5ZJpHPlEP2xs3ctHRmq0RN4
         mVxcx57kaz4RtDlmt2BUWDv8fLKc44cuwqiN+ZmSfntYVTdy+q2tv82TPY7U6iPveZav
         ZaRw==
X-Gm-Message-State: AN3rC/4qjH+1yGKo14lT27UCp1PHbd4LZZRyrm2eaFAU0DyU5FWs4Scr
        QvhZOcoxQz4XQA==
X-Received: by 10.84.254.4 with SMTP id b4mr81518638plm.64.1494216681522;
        Sun, 07 May 2017 21:11:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3011:642f:81a0:efbd])
        by smtp.gmail.com with ESMTPSA id o5sm27671214pfk.126.2017.05.07.21.11.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 21:11:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     xiaoqiang zhao <zxq_yx_007@163.com>
Cc:     git@vger.kernel.org, viktorin@rehivetech.com, mst@kernel.org,
        pbonzini@redhat.com, mina86@mina86.com, artagnon@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v3] send-email: --batch-size to work around some SMTP server limit
References: <20170507043648.24143-1-zxq_yx_007@163.com>
Date:   Mon, 08 May 2017 13:11:20 +0900
In-Reply-To: <20170507043648.24143-1-zxq_yx_007@163.com> (xiaoqiang zhao's
        message of "Sun, 7 May 2017 12:36:48 +0800")
Message-ID: <xmqqpofk9edz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

xiaoqiang zhao <zxq_yx_007@163.com> writes:

> @@ -1664,6 +1674,14 @@ foreach my $t (@files) {
>  		}
>  	}
>  	$message_id = undef;
> +	$num_sent++;
> +	if ($num_sent == $batch_size) {
> +		$num_sent = 0;
> +		$smtp->quit;
> +		$smtp = undef;
> +		$auth = 0;

Two suggestions.

 (1) I do not think $smtp is always valid when we come here; it is
     unsafe to unconditionally say $smtp->quit like this patch does.

	$smtp->quit if defined $smtp;

     may help codepaths like $dry_run and also the case where
     $smtp_server is the absolute path to a local program.

 (2) You are setting $auth to zero to force re-authentication to
     happen.  It would be more consistent to the state of $auth that
     is not-yet-used to "undef $auth;" here instead.  After all, the
     variable starts its life in an undefined state.


So all in all

	$smtp->quit if defined $smtp;
	undef $smtp;
	undef $auth;

perhaps?

This change of course forces re-authentication every N messages,
which may not hurt those who use some form of credential helper, but
that may be something we want to mention in the log message.

> +		sleep($relogin_delay);
> +	}
>  }

Thanks.
