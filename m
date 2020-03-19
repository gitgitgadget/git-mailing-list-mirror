Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB9EC4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC772070A
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 16:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqscUZ9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgCSQmq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:42:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36339 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbgCSQmp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 12:42:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id z72so1567049pgz.3
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 09:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NmQB9DYcSTzsnpjTr95e0SGVmye2S/979KpISQIR4M8=;
        b=jqscUZ9Wr7JJjrQtT9buZoQ2VJ2yFIw7otharGBdIFZt7eygv8qCrIP6aFylNfiFxs
         ExcOZUoM0VdH9qpyLu/nsZOl1WOc67KQPvqoIEArIlJCuCwWI48HO+lEBDY6Ho1B75Pk
         69z2BBdm1HBmQpwH32mzGfEqK5OfD8CNP3LPyHPpxYDRqlNrjepkdFc9bYgsty6yB6QI
         flJE2HNAOKlLPN+s6TVYfjP5IGkg/UwR57Ktde5Nj3tAlOMl9RbvQQhjbK+Pbm5OUjzk
         vqFracO0ZiF4SBbCCmRgT88Nne1aByLVSvIlxvwKHXOSb2Naeg7sYcX+xcyBKQd+1dQW
         mfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NmQB9DYcSTzsnpjTr95e0SGVmye2S/979KpISQIR4M8=;
        b=DXzxNLnESbQkBLbULw/KDy2xIDCIJ+hkroC8SUOXnmg8T/JwtyLmCRWpD2cUAiFfAg
         40UNJ7KTgosTqVzqRYjKghLEP2Wr7O/69nHZtJVrwPV8qMJjRLEsbsJC+AUktUfThLge
         CAOZVzgZNKOqXyBYHfOpwLm885EwGoTSxmsNg7hy7ZTNrVWYElxitzOn1dBjLyXXEQ5b
         QgKBfHSzq7Zk2y8V9huWfLXsug2Ut/ysttRjjyF5OdyraMctRuHsHMKOd67LWjWKbOug
         y0kTGu1pK9ig6/ymEt8Sv1CFyYbmrld1XQaO9ahtRJkZYA4hdDHT6XR17D46hYCTsOaD
         RPtA==
X-Gm-Message-State: ANhLgQ0lLvRF00nCWsZ2mhLUdqIJJNu8LeA0+vDCAop075NiTKiXLMR7
        nw8t2RupykWs3FJiCdJ8p4Rn+dg0ZBzj4Wbg
X-Google-Smtp-Source: ADFU+vvdIYepfrflN00WBhQ8yJyZkQchtAQGxfeMwrREbVcA7zcDIvdUifVBWxFHG+/5pdZII2OGvA==
X-Received: by 2002:a62:1dcd:: with SMTP id d196mr5004982pfd.296.1584636164521;
        Thu, 19 Mar 2020 09:42:44 -0700 (PDT)
Received: from konoha.iitr.ac.in ([103.37.201.177])
        by smtp.gmail.com with ESMTPSA id r8sm2480440pjo.22.2020.03.19.09.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 09:42:43 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     harshitjain1371999@gmail.com
Cc:     git@vger.kernel.org, Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [GSoC][PATCH 2/2] t4131: use helper function to replace test -f <path>
Date:   Thu, 19 Mar 2020 22:12:34 +0530
Message-Id: <20200319164234.4441-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200319132957.17813-3-harshitjain1371999@gmail.com>
References: <20200319132957.17813-3-harshitjain1371999@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Harshit,

> Replace 'test -f' with the helper function 'test_path_is_file' as the helper function improves the code readability and also gives better error messages.

Again the same thing, you may follow what I stated before regarding commit messages.

The commit title can be of the form:

t4131: use helpers to replace test -f <path>

<<commit description>>

If you still face any problem, feel free to drop a message :)

Regards,
Shourya Shukla
