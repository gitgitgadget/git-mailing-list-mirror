Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27A261F404
	for <e@80x24.org>; Fri, 16 Mar 2018 20:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbeCPUtW (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:49:22 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43502 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeCPUtV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:49:21 -0400
Received: by mail-wr0-f194.google.com with SMTP id o1so12833741wro.10
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 13:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=0bW5Zcw6IZADjHV8NycW4jm7ju/0fJif7asN50MSIKE=;
        b=ZkTCbFi3z0nggOLIui2v/P9gnLbymgX94ngIBmtikeY0dh4ZzfjtQMsJ+YUAAWvXXk
         7xKychCXdL3licIh2GBGrGZj9idTpPLuQ3PaY7AIrZkCQZYd6LAWy72DsvsZCG1AJ+OD
         XGmApn6rESijgg8j/Glqsd1tG4NgOy2PUZi+0GFE4np2moRqvlWjOwPgd850RHVx5/V8
         3CFhZ7nT1DETfh2v5qqukbRouOK6RzrwFH/Na2aBf0nP+x2RsIHG2pmSj8degrRGXNvu
         0jtR+vrmyu0DXlC8eldYI5nwIIlMD8SEXYViJj3GWhL+KPidTeqQDkPGc5jtvLY/iglU
         08gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=0bW5Zcw6IZADjHV8NycW4jm7ju/0fJif7asN50MSIKE=;
        b=IISM5vKyq5zkUId2IkUDELNbhoguGSPbFbmeuL8GRM+y3Zf0/dVA4VZp2urlVvdj4d
         FASaqJteLigFZRfPZIaVxfabtT17lqUCtg2OAOwiVcxfjpGlAn3dy1gDFONMpud8PqL0
         MX7gvkG6Rm6vYuS4aeH/vidWadxG67eDbQ6fBSupELvcoJd4Wpdd+skrTpRWuMc1w8ND
         NInbbjIzHVX5i3O1XgQfmvcF1lVOshXvxu7qkHVSM70oILLU1B1zV+CrVNtRWTmKOaly
         c3IzAEgnsKlTnbHCMIOQzW2AHlF0mxIlEf2rRd7tGBOFjTW5H6wL4idcvPAGESiJ47Md
         62Tg==
X-Gm-Message-State: AElRT7FuPrJv+rbAjodrWiHPcyl6hedzkn8B8QfRYN0BAT7BopCXsHka
        KDqY+can56VxgKaq88V84y4=
X-Google-Smtp-Source: AG47ELviRRvePqgfhQ8MzUhpNEHoCx41nUzKc263M4Zpb1LT47zEl+qfauvqO827fUINq+z8yc3wZA==
X-Received: by 10.223.160.195 with SMTP id n3mr2921455wrn.92.1521233360015;
        Fri, 16 Mar 2018 13:49:20 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 67sm2326159wmv.3.2018.03.16.13.49.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 13:49:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 02/11] pack-objects: turn type and in_pack_type to bitfields
References: <20180308114232.10508-1-pclouds@gmail.com>
        <20180316183200.31014-1-pclouds@gmail.com>
        <20180316183200.31014-3-pclouds@gmail.com>
Date:   Fri, 16 Mar 2018 13:49:18 -0700
In-Reply-To: <20180316183200.31014-3-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 16 Mar 2018 19:31:51 +0100")
Message-ID: <xmqqbmfn21bl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> An extra field type_valid is added to carry the equivalent of OBJ_BAD
> in the original "type" field. in_pack_type always contains a valid
> type so we only need 3 bits for it.
> ...
> @@ -1570,7 +1576,7 @@ static void drop_reused_delta(struct object_entry *entry)
>  	entry->depth = 0;
>  
>  	oi.sizep = &entry->size;
> -	oi.typep = &entry->type;
> +	oi.typep = &type;
>  	if (packed_object_info(entry->in_pack, entry->in_pack_offset, &oi) < 0) {
>  		/*
>  		 * We failed to get the info from this pack for some reason;
> @@ -1578,8 +1584,10 @@ static void drop_reused_delta(struct object_entry *entry)
>  		 * And if that fails, the error will be recorded in entry->type

This "entry->type" needs updating.

>  		 * and dealt with in prepare_pack().
>  		 */
> -		entry->type = sha1_object_info(entry->idx.oid.hash,
> -					       &entry->size);
> +		oe_set_type(entry, sha1_object_info(entry->idx.oid.hash,
> +						    &entry->size));
> +	} else {
> +		oe_set_type(entry, type);
>  	}
>  }
