Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A191F855
	for <e@80x24.org>; Mon,  1 Aug 2016 17:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244AbcHARMe (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 13:12:34 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34793 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbcHARMd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2016 13:12:33 -0400
Received: by mail-it0-f66.google.com with SMTP id u186so12272423ita.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2016 10:10:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3LSLStkw9M02AK3o9YgU9u3iQVloZMHNnaoPgKc3Nvg=;
        b=A1CFWGH0WPSEWROrSG9L6DjbtxtY49A4w5QxPXICx3IVMx6F0wPgI2ftHEYfQ4qTot
         ZawYzATRdQT311Biik+qHK1M0Dn62GknPP489oZ79jGvMxfRFTf/foNv/2CnV/CJw4ve
         YBT7Rlu92T6vxkcsoChKjO/quTZZXypdCQmSjvqKvn5lHfiOfNrCxXKShMR+kH7tN3Pg
         dCikXSOjbzslPj/H3zm/gG9smGmxVvoj98CnO9rnnWzND4ZGBRiHb0RTKViYhNucR0NF
         7yNrXYPNlndubQM9eq6X5L2dwzIMcJIO7ZXQVSFzACPVwUDT1kSHTIBy6aXmA4k9vgXm
         AFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3LSLStkw9M02AK3o9YgU9u3iQVloZMHNnaoPgKc3Nvg=;
        b=NE9uaiggujn04ncj5srw6VBNkW5hqgcseOXXWev6oG8KDLZelCasv9s2bBnFgmF4I7
         EcXmQyGd0G2CEpGAmlywd/072BPlVG5kq97Pkh0Wb9TMX2Ii3ClHlLXHZl+G5cEW8bcO
         BEmWuCK3Fqbi9u8+NeuQfaT0b7xBQXB1TpvnxD2g3+0dYxr7V+R2KCRIcq9fCafOHQxG
         ZwbcEB9oHUffVxZ58pmjoOnEmZbJC00S7iAkfJi9IQIkGqZiDpc+V3poyjGPXjZ/vEoD
         xCZkTujMTcMAvN2q4PArs1C4cgIvJHMSDrykIDAW8o6HbcdMnokvNVYLH0zGYV7QF+9g
         62fw==
X-Gm-Message-State: AEkoouvrNqY4RP/WrOV+k9oXJqlaLxJlvkSV7CMItR8hrZZkO4VLb4Ikk4QwWYbE6dMX80qnBIX52oTUzjNwjQ==
X-Received: by 10.36.208.71 with SMTP id m68mr60149477itg.63.1470071458829;
 Mon, 01 Aug 2016 10:10:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Mon, 1 Aug 2016 10:10:28 -0700 (PDT)
In-Reply-To: <6955746D-E47E-4BB8-AB0E-44D461E67AD6@web.de>
References: <20160718223038.GA66056@plume> <20160730182005.14426-1-pclouds@gmail.com>
 <6955746D-E47E-4BB8-AB0E-44D461E67AD6@web.de>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 1 Aug 2016 19:10:28 +0200
Message-ID: <CACsJy8D=dZeE1tLFRaCefkkNX8dHQfTL134Nv--5=BXvnUm1ZQ@mail.gmail.com>
Subject: Re: [PATCH] t7063: work around FreeBSD's lazy mtime update feature
To:	=?UTF-8?Q?Torstem_B=C3=B6gershausen?= <tboegi@web.de>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"e@80x24.org" <e@80x24.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 1, 2016 at 3:37 AM, Torstem Bögershausen <tboegi@web.de> wrote:
> the term FREEBSD may be too generic to point out a single feature
> in an OS distributution.
> Following your investigations, it may even be possible that
> other systems adapt this "feature"?
>
> How about
> LAZY_DIR_MTIME_UPDATE
> (or similar)

This feature was added in 1998, so yes there's a chance it has spread
to a few fbsd derivatives (not sure if openbsd or netbsd is close
enough and they ever exchange changes). But I'd rather wait for the
second OS to expose the same feature before renaming it.
-- 
Duy
