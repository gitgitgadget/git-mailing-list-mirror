Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8F3C433F5
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 15:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378704AbiDDPqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 11:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378703AbiDDPqG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 11:46:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA1AF67
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 08:44:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q19so8209941wrc.6
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xMLn0/49nTG8oUj87Ke+WUzwfzpBvGvfZNJa0EvCRh8=;
        b=KpDy/N24ZcY/KxQLha3f1CLg6DEGPWJcjYHdiZjNUmJsZUwHBKmpDqXGTzc8FrC1at
         +yk3QfNqlH1BQEeVHLJiSXnCESjChdgFyWVx6JMA35YzDAagLX6G/B9uEDgvDRUzU1Aq
         cssrHuw7dYuon/r+Gk4mFan6DCKvFCgCnz1SoUNBaPDRI4JtO2Xv0ns32tPsaCHX/+lg
         KDZU2TOS/ph9AziNzuJtqKVocssGc+tWbh2jsZI97Qz9GYHd0C5S6fDVTqDhrgltF+2J
         yFUZx+uSXwAgIvNoKSrGpt25Ptc1wgyVNn1CRc42huXJjDJ7P5QF+inJQnVeK+HiXWcg
         FszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xMLn0/49nTG8oUj87Ke+WUzwfzpBvGvfZNJa0EvCRh8=;
        b=7Duwv1DnVwM0bod8azqu7cSaSLWrgmg5PSW2UehijQAVn0Cr28wJmbFl4ZGSLjPk9b
         JVGv8A4uhM5ljcEaGh9RZA5E+l5kjqj5mG8Vrmoq1yjiCmRdUCrAL6MhnPvEDuDy6l7n
         oUPE0ek9dKHjS6yIi5dGLQXWQdacO3xu0BQcYWmir2WZ66WX2rTk30HL3dVTrZ4HkbSi
         YcBBLHPexgJw5Aqse6tsSt6snprcdZ2pjH7hPMCeU9ncJ2u26hCEHwGC2rvu7w1jfpZ5
         jqvjV3BCWinTUyJpFt7FerV8ydFdQJUCeoCPSUvzhFM/8O4OgywixrElIAs7cHdjcuHF
         d7xQ==
X-Gm-Message-State: AOAM533XU7xvSlHZsla+KzsTPkRgt2kWGz6fEVNVVNfskHN5R7+P0lZa
        zWNGr6UDNAq17ygXn/f2Ics=
X-Google-Smtp-Source: ABdhPJxbo+03AeR2At3d7jfzV4051wyRCIPHxjl1iA7au3ejv+M5VDldRyojbsry/xqjG/gwgYnYzw==
X-Received: by 2002:a05:6000:1052:b0:206:895:80f3 with SMTP id c18-20020a056000105200b00206089580f3mr271014wrx.698.1649087045529;
        Mon, 04 Apr 2022 08:44:05 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600c400100b0038cf3371208sm9867698wmm.22.2022.04.04.08.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 08:44:05 -0700 (PDT)
Message-ID: <e73dc9f4-ad32-d49b-9767-c23c78a7e681@gmail.com>
Date:   Mon, 4 Apr 2022 16:44:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/4] builtin/stash: factor out revision parsing into a
 function
Content-Language: en-GB-large
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220403182250.904933-1-sandals@crustytoothpaste.net>
 <20220403182250.904933-3-sandals@crustytoothpaste.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20220403182250.904933-3-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian

On 03/04/2022 19:22, brian m. carlson wrote:
> We allow several special forms of stash names in this code.  In the
> future, we'll want to allow these same forms without parsing a stash
> commit, so let's refactor this code out into a function for reuse.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>   builtin/stash.c | 34 +++++++++++++++++++++-------------
>   1 file changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 5897febfbe..4c281a5781 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -130,6 +130,24 @@ static void assert_stash_like(struct stash_info *info, const char *revision)
>   		die(_("'%s' is not a stash-like commit"), revision);
>   }
>   
> +static int parse_revision(struct strbuf *revision, const char *commit, int quiet)
> +{
> +	strbuf_init(revision, 0);

I think this should become strbuf_reset() and the caller should call 
strbuf_init() once before calling this function (or use STASH_INFO_INIT 
from ab/plug-leak-in-revisions). That should fix one of the leaks Ævar 
was talking about, otherwise we reallocate the strbuf each time this 
function is called and leak the previous allocation.

Best Wishes

Phillip

> +	if (!commit) {
> +		if (!ref_exists(ref_stash)) {
> +			fprintf_ln(stderr, _("No stash entries found."));
> +			return -1;
> +		}
> +
> +		strbuf_addf(revision, "%s@{0}", ref_stash);
> +	} else if (strspn(commit, "0123456789") == strlen(commit)) {
> +		strbuf_addf(revision, "%s@{%s}", ref_stash, commit);
> +	} else {
> +		strbuf_addstr(revision, commit);
> +	}
> +	return 0;
> +}
> +
>   static int get_stash_info(struct stash_info *info, int argc, const char **argv)
>   {
>   	int ret;
> @@ -157,19 +175,9 @@ static int get_stash_info(struct stash_info *info, int argc, const char **argv)
>   	if (argc == 1)
>   		commit = argv[0];
>   
> -	strbuf_init(&info->revision, 0);
> -	if (!commit) {
> -		if (!ref_exists(ref_stash)) {
> -			free_stash_info(info);
> -			fprintf_ln(stderr, _("No stash entries found."));
> -			return -1;
> -		}
> -
> -		strbuf_addf(&info->revision, "%s@{0}", ref_stash);
> -	} else if (strspn(commit, "0123456789") == strlen(commit)) {
> -		strbuf_addf(&info->revision, "%s@{%s}", ref_stash, commit);
> -	} else {
> -		strbuf_addstr(&info->revision, commit);
> +	if (parse_revision(&info->revision, commit, 0)) {
> +		free_stash_info(info);
> +		return -1;
>   	}
>   
>   	revision = info->revision.buf;
