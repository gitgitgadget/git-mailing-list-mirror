Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ECC21F404
	for <e@80x24.org>; Mon, 11 Dec 2017 20:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751433AbdLKUr2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 15:47:28 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:55464 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750929AbdLKUr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 15:47:28 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3ywZlL0DZTz5tlF;
        Mon, 11 Dec 2017 21:47:25 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 1BC112A79;
        Mon, 11 Dec 2017 21:47:25 +0100 (CET)
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
To:     lars.schneider@autodesk.com, git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, peff@peff.net, patrick@luehne.de,
        Lars Schneider <larsxschneider@gmail.com>
References: <20171211155023.1405-1-lars.schneider@autodesk.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <a07a0b5c-453a-f644-d5e5-7d185a943088@kdbg.org>
Date:   Mon, 11 Dec 2017 21:47:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171211155023.1405-1-lars.schneider@autodesk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.12.2017 um 16:50 schrieb lars.schneider@autodesk.com:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Git and its tools (e.g. git diff) expect all text files in UTF-8
> encoding. Git will happily accept content in all other encodings, too,
> but it might not be able to process the text (e.g. viewing diffs or
> changing line endings).
> 
> Add an attribute to tell Git what encoding the user has defined for a
> given file. If the content is added to the index, then Git converts the
> content to a canonical UTF-8 representation. On checkout Git will
> reverse the conversion.
> 
> Reviewed-by: Patrick Lühne <patrick@luehne.de>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> 
> Hi,
> 
> here is a WIP patch to add text encoding support for files encoded with
> something other than UTF-8 [RFC].
> 
> The 'encoding' attribute is already used to view blobs in gitk. That
> could be a problem as the content is stored in Git with the defined
> encoding. This patch would interpret the content as UTF-8 encoded and

This will be a major drawback for me because my code base stores text 
files that are not UTF-8 encoded. And I do use the existing 'encoding' 
attribute to view the text in git-gui and gitk. Repurposing this 
attribute name is not an option, IMO.

> it would try to reencode it to the defined encoding on checkout > Plus, many repos define the attribute very broad (e.g. "* 
encoding=cp1251").
> These folks would see errors like these with my patch:
>      error: failed to encode 'foo.bar' from utf-8 to cp1251

-- Hannes
