Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E017FC001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 22:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbjHKWHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 18:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236359AbjHKWHH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 18:07:07 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66E13593
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 15:07:02 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-317b31203c7so2170658f8f.2
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 15:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691791621; x=1692396421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CxhaFGhc4QiWEYHMXND/p+NpkPRzhJiNodIJkt/znG0=;
        b=cIHBCE1Hh40cTif8akh7P+FmMhFIHcYGulstCn7wf99IrDDHylslHudMAy4X9SLITs
         J2SCKq7k2j9rGVrDIos1TI7nzfNTNmRv77ArQsstzI7XmgitBizHgGMXRkc3zlq7HkOP
         Yx86BLmt+9Hkzqhohgxy2+w/HqzxDtytOIeTteZKnAdiuMfe9hAu7Lo+WAx1qybkKrQr
         ow1F5tK/Jsp9jpnS+afjifIrw4cIBl6oobFe5IDrufZm7Gd+wQ2S8/zCmrPjxF0gWUQg
         b6QSwJaVn40PM5S8blhVV5sRV9587frioOGnA0gY4kr+ZmFApOM5XsLJwYhlZcqWC9sW
         qKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691791621; x=1692396421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CxhaFGhc4QiWEYHMXND/p+NpkPRzhJiNodIJkt/znG0=;
        b=R9mwNfvmTi4AzcTFGpHmuMslDSzHTEP5YZ7wd8AldhOsuH5T6zrSjFljntulw11Fu8
         y2ijCtoNgdpTIhbRAhLAvMwsdKWt/eSRSPMPHwYZFZMKZiozYiof9pHfEXHq/lhYH+Ox
         Wpe1I328qEM/kuiHF4fp/omlHW5QKOUVo6WzeadiUZVWWY1MaCCZS+7s0Tz2u41y/1lc
         I6vk0+q9oROuNHQ4TBwNKW/riKsYz9OF8seCGzh5D2kji+guMVjL4EzgZOhN/9tTvCZj
         zfZbshnivxKU5Jgyek2iNCe/C7pAiJpwQkHQX7AFGpWSM4/8bArX5Jk0wZf0vWENiem0
         XVdg==
X-Gm-Message-State: AOJu0Yxsg1htv6+Kr97yuLT4pObIBqwGcCslp4Yl1onLXcHmOVKAE8Dh
        omWRv7OpR+ybidXQxhOymDM=
X-Google-Smtp-Source: AGHT+IFm+1DP/tzpxBtV9NdtZwhgbg9/mosExWV3Gi0p3oXnV0Rd6D6PMwpj9WXmkrwbJWPOE6ZD+A==
X-Received: by 2002:a5d:53c3:0:b0:315:a74c:f627 with SMTP id a3-20020a5d53c3000000b00315a74cf627mr2383947wrw.16.1691791620855;
        Fri, 11 Aug 2023 15:07:00 -0700 (PDT)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id f2-20020a7bcd02000000b003fe210d8e84sm9347129wmj.5.2023.08.11.15.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 15:07:00 -0700 (PDT)
Message-ID: <61337dad-e1db-4f08-84f5-404bacc6c9bf@gmail.com>
Date:   Fri, 11 Aug 2023 23:06:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pretty: add %(decorate[:<options>]) format
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     phillip.wood@dunelm.org.uk, Glen Choo <chooglen@google.com>,
        git@vger.kernel.org
References: <20230715103758.3862-1-andy.koppe@gmail.com>
 <20230715160730.4046-1-andy.koppe@gmail.com>
 <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com>
 <783011d8-53ea-15cb-a9c7-6cb0c15bd5aa@gmail.com>
 <CAHWeT-Zo3nTTGBfJPwNhg50KfLn-GAdpU8WZ96d7fT9_axAQXg@mail.gmail.com>
 <xmqqv8dlqpq7.fsf@gitster.g>
From:   Andy Koppe <andy.koppe@gmail.com>
In-Reply-To: <xmqqv8dlqpq7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/08/2023 21:38, Junio C Hamano wrote:
 > Andy Koppe <andy.koppe@gmail.com> writes:
 >
 >> There are a number of uses of designated initializers already, so
 >> hopefully compound literals aren't too much of an extra challenge.
 >
 > I do not see how one leads to the other here.  I'd prefer not to see
 > use of a new construct we do not currently use mixed in a new code,
 > even if it is mentioned in the proposed log message.

Okay.

Would this style be acceptable to fulfil Glen's request to name the
fields?

	case 'D':
		{
			const struct decoration_options opts = {
				.prefix = "",
				.suffix = ""
			};

			format_decorations(sb, commit, c->auto_color, &opts);
		}
		return 1;

Andy
