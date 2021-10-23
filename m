Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EACC433EF
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 12:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E39E460FDA
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 12:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhJWNAb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 09:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhJWNAa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 09:00:30 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D9BC061764
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 05:58:11 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t184so5966565pgd.8
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 05:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QEFjduxivPHS3FQ0Xp6CRGxWajf3GrLP2ZvnjKSSr2s=;
        b=OIlDcmtF1YaBcUCwkfex2N1Wa0kxRQQ4fRUQ/vY6kQGMyX7KYQ3a3NbbnEZ2DEIA2o
         4dmlgqVOtoyv5upVbnyJfhdCzUJqWlLTiHVlHfzif+TQi8TV13LOfr0CLUP7HSNCrCqE
         zerzVEAgF0Cr2MbaBEMK/vDAfMSBI4r4efFXnmlkNw4MKC7D/NRWqQ+U3gqkK7V2ZqW+
         HKyeVm9Q58/pcscyYJx4GfzdD6YsVdEA0kA4iQG7uD1yfBYGlSamsIQQzrsbRbWaGynE
         XMiHSxpUOb4c4vskOJMRqXy2pblvuQGWge4LOc0NsqZ8/tdVXtWfcIWHdVAqlG47bZES
         M2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QEFjduxivPHS3FQ0Xp6CRGxWajf3GrLP2ZvnjKSSr2s=;
        b=MewUDubjAM5A7uZHtYLsA8KZ9imDEzZIfQSkyf3W7H+Pj1VTavpu3f5gTNqTySnBMK
         10YQ22a2mVd6242H0t6Lo6SJ6WRrtML+I6Hh/PEwMlMbrV/2vfYdOjyCqWkScaJKiZ+y
         nzrRd/yUq5VMcj7QNLCJ4Ku+nLhB4aQgVWbHutNEJjciZYN4LyZcRozTVvmW9Ktn/Z/o
         G1JjCvEKjIj9e+hU1/tqTztTQqzu5uapQ+rHSKoIcPXnXqdIIbXjGpjGxW37mBD/Bfv2
         fm2kEl4md4y9cx+Eub88aPkgObxSjbqhNylA+pl6Zzlpx+kY336kRncVf8COnMqfDAIc
         RiMA==
X-Gm-Message-State: AOAM5336nzNG+BGkbWObfDATCIxfWAfw8421xtpZbrgtlCZPyXGrvjzc
        guFv0xNkW2WRwq39z44cnb9Urtivuo8=
X-Google-Smtp-Source: ABdhPJzZQJWYIuuFy8ZoGEb/h6v9UFFwOA/O2tdSzKyKdXcJZrQiHRQ0+N75+i7DoCisrEnqO5c3YQ==
X-Received: by 2002:a63:3548:: with SMTP id c69mr4486489pga.111.1634993891420;
        Sat, 23 Oct 2021 05:58:11 -0700 (PDT)
Received: from localhost.localdomain ([49.204.131.111])
        by smtp.gmail.com with ESMTPSA id p4sm10955655pgc.15.2021.10.23.05.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 05:58:11 -0700 (PDT)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Atharva Raykar <raykar.ath@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Subject: [PATCH v3 0/1] submodule: correct an incorrectly formatted error message
Date:   Sat, 23 Oct 2021 18:27:21 +0530
Message-Id: <20211023125722.125933-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.33.1.1058.gd3b4e01def
In-Reply-To: <m27df9lvm1.fsf@gmail.com>
References: <m27df9lvm1.fsf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Atharva,

Sorry for the delay in sending this. Got held up with other work.

On 21/09/21 10:17 pm, Atharva Raykar wrote:
>>
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 414fcb63ea..236da214c6 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -2775,7 +2775,7 @@ struct add_data {
>>   };
>>   #define ADD_DATA_INIT { .depth = -1 }
>>
>> -static void show_fetch_remotes(FILE *output, const char *sm_name, const char *git_dir_path)
>> +static void show_fetch_remotes(struct strbuf *msg, const char *sm_name, const char *git_dir_path)
> 
> I like the change from using a strbuf instead of passing the output
> stream and printing to it. But maybe we should rename this function, now
> that it doesn't really 'show' anything? Probably something like
> 'append_fetch_remotes()'?

That's a good point. I've taken your suggestion into account in this v3.

Find the details of the v3 of this patch below.

Changes since v2:

- Renamed the helper function name to be more appropriate, upon suggestion.

Also, I rebased my local branch over the latest 'master'. So, this should apply
cleanly over 'master'.

For reference, the v2 could be found here:

    https://public-inbox.org/git/20210918193116.310575-1-kaartic.sivaraam@gmail.com/

... and the range-diff against v2 could be found below.

--
Sivaraam


Kaartic Sivaraam (1):
  submodule--helper: fix incorrect newlines in an error message

 builtin/submodule--helper.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

Range-diff against v2:
1:  95cbe38be3 ! 1:  7c4887ccf5 submodule--helper: fix incorrect newlines in an error message
    @@ builtin/submodule--helper.c: struct add_data {
      #define ADD_DATA_INIT { .depth = -1 }
      
     -static void show_fetch_remotes(FILE *output, const char *git_dir_path)
    -+static void show_fetch_remotes(struct strbuf *msg, const char *sm_name, const char *git_dir_path)
    ++static void append_fetch_remotes(struct strbuf *msg, const char *sm_name, const char *git_dir_path)
      {
      	struct child_process cp_remote = CHILD_PROCESS_INIT;
      	struct strbuf sb_remote_out = STRBUF_INIT;
    @@ builtin/submodule--helper.c: static int add_submodule(const struct add_data *add
     +						    "locally with remote(s):\n"),
     +					    add_data->sm_name);
     +
    -+				show_fetch_remotes(&msg, add_data->sm_name,
    -+						   submod_gitdir_path);
    ++				append_fetch_remotes(&msg, add_data->sm_name,
    ++						     submod_gitdir_path);
      				free(submod_gitdir_path);
     -				die(_("If you want to reuse this local git "
     -				      "directory instead of cloning again from\n"
-- 
2.33.1.1058.gd3b4e01def

