Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD08A1F744
	for <e@80x24.org>; Tue, 21 Jun 2016 07:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995AbcFUHpw (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 03:45:52 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35073 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754972AbcFUHpu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2016 03:45:50 -0400
Received: by mail-lf0-f49.google.com with SMTP id l188so10412514lfe.2
        for <git@vger.kernel.org>; Tue, 21 Jun 2016 00:45:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gNe1MRTPlaLl7jpt+I7dZrJlmRuUEubkGa8BNqktF2c=;
        b=VhcnnvQ2USAjKWj7Jj7P+tf6KL2ClX80Zs/KbC5QxBl29tgOsiI/GbcIGxBXNhDO5K
         lkuqVFKlKTA9fsV6PFG5K72fDRk/vz/ek3JtZY4XXq8y57RwoQsnr6p1uuGN/ruMeCA3
         pBzqvtUHXudD/yQPllX5h9Yll+VXzGmcd/fFT+pY72ocS5Hu+ZZSo9vhuydLTMTAakbk
         GdupvfaHPXuQohnNuRabt306Ha7RMsHLF8hyl/5QKH9SWCJMa8Jht9n9EP/IuZFL7/jf
         Hminyf5VLnEdHFapkxu4E4kh4HCqOrS0159LiwbyB/wFKZZGBEyDuO9Vj7Fc6fVJCPku
         d3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gNe1MRTPlaLl7jpt+I7dZrJlmRuUEubkGa8BNqktF2c=;
        b=kD8uo/UMKOLbqgYIjgCypB+8UKbKH6jOrNbhQyuFPV2Oo/YkfPcxTZ8VYhUDVa4cif
         KRlBjSIxLr0vAPZwC0KWOfQ7/J+rdGHXkgICrXKIXnewqUISlHspJShGK+AXyUI/tZm0
         TgA4q7NSQSmRkCCG2NefNhsynPBpT4f6sjyIdEkWaWKAKBkWLIjabl1OYMZCpDSjJ5pT
         LReayX35OzpXF93HRiExMwg3jhVMEqBDmb3CmMInclvb1zGHWSmVHcafkuVCbryTXpgW
         eveRbOqTs5yl+cNYj14cgY7uJD6b3H0zPYnSoZMoPfzjGs0/0VK7u6kXy9Mdtcoyecye
         KXiA==
X-Gm-Message-State: ALyK8tLnZmws6h5fKRnRc18/gf2bG51SsTGkYUVORJOD2qkW8OcQZEJLyYQKdur0lIdQ8g==
X-Received: by 10.28.146.9 with SMTP id u9mr1829659wmd.52.1466495147947;
        Tue, 21 Jun 2016 00:45:47 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4933.dip0.t-ipconnect.de. [93.219.73.51])
        by smtp.gmail.com with ESMTPSA id a84sm1628561wma.0.2016.06.21.00.45.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jun 2016 00:45:47 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC/PATCH] push: deny policy to prevent pushes to unwanted remotes.
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <vpqfus7jc59.fsf@anie.imag.fr>
Date:	Tue, 21 Jun 2016 09:45:45 +0200
Cc:	Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Antoine Queru <Antoine.Queru@grenoble-inp.org>,
	git@vger.kernel.org,
	william duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	rsbecker@nexbridge.com, aaron@schrab.com, peff@peff.net
Content-Transfer-Encoding: 8BIT
Message-Id: <827DA549-F046-4B52-90C2-ADB5BC72C16F@gmail.com>
References: <20160604145101.21928-1-Antoine.Queru@grenoble-inp.org> <998280064.353519.1465213163063.JavaMail.zimbra@ensimag.grenoble-inp.fr> <2104102670.380496.1465220639026.JavaMail.zimbra@ensimag.grenoble-inp.fr> <3899461F-44B4-407F-ACCE-793E65486554@gmail.com> <1599012395.707458.1466461517473.JavaMail.zimbra@ensimag.grenoble-inp.fr> <vpqfus7jc59.fsf@anie.imag.fr>
To:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 21 Jun 2016, at 08:20, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> 
> Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr> writes:
> 
>> However, in the last version, if we want to deny an website,
>> including all schemes, we can blacklist the url without the
>> scheme. For example, "pushBlacklist = github.com". By doing so, this
>> remote is not an url anymore, and it can't be differenced with a local
>> relative path. It's a problem because these two have a different
>> treatement. The choice we made to solve this is to force the user to
>> put the scheme "file://" before any local relative path. What do you
>> think ?
> 
> file:// URL can not be relative (well, you can invent a syntax where
> they are, but that would be weird).
> 
> I think you can just forbid relative path in whitelist/blacklist, hence
> consider that anything that is neither a full URL nor an absolute path
> is a protocol-less URL:
> 
> * http://github.com = github.com with HTTP protocol
> 
> * github.com = github.com with any protocol
> 
> * /path/to/file or file:///path/to/file = local path

I agree. Ignoring relative paths (and mentioning that in the docs)
sounds reasonable to me. I don't think that would be a limitation as
I can't think of a white/blacklist use case for relative URLs.

Thanks,
Lars