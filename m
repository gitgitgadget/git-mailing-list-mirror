Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BD511F404
	for <e@80x24.org>; Fri, 16 Feb 2018 01:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757067AbeBPBXC (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 20:23:02 -0500
Received: from mail-wr0-f182.google.com ([209.85.128.182]:40978 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757063AbeBPBXB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 20:23:01 -0500
Received: by mail-wr0-f182.google.com with SMTP id f8so1482980wrh.8
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 17:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L2X+zyyxibTp9mqDNfW7Mh7sJDEzTuTVcgDSvFe2n8g=;
        b=JEdxeHyHpO9ojZ0UEcUP9sTWfVuP+izOFztwYtfUhYA74FM9micghLgkjVu22aXXKH
         MhlFwSDTYJd/0zYgIis3nKj7C147k4jeOuDoZM52nAMu2LXNCwOq4eV9G+ulSUvZMVq5
         U7VLsOJzmrz/hpOZOM8PYKan+UWl7RtpKv0yIgwtS789SucqLZYNiWONnrDds3RcrGJt
         7uEL1o9K333meV6X07YcUkoGNa5OdneVpdPtXOBbS/gADE0yYM752GxNoOcW8NOg9KZs
         PfM2Yh3yciLnoSiYr4uXmFZeUOT418ekQwchN9KHbBF1N7CR1kx0wkpsf9kc3VHfKrup
         b2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L2X+zyyxibTp9mqDNfW7Mh7sJDEzTuTVcgDSvFe2n8g=;
        b=stJVGhfyn1NXu4eDyhKRyxBfq0EfTOzsnbVWwaYBWJw41EnAUF9jEuf/33kmXOu/2H
         DPkMqVQmOvrCp9sgg/N2/3HEf//tPdZ5dCvyJFpamNHsh7sPvKj3Rd858/vcNQqbDDQb
         gxGe26yRkA7RxpQeNAa1gRTA+W/MQvAAoOilX4ouUtWnRIKamZPTVHLfLTZ9wrTHR0u7
         LNhVUe6f1KtnmpXEZRVRAgnBgbz+qAKCaW2zvqg9fStP+0yk4GgyOnK/Av0YkqgLTynq
         pZ0wtfRQyhehQuK7QxoU6MnWSe660rFzxsBfgNH7QNdVwiUEVrC6Su7HPSXLpOSwhyGt
         2AtA==
X-Gm-Message-State: APf1xPBICjBao3LfAwEG2Wqu4fWC1rEUPLBgH12gXEq40YS+LezKnEyN
        9LZN7ApHgbF3hMQkUTGNqaFCNg==
X-Google-Smtp-Source: AH8x226ZwrGXe4poVFAsc28/ql8DlqQMgsuvC/n93BIk3rupXHFC+6BWXmPl4ratkGyDPT1m/9jeTQ==
X-Received: by 10.223.185.82 with SMTP id b18mr3930686wrg.180.1518744180725;
        Thu, 15 Feb 2018 17:23:00 -0800 (PST)
Received: from localhost.localdomain (x4db1bd99.dyn.telefonica.de. [77.177.189.153])
        by smtp.gmail.com with ESMTPSA id 10sm10182616wmj.19.2018.02.15.17.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Feb 2018 17:23:00 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v16 Part II 7/8] bisect--helper: `bisect_start` shell function partially in C
Date:   Fri, 16 Feb 2018 02:22:43 +0100
Message-Id: <20180216012243.14169-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.354.g266d823471
In-Reply-To: <0102015f5e5ee2f5-3d106a61-7f79-4973-851f-f55a691a6189-000000@eu-west-1.amazonses.com>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com> <0102015f5e5ee2f5-3d106a61-7f79-4973-851f-f55a691a6189-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index ab0580ce0089a..4ac175c49e80c 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c

> +	/*
> +	 * Check if we are bisecting
> +	 */
> +	if (!is_empty_or_missing_file(git_path_bisect_start())) {
> +		/* Reset to the rev from where we started */
> +		strbuf_read_file(&start_head, git_path_bisect_start(), 0);
> +		strbuf_trim(&start_head);
> +		if (!no_checkout) {
> +			struct argv_array argv = ARGV_ARRAY_INIT;
> +
> +			argv_array_pushl(&argv, "checkout", start_head.buf,
> +					 "--", NULL);
> +			if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
> +				error(_("checking out '%s' failed. Try 'git "
> +					"bisect start <valid-branch>'."),
> +				      start_head.buf);
> +				goto fail;
> +			}
> +		}
> +	} else {
> +		/* Get the rev from where we start. */
> +		if (!get_oid(head, &head_oid) &&
> +		    !starts_with(head, "refs/heads/")) {
> +			strbuf_reset(&start_head);
> +			strbuf_addstr(&start_head, sha1_to_hex(head_oid.hash));

Please use oid_to_hex(&head_oid) instead of sha1_to_hex().

